package Regexp;
# 正規表現クラス
use strict;
use warnings;
use utf8;

# 定数定義
use constant False => 0;
use constant True => 1;
use constant VERSION => '1.0';


# コンストラクタ  new(regex)
sub new {
  my $class = shift;
  my $sr = shift;  # regex
  my $self = {};
  $self->{re} = $sr;
  
  bless $self, $class;
}

# 内部で使用。変数が数値か判別する。static bool is_int(v)
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


# 内部で使用。変数をBOOL値に変換する。static bool to_bool(v)
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


# 指定した部分文字列が含まれているかどうかを返す。 bool ismatch(str)
sub ismatch {
  my $self = shift;
  my $str = shift;
  my $b = $str =~ m"$self->{re}";
  return to_bool($b);
}


# 部分文字列を検索して見つかったものを返す(最大５個まで)。str matches(str, n=0)
sub matches {
  my $self = shift;
  my $str = shift;
  my $n = 0;
  if ($#_ >= 0) {
    $n = shift;
  }
  $str =~ m"$self->{re}";
  if ($n == 0) {
    return $1;
  }
  elsif ($n == 1) {
    return $2;
  }
  elsif ($n == 2) {
    return $3;
  }
  elsif ($n == 3) {
    return $4;
  }
  else {
    return $5;
  }
}

# 部分文字列を置き換える。static string replace(str, pattern, new)
sub _replace {
  my $str = shift;  # str
  my $pat = shift;  # pattern
  my $rep = shift;  # replaced
  $str =~ s/$pat/$rep/g;
  return $str;
}


# 部分文字列で元の文字列を分割した配列を返す。static array split(str, pattern)
sub _split {
  my $str = shift;
  my $pat = shift;  # pattern
  return split(/$pat/, $str);
}

# 配列の要素を結合する。 static string join(\arr, delim)
sub _join {
  my $rar = shift;
  my $delim = shift;
  return join($delim, @$rar);
}


#  おまじないとして必要。(require の約束事)
1
