package MySQL;
#  MySQL 簡易操作クラス
#    (DBD::mysql インストール)  sudo apt-get install libdbd-mysql-perl
#    (Windows Active Perl インストール) ppm install DBD-mysql
use strict;
use warnings;
use utf8;
use DBD::mysql;

# 定数定義
use constant VERSION => '1.0';
use constant False => 0;
use constant True => 1;
use constant APPCONF => 'AppConf.ini';

# コンストラクタ
sub new {
  my $param_count = $#_ + 1;
  my $class = shift;
  my $self = {
    dbh => undef    # DB ハンドル
  };
  # 接続文字列を得る。(例) server=127.0.0.1;uid=root;pwd=12345;database=test
  my $connstring = "";
  if ($param_count >= 2) {
    $connstring = shift;
  }
  # 接続情報を得る。
  my %connection_info;
  if ($connstring eq "") {
    # AppConf.ini ファイルから接続情報を取得する。
    %connection_info = readAppConf();
  }
  else {
    # 接続文字列から接続情報を得る。
    %connection_info = getConnectionInfo($connstring);
  }
  # 接続ハンドル(インスタンス変数)
  my $dsn = "DBI:mysql:database=".$connection_info{'db'}.";host=".$connection_info{'host'};
  my $uid = $connection_info{'uid'};
  my $pwd = $connection_info{'pwd'};
  $self->{dbh} = DBI->connect($dsn, $uid, $pwd);
  # クラスにするおまじない。メンバ変数を保持する連想配列をクラス名に連携する。
  bless $self, $class;
}

# AppConf.ini を読んで接続情報を返す。
sub readAppConf {
  my %conn;
  open(FH, "<", APPCONF);
  while (<FH>) {
    chomp;
    next if (/^#.*/);
    my @a = split('=', $_);
    my $key = $a[0];
    my $val = $a[1];
    $conn{$key} = $val;
  }
  close(FH);
  return %conn;
}

# 接続文字列から接続情報を返す。
sub getConnectionInfo {
  my %conn;
  my $connstr = shift;
  my @a = split(';', $connstr);
  if ($a[0] eq 'server') {
    $conn{'host'} = $a[1];
  }
  elsif ($a[0] eq 'database') {
    $conn{'db'} = $a[1];
  }
  else {
    $conn{$a[0]} = $a[1];
  }
  return %conn;
}


# 接続を開く。
sub mysql_open {
  my $self = shift;
  my $host = shift;
  my $uid = shift;
  my $pwd = shift;
  my $db = shift;
  $self->dbh = DBI->connect("DBI:mysql:database=.$db;host=$host", $uid, $pwd, {AutoCommit=>1});
}

# 接続を閉じる。
sub mysql_close {
  my $self = shift;
  $self->{dbh}->disconnect();

}

# 結果を返すクエリーを行って行のコレクションを返す。
sub query {
  my $self = shift;
  my $sql = shift;
  my @rows = ();
  my $sth = $self->{dbh}->prepare($sql);
  $sth->execute();
  while (my @row = $sth->fetchrow_array()) {
    push(@rows, \@row);
  }
  $sth->finish();
  return @rows;
}

# 結果を返すクエリーを行って列名の連想配列の参照配列を返す。
sub query2 {
  my $self = shift;
  my $sql = shift;
  my @rows = ();
  my $sth = $self->{dbh}->prepare($sql);
  $sth->execute();
  while (my $row = $sth->fetchrow_hashref()) {
    push(@rows, $row);
  }
  $sth->finish();
  return @rows;
}

# 結果を返さないクエリーを行う。
sub execute {
  my $self = shift;
  my $sql = shift;
  $self->{dbh}->do($sql);
}

# 値を一つだけ返すクエリーを行って値を返す。
sub get_value {
  my $self = shift;
  my @rows = ();
  my $sql = shift;
  my $sth = $self->{dbh}->prepare($sql);
  $sth->execute();
  my $row = $sth->fetchrow_arrayref();
  my $value = $row->[0];
  $sth->finish();
  return $value;
}


# おまじないとして必要
1;
