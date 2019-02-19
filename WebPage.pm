package WebPage;
# 簡易 CGI クラス

use strict;
use warnings;
use utf8;
use CGI;
use CGI::Cookie;
use HTML::Entities;
use constant True =>  1;
use constant False => 0;
use constant APPCONF => 'AppConf.ini';
use constant LOGFILE => '/var/www/data/WebPage.log';
use constant UPLOAD => '/var/www/data';


# コンストラクタ
sub new {
  my $class = shift;  # クラス名
  my $template = "";
  if ($#_ >= 0) {
    $template = shift;
  }
  my $self = CGI->new;
  $self->{html} = "";
  $self->{headers} = ();
  $self->{params} = $self->{param};
  my %cookies = fetch CGI::Cookie;
  $self->{vars} = {};
  $self->{vkey} = ();
  $self->{nkeys} = 0;
  $self->{nheaders} = 0;
  $self->{conf} = {};
  # クラスにするおまじない。メンバ変数を保持する連想配列をクラス名に連携する。
  bless $self, $class;
  # AppConf.ini を読む。
  $self->readConf();
  # HTML テンプレートファイルを読む。
  if ($template ne '') {
    $self->loadFile($template);
    # HTTP ヘッダーを設定する。
    $self->{headers}->[0] = "Content-Type: text/html; charset=utf8";
    $self->{nheaders} = 1;
    # クッキーがあればヘッダーに追加する。
    my $i = $self->{nheaders};
    foreach my $key (keys(%cookies)) {
       $self->{headers}->[$i] = sprintf("Set-Cookie: %s", $cookies{$key});
       $i += 1;
    }
    $self->{nheaders} = $i;
  }
  return $self;
}

# 応答を返す。 void echo()
sub echo {
  my $self = shift;
  # プレースホルダを実値で置き換える。
  my $n = $self->{nkeys};
  for (my $i = 0; $i < $n; $i++) {
    my $key = $self->{vkeys}->[$i]; 
    my $phol = "\\(\\*$key\\*\\)";
    my $repl = $self->{vars}->{$key};
    $self->{html} =~ s/$phol/$repl/g;
  }
  # HTML ヘッダーを出力する。
  $self->send_headers();
  # HTML 本体を出力する。
  print $self->{html};
}

# ポストバックかどうか。 bool isPostback(key)
sub isPostback {
  my $self = shift;
  my $key = shift;
  my $val = $self->{param}->{$key};
  my $r = defined($val);
  return to_bool($r);
}

