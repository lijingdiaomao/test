#!/usr/local/bin/perl
use strict;
open IN,"$ARGV[0]" or die $!;
open OUT,">$ARGV[1]" or die $!;
my $count=0;
while(<IN>)
{
  chomp;
  my @A=split /\t/,$_;
  my $fid=shift @A;
  my $line=shift @A;
  if($line=~/\|bu\|/){
    # print "$line\n";
    if($count < 170000){
      $count++;
      next;
    }
  }
  print OUT "$_\n";
}
close IN;
close OUT;
