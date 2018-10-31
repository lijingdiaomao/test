#!/usr/bin/perl
use strict;
use File::Basename;
#use Math::Round;
use POSIX;
open IN,"<:utf8",$ARGV[0] or die $!;
open OUT,">:utf8",$ARGV[1] or die $!;
my $numerator = $ARGV[2];  #分子
my $denominator =$ARGV[3]; #分母
my %hash;
my %num;
while(<IN>){
  chomp;
  my @A=split /\t/,$_;
  my $name = shift @A;
  $name =~ s/(.*\_[F M]).*/$1/g;
  #print "$name\n";
  if( ! exists $hash{$name}){
      $hash{$name}=1;
  }else{
      $hash{$name}++;
  }
}
#close IN;
#open IN,"<:utf8",$ARGV[0] or die $!;
seek(IN,0,0);
while(<IN>){
    chomp;
    my @A=split /\t/,$_;
    my $name = shift @A;
    $name =~ s/(.*\_[F M]).*/$1/g;
    #print "$name\n";
    if( ! exists $num{$name}){
        $num{$name} = int($hash{$name}*$numerator/$denominator);
        if($num{$name}==0){
            $num{$name}=1;
        }
        #print "$_\t$num{$name}\t$hash{$name}\n";
        print OUT "$_\n";
        $num{$name}--;
    }elsif($num{$name} > 0){
        print OUT "$_\n";
        $num{$name}--;
    }

}

close IN;
close OUT;

#foreach(sort {$hash{$b}<=>$hash{$a}} keys %hash){
#  print "$_\t$hash{$_}\n";
#}
