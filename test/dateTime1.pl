#!/usr/bin/perl
#  DateTime クラスのテスト
require "../DateTime.pm";

my $dt = DateTime->new;
print $dt->toString(), "\n";
print $dt->toDateString(), "\n";
print $dt->toTimeString(), "\n";

