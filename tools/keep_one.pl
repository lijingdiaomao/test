#!/usr/bin/perl
use strict;
open IN,"<:utf8",$ARGV[0] or die $!;
open OUT,">:utf8",$ARGV[1] or die $!;
my %hash;
while(<IN>){
  chomp;
  my @A=split /\t/,$_;
  if( ! exists $hash{$A[1]}){
    print OUT "$_\n";
  }elsif($hash{$A[1]}< 100){
    print OUT "$_\n";
  }
  $hash{$A[1]}++;
}
close IN;
close OUT;

foreach(sort {$hash{$b}<=>$hash{$a}} keys %hash){
  print "$_\t$hash{$_}\n";
}
