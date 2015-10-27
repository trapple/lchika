use strict;
use warnings;
use utf8;
use Carp;
use 5.020;
use lib 'lib';
use GPIO;
use Time::HiRes;
use AnyEvent;

main();

sub main {

  my $gpio = GPIO->new({
    channel => 17,
    direction => "out",
    verbose => 1
  });

  my $cv = AE::cv;
  my $value = 0;
  my $w; $w = AE::timer 0, 0.5, sub {
    my $v = $value % 2;
    $gpio->set($v);
    $value = ++$v;
  };

  my $finalize = AE::signal "INT", sub {
    print "\n";
    $gpio->unexport();
    $cv->send;
    undef $w;
  };

  $cv->recv;
  undef $finalize;
  say "Bye!!";
}

