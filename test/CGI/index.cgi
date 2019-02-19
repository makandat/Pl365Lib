#!/usr/bin/perl
#  WebPage テストのトップページ

require "./WebPage.pm";
require "./FileSystem.pm";

my $cgi = WebPage->new('templates/index.html');
my @files = FileSystem::listFiles("./", "*.cgi");
my $cgilist = "";
foreach my $f (@files) {
  $filename = FileSystem::getFileName($f);
  $cgilist .= "<li><a href=\"/cgi-bin/Perl/$filename\">$filename</a></li>\n";
}
$cgi->setPlaceHolder('cgilist', $cgilist);

$cgi->echo();
