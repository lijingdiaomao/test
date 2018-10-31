 #!/usr/bin/perl -w
 use strict;
 use File::Basename;
 die("Usage: filter_txt.pl wavlist ref.all ref.select!\n")if(@ARGV<3);
 my ($ref_file, $new_file, $fix_file)=@ARGV;
 my %hash;
 open IN,"<:utf8",$ref_file or die $!;
 while(<IN>)
 {
   chomp;
   my @A=split /\t/,$_;
   my $utt = shift @A;
   my $line=$_;
   # $utt =~ s/^.*\/(.*?)\.pcm$/$1/;
   #$utt =~ s/^(.*)(\_ch\d\_16k\_i16)$/$1/;
   $utt =~ s/^.*\/(.*?)(\_ch\d\_.*pcm)$/$1/;
   #$_ = basename $_;
   $hash{$utt}=$line;
   #print "$utt\n";
 }
 close IN;
 
 open IN,"<:utf8",$new_file or die $!;
 open OUT,">:utf8",$fix_file or die $!;
 while(<IN>)
 {
   chomp;
   ##my @A=split /\t/,$_;
   #my $utt = shift @A;
   my $utt = $_;
   #$utt=~s/\.pcm$//;
   $utt =~ s/^.*\/(.*?)(\_ch\d\_.*\.tfr)$/$1/;
   #print "$utt\n";
   #my $text =shift @A;
   if(exists $hash{$utt}){
     #print OUT "$utt\t$text\n";
     #print OUT "$_\n";
     print "$_\n";
     #delete $hash{$utt};
   }else{
       #print "$_\n";
       print OUT "$_\n";
   }
 }
 close IN;
 close OUT;
 
