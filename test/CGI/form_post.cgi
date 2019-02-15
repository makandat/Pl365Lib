#!/usr/bin/perl
#  form_post.cgi  フォームのテスト(2)
require "./WebPage.pm";
require "./FileSystem.pm";
require "./Text.pm";
require "./Common.pm";

our $cgi = WebPage->new("templates/form_post.html");

my $b = $cgi->isPostback('text1');

if ($b == 1) {
  $cgi->setPlaceHolder('message', 'OK "' . $cgi->getParam('text1') . '", ' . $cgi->getParam('radio'));
}
else {
  $cgi->setPlaceHolder('message', '');
}

# 応答を返す。
$cgi->echo();
