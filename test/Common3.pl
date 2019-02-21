#!/usr/bin/perl
use strict;
use Common;

my @cmd = ('ls', '-la', '/home/user/lib');
Common::exec(@cmd);
my $a = Common::readline("> ");
print "$a\n";
my $s = Common::shell('cat /home/user/bin/rmcr');
print "$s\n";


