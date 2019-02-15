#!/usr/bin/perl
#  MySQL.pm テスト INSERT
require "../MySQL.pm";
require "../Common.pm";
use utf8;
use strict;
use warnings;

if (Common::count_args() < 2) {
  Common::stop(9, "カラーコードとカラー名を指定してください。")
}

my ($code, $color) = Common::args();
my $sql = "INSERT INTO colors(code, color) VALUES('$code', '$color')";
my $mysql = MySQL->new();
my $r = $mysql->execute($sql);
print $sql."\n";
print "$r\n";

$mysql->mysql_close();
print "Done.\n";

