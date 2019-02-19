#!/usr/bin/perl
use strict;
use warnings;
use utf8;
require "../Common.pm";


my $html = <<EOS;
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8" />
 <title>TITLE</title>
 <link rel="stylesheet" href="/css/default.css" />
 <style>
  .content {
    margin-left: 5%;
    margin-right: 5%;
  }
 </style>
HEADER
 <script>
JAVASCRIPT
 </script>
</head>

<body>
<h1>TITLE</h1>
<div class="menu" style="text-align:center"><a href="/">HOME</a></div>
<br />
<div class="content">

OPTION

</div>
<p>&nbsp;</p>
<p style="text-align:center;"><a href="#top">TOP</a></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
EOS


my $htmlopt1 = <<EOS;
<form method="GET">
 <table>
 <tr><td>Text1</td><td><input type="text" name="text1" size="50" /></td></tr>
 <tr><td>Check1</td><td><input type="checkbox" name="check1" value="check1" /></td></tr>
 <tr><td></td><td></td></tr>
 <tr><td></td><td><input type="submit" value=" 送信 "/></td></tr>
 <table>
</form>
<br />
<div class="message"></div>
EOS

my $htmlopt2 = <<EOS;
<form method="POST">
 <table>
 <tr><td>Text1</td><td><input type="text" name="text1" size="50" /></td></tr>
 <tr><td>Radio</td><td><input type="radio" name="radio" value="1" checked />&nbsp;Radio1&nbsp;<input type="radio" name="radio" value="2" />&nbspRadio2</td></tr>
 <tr><td></td><td></td></tr>
 <tr><td></td><td><input type="submit" value=" 送信 "/></td></tr>
 <table>
</form>
<br />
<div class="message"></div>
EOS

my $htmlopt3 = <<EOS;
<form method="POST" enctype="multipart/form-data">
 <table>
 <tr><td>Text1</td><td><input type="text" name="text1" size="50" /></td></tr>
 <tr><td>File1</td><td><input type="file" name="file1" /></td></tr>
 <tr><td></td><td></td></tr>
 <tr><td></td><td><input type="submit" value=" 送信 "/></td></tr>
 <table>
</form>
<br />
<div class="message"></div>
EOS

my $htmlopt4 = <<EOS;
<form method="GET">
 <table>
 <tr><td>Text1</td><td><input type="text" id="text1" size="50" /></td></tr>
 <tr><td></td><td><label><input type="radio" name="temp" value="C">&nbsp;C to F</label><br />
  <label><input type="radio" name="temp" value="F">&nbsp;F to C</label>
 </td></tr>
 <tr><td></td><td></td></tr>
 <tr><td></td><td><input type="button" id="button1" value=" 送信 " onclick="javascript:btnclick();" /></td></tr>
 <table>
</form>
<br />
<div class="message"></div>
EOS

my $jquery = <<EOS;
<script src="/js/jquery.min.js"></script>
EOS

my $script4 = <<EOS;
  function btnclick() {
    var text1 = \$('#text1').val();
    var temp = \$('input[name="temp"]:checked').val();
    \$.get('/cgi-bin/Perl/fahren.cgi',
     {"text1":text1, "temp":temp},
     function(data) { \$('#message').text(data); });
  }
EOS

my $htmlopt5 = <<EOS;
<form method="GET">
 <table>
 <tr><td>Text1</td><td><input type="text" id="complex" size="50" /></td></tr>
 <tr><td></td><td></td></tr>
 <tr><td></td><td><input type="button" id="button1" value=" 送信 "/></td></tr>
 <table>
</form>
<br />
<div class="message"></div>
EOS

my $script5 = <<EOS;
$(function() {
  $('#button1').click(function() {
    complex = $('#complex').val();
    \$.getJSON('/cgi-bin/Perl/complex.cgi', {"complex":complex}, function(data) { $('#result').text(data); });
  });
});

EOS


my $htmlopt6 = <<EOS;
<figure>
 <img src="/cgi-bin/Perl/image.cgi?id=0" />
<figure>
<br />
<div class="message"></div>
EOS

my $script6 = <<EOS;

EOS


my $htmlopt7 = <<EOS;
<pre><code>
&lt;html&gt;
 &lt;head&gt;
 &lt;head&gt;

 &lt;body&gt;
 &lt;body&gt;
&lt;/html&gt;
</code></pre>
EOS

my $header7 = <<EOS;
<link rel="stylesheet" href="/js/highlight/stylesheets/default.css">
<script src="/js/highlight/highlight.pack.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
EOS


my $htmlopt8 = <<EOS;
<div class="container">
  
</div>
EOS

my $header8 = <<EOS;
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
EOS


#  START Here
Common::esc_print("yellow", "=== HTML Generator ===\n");
my $savePath = Common::readline("Enter the FULL path to be saved. > ");
if ($savePath eq '') {
  print "Aborted.\n";
  exit 1;
}
print "=== Select the OPTION below. ===\n";
print "0  Nothing\n";
print "1  Form (GET)\n";
print "2  Form (POST)\n";
print "3  Form (File Upload)\n";
print "4  Ajax (Plain Text)\n";
print "5  Ajax (JSON)\n";
print "6  Ajax (Image)\n";
print "7  Highlight.js\n";
print "8  Bootstrap.css\n";

my $option = Common::readline("Enter the No. > ");


if ($option == 1) {
  $html =~ s/OPTION/$htmlopt1/g;
  $html =~ s/HEADER//g;
  $html =~ s/JAVASCRIPT//g;
}
elsif ($option == 2) {
  $html =~ s/OPTION/$htmlopt2/g;
  $html =~ s/HEADER//g;
  $html =~ s/JAVASCRIPT//g;
}
elsif ($option == 3) {
  $html =~ s/OPTION/$htmlopt3/g;
  $html =~ s/HEADER//g;
  $html =~ s/JAVASCRIPT//g;
}
elsif ($option == 4) {
  $html =~ s/OPTION/$htmlopt4/g;
  $html =~ s/HEADER/$jquery/g;
  $html =~ s/JAVASCRIPT/$script4/g;
}
elsif ($option == 5) {
  $html =~ s/OPTION/$htmlopt5/g;
  $html =~ s/HEADER/$jquery/g;
  $html =~ s/JAVASCRIPT/$script5/g;
}
elsif ($option == 6) {
  $html =~ s/OPTION/$htmlopt6/g;
  $html =~ s/HEADER/$jquery/g;
  $html =~ s/JAVASCRIPT/$script6/g;
}
elsif ($option == 7) {
  $html =~ s/OPTION/$htmlopt7/g;
  $html =~ s/HEADER/$header7/g;
  $html =~ s/JAVASCRIPT//g;
}
elsif ($option == 8) {
  $html =~ s/OPTION/$htmlopt8/g;
  $html =~ s/HEADER/$header8/g;
  $html =~ s/JAVASCRIPT//g;
}
else {
  $html =~ s/OPTION//g;
  $html =~ s/HEADER//g;
  $html =~ s/JAVASCRIPT//g;
}

# save file.
open(my $fh, ">:encoding(utf8)", $savePath) or die "The save path is illegal.";
print $fh $html;
close($fh);
print "The HTML file has been saved.\n";


