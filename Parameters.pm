package Parameters;
# パラメータクラス
use strict;
use warnings;
use utf8;

# 定数定義
use constant False => 0;
use constant True => 1;
use constant VERSION => '1.0';


# コンストラクタ  new()
sub new {
  my $class = shift;
  my $self = {};
  bless $self, $class;
  $self->_parse();
  return $self;
}

# @ARGV を分析して params に格納する。 内部で使用するメソッド。  void _parse()
sub _parse {
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

# 指定したキーのオプション値または指定したインデックスの文字列を得る。ない場合は undef を返す。 string get(string key|int idx)
sub get {
  my $self = shift;
  my $key = shift;
  my $val = undef;
  if (exists($self->{params}->{$key})) {
    $val = $self->{params}->{$key};
  }
  return $val;
}

# オプションのキー数    int num_option()
sub num_option {
  my $self = shift;
  return $self->{nkeys};
}

# パラメータ(非オプション)の数   int num_param()
sub num_param {
  my $self = shift;
  return $self->{nidx};
}

# オプションのキーを得る。string get_optionkey(int n)
sub get_optionkey {
  my $self = shift;
  my $n = shift;
  return $self->{keys}->[$n];
}



# おまじないとして必要。(require の約束事)
1;
