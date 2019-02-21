package DateTime;
#  日付時間パッケージ (クラス)
use strict;
use warnings;
use utf8;
use Time::Piece ':override';
our @ISA = qw(Time::Piece);
use Time::Local;
use Time::Seconds;

# 定数定義
use constant False => 0;
use constant True => 1;
use constant VERSION => '1.0';

our $timezone = "JST";

# コンストラクタ new(pt)
sub new {
  my $class = shift;
  my $self;
  if ($#_ >= 0) {
    my $pt = shift;
    if (lc($pt) eq 'utc' || lc($pt) eq 'gmt') { 
      $self = gmtime;
    }
    else {
      $self = Time::Piece->strptime($pt, "%Y-%m-%d %H:%M:%S");
    }
  }
  else {
    $self = localtime;
  }
  bless $self, $class;
  return $self;
}


# このインスタンスを日付時刻文字列に変換する。(ISO 8601 標準)
sub toString {
  my $self = shift;
  my $result = $self->ymd . " " . $self->hms;
  return $result;
}

# このインスタンスの日付部分を日付文字列に変換する。(ISO 8601 標準)
sub toDateString {
  my $self = shift;
  my $result = $self->ymd;
  return $result;
}

# このインスタンスの時刻部分を時刻文字列に変換する。(ISO 8601 標準)
sub toTimeString {
  my $self = shift;
  my $result = $self->hms;
  return $result;
}

# このインスタンスのタイムスタンプ (実数)
sub timestamp {
  my $self = shift;
  return timelocal($self->sec, $self->min, $self->hour, $self->mday, $self->mon - 1, $self->year);
}

# タイムスタンプを日付時刻に変換する。
sub from_timestamp {
  my $timestamp = shift;
  my ($sec, $min, $hour, $day, $mon, $year) = localtime($timestamp);
  my $s = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year, $mon, $day, $hour, $min, $sec);
  return $s;
}



# おまじないとして 1 を返す。(require の約束事)
1;
