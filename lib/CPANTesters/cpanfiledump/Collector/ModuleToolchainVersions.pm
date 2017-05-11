package CPANTesters::cpanfiledump::Collector::ModuleToolchainVersions;
use Moose;

with 'CPANTesters::cpanfiledump::Collector';

sub collect {
  my ($self, $lines) = @_;

  my (%prereqs, $found_start);

  for my $line (@$lines) {
    if ($line =~ /^\s*Perl module toolchain versions installed:\s*$/i) {
      $found_start = 1;

    } elsif ($found_start && $line =~ /^\s*--\s*$/) {

      last;
    } elsif ($found_start && $line =~ /^\s*$/ && %prereqs) {
      # Found some prereqs and got a blank line? We're done
      last;

    } elsif ($found_start) {
      next if $line =~ /Module Name.*Have/;
      next if $line =~ /-----/;
      next if $line =~ /^\s*$/;

      # Mod::ule     0.4
      unless ($line =~ /^\s*([^\s]+)\s+([^\s]+)\s*$/) {
        warn "Found bizarre line in module toolchain section: $line\n";

        next;
      }

      my ($mod, $ver) = ($1, $2);

      next if $mod eq 'Module' && $ver eq 'Have';
      next if $ver eq 'n/a';

      if ($prereqs{$mod} && $prereqs{$mod} ne $ver) {
        warn "Found $mod twice in module toolchian section, with versions $prereqs{$mod} and $ver\n";
      }

      $prereqs{$mod} = $ver;
    }
  }

  return \%prereqs;
}

1;
