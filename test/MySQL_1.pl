#!/usr/bin/perl
#  MySQL.pm テスト
require "../MySQL.pm";
use utf8;
use strict;
use warnings;

my $mysql = MySQL->new();

# 配列の配列が返される。
my @rows = $mysql->query("SELECT * FROM m_tables WHERE `database`='user'");

my $n = $#rows;
print "行数 ";
print $n + 1, "\n";

for (my $i = 0; $i <= $n; $i++) {
  my $row = $rows[$i];
  print $row->[0] . ",";
  print $row->[1] . ",";
  print $row->[2] . ",";
  print $row->[3] . ",";
  print $row->[4] . "\n";
}

$mysql->mysql_close();
print "Done.\n";

