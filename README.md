# bookmarklet

ブックマークレット集。
src ディレクトリ配下のスクリプトを読み取って、このREADMEファイルを上書きする。

<!-- START -->
* [Amazonの商品ページURLを短縮](javascript:(function(){var url = window.location.href;var id = url.split("/")[5];window.prompt("短縮されたURL", "https://www.amazon.co.jp/gp/product/"+id);})())
