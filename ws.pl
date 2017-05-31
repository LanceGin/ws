#! /usr/bin/perl -w

use 5.010;
use Getopt::Std;
use LWP::UserAgent;
use JSON;

$GD_KEY = "c1f8aa28560b5144e73a80205fae124b";

sub get_weather {
    my $ua = LWP::UserAgent->new;
    my $url = "http://restapi.amap.com/v3/weather/weatherInfo";
    my $city = "武汉";
    my $extention = "base";
    my $args = "?key=$GD_KEY\&city=$city\&extention=$extention";
    my $req = HTTP::Request->new(GET => $url.$args);

    my $res = $ua->request($req);
    if ($res->is_success) {
        my $content =  $res->content;
        return $content;
    }
    else {
        say $res->status_line;
    }
}

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
        my $weather = get_weather;
        my $json_scalar = from_json($weather);
        say $json_scalar->{"lives"}->[0]->{"weather"};
    }
}

main;

