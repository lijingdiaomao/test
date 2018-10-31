#!/usr/bin/perl -w
use Data::Dumper;

my @sentences;
my $max_repeat = 99999999;
my $min=99999999999999;
#my %reduce_ptns = (
#'ruo qi'=>99999999,
#);

open IN1,"<:utf8",$ARGV[0] or die $!;
open IN2,"<:utf8",$ARGV[1] or die $!;
my %reduce_ptns;
while(<IN1>){
    chomp;
    my $line =$_;
    $line =~ s/\,$//g;
    #print "$line\n";
    my @A = split /\t/, $line;
    my $key = shift @A;
    #$key =~ s/'//g;
    my $value = shift @A;
    #print "$key\t$value\n";
    $reduce_ptns{$key} = $value;
    $min = $value if $min > $value;

}

foreach $key(keys %reduce_ptns) {
    $reduce_ptns{$key} = $reduce_ptns{$key} - $min;
    print "$key\t$reduce_ptns{$key}\n";
}

#print Dumper(\%reduce_ptns);

open OUT1,">:utf8",$ARGV[2] or die $!;
#open OUT2,">:utf8",$ARGV[3] or die $!;

while (<IN2>) {
    chomp;
    my @cols = split /\t/,$_;
    die "error format: $_\n" if @cols != 2;
    #print "1\:$cols[1]\n";
    my $now_count = 0;
    $now_count = $sentences{$cols[1]} if exists $sentences{$cols[1]};
    next if $now_count >= $max_repeat;
    $sentences{$cols[1]} = $now_count + 1;

    my @words = split /\|/, $cols[1];
    my $words = "@words";
    #print "2\:@words\n";
    my $is_skip = 0;
    #print "1\:$cols[1]\n";
    #print "2\:@words\n";
    foreach $reduce_ptn(keys %reduce_ptns) {
        next if $reduce_ptns{$reduce_ptn} <= 0;
        if ($words =~ /$reduce_ptn\s|$reduce_ptn$/) {
            $reduce_ptns{$reduce_ptn} --;
            $is_skip = 1;
        }
    }
    next if $is_skip;
        
    #print "3\:@words\n";
    #print "4\:$cols[0]\t$cols[1]\n";
    #print OUT1 "@words\n";
    print OUT1 "$cols[0]\t$cols[1]\n";
    #print OUT1 "@words\n";
    #print STDERR "$cols[0]\t$cols[1]\n";
}
close IN1;
close IN2;
close OUT1;
#close OUT2;
