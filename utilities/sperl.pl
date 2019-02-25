#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use Common;
use FileSystem;
use constant MODULE_PATH => '/home/user/workspace/perl/Pl365Lib';


our $console = <<EOS;
#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
require "./Common.pm";
require "./FileSystem.pm";
require "./Text.pm";
REQUIRES

binmode(STDOUT, ":utf8");
Common::esc_print("bold", "開始 ..\\n");
if (Common::count_args() == 0) {
  Common::stop(9, "ERROR: No parameter(s).");
}

my \$arg0 = \$ARGV[0];
print "arg0 = \$arg0", "\\n";


print "正常終了.\\n";
exit 0;
EOS

our $cgi = <<EOS;
#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
require "./WebPage.pm";
require "./Common.pm";
require "./FileSystem.pm";
require "./Text.pm";
REQUIRES
use constant TEMPLATE => "./templates";

our \$cgi = WebPage->new(TEMPLATE . "/index.html");


\$cgi->echo();
EOS


our $ajax = <<EOS;
#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
require "./WebPage.pm";
require "./Common.pm";
require "./FileSystem.pm";
require "./Text.pm";
REQUIRES
use constant TEMPLATE => "./templates";

our \$cgi = WebPage->new;

my \$json = "{\"a\":\"0\", \"b\":\"2\"}";

\$cgi->send_json(\$json);
EOS



# START here.
my $a;
Common::esc_print("yellow", "=== Perl Source Generator ===\n");

my $save_name = Common::readline("Enter the path to be saved. (FULL path) > ");
if ($save_name eq '') {
  Common::stop(1, "Aborted.");
}

if (-e $save_name) {
  $a = Common::readline("\"$save_name\" exists. Continue ? (y/n) > ");
  if (lc($a) eq 'y') {
    print "Continued .. \n";
  }
  else {
    Common::stop(3, "Aborted.\n");
  }
}

$a = Common::readline("Additional modules require ? (y/n) > ");
my $requires = "";
if (lc($a) eq 'y') {
  $requires = <<EOS;
require "./DateTime.pm";
require "./Parameters.pm";
require "./Regexp.pm";
require "./MySQL.pm";
EOS
}

print "1. Console App.\n";
print "2. CGI.\n";
print "3. CGI (Ajax).\n";
$a = Common::readline("Enter No. > ");

if ($a eq '1') {
  $console =~ s/REQUIRES/$requires/g;
  FileSystem::writeAllText($save_name, $console);
}
elsif ($a eq '2') {
  $cgi =~ s/REQUIRES/$requires/g;
  FileSystem::writeAllText($save_name, $cgi);
}
elsif ($a eq '3') {
  $ajax =~ s/REQUIRES/$requires/g;
  FileSystem::writeAllText($save_name, $ajax);
}
else {
  Common::stop(2, "Aborted.");
}


$a = Common::readline("Create symbolic links of the modules ? (y/n) > ");
if (lc($a) eq 'y') {
  my $save_dir = FileSystem::getDirectoryName($save_name);
  symlink MODULE_PATH . "/Common.pm", $save_dir . "/Common.pm";
  symlink MODULE_PATH . "/FileSystem.pm", $save_dir . "/FileSystem.pm";
  symlink MODULE_PATH . "/Text.pm", $save_dir . "/Text.pm";
  if ($requires ne '') {
    symlink MODULE_PATH . "/DateTime.pm", $save_dir . "/DateTime.pm";
    symlink MODULE_PATH . "/Parameters.pm", $save_dir . "/Parameters.pm";
    symlink MODULE_PATH . "/Regexp.pm", $save_dir . "/Regexp.pm";
    symlink MODULE_PATH . "/MySQL.pm", $save_dir . "/MySQL.pm";
  }
}

$a = Common::readline("Do you want to change mode '0755' of $save_name ? (y/n) > ");
FileSystem::_chmod($save_name, 0755); 

Common::esc_print("green", "Done.\n");
