package Common;
#  コンソール共通パッケージ
#    Version 1.00  2019-02-19
use strict;
use utf8;
use warnings;
# BOOL値の定義
use constant False => 0;
use constant True => 1;
# LOGファイル出力先
use constant LOGFILE => 'Pl365.log';
# 端末エスケープシーケンス指定コード
use constant ESC_NORMAL => "\x1b[0m";
use constant ESC_BOLD => "\x1b[1m";
use constant ESC_DIM => "\x1b[2m";
use constant ESC_ITALIC => "\x1b[3m";
use constant ESC_UNDERLINE => "\x1b[4m";
use constant ESC_BLINK => "\x1b[5m";
use constant ESC_HBLINK => "\x1b[6m";
use constant ESC_REVERSE => "\x1b[6m";
use constant ESC_FG_BLACK => "\x1b[30m";
use constant ESC_BG_BLACK => "\x1b[40m";
use constant ESC_FG_RED => "\x1b[31m";
use constant ESC_BG_RED => "\x1b[41m";
use constant ESC_FG_GREEN => "\x1b[32m";
use constant ESC_BG_GREEN => "\x1b[42m";
use constant ESC_FG_YELLOW => "\x1b[33m";
use constant ESC_BG_YELLOW => "\x1b[43m";
use constant ESC_FG_BLUE => "\x1b[34m";
use constant ESC_BG_BLUE => "\x1b[44m";
use constant ESC_FG_MAGENTA => "\x1b[35m";
use constant ESC_BG_MAGENTA => "\x1b[45m";
use constant ESC_FG_CYAN => "\x1b[36m";
use constant ESC_BG_CYAN => "\x1b[46m";
use constant ESC_FG_WHITE => "\x1b[37m";
use constant ESC_BG_WHITE => "\x1b[47m";

#  ログ出力
sub log_output {
  my $message = shift;
  my $level = "INFO";
  if ($#_ == 0) {
    $level = shift;
  }
  open(FL, ">>", LOGFILE);
  my @time = localtime();
  my $s = sprintf("%04d-%02d-%02dT%02d:%02d:%02d [%s] %s.\n", $time[5]+1900, $time[4]+1, @time[3,2,1,0], $level, $message);
  print FL $s;
  close FL;
  return;
}

# Linux の場合、属性をつけて文字列を表示する。void esc_print(color, text)
sub esc_print {
  my $color = shift;
  my $text = shift;

  if (is_windows()) {
    print $text;
    return;
  }
  
  if (lc($color) eq 'red') {
    print ESC_FG_RED . $text;
  }
  elsif (lc($color) eq 'green') {
    print ESC_FG_GREEN . $text;
  }
  elsif (lc($color) eq 'blue') {
    print ESC_FG_BLUE . $text;
  }
  elsif (lc($color) eq 'yellow') {
    print ESC_FG_YELLOW . $text;
  }
  elsif (lc($color) eq 'cyan') {
    print ESC_FG_CYAN . $text;
  }
  elsif (lc($color) eq 'magenta') {
    print ESC_FG_MAGENTA . $text;
  }
  elsif (lc($color) eq 'bold') {
    print ESC_BOLD . $text;
  }
  elsif (lc($color) eq 'reverse') {
    print ESC_FG_YELLOW . $text;
  }
  elsif (lc($color) eq 'underline') {
    print ESC_FG_YELLOW . $text;
  }
  elsif (lc($color) eq 'blink') {
    print ESC_FG_YELLOW . $text;
  }
  else {
    print $color . $text;
  }
  print ESC_NORMAL;
}

#  コマンドライン引数の数
sub count_args {
  return $#ARGV+1;
}

# コマンドライン引数の配列を返す。インデックスが指定されたときは、そのパラメータを返す。 mix args([idx])
sub args {
  if ($#_ < 0) {
    return @ARGV;
  }
  my $i = shift;
  return $ARGV[$i];
}

# 実行中止
sub stop {
  binmode(STDOUT, ":utf8");  # メッセージで日本語を使うと警告が出るのを防ぐ。
  my $c = 9;
  my $message = "";
  if ($#_ <= 0) {
    $c = 9;
    $message = shift
  }
  else {
    $c = shift;
    $message = shift;
  }
  print $message, "\n";
  exit $c;
}

# コマンドを実行する。int exec(list)
sub exec {
  system(@_);
  return $?;
}

# コマンドを実行する。string shell(cmd)
sub shell {
  my $cmd = shift;
  `$cmd`;
}

# 標準入力から1行読む。string readline(message)
sub readline {
  if ($#_ >= 0) {
    print shift;
  }
  $_ = <STDIN>;
  chomp;
  return $_;
}

# 環境変数の値を得る。 string get_env(key)
sub get_env {
  my $key = shift;
  return $ENV{$key}
}


# OS が Windows かどうか？
sub is_windows {
  return to_bool($^O eq 'MSWin32');
}

# OS が Linux かどうか？
sub is_linux {
  return to_bool($^O eq 'linux');
}

# 変数が数値か判別する。
sub is_int {
  my $x = shift;
  if (!defined($x)) {
    return False;
  }
  my $y = \$x;
  if (ref($y) eq 'SCALAR') {
    if ($x eq '') {
      return False;
    }
    else {
      return ($x ^ $x ? False : True);
    }
  }
  else {
    return False;
  }
}

# 変数が文字列か判別する。
sub is_str {
  my $x = shift;
  if (!defined($x)) {
    return False;
  }
  my $y = \$x;
  if (ref($y) eq 'SCALAR') {
    if ($x eq '') {
      return True;
    }
    else {
      return ($x ^ $x ? True : False);
    }
  }
  else {
    return False;
  }
}

# 引数が定義(not undef)されていたら 1 を返す。
sub isset {
  my $x = shift;
  return defined($x) == 1 ? True : False;
}

# 引数が未定義(undef)の場合なら 1 を返す。
sub isnull {
  my $x = shift;
  return defined($x) eq '' ? True : False;
}

# 変数をBOOL値に変換する。
sub to_bool {
  my $rv;
  my $x = shift;
  if (defined($x)) {
    if (is_int($x) == True) {
      $rv = $x == 0 ? False : True;
    }
    else {
      $rv = $x eq '' ? False : True
    }
  }
  else {
    $rv = False;
  }
  return $rv;
}

# 変数を文字列に変換する。
sub to_str {
  my $x = shift;
  return $x . '';
}

# 変数を整数に変換する。
sub to_int {
  my $x = shift;
  return int($x);
}

# true を返さないといけない。
1;
