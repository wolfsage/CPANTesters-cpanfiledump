use strict;
use warnings;

use lib qw(lib);

use Path::Tiny;
use Test::More 0.88;
use Test::Differences;

use CPANTesters::cpanfiledump;

subtest "report-prereqs - style 1" => sub {
  # Make sure we can understand report-prereqs output

  # #     Module               Want     Have
  # #     -------------------- ---- --------
  # #     Dist::CheckConflicts 0.02     0.11
  # #     ExtUtils::CBuilder   0.27 0.280220
  # #     ExtUtils::MakeMaker   any     6.98
  # #     File::Spec            any     3.47


my $file = 't/corpus/report-prereqs-only';
my $want = <<EOF;
requires 'CPAN::Meta'                                      => '==   2.142690';
requires 'CPAN::Meta::Check'                               => '==      0.009';
requires 'CPAN::Meta::Requirements'                        => '==      2.125';
requires 'Carp'                                            => '==     1.3301';
requires 'Class::Load'                                     => '==       0.22';
requires 'Class::Load::XS'                                 => '==       0.08';
requires 'Data::OptList'                                   => '==      0.109';
requires 'Devel::GlobalDestruction'                        => '==       0.13';
requires 'Devel::OverloadInfo'                             => '==      0.002';
requires 'Devel::StackTrace'                               => '==       2.00';
requires 'Dist::CheckConflicts'                            => '==       0.11';
requires 'Eval::Closure'                                   => '==       0.11';
requires 'ExtUtils::CBuilder'                              => '==   0.280220';
requires 'ExtUtils::MakeMaker'                             => '==       6.98';
requires 'File::Spec'                                      => '==       3.47';
requires 'IO::File'                                        => '==       1.16';
requires 'List::MoreUtils'                                 => '==       0.33';
requires 'List::Util'                                      => '==       1.38';
requires 'MRO::Compat'                                     => '==       0.12';
requires 'Module::Runtime'                                 => '==      0.014';
requires 'Module::Runtime::Conflicts'                      => '==      0.001';
requires 'Package::DeprecationManager'                     => '==       0.13';
requires 'Package::Stash'                                  => '==       0.37';
requires 'Package::Stash::XS'                              => '==       0.28';
requires 'Params::Util'                                    => '==       1.07';
requires 'Scalar::Util'                                    => '==       1.38';
requires 'Sub::Exporter'                                   => '==      0.987';
requires 'Sub::Name'                                       => '==       0.12';
requires 'Task::Weaken'                                    => '==       1.04';
requires 'Test::CleanNamespaces'                           => '==       0.16';
requires 'Test::Deep'                                      => '==      0.113';
requires 'Test::Fatal'                                     => '==      0.013';
requires 'Test::More'                                      => '==   1.001006';
requires 'Test::Requires'                                  => '==       0.08';
requires 'Test::Warnings'                                  => '==      0.016';
requires 'Try::Tiny'                                       => '==       0.22';
requires 'parent'                                          => '==      0.228';
requires 'strict'                                          => '==       1.08';
requires 'warnings'                                        => '==       1.23';
EOF

  my $dumper = CPANTesters::cpanfiledump->new;

  my $report = $dumper->parse_raw($file);
  eq_or_diff($report->to_cpanfile, $want, 'our cpanfile looks good')
    or warn $report->to_cpanfile;
};

subtest "report-prereqs - style 2" => sub {
  # Make sure we can understand report-prereqs output

  # #     Module               Want     Have
  # #     -------------------- ---- --------
  # #     Dist::CheckConflicts 0.02     0.11
  # #     ExtUtils::CBuilder   0.27 0.280220
  # #     ExtUtils::MakeMaker   any     6.98
  # #     File::Spec            any     3.47


my $file = 't/corpus/report-prereqs-only-other-style';
my $want = <<EOF;
requires 'CPAN::Meta'                                      => '==   2.133380';
requires 'CPAN::Meta::Requirements'                        => '==      2.125';
requires 'Carp'                                            => '==       1.32';
requires 'Class::Load'                                     => '==       0.20';
requires 'Class::Load::XS'                                 => '==       0.06';
requires 'Data::OptList'                                   => '==      0.109';
requires 'Devel::GlobalDestruction'                        => '==       0.12';
requires 'Devel::PartialDump'                              => '==       0.17';
requires 'Devel::StackTrace'                               => '==       1.30';
requires 'Dist::CheckConflicts'                            => '==       0.10';
requires 'Eval::Closure'                                   => '==       0.11';
requires 'ExtUtils::CBuilder'                              => '==   0.280212';
requires 'ExtUtils::MakeMaker'                             => '==       6.86';
requires 'File::Spec'                                      => '==       3.45';
requires 'List::MoreUtils'                                 => '==       0.33';
requires 'MRO::Compat'                                     => '==       0.12';
requires 'Module::Runtime'                                 => '==      0.013';
requires 'Package::DeprecationManager'                     => '==       0.13';
requires 'Package::someoneh'                               => '==       0.36';
requires 'Package::someoneh::XS'                           => '==       0.28';
requires 'Params::Util'                                    => '==       1.07';
requires 'Scalar::Util'                                    => '==       1.35';
requires 'Sub::Exporter'                                   => '==      0.987';
requires 'Sub::Name'                                       => '==       0.05';
requires 'Task::Weaken'                                    => '==       1.04';
requires 'Test::Fatal'                                     => '==      0.013';
requires 'Test::More'                                      => '==   1.001002';
requires 'Test::Requires'                                  => '==       0.07';
requires 'Try::Tiny'                                       => '==       0.18';
requires 'parent'                                          => '==      0.228';
EOF

  my $dumper = CPANTesters::cpanfiledump->new;

  my $report = $dumper->parse_raw($file);
  eq_or_diff($report->to_cpanfile, $want, 'our cpanfile looks good')
    or warn $report->to_cpanfile;
};

done_testing;
