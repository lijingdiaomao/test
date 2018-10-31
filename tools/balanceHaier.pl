#!/usr/bin/perl -w

open IN,"<:utf8",$ARGV[0] or die $!;
open SPY,"<:utf8",$ARGV[1] or die $!;
open OUT,">:utf8",$ARGV[2] or die $!;
my %hash;
my %spy;
while(<SPY>){
  chomp;
  my @str=split /\s/,$_;
  $spy{$str[0]}=$str[1];
  print "$_";
  if($str[1] > 100000){
    print("big\n");
    
  }else{
    print("samll\n");
  }
}

while(<IN>){
  chomp;
  my @A=split /\s/,$_;
  foreach(@A)
  {
    if($spy{$_} < 100000){
       foreach(@A)
       {
         $hash{$_}++;
       }         
    }elsif($spy{$_} > 200000){
         
    }
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
