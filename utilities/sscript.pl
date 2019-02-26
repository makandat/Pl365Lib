#!/usr/bin/perl
#   JavaScript(jQuery) コードを HTML に挿入する。
use strict;
use warnings;
use Common qw(esc_print stop puts);
use FileSystem;

# 1. イベントハンドラ
our $event_handler = <<EOS;
  \$(function() {
    \$('#button1').click(function() {
      # insert your code here.
    });
    # or
    \$('#button2').on('click', function() {
      # insert your code here.
    });
  });
EOS

# 2. フォーム要素をチェックして送信
our $form_check = <<EOS;
  \$(function() {
    \$('#form1').submit(function() {
       if ('#text1').val() != "") {
          \$('#form1').submit();
        }
       else {
          // not submit
        }
    });
  });
EOS

# 3. name セレクタ
our $name_selector = <<EOS;
  // 3. name selecor
  \$(function() {
    \$('button[name="btn1"]').click(function() {
      # insert your code here.
    });
  });
EOS

# 4. each()
our $each = <<EOS;
  // 4. each
  function checkTexts() {
    \$('input[type="text"]').each(function(index, element) {
      if (\$(element).val() == '') {
        return false;
      }
    }
    return true;
  }
EOS

# 5. AJAX getJSON
our $ajax_getJSON = <<EOS;
  // Ajax getJSON
  \$(function() {
    \$('#button1').on('click', function() {
      \$.getJSON("/cgi-bin/getobj1.cgi", {"text1":\$('#text1').val()}, function(data) {
       # insert your code here.
      });
    });
  });
EOS



# JavaScript コードを HTML ファイルに挿入する。
sub insertCode {
  my $menu = shift;
  my $fileName = shift;
  my $found = Common::False;
  open(FH, "<$fileName");
  my $lines = "";
  my $line;
  while (<FH>) {
    if (/^<\/script>$/) {
      $found = Common::True;
      if ($menu == 1) {
        $lines .= $event_handler;
      }
      elsif ($menu == 2) {
        $lines .= $form_check;
      }
      elsif ($menu == 3) {
        $lines .= $name_selector;
      }
      elsif ($menu == 4) {
        $lines .= $each;
      }
      elsif ($menu == 5) {
        $lines .= $ajax_getJSON;
      }
      else {
      }
      $lines .= "\n</script>\n";
    }
    else {
      $lines .= $_;
    }
  }
  close(FH);

  print $lines;

  FileSystem::writeAllText($fileName, $lines);
}


#  メインプログラム
esc_print("yellow", "=== jQuery code insertion tool ===\n");
esc_print("yellow", "Menu\n");
puts "1. Event handler.";
puts "2. Form check and submit.";
puts "3. name selector.";
puts "4. input selector.";
puts "5. AJAX getJSON";
my $menu = Common::readline("Select number > ");
if ($menu eq '') {
  stop(1, "Aborted.");
}
my $htmlFile = Common::readline("Enter the HTML file (FULL PATH) > ");
if (FileSystem::isFile($htmlFile) == Common::False) {
  stop("Aborted: \"$htmlFile\" does not exists.");
}
esc_print("magenta", "\nConfirmation.\n");
puts("Menu number is " . $menu);
puts("HTML file is " . $htmlFile);
my $ans = Common::readline("Execute OK ? (y/n) > ");
if (lc($ans) eq 'y') {
  insertCode($menu, $htmlFile);
  esc_print("yellow", "Normal termination.\n");
}
else {
  stop(1, "Aborted.");
}

