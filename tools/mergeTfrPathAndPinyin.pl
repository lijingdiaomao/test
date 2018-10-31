#!/usr/bin/perl -w
open Tfr,"<:utf8",$ARGV[0] or die $!;
open PinyinID,"<:utf8",$ARGV[1] or die $!;
open PathPinyin,">:utf8",$ARGV[2] or die $!;

my %tfr;
my %pinyin_id;

while(<PinyinID>){
  chomp;
  @A=split /\t/,$_;
  $pinyin_id{$A[0]}=$A[1];
}

while(<Tfr>){
  chomp;
  @B=split /\//,$_;
  @C=split /\./,$B[$#B];
  print PathPinyin "$_ $pinyin_id{$C[0]}\n"
}

close Tfr;
close PinyinID;
close PathPinyin;


