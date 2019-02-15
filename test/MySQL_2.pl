#!/usr/bin/perl
#  MySQL.pm テスト
require "../MySQL.pm";
use utf8;
use strict;
use warnings;

my $mysql = MySQL->new();

# 連想配列の参照の配列が返される。
my @rows = $mysql->query2("SELECT * FROM m_tables WHERE `database`='user'");

my $n = $#rows;
print "行数 ";
print $n+1, "\n";

for (my $i = 0; $i <= $n; $i++) {
  my $row = $rows[$i];
  print $row->{database} . ",";
  print $row->{name} . ",";
  print $row->{engine} . ",";
  print $row->{rows} . ",";
  print $row->{created} . "\n";
}

$mysql->mysql_close();
print "Done.\n";

