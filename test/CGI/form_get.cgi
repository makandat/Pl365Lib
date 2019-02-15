#!/usr/bin/perl
#  form_get.cgi  フォームのテスト(1)
require "./WebPage.pm";
require "./FileSystem.pm";
require "./Text.pm";

our $cgi = WebPage->new("templates/form_get.html");

if ($cgi->isPostback('text1')) {
  $cgi->setPlaceHolder('message', 'OK "' . $cgi->getParam('text1') . '", ' . $cgi->isParam('check1'));
}
else {
  $cgi->setPlaceHolder('message', '');
}

# 応答を返す。
$cgi->echo();