# AppConf.ini を読む。 void readConf()
sub readConf {
  my $self = shift;
  if (!(-f APPCONF)) {
    return;
  }
  open(FH, "<", APPCONF);
  while (<FH>) {
    chomp;
    next if (/^#.*/);
    my @a = split('=', $_);
    my $key = $a[0];
    my $val = $a[1];
    $self->{conf}->{$key} = $val;
  }
  close(FH);
}


# テンプレートファイルを読み込む。 void loadFile()
sub loadFile {
  my $self = shift;
  my $filePath = shift;
  if ($filePath ne "") {
    $self->{html} = "";
    open(FH, "<", $filePath);
    while (<FH>) {
      $self->{html} .= $_;
    }
    close(FH);
  }
}


# HTTP ヘッダーをすべて送信する。  void send_header()
sub send_headers {
  my $self = shift;
  for (my $i = 0; $i < $self->{nheaders}; $i++) {
    print $self->{headers}->[$i], "\n";
  }
  print "\n";
}


# HTTP ヘッダーを $self->{headers} に追加する。 void add_header(header);
sub add_header {
  my $self = shift;
  my $header = shift;
  my $n = $self->{nheaders};
  $self->{headers}->[$n] = $header;
  $n += 1;
  $self->{nheaders} = $n;
}

# プレースホルダのキー：値を設定する。  void setPlaceHolder(key, val)
sub setPlaceHolder {
  my $self = shift;
  my $key = shift;
  my $val = shift;

  $self->{vars}->{$key} = $val;
  my $n = $self->{nkeys};
  $self->{vkeys}->[$n] = $key;
  $n += 1;
  $self->{nkeys} = $n;
}

# プレースホルダの値を得る。  str getPlaceHolder(key)
sub getPlaceHolder {
  my $self = shift;
  my $key = shift;
  return $self->{vars}->{$key};
}

# キー key 値 value のクッキーをセットする。void setCookie(key, value)
sub setCookie {
  my $self = shift;
  my $key = shift;
  my $val = shift;
  if ($self->isCookie($key)) {
    my $n = $self->{nheaders};
    for (my $i = 0; $i < $n; $i++) {
      my $header = $self->{headers}->[$i];
      if ($header =~ /^Set\-Cookie: $key=\w+/) {
        my @a = split(/=/, $header);
        $self->{headers}->[$i] = $a[0]. "=" . $val ;
      }
    }
  }
  else {
    my $i = $self->{nheaders};
    my $cookie = sprintf("Set-Cookie: %s=%s", $key, $val);
    $self->{headers}->[$i] = $cookie;
    $i += 1;
    $self->{nheaders} = $i;
  }
}

# クッキーのキー key が存在すれば、その連想配列の値 、なければ "" を返す。 str getCookie(key)
sub getCookie {
  my $self = shift;
  my $k = shift;
  my $v = "";
  my $n = $self->{nheaders};
  for (my $i = 0; $i < $n; $i++) {
     my $header = $self->{headers}->[$i];
     if ($header =~ /^Set\-Cookie: $k=\w+/) {
        my @a = split(/[=|;]/, $header);
        $v = $a[1];
     }
  }
  return $v;
}


# キーで指定されるクッキーが存在すれば True を返す。 bool isCookie(key)
sub isCookie {
  my $self = shift;
  my $key = shift;
  my $n = $self->{nheaders};
  for (my $i = 0; $i < $n; $i++) {
      my $header = $self->{headers}->[$i];
     if ($header =~ /Set\-Cookie: $key=\w+/) {
        return True;
     }
  }
  return False;
}

# パラメータのキー key が存在すれば、その連想配列の値 (self.params[key].value) 、なければ "" を返す。 str getparam(key)
sub getParam {
  my $self = shift;
  my $key = shift;
  my $value = "";
  if (exists($self->{params}->{$key})) {
    $value = $self->{params}->{$key}->[0];
  }
  return $value;
}


# パラメータにキーが存在すれば true を返す。  bool isParam(key)
sub isParam {
  my $self = shift;
  my $key = shift;
  my $b = exists($self->{params}->{$key});
  return to_bool($b);
}


# <name>str</name> を作る。str tag(name, str)
sub tag {
  my $name = shift;
  my $str = shift;
  return "<$name>$str</$name>";
}

# HTML テーブル行を作る。 str table_row(columns)
sub table_row {
  my @cols = shift;
  my $row = "<tr>";
  foreach (@cols) {
     $row .= "<td>$_</td>";
  }
  $row .= "</tr>\n";
  return $row;
}

# HTML エスケープされた文字列にする。 static str escape(text)
sub escape {
  my $text = shift;
  return encode_entities($text, q{&<>"'});
}

# key で指定されたアップロードされたファイルを UPLOAD ディレクトリへ保存する。void saveFile(key)
sub saveFile {
  my $self = shift;
  my $file = shift;
  my $file_param = $self->{params}->{$file};
  my $filename = $file_param->[0];
  my $save_file = UPLOAD . "/" . $filename;
  my $buffer;
  open(FH, ">", $save_file);
  while (my $byteread = read($filename, $buffer, 1024)){
    print FH $buffer;
  }
  close(FH);
}

# HTTPヘッダーと画像ファイルを送信する。static void sendImage(file)
sub sendImage {
  my $path = shift;
  # 画像ファイルを読む。
  my @bytes = ();
  open(FH, "<", $path);
  binmode(FH);
  while (sysread(FH, my $b, 1)) {
    push(@bytes, ord($b));
  }
  close(FH);
  
  # HTTP ヘッダを送る。
  my @matches = ($path =~ /\.\w+$/g);
  my $ext = $matches[0];
  if (lc($ext) eq '.jpg') {
    print "Content-Type: image/jpeg\n\n";
  }
  elsif (lc($ext) eq '.png') {
    print "Content-Type: image/png\n\n";
  }
  else {
    print "Content-Type: image/gif\n\n";
  }
  # 画像データを送信
  foreach (@bytes) {
    print chr($_);
  }
  print "\n";
}

# HTTPヘッダー(application/json)とJSON 形式文字列を送信する。 static void sendJson(json)
sub sendJson {
  my $json = shift;
  print "Content-Type: application/json; charset=utf-8\n\n";
  print "$json\n";
}

# HTTPヘッダー(text/plain)と文字列を送信する。static void sendText(text)
sub sendText {
  my $text = shift;
  print "Content-Type: text/plain; charset=utf-8\n\n";
  print "$text\n";
}

# 指定した URL へジャンプする。static void redirect(url)
sub redirect {
  my $url = shift;
  my $html = << "EOS";
<html>
<head>
<meta charset="utf-8" />
<title>redirect</title>
<meta http-equiv="refresh" content="0;URL=" />
</head>
<body>
<div style="margin-left:25%;margin-top:50px;">
<a href="URL=">Click here to jump.</a>
</div>
</body>
</html>
EOS
  $html =~ s/URL=/URL=$url/g;
  print "Content-Type: text/html\n\n";
  print $html;
}

# 変数をBOOL値に変換する。  static bool to_bool(v)
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


# 変数が数値か判別する。  static bool is_int(v)
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


#  ログ出力   static void log_output(message, level="info")
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



# 1 を返す。(おまじない)
1;

