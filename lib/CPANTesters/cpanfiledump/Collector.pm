package CPANTesters::cpanfiledump::Collector;
use Moose::Role;

requires 'collect';

has cpanfiledump => (
  is => 'ro',
  isa => 'CPANTesters::cpanfiledump',
  required => 1,
  weak_ref => 1,
);

1;
