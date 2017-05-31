#! /usr/bin/perl -w

use 5.010;
use Getopt::Std;

sub weather_forecast {
    my $city = $_[0];
    say "this is the forecast weather of $city."
}

sub weather_live {
    my $city = $_[0];
    say "this is the live weather of $city."
}

sub main {
    my %opt;
    getopts('a:', \%opt);
    if ($opt{a}) {
        weather_forecast($opt{a});
    } else {
        weather_live($ARGV[0]);
    }
}

main;

