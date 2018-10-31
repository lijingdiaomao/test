#!/usr/bin/perl
my $infile=$ARGV[0];
my $outfile=${infile}.".size";
my $errfile=${infile}.".err";
open IN,"$infile" or die $!;
open O,">$outfile" or die $!; 
#open E,">$errfile" or die $!;
while(<IN>)
{
  chomp;
  #my @A=split /\t/,$_;
  my @args = stat ($_);
  my $size = $args[7];
  #if($size > 0){
   # print O "$_\n";
  #}else{
   # print E "$_\n";
  #}
  print O "$_\t$size\n";
}
close IN;
close O;
#close ERR;
