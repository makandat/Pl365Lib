package Parameters;
# パラメータクラス
use strict;
use warnings;
use utf8;


# コンストラクタ  new()
sub new {
  my $class = shift;
  my $self = {};
  bless $self, $class;
  $self->parse();
  return $self;
}

# @ARGV を分析して params に格納する。
sub parse {
  my $key;
  my $idx = 0;
  my $kix = 0;
  my $self = shift;
  for (@ARGV) {
    if (/^\-[a-z,A-Z]/) {
      $key = substr($_, 1);
      $self->{keys}->[$kix] = $key;
      $kix += 1;
    }
    elsif (defined($key)) {
      $self->{params}->{$key} = $_;
      $key = undef;
    }
    else {
      $self->{params}->{$idx} = $_;
      $idx += 1;
    }
  }
  $self->{nkeys} = $kix;
  $self->{nidx} = $idx;
}

# 指定したキーのオプション値または指定したインデックスの文字列を得る。ない場合は undef を返す。
sub get {
  my $self = shift;
  my $key = shift;
  my $val = undef;
  if (exists($self->{params}->{$key})) {
    $val = $self->{params}->{$key};
  }
  return $val;
}

# オプションのキー数
sub numkey {
  my $self = shift;
  return $self->{nkeys};
}

# パラメータ(非オプション)の数
sub numparam {
  my $self = shift;
  return $self->{nidx};
}

# オプションのキーを得る。
sub getkey {
  my $self = shift;
  my $n = shift;
  return $self->{keys}->[$n];
}



# おまじないとして必要。(require の約束事)
1;
