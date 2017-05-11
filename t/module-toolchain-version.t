use strict;
use warnings;

use lib qw(lib);

use Path::Tiny;
use Test::More 0.88;

use CPANTesters::cpanfiledump;

subtest "module-toolchain-version" => sub {
  # Module::Signature is skipped since it's n/a
  my $file = 't/corpus/no-prereqs';
  my $want = <<EOF;
requires 'CPAN'                                            => '==       2.03';
requires 'CPAN::Meta'                                      => '==   2.133380';
requires 'Cwd'                                             => '==       3.45';
requires 'ExtUtils::CBuilder'                              => '==   0.280212';
requires 'ExtUtils::Command'                               => '==       1.18';
requires 'ExtUtils::Install'                               => '==       1.61';
requires 'ExtUtils::MakeMaker'                             => '==       6.86';
requires 'ExtUtils::Manifest'                              => '==       1.63';
requires 'ExtUtils::ParseXS'                               => '==       3.23';
requires 'File::Spec'                                      => '==       3.45';
requires 'JSON'                                            => '==       2.90';
requires 'JSON::PP'                                        => '==    2.27203';
requires 'Module::Build'                                   => '==     0.4203';
requires 'Parse::CPAN::Meta'                               => '==     1.4409';
requires 'Test::Harness'                                   => '==       3.30';
requires 'Test::More'                                      => '==   1.001002';
requires 'YAML'                                            => '==       0.88';
requires 'YAML::Syck'                                      => '==       1.27';
requires 'version'                                         => '==     0.9906';
EOF

  my $dumper = CPANTesters::cpanfiledump->new;

  my $report = $dumper->parse_raw($file);
  is(
    $report->to_cpanfile,
    $want,
    'our cpanfile looks good'
  );
};

done_testing;
