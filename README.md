# The basics

Take a cpantesters report and generate a cpanfile to make it easier to set up
a test instance with a similar set of modules.

For a quick example:

````
$ perl -Ilib bin/cpantesters-report-to-cpanfile t/corpus/no-prereqs 
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
````

Typical usage:

````
wget <some-report-from-cpantesters>
perl -Ilib bin/cpantesters-report-to-cpanfile <some-report-from-cpantesters>
````

# TODO

 - Something to make it easy to exlude modules that are installed when the
   report notes that a module is recommended but missing
 - Tests for error conditions/weird module version mismatches

