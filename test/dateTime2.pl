#!/usr/bin/perl
#  DateTime クラスのテスト
require "../DateTime.pm";

# オブジェクト作成
my $dt1 = DateTime->new('GMT');
print $dt1->toString(), "\n";
my $dt2 = DateTime->new('2010-09-10 13:22:00');
print $dt2->toString(), "\n";

# 日付要素
printf("%04d年%02d月%02d日\n", $dt2->year, $dt2->mon, $dt2->mday);

# 計算
my $dt3 = $dt2 + 60*60*1 + 60*1 + 1;
printf("%02d時%02d分%02d秒\n", $dt2->hour, $dt2->min, $dt2->sec);
printf("%02d時%02d分%02d秒\n", $dt3->hour, $dt3->min, $dt3->sec);

# タイムスタンプ
printf("%d\n", $dt1->timestamp());

# クラス変数
print $DateTime::timezone, "\n";

# 終わり
print "Done.\n";
