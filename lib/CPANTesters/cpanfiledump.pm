package CPANTesters::cpanfiledump;
# ABSTRACT: generate a cpanfile to replicate an install of a cpan report
use Moose;
use Carp qw(croak);
use Path::Tiny;

use CPANTesters::cpanfiledump::Report;
use CPANTesters::cpanfiledump::Collector::ModuleToolchainVersions;

has _collectors => (
  is => 'ro',
  traits  => [ 'Array' ],
  lazy => 1,
  default => sub {
    my ($self) = @_;

    return [
      CPANTesters::cpanfiledump::Collector::ModuleToolchainVersions->new({
        cpanfiledump => $self,
      }),
    ];
  },
  handles => {
    'collectors' => 'elements',
  }
);

sub parse_raw {
  my ($self, $filename_or_blob) = @_;

  my $lines = $self->_get_report_from_html($filename_or_blob);

  my $prereqs = $self->_collect_prereqs($lines);

  return CPANTesters::cpanfiledump::Report->new({
    cpanfiledump => $self,
    prereqs      => $prereqs
  });
}

sub _get_report_from_html {
  my ($self, $filename_or_blob) = @_;

  if (ref $filename_or_blob eq 'SCALAR') {
    return [ split /\n/, $$filename_or_blob ];
  } elsif (my $reftype = ref $filename_or_blob) {
    croak("Expected filename or scalarref, got $reftype");
  }

  my $file = path($filename_or_blob);
  unless ($file && $file->exists) {
    croak("Cannot find file $filename_or_blob");
  }

  my @lines = $file->lines;

  my ($found_start, @report);

  while (@lines) {
    my $line = shift @lines;

    if ($line =~ /^\s*<pre>\s*$/) {
      $found_start = 1;
    } elsif ($line =~ /<\/pre>/) {
      last;
    } elsif ($found_start) {
      push @report, $line;
    }
  }

  unless (@report) {
    croak("Could not find an email within the report");
  }

  return \@report;
}

sub _collect_prereqs {
  my ($self, $lines) = @_;

  my %prereqs;

  for my $collector ($self->collectors) {
    my $found = $collector->collect($lines);

    if ($found && %$found) {
      for my $have (keys %$found) {
        my $ver = $found->{$have};

        if ($prereqs{$have} && $prereqs{$have} ne $ver) {
          warn("$have: Already claim to have $prereqs{$have}, now saying we have $ver?!");
        }

        $prereqs{$have} = $ver;
      }
    }
  }

  return \%prereqs;
}

1;
