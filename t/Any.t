#!/usr/bin/perl -w

use Test::More 'no_plan';

use Archive::Any;
use File::Spec::Functions qw(updir);

my %tests = (
  't/Acme-POE-Knee-1.10.zip' => {
      impolite=> 0,
      naughty => 0,
      type  => 'zip',
      files => [qw( Acme-POE-Knee-1.10/
                    Acme-POE-Knee-1.10/lib/
                    Acme-POE-Knee-1.10/lib/Acme/
                    Acme-POE-Knee-1.10/lib/Acme/POE/
                    Acme-POE-Knee-1.10/lib/Acme/POE/Knee.pm
                    Acme-POE-Knee-1.10/demo_simple.pl
                    Acme-POE-Knee-1.10/demo_race.pl
                    Acme-POE-Knee-1.10/Makefile.PL
                    Acme-POE-Knee-1.10/MANIFEST
                    Acme-POE-Knee-1.10/README
                    Acme-POE-Knee-1.10/Changes
                  )],
  },
  't/your-0.01.tar.gz' => {
      impolite  => 0,
      naughty   => 0,
      type      => 'tar',
      files     => [qw( 
                       your-0.01/
                       your-0.01/Makefile.PL
                       your-0.01/Changes
                       your-0.01/t/
                       your-0.01/t/lib/
                       your-0.01/t/lib/Test/
                       your-0.01/t/lib/Test/More.pm
                       your-0.01/t/lib/Test/Simple.pm
                       your-0.01/t/your.t
                       your-0.01/lib/
                       your-0.01/lib/your.pm
                       your-0.01/MANIFEST
                      )],
  },
  't/LoadHtml.5_0.tar.gz' => {
      impolite  => 1,
      naughty   => 0,
      type      => 'tar',
      files     => [qw( loadhtml.htm LoadHtml.pm README )],
  },
  't/naughty.tar.gz' => {
      impolite  => 0,
      naughty   => 1,
      type      => 'tar',
      files     => [qw(
                       /tmp/File-Spec-0.6/
                       /tmp/File-Spec-0.6/t/
                       /tmp/File-Spec-0.6/t/base.t
                       /tmp/File-Spec-0.6/Spec/
                       /tmp/File-Spec-0.6/Spec/Win32.pm
                       /tmp/File-Spec-0.6/Spec/Unix.pm
                       /tmp/File-Spec-0.6/Spec/OS2.pm
                       /tmp/File-Spec-0.6/Spec/VMS.pm
                       /tmp/File-Spec-0.6/Spec/Mac.pm
                       /tmp/File-Spec-0.6/Makefile.PL
                       /tmp/File-Spec-0.6/Spec.pm
                       /tmp/File-Spec-0.6/MANIFEST
                      )],
  },
);


while( my($file, $expect) = each %tests ) {
    my $archive = Archive::Any->new($file);

    # And now we chdir out from under it.  This causes serious problems
    # if we're not careful to use absolute paths internally.
    chdir('t');

    ok( defined $archive,               "new($file)" );
    ok( $archive->isa('Archive::Any'),  "  it's an object" );

    ok( eq_set([$archive->files], $expect->{files}),
                                     '  lists the right files' );

    is( $archive->type, $expect->{type},    '  right type' );

    is( $archive->is_impolite, $expect->{impolite},  "  impolite?" );
    is( $archive->is_naughty,  $expect->{naughty},   "  naughty?" );

    unless( $archive->is_impolite || $archive->is_naughty ) {
        ok($archive->extract(),   "extract($file)");
        foreach my $file (reverse $archive->files) {
            ok( -e $file, "  $file" );
            -d $file ? rmdir $file : unlink $file;
        }
    }

    chdir(updir);
}
