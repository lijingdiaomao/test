#!/usr/bin/perl -w
open IN,"<:utf8",$ARGV[0] or die $!;
open OUT,">:utf8",$ARGV[1] or die $!;
my %hash;
my $total=0;
my $rate=0;
while(<IN>){
  chomp;
  my @A=split /\s/,$_;
  foreach(@A)
  {
    $hash{$_}++;
    $total++;
  }
}
close IN;
while (($k, $v) = each %hash) {
  $rate=$v/$total;  
  print OUT "$k $rate\n";

}

close OUT;
