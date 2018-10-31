#!/usr/bin/perl
use strict;
open IN,"<:utf8",$ARGV[0] or die $!;
open OUT,">:utf8",$ARGV[1] or die $!;
open OUTQi,">:utf8",$ARGV[2] or die $!;
my $num = 0;
while(<IN>){
  chomp;
  if($_ =~ /\|qi\|/){
    if($num < 200000){
      print OUTQi "$_\n";
      $num=$num + 1; 
    }else{
      next;
    }
  }else{
    print OUT "$_\n";
  }
}
close IN;
close OUT;
close OUTQi;
print "$num";
