#!/usr/bin/perl -w
use strict;
my ($ref_file, $fix_file)=@ARGV;
my %hash;
open IN,"<:utf8",$ref_file or die $!;
open OUT,">:utf8",$fix_file or die $!;
while(<IN>)
{
  chomp;
  my @A=split /\t/,$_;
  my $utt=shift @A;
  my $pinyin=shift @A;
  #$pinyin=~s/ /%20/g;
  $pinyin=~s/\|/ /g;
  print OUT "$pinyin\n";
}
close IN;
close OUT;
