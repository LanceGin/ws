#! /usr/bin/perl -w

use 5.010;
use Getopt::Std;
use LWP::UserAgent;
use JSON;

$GD_KEY = "c1f8aa28560b5144e73a80205fae124b";

sub get_weather {
    my $ua = LWP::UserAgent->new;
    my $url = "http://restapi.amap.com/v3/weather/weatherInfo";
    my $city = $_[0];
    my $extensions = $_[1];
    my $args = "?key=$GD_KEY\&city=$city\&extensions=$extensions";
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

sub show_live {
    my $data = $_[0];
    my $live = $data->{"lives"}->[0];
    say "您好！您查询的".$live->{"city"}."实时天气情况如下：";
    say "   位置：".$live->{"city"};
    say "   天气：".$live->{"weather"};
    say "   气温：".$live->{"temperature"};
    say "   空气湿度：".$live->{"humidity"};
    say "   风向：".$live->{"winddirection"};
    say "   风力：".$live->{"windpower"};
}

sub show_forecast {
    my $data = $_[0];
    my $forecast = $data->{"forecasts"}->[0];
    say "您好！您查询的".$forecast->{"city"}."近期天气情况如下：";
    say "---------------------------------------------------------------------------";
    say "   日期      星期      白天天气      晚上天气      最低气温      最高气温";
    say "---------------------------------------------------------------------------";
    my $casts = $forecast->{"casts"};
    for (my $i = 0; $i < 4; $i++) {
        my $cast = $casts->[$i];
        my $date = $cast->{"date"};
        my $week = $cast->{"week"};
        my $dayweather = $cast->{"dayweather"};
        my $nightweather = $cast->{"nightweather"};
        my $daytemp = $cast->{"daytemp"};
        my $nighttemp = $cast->{"nighttemp"};
        printf "%s    %s          %-5s          %-5s          %s            %s\n", $date, $week, $dayweather, $nightweather, $nighttemp, $daytemp
    }
}

my %opt;
my $weather;
my $json_scalar;

getopts('a:', \%opt);
if ($opt{a}) {
    $weather = get_weather($opt{a}, "all");
    $json_scalar = from_json($weather);
    show_forecast($json_scalar);
} else {
    $weather = get_weather($ARGV[0], "base");
    $json_scalar = from_json($weather);
    show_live($json_scalar);
}
