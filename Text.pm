package Text;
#  文字列処理関数パッケージ
use strict;
use warnings;
use utf8;

use parent qw(Exporter);
our @EXPORT_OK = qw(isdigit isalpha isdelim isprint tolower toupper len append substring left right times format money);

# 定数定義
use constant False => 0;
use constant True => 1;
use constant VERSION => '1.01';

# ASCII 文字が数字かどうか判別する。 bool isdigit(c)
sub isdigit {
  my $c = shift;
  return False if ($c eq '');
  my $a = ord($c);
  if (($a >= 0x30) && ($a <= 0x39)) {
    return True;
  }
  else {
    return False;
  }
}

# ASCII 文字が英字かどうか判別する。 bool isalpha(c)
sub isalpha {
  my $c = shift;
  return False if ($c eq '');
  my $a = ord($c);
  if (($a >= 0x41 && $a <= 0x5a) || ($a >= 0x61 && $a <= 0x7a)) {
    return True;
  }
  else {
    return False;
  }
}

# ASCII 文字が区切りかどうか判別する。 bool isdelim(c)
sub isdelim {
  my $c = shift;
  return False if (isdigit($c) || isalpha($c));
  my $a = ord($c);
  if (($a >= 0x20) && ($a <= 0x7e)) {
    return True;
  }
  else {
    return False;
  }
}

# ASCII 文字が表示可能かどうか判別する。bool isprint(c)
sub isprint {
  my $c = shift;
  my $a = ord($c);
  if (($a >= 0x20) && ($a <= 0x7e)) {
    return True;
  }
  else {
    return False;
  }
}

# 文字列に含まれる英大文字をすべて小文字に変換する。
sub tolower {
  my $s = shift;
  return lc($s);
}


# 文字列に含まれる英小文字をすべて大文字に変換する。
sub toupper {
  my $s = shift;
  return uc($s);
}


# 文字列の長さ int len(str)
sub len {
  my $str = shift;
  return length($str);
}

# 文字列に別の文字列を連結する。string append(str, other)
sub append {
  my $str = shift;
  my $other = shift;
  my $rs = $str . $other;
  return $rs;
}

# 部分文字列 string substring(str, start, length)
sub substring {
  my $str = shift;
  my $start = shift;
  my $length = shift;
  return substr($str, $start, $length);
}

# str の先頭から長さ length の部分文字列を返す。
sub left {
  my $str = shift;
  my $length = shift;
  return substr($str, 0, $length);
}

# str の最後から長さ length の部分文字列を返す。
sub right {
  my $str = shift;
  my $length = -shift;
  return substr($str, $length);
}

# 同じ文字からなる長さ n の文字列を得る。string times(c, n)
sub times {
  my $c = shift;
  my $n = shift;
  my $buff = "";
  for (my $i = 0; $i < $n; $i++) {
    $buff .= $c;
  }
  return $buff;
}


# 書式化文字列を返す(引数は6個まで)。 string format(form, ...)
sub format {
  my $form = shift;
  my $result = "";
  
  if ($#_ == 0) {
    $result = sprintf($form, $_[0]);
  }
  elsif ($#_ == 1) {
    $result = sprintf($form, $_[0], $_[1]);
  }
  elsif ($#_ == 2) {
    $result = sprintf($form, $_[0], $_[1], $_[2]);
  }
  elsif ($#_ == 3) {
    $result = sprintf($form, $_[0], $_[1], $_[2], $_[3]);
  }
  elsif ($#_ == 4) {
    $result = sprintf($form, $_[0], $_[1], $_[2], $_[3], $_[4]);
  }
  elsif ($#_ == 5) {
    $result = sprintf($form, $_[0], $_[1], $_[2], $_[3], $_[4], $_[5]);
  }
  else {
    $result = "error";
  }
}

# 金額文字列にカンマを三桁ごとに挿入する。 string money(string num)
sub money {
  my $num = shift;
  1 while $num =~ s/(.*\d)(\d\d\d)/$1,$2/;
  return $num;
}


# おまじないとして最後に 1 を返す。
1;
