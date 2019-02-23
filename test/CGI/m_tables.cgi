#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
require "./WebPage.pm";
require "./MySQL.pm";
use constant TEMPLATE => "./templates";

our $cgi;
our $mysql;
our @rows;

sub makeHtml {
  my $buff = "";
  foreach my $row (@rows) {
    $buff .= "<tr><td>";
    $buff .= $row->[0];
    $buff .= "</td><td>";
    $buff .= $row->[1];
    $buff .= "</td><td>";
    $buff .= $row->[2];
    $buff .= "</td></tr>\n";
  }
  return $buff;
}

$cgi = WebPage->new(TEMPLATE . "/m_tables.html");
$mysql = MySQL->new;

@rows = $mysql->query("SELECT name, rows, created FROM m_tables");
$cgi->setPlaceHolder('content', makeHtml());
$cgi->echo();
