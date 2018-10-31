#!/usr/bin/perl -w

open IN,"<:utf8",$ARGV[0] or die $!;
open SPY,"<:utf8",$ARGV[1] or die $!;
open OUT,">:utf8",$ARGV[2] or die $!;
my %hash;
my $total=0;
my $rate=0;
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
    $total++;
  }
}
while (($k, $v) = each %hash) {
  $rate=$v/$total;  
  if(exists $spy{$k} ){
    print OUT "$k $rate\n";
  }
}

close OUT;
close SPY;
close IN;
