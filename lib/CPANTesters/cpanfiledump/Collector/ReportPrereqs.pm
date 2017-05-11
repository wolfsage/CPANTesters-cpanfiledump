package CPANTesters::cpanfiledump::Collector::ReportPrereqs;
use Moose;

with 'CPANTesters::cpanfiledump::Collector';

# Grab prereqs from t/report-prereqs.t
#
# -----------------------------
# PREREQUISITES
# -----------------------------
#
# section

sub collect {
  my ($self, $lines) = @_;

  my (%prereqs, $found_start);

  while (@$lines) {
    my $line = shift @$lines;

    if ($line =~ /^# Versions for all modules listed in/i) {
      $found_start = 1;

    } elsif ($found_start && $line =~ /^[^#]/) {
      # Go until we see no more comment output
      last;

    } elsif ($found_start) {
      next if $line =~ /-----/;
      next if $line =~ /^\s*$/;
      next if $line =~ /Module (Name)?.*Have/;

      unless ($line =~ /^# \s*([^\s]+)\s+([^\s]+)\s*([^\s]+)?\s*$/) {
        next;
      }

      my ($mod, $need, $have) = ($1, $2, $3);

      unless ($have) {
        ($have, $mod) = ($mod, $need);
      }

      next if $have eq 'missing';
      next if $mod eq 'Module' && $have eq 'Version';

      if ($prereqs{$mod} && $prereqs{$mod} ne $have) {
        warn "Found $mod twice in module report-prereqs section, with versions $prereqs{$mod} and $have\n";
      }

      $prereqs{$mod} = $have;
    }
  }

  return \%prereqs;
}

1;
