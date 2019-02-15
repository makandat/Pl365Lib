package FileSystem;
#  ファイルシステム共通パッケージ
use strict;
use warnings;
use utf8;
use File::Copy qw/copy move/;
use File::stat;
use File::Basename;
use Cwd;
use Cwd 'abs_path';
use File::Temp qw/ tempfile tempdir /;



# 定数定義
use constant False => 0;
use constant True => 1;

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

# ファイルをすべて読み込んで文字列として返す。readAllText(filePath, encode);
sub readAllText {
  my $param_count = $#_ + 1;
  my $filePath = shift;
  my $encode = "UTF-8";
  if ($param_count >= 2) {
    $encode = shift;
  }
  my $buff = "";
  $encode = ":encoding(" . $encode . ")";
  open(FH, "<".$encode, $filePath);
  while (my $row = <FH>) {
    $buff .= $row;
  }
  close(FH);
  return $buff;
}


# ファイルをすべて読み込んで配列として返す。readAllLines(filePath, encode);
sub readAllLines {
  my $param_count = $#_ + 1;
  my $filePath = shift;
  my $encode = "UTF-8";
  if ($param_count >= 2) {
    $encode = shift;
  }
  my @lines = ();
  $encode = ":encoding(" . $encode . ")";
  open(FH, "<".$encode, $filePath);
  while (my $row = <FH>) {
    push(@lines, $row.chomp);
  }
  close(FH);
  return @lines;
}

# 文字列をファイルに上書きまたは追加する。writeAllText(filePath, text, mode, encode);
sub writeAllText {
  my $param_count = $#_ + 1;
  my $filePath = shift;
  my $text = shift;
  my $mode = ">";
  if ($param_count >= 3) {
    my $wr = shift;
    if ($wr eq 'w') {
      $mode = ">";
    }
    elsif ($wr eq 'a') {
      $mode = ">>";
    }
    else {
      return;
    }
  } 
  my $encode = "UTF-8";
  if ($param_count >= 4) {
    $encode = shift;
  }
  $mode = $mode . ":encoding(" . $encode . ")";
  open(FH, $mode, $filePath);
  print FH $text;
  close(FH);
}
  
# 文字列の配列(参照)をすべてファイルに書く。 writeAllLines(filePath, str_array, mode, encode);
sub writeAllLines {
  my $param_count = $#_ + 1;
  my $filePath = shift;
  my $array = shift;
  my $mode = ">"; 
  if ($param_count >= 3) {
    my $wr = shift;
    if ($wr eq 'w') {
      $mode = ">";
    }   
    elsif ($wr eq 'a') {
      $mode = ">>";
    }   
    else {
      return;
    }   
  }   
  my $encode = "UTF-8";
  if ($param_count >= 4) {
    $encode = shift;
  }
  $mode = $mode . ":encoding(" . $encode . ")";
  open(FH, $mode, $filePath);
  foreach (@$array) {
    print FH $_ . "\n";
  }
  close(FH);
}


# バイナリーファイルをすべて読んでバイト列(参照)として返す。 byte[] readBinary(filePath)
sub readBinary {
  my $filePath = shift;
  my @bytes = ();
  open(FH, "<", $filePath);
  binmode(FH);
  while (sysread(FH, my $b, 1)) {
    push(@bytes, ord($b));
  }
  close(FH);
  return \@bytes;
}

# バイト列をファイルにそのまま書く。writeBinary(filePath, buffer)
sub writeBinary {
  my $filePath = shift;
  my $bytes = shift;
  open(FH, ">", $filePath);
  binmode(FH);
  foreach my $b (@$bytes) {
    my $bi = chr($b);
    syswrite(FH, $bi, 1);
  }
  close(FH);
}

# ファイルをコピーする。 void _copy(src, dest)
sub _copy {
  my $src = shift;
  my $dest = shift;
  copy $src, $dest;
}

# ファイルを移動する。  void _move(src, dest)
sub _move {
  my $src = shift;
  my $dest = shift;
  move $src, $dest;
}

# ファイルやリンクを削除する。 void _unlink(file)
sub _unlink {
  my $file = shift;
  unlink $file;
}

# シンボリックリンクを作成する。
sub createSymbolicLink {
  my $file = shift;
  my $symname = shift;
  symlink($file, $symname);
}

# ファイルを削除する。 void deleteFile($file)
sub deleteFile {
  my $file = shift;
  unlink $file;
}

