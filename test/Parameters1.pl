#!/usr/bin/perl
use strict;
use warnings;
use Common qw(stop esc_print args count_args);
use Parameters;

if (count_args() == 0) {
  stop("No parameters.");
}

esc_print(Common::ESC_BOLD, "START Parameters1.pl\n");
my $param = Parameters->new;

my $nopt = $param->num_option();
my $nprm = $param->num_param();

printf("Option keys = %d\n", $nopt);
printf("Non option  count = %d\n", $nprm);

esc_print("blue", "== Parameters ==\n");
my $n = count_args();
printf("count = %d\n", $n);

for (my $i = 0; $i < $n; $i++) {
  printf("args(%d) = %s\n", $i, args($i)); 
}

esc_print("blue", "Options ..\n");
for (my $i = 0; $i < $nopt; $i++) {
  my $key = $param->get_optionkey($i);
  printf("key = %s : value = %s\n", $key, $param->get($key));
}

esc_print("blue", "Params ..\n");
for (my $i = 0; $i < $nprm; $i++) {
  printf("No.%d : value = %s\n", $i, $param->get($i));
}

esc_print("blue", "終わり\n");

