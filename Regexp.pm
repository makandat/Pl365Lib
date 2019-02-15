package Regexp;
# 正規表現クラス
use strict;
use warnings;
use utf8;


# コンストラクタ  new(regex)
sub new {
  my $class = shift;
  my $sr = shift;  # regex
  my $self = {};
  $self->{re} = $sr;
  
  bless $self, $class;
}

# 指定した部分文字列が含まれているかどうかを返す。 bool ismatch(str)
sub ismatch {
  my $self = shift;
  my $str = shift;
  return $str =~ m"$self->{re}";
}


# 部分文字列を検索して見つかったものを返す。str matches(str)
sub matches {
  my $self = shift;
  my $str = shift;
  my $n = shift;
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

# 部分文字列を置き換える。str replace(str, pattern, new)
sub replace {
  my $self = shift;
  my $str = shift;  # str
  my $rep = shift;  # replaced
  my $pat = qr/$self->{re}/;  # pattern
  $str =~ s/$pat/$rep/g;
  return $str;
}


# 部分文字列で元の文字列を分割した配列を返す。array split(str)
sub split {
  my $self = shift;
  my $str = shift;
  return split(qr/$self->{re}/, $str);
}




#  おまじないとして必要。(require の約束事)
1
