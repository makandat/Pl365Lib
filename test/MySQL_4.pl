#!/usr/bin/perl
#  MySQL.pm テスト get_value
require "../MySQL.pm";
use utf8;
use strict;
use warnings;

my $sql = "SELECT count(*) FROM m_tables";
my $mysql = MySQL->new();
my $value = $mysql->get_value($sql);
print $value."\n";

$mysql->mysql_close();
print "Done.\n";

