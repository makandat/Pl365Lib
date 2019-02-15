#!/usr/bin/perl
use strict;
use utf8;
require "../Common.pm";

print "isnull(x)\n";
print Common::isnull(''), "\n";
print Common::isnull(0), "\n";
print Common::isnull(undef), "\n";

print "isset(x)\n";
print Common::isset(''), "\n";
print Common::isset(0), "\n";
print Common::isset(undef), "\n";

print "is_int(x)\n";
print Common::is_int('0'), "\n";
print Common::is_int(0), "\n";
print Common::is_int(undef), "\n";

print "is_str(x)\n";
print Common::is_str('0'), "\n";
print Common::is_str(0), "\n";
print Common::is_str(undef), "\n";

print "is_windows, is_linux\n";
print Common::is_windows(), "\n";
print Common::is_linux(), "\n";

print "get_env(key)\n";
print Common::get_env('PERL5LIB'), "\n";
print Common::get_env('PYTHONPATH'), "\n";
print Common::get_env('RUBYLIB'), "\n";
