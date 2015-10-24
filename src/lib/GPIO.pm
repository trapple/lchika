package GPIO;
use strict;
use warnings;
use utf8;
use Carp;
use IO::File;

use Class::Tiny qw/channel direction verbose value/;

our $GPIO_EXPORT = '/sys/class/gpio/export';
our $GPIO_UNEXPORT = '/sys/class/gpio/unexport';
our $GPIO_DIRECTION = '/sys/class/gpio/gpio%d/direction';
our $GPIO_VALUE = '/sys/class/gpio/gpio%d/value';

sub BUILD {
  my ($self, $args) = @_;

  $self->channel || croak "channel is required.";
  $self->direction || croak "direction is required.";

  $self->export();
  $self->init();
}

sub export {
  my $self = shift;

  open my $fh, '>', $GPIO_EXPORT || croak $!;
  warn "export $self->channel > $GPIO_EXPORT" if $self->verbose;
  print $fh $self->channel;
  close $fh;

  open my $fh_direction, '>', sprintf($GPIO_DIRECTION, $self->channel) || croak $1;
  print $fh_direction $self->direction;
  close $fh_direction;
}

sub init {
  my $self = shift;
  open my $fh, '>', sprintf($GPIO_VALUE, $self->channel) || croak $!;
  $fh->autoflush(1);
  $self->value($fh);
}

sub set {
  my $self = shift;
  my $val = $_[0] ? 1 : 0; 
  warn "set value = $val" if $self->verbose;
  print {$self->value} $val;
}

sub unexport {
  my $self = shift;
  open my $fh, '>', $GPIO_UNEXPORT || croak $!;
  print "unexport $self->channel > $GPIO_UNEXPORT", "\n";
  print $fh $self->channel;
  close $fh;
}

1;
