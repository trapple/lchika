use strict;
use warnings;
use utf8;
use Carp;
use 5.020;
use lib 'lib';
use GPIO;

main();

sub main {

  my $gpio = GPIO->new({
    channel => 17,
    direction => "out",
    verbose => 1
  });

  my $loop = 1;
  local $SIG{INT} = sub {
    print "\n";
    $gpio->unexport();
    $loop = 0;
  };

  while($loop) {
    $gpio->set(time % 2);
    sleep(1);
  }
  say "Bye!!";
}

