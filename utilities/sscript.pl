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
      // insert your code here.
    });
    # or
    \$('#button2').on('click', function() {
      // insert your code here.
    });
  });
EOS

# 2. フォーム要素をチェックして送信
our $form_check = <<EOS;
  \$(function() {
    \$('#form1').submit(function() {
       if (\$('#text1').val() == '') {
          alert('not submit');
       }
       else {
          \$('#form1').submit();
       }
    });
  });
EOS

# 3. name セレクタ
our $name_selector = <<EOS;
  // 3. name selecor
  \$(function() {
    \$('input[name="btn1"]').click(function() {
      alert('btn1 click');
    });
  });
EOS

# 4. each()
our $each = <<EOS;
  var each_ok = true;
  $(function(){
    $('input[type="button"]').click(
      function() {
        $('input[type="text"]').each(function(index, element) {
          if ($(element).val() == '') {
            alert(element.name + ' element is empty.');
            each_ok = false;
          }
        });
        alert(each_ok);
      });
  });
EOS

# 5. AJAX getJSON
our $ajax_getJSON = <<EOS;
  \$(function() {
    \$('input[type="button"]').on('click', function() {
      \$.getJSON("/cgi-bin/getobj1.cgi", {"text1":\$('#text1').val()}, function(data) {
        alert(data['text1']);
      });
    });
  });
EOS

# 6. set/get attr or style
our $set_get_attr = <<EOS;
  \$(function() {
     \$('input[type="button"]').on("click", function() {
       var attr1 = \$('#image1').attr('src');
       \$('#p1').text(attr1);
       var style1 = \$('#p1').css('color');
       \$('#p1').css('color', 'red');
       \$('#p1').text(style1);
     });
  });
EOS

# 7. set/get Cookies
our $set_get_cookies = <<EOS;
  \$(function() {
    \$.cookie('message', 'Hello, Cookies');
    \$('#p1').text(\$.cookie('message'));
  });
EOS

# 8. working with Checkbox, Radio button
our $work_checkbox = <<EOS;
  \$(function() {
    \$('button').on('click', function() {
       \$('#p1').text('check1 checked = ' + \$('#check1').prop('checked'));
       var v = \$("[name=radio]:checked").val();
        \$('#p2').text('radio checked = ' + v);
     });
  });
EOS

# 9. working with Listbox
our $work_listbox = <<EOS;
  \$(function() {
    \$('button').on('click', function() {
       \$('#p1').text('button event select1.val() = ' + \$('#select1').val());
     });
    \$('select').on('change', function() {
       \$('#p2').text('select change event select1.val() = ' + \$('#select1').val());
     });
  });
EOS



# -----------------------------------------------------------------------------------------
# JavaScript コードを HTML ファイルに挿入する。
sub insertCode {
  my $menu = shift;
  my $fileName = shift;
  my $cdn = shift;
  my $found = Common::False;
  open(FH, "<$fileName");
  my $lines = "";
  my $line;
  
  while (<FH>) {
    if (/^\s*<script/ && ($cdn eq 'y')) {
      $lines .= "<script src=\"https://code.jquery.com/jquery-3.3.1.min.js\"></script>\n";
      $lines .= "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js\"></script>\n";
      $lines .= $_;
    }
    elsif (/^\s*<\/script>$/) {
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
      elsif ($menu == 6) {
        $lines .= $set_get_attr;
      }
      elsif ($menu == 7) {
        esc_print("red", "You need \"jquery.cookie.js\"\n");
        $lines .= $set_get_cookies;
      }
      elsif ($menu == 8) {
        $lines .= $work_checkbox;
      }
      elsif ($menu == 9) {
        $lines .= $work_listbox;
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
puts "4. each function.";
puts "5. AJAX getJSON";
puts "6. set/get attr or style";
puts "7. set/get Cookies";
puts "8. working with Checkbox, Radio button";
puts "9. working with Listbox";
my $menu = Common::readline("Select number > ");
if ($menu eq '') {
  stop(1, "Aborted.");
}
my $htmlFile = Common::readline("Enter the HTML file (FULL PATH) > ");
if (FileSystem::isFile($htmlFile) == Common::False) {
  stop("Aborted: \"$htmlFile\" does not exists.");
}
my $cdn = Common::readline("Do you want to insert jQuery CDN ? (y/n) > ");
if ($cdn eq '') {
  stop(1, "Aborted.");
}
esc_print("magenta", "\nConfirmation.\n");
puts("Menu number is " . $menu);
puts("HTML file is " . $htmlFile);
puts("jQuery CDN: " . $cdn);
my $ans = Common::readline("Execute OK ? (y/n) > ");
if (lc($ans) eq 'y') {
  insertCode($menu, $htmlFile, $cdn);
  esc_print("yellow", "Normal termination.\n");
}
else {
  stop(1, "Aborted.");
}

