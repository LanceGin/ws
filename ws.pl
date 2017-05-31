#! /usr/bin/perl -w

use 5.010;
use Getopt::Std;

sub main {
    my %opt;
    getopts('a:', \%opt);
    if ($opt{a}) {
        print "show weather forecast of $opt{a}\n";
    } else {
        print "show weather live of $ARGV[0]\n";
    }
}

main;

