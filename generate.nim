import os, tables, strutils, streams

type Bookmarklet = object
  title, content: string

var bookmarklet = initTable[string, Bookmarklet]()

for file in walkFiles("src/*/*"):
  let dir = file.parentDir
  if not bookmarklet.hasKey(dir):
    bookmarklet[dir] = Bookmarklet()
  let (_, name, _) = file.splitFile
  case name
  of "TITLE":
    let title = file.readFile.strip
    bookmarklet[dir].title = title
  else:
    let content = file.readFile.replace("\n", "").strip
    let script = "javascript:(function(){" & content & "})()"
    bookmarklet[dir].content = script

var links: seq[string]
for k, v in bookmarklet:
  let link = "* [" & v.title & "](" & v.content & ")"
  links.add link

let adocLinks = links.join("\n")

var strm = newFileStream("README.md", fmWrite)
const marker = "<!-- START -->"
for line in "README.tmpl.md".lines:
  if line != marker:
    strm.writeLine line
  else:
    strm.writeLine marker
    strm.writeLine adocLinks
    break
strm.close

echo "done"
