use strict;
use warnings;

use lib qw(lib);

use Path::Tiny;
use Test::More 0.88;
use Test::Differences;

use CPANTesters::cpanfiledump;

subtest "prereqs - style one" => sub {
  # Make sure we can understand:
  #
  # -----------------------------
  # PREREQUISITES
  # -----------------------------

my $file = 't/corpus/prereqs-and-prereqs-t';
  my $want = <<EOF;
requires 'CPAN'                                            => '==       2.05';
requires 'CPAN::Meta'                                      => '==   2.142690';
requires 'CPAN::Meta::Check'                               => '==      0.009';
requires 'CPAN::Meta::Requirements'                        => '==      2.127';
requires 'Carp'                                            => '==     1.3301';
requires 'Class::Load'                                     => '==       0.22';
requires 'Class::Load::XS'                                 => '==       0.08';
requires 'Cwd'                                             => '==       3.47';
requires 'Data::OptList'                                   => '==      0.109';
requires 'Devel::GlobalDestruction'                        => '==       0.12';
requires 'Devel::OverloadInfo'                             => '==      0.002';
requires 'Devel::StackTrace'                               => '==       2.00';
requires 'Dist::CheckConflicts'                            => '==       0.11';
requires 'Eval::Closure'                                   => '==       0.11';
requires 'ExtUtils::CBuilder'                              => '==   0.280220';
requires 'ExtUtils::Command'                               => '==       1.18';
requires 'ExtUtils::Install'                               => '==       2.04';
requires 'ExtUtils::MakeMaker'                             => '==       7.00';
requires 'ExtUtils::Manifest'                              => '==       1.68';
requires 'ExtUtils::ParseXS'                               => '==       3.24';
requires 'File::Spec'                                      => '==       3.47';
requires 'JSON'                                            => '==       2.90';
requires 'JSON::PP'                                        => '==    2.27203';
requires 'List::MoreUtils'                                 => '==       0.33';
requires 'List::Util'                                      => '==       1.40';
requires 'MRO::Compat'                                     => '==       0.12';
requires 'Module::Build'                                   => '==     0.4210';
requires 'Module::Runtime'                                 => '==      0.014';
requires 'Module::Runtime::Conflicts'                      => '==      0.001';
requires 'Module::Signature'                               => '==       0.73';
requires 'Package::DeprecationManager'                     => '==       0.13';
requires 'Package::Stash::XS'                              => '==       0.28';
requires 'Params::Util'                                    => '==       1.07';
requires 'Parse::CPAN::Meta'                               => '==     1.4414';
requires 'Scalar::Util'                                    => '==       1.40';
requires 'Sub::Exporter'                                   => '==      0.987';
requires 'Sub::Name'                                       => '==       0.12';
requires 'Task::Weaken'                                    => '==       1.04';
requires 'Test::CleanNamespaces'                           => '==       0.16';
requires 'Test::Fatal'                                     => '==      0.013';
requires 'Test::Harness'                                   => '==       3.33';
requires 'Test::More'                                      => '==   1.001008';
requires 'Test::Requires'                                  => '==       0.08';
requires 'Test::Warnings'                                  => '==      0.016';
requires 'Try::Tiny'                                       => '==       0.22';
requires 'YAML'                                            => '==       1.13';
requires 'YAML::Syck'                                      => '==       1.27';
requires 'parent'                                          => '==      0.228';
requires 'strict'                                          => '==       1.08';
requires 'version'                                         => '==     0.9909';
requires 'warnings'                                        => '==       1.23';
EOF

  my $dumper = CPANTesters::cpanfiledump->new;

  my $report = $dumper->parse_raw($file);
  eq_or_diff($report->to_cpanfile, $want, 'our cpanfile looks good');
};

subtest "prereqs - style two" => sub {
  # Make sure we can understand:
  #
  # PREREQUISITES:
  #

my $file = 't/corpus/prereqs-t';
  my $want = <<EOF;
requires 'CPAN::Meta::Check'                               => '==      0.009';
requires 'CPAN::Meta::Requirements'                        => '==      2.125';
requires 'CPANPLUS'                                        => '==     0.9152';
requires 'CPANPLUS::Dist::Build'                           => '==       0.78';
requires 'Carp'                                            => '==     1.3301';
requires 'Class::Load'                                     => '==       0.22';
requires 'Class::Load::XS'                                 => '==       0.08';
requires 'Cwd'                                             => '==       3.47';
requires 'Data::OptList'                                   => '==      0.109';
requires 'Devel::GlobalDestruction'                        => '==       0.13';
requires 'Devel::OverloadInfo'                             => '==      0.002';
requires 'Devel::StackTrace'                               => '==       2.00';
requires 'Dist::CheckConflicts'                            => '==       0.11';
requires 'Eval::Closure'                                   => '==       0.11';
requires 'ExtUtils::CBuilder'                              => '==   0.280220';
requires 'ExtUtils::Command'                               => '==       1.18';
requires 'ExtUtils::Install'                               => '==       2.04';
requires 'ExtUtils::MakeMaker'                             => '==       6.98';
requires 'ExtUtils::Manifest'                              => '==       1.68';
requires 'ExtUtils::ParseXS'                               => '==       3.24';
requires 'File::Spec'                                      => '==       3.47';
requires 'List::MoreUtils'                                 => '==       0.33';
requires 'List::Util'                                      => '==       1.38';
requires 'MRO::Compat'                                     => '==       0.12';
requires 'Module::Build'                                   => '==     0.4210';
requires 'Module::Runtime'                                 => '==      0.014';
requires 'Module::Runtime::Conflicts'                      => '==      0.001';
requires 'Package::DeprecationManager'                     => '==       0.13';
requires 'Package::Stash'                                  => '==       0.37';
requires 'Package::Stash::XS'                              => '==       0.28';
requires 'Params::Util'                                    => '==       1.07';
requires 'Pod::Parser'                                     => '==       1.62';
requires 'Pod::Simple'                                     => '==       3.28';
requires 'Scalar::Util'                                    => '==       1.38';
requires 'Sub::Exporter'                                   => '==      0.987';
requires 'Sub::Name'                                       => '==       0.12';
requires 'Task::Weaken'                                    => '==       1.04';
requires 'Test::CleanNamespaces'                           => '==       0.16';
requires 'Test::Fatal'                                     => '==      0.013';
requires 'Test::Harness'                                   => '==       3.33';
requires 'Test::More'                                      => '==   1.001006';
requires 'Test::Requires'                                  => '==       0.08';
requires 'Test::Warnings'                                  => '==      0.016';
requires 'Try::Tiny'                                       => '==       0.22';
requires 'parent'                                          => '==      0.228';
requires 'strict'                                          => '==       1.08';
requires 'version'                                         => '==     0.9909';
requires 'warnings'                                        => '==       1.23';
EOF

  my $dumper = CPANTesters::cpanfiledump->new;

  my $report = $dumper->parse_raw($file);
  is(
    $report->to_cpanfile,
    $want,
    'our cpanfile looks good'
  );
  eq_or_diff($report->to_cpanfile, $want, 'our cpanfile looks good');
};

done_testing;
