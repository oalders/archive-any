#!/usr/bin/perl -w

use Test::More tests => 5;

use_ok 'Archive::Any';

my $a = Archive::Any->new('t/Acme-POE-Knee-1.10.zip', 'zip');
isa_ok( $a, 'Archive::Any' );
is( $a->type, 'zip' );

{
    my $warning = '';
    local $SIG{__WARN__} = sub {
        $warning .= join '', @_;
    };
    ok( !Archive::Any->new('t/Acme-POE-Knee-1.10.zip', 'hominawoof') );
    is( $warning, qq{Archive::Any can't handle hominawoof.\n} );
}

