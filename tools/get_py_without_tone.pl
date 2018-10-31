#!/usr/bin/perl
# 2018-01-27
# lcfan@rokid.com
use strict;
open IN,"$ARGV[0]" or die $!;
open OUT,">$ARGV[1]" or die $!;
while(<IN>)
{
  chomp;
  my @A=split /\t/,$_;
  my $utt=shift @A;
  my $line=shift @A;
  my @B=split /\|/,$line;
  my $flag=0;
  foreach my $seg(@B){
    if(not $seg=~/p_/){
      $flag=1;
      last;
    }
  }
  if(not $flag){
    $line=~s/p_//g;
    $line=~s/\d//g;
    print OUT "$utt\t$line\n";
  }
  #else{print "$line\n";}
}
close IN;
close OUT;