# オブジェクトのモードを変更する。 void chmod(file, mode)
sub _chmod {
  my $file = shift;
  my $mode = shift;
  chmod $mode, $file;
}

# ファイルなどが存在するかどうかを返す。 bool exists(obj)
sub exists {
  my $file = shift;
  return to_bool(-e $file);
}

# オブジェクトがファイルかどうかを返す。 bool isFile(obj)
sub isFile {
  my $file = shift;
  return to_bool(-f $file);
}

# オブジェクトがディレクトリかどうかを返す。 bool isDirectory(obj)
sub isDirectory {
  my $dir = shift;
  return to_bool(-d $dir);
}

# オブジェクトがリンクかどうかを返す。 bool isLink(obj)
sub isLink {
  my $dir = shift;
  return to_bool(-l $dir);
}


# オブジェクトの属性を返す。  mode_array getAttr(file)
sub getAttr {
  my $file = shift;
  if (-l $file) {
    return lstat($file);
  }
  else {
    return stat($file);
  }
}

# ファイルの長さを返す。  int getLength(file)
sub getLength {
  my $file = shift;
  my $a = stat($file);
  return $a->size;
}

# 最後に更新された日時を返す。  str getUpdated(file)
sub getUpdated {
  my $file = shift;
  my $a = stat($file);
  my ($sec, $min, $hour, $day, $mon, $year) = localtime($a->mtime);
  my $s = sprintf("%04d-%02d-%02d %02d:%02d:%02d", $year, $mon, $day, $hour, $min, $sec);
  return $s;
}

# モードを返す。
sub getMode {
  my $file = shift;
  my $a = stat($file);
  return $a->mode;
}


# オブジェクトの所有者を返す。
sub getOwner {
  my $file = shift;
  my $a = stat($file);
  return getpwuid($a->uid);
}

# オブジェクトのグループを返す。
sub getGroup {
  my $file = shift;
  my $a = stat($file);
  return getgrgid($a->gid);
}

# 現在のディレクトリを変更する。
sub _chdir {
  my $dir = shift;
  chdir($dir);
}

# ディレクトリを作成する。
sub _mkdir {
  my $dir = shift;
  mkdir $dir;
}

# ディレクトリを削除する。
sub _rmdir {
  my $dir = shift;
  my $force = shift;
  if ($force) {
    exec ['rm', '-rf', $dir];
  }
  else {
    rmdir $dir;
  }
}

# ホームディレクトリを得る。
sub getHome {
  return $ENV{'HOME'};
}

# 現在のディレクトリを得る。
sub getCurrentDirectory {
  return getcwd;
}


# 指定したフォルダのファイル一覧を得る。
sub listFiles {
  my $dir = shift;
  my $wildcard = "*";
  if ($#_ == 0) {
    $wildcard = shift;
  }
  $dir .= "/";
  $dir .= $wildcard;
  my @list = glob $dir;
  my @files = ();
  foreach (@list) {
    if (-f $_) {
      push @files, $_;
    }
  }
  return \@files;
}

# 指定したフォルダのサブディレクトリ一覧を得る。
sub listDirectories {
  my $dir = shift;
  my $wildcard = "*";
  if ($#_ == 0) {
    $wildcard = shift;
  }
  $dir .= "/";
  $dir .= $wildcard;
  my @list = glob $dir;
  my @dirs = ();
  foreach (@list) {
    if (-d $_) {
      push @dirs, $_;
    }
  }
  return \@dirs;
}


# パスのファイル部分を得る。
sub getFileName {
  my $path = shift;
  return basename($path);
}

# パスのディレクトリ部分を得る。
sub getDirectoryName {
  my $path = shift;
  return dirname($path);
}

# パスの拡張子部分を得る。(ドットを含む)
sub getExtension {
  my $path = shift;
  my @matches = ($path =~ /\.\w+$/g);
  if ($#matches < 0) {
    return "";
  }
  else {
    return $matches[0];
  }
}

# 指定した相対パスの絶対パスを得る。
sub getAbsolutePath {
  my $relpath = shift;
  return abs_path($relpath);
}


# 一時ファイルを得る。
sub getTempFile {
  my $dir = tempdir( CLEANUP => 1 );
  my ($fh, $filename) = tempfile( DIR => $dir );
  return $filename;
}

# 指定したファイルの拡張子を変更する。
sub changeExt {
  my $path = shift;
  my $ext2 = shift;
  my $ext = getExtension($path);
  $path =~ s/$ext$/$ext2/;
  return $path;
}


# おまじないとして必要。(require の約束事)
1;
