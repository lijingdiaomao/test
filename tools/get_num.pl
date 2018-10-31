#!/usr/bin/perl
my $infile=$ARGV[0];
#my $outfile=${infile}.".size";
open IN,"$infile" or die $!;
open O,">$ARGV[1]" or die $!; 
#open E,">$errfile" or die $!;a
my $num = 0;
while(<IN>)
{
  chomp;
  my @A=split / /,$_;
  #my @args = stat ($_);
  $num = $num + @A;
  #if($size > 0){
   # print O "$_\n";
  #}else{
   # print E "$_\n";
  #}
}
print O "$infile\t$num\n";
close IN;
close O;
#close ERR;
