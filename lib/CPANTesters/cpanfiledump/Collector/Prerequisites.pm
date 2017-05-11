package CPANTesters::cpanfiledump::Collector::Prerequisites;
use Moose;

with 'CPANTesters::cpanfiledump::Collector';

# Grab prereqs from the
#
# -----------------------------
# PREREQUISITES
# -----------------------------
#
# section

sub collect {
  my ($self, $lines) = @_;

  my (%prereqs, $found_start);

  # Do we expect have first, or want first?
  my $first = 'want';

  while (@$lines) {
    my $line = shift @$lines;

    if ($line =~ /^\s*PREREQUISITES\s*$/i) {
      # -----------------------------
      # PREREQUISITES
      # -----------------------------
      $found_start = 1;

      # Skip wrapping '---------' since the next time we see a '-' at the
      # start of a line we'll assume we've reached the end of this section
      if ($lines->[0] =~ /^-+/) {
        shift @$lines;
      }

    } elsif ($line =~ /^\s*PREREQUISITES:\s*$/i) {
      #
      # PREREQUISITES:
      #
      $found_start = 1;

      if ($lines->[1] =~ /here is a list/i) {
        shift @$lines; shift @$lines;
      }

    } elsif ($found_start && $line =~ /^-+\s*$/) {
      # Go until we see what looks like another header or the ending --
      last;

    } elsif ($found_start) {
      last if $line =~ /Perl module toolchain versions installed/;

      next if $line =~ /-----/;
      next if $line =~ /^\s*$/;
      # requires: build_requires: etc...
      next if $line =~ /^[a-z_ ]+:\s*$/i;
      next if $line =~ /No requirements found/;

      if ($line =~ /Module.*?(Want|Need|Have).*?(Want|Need|Have)/i) {
        if ($1 =~ /want|need/i) {
          $first = 'want';
        } else {
          $first = 'have';
        }

        next;
      }

      # Module       Need Have (or Have Need)
      # Mod::ule     0.4  0.05
      unless ($line =~ /^\s*([^\s]+)\s+([^\s]+)\s*([^\s]+)\s*$/) {
        warn "Found bizarre line in prerequisites section: $line\n";

        next;
      }

      my ($mod, $need, $have) = ($1, $2, $3);

      if ($first eq 'have') {
        ($need, $have) = ($have, $need);
      }

      next if $have eq 'missing';

      if ($prereqs{$mod} && $prereqs{$mod} ne $have) {
        warn "Found $mod twice in module toolchian section, with versions $prereqs{$mod} and $have\n";
      }

      $prereqs{$mod} = $have;
    }
  }

  return \%prereqs;
}

1;
