
use Module::Build;
my $build = Module::Build->new(
                               module_name => "Archive::Any",
                               license => 'perl',
                               requires => {
                                            Archive::Tar   => 0.22,
                                            Archive::Zip   => 1.07,
                                            Cwd            => 0,
                                            Module::Find   => 0.05,
                                            MIME::Types    => 1.16,
                                            File::MMagic   => 1.27,
                                            File::Spec::Functions => 0,
                                            Test::More     => 0.40,
                                            Test::Warn     => 0,
                                            },
                               );
$build->create_build_script();
