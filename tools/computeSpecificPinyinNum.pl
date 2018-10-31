#!/usr/bin/perl -w

open IN,"<:utf8",$ARGV[0] or die $!;
open SPY,"<:utf8",$ARGV[1] or die $!;
open OUT,">:utf8",$ARGV[2] or die $!;
my %hash;
my %spy;
while(<SPY>){
  chomp;
  $spy{$_}++;
}
while(<IN>){
  chomp;
  my @A=split /\s/,$_;
  foreach(@A)
  {
    $hash{$_}++;
  }
}
while (($k, $v) = each %hash) {
  if(exists $spy{$k} ){
    print OUT "$k $v\n";
  }
}

close OUT;
close SPY;
close IN;
