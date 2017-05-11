package CPANTesters::cpanfiledump::Report;
use Moose;

has cpanfiledump => (
  is => 'ro',
  isa => 'CPANTesters::cpanfiledump',
  required => 1,
);

has prereqs => (
  is => 'ro',
  isa => 'HashRef',
  required => 1,
);

sub to_cpanfile {
  my ($self) = @_;

  my $lines;

  my $fmt = "requires %-49s => '== %10s';\n";

  my $prereqs = $self->prereqs;

  for my $k (sort keys $prereqs) {
    $lines .= sprintf($fmt, "'$k'", $prereqs->{$k});
  }

  return $lines;
}
 
1;
