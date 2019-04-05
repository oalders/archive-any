package Archive::Any::Plugin::Zip;

use strict;
use warnings;
use base qw(Archive::Any::Plugin);

use Archive::Zip qw(:ERROR_CODES);

sub can_handle {
    return ( 'application/x-zip', 'application/x-jar', 'application/zip', );
}

sub files {
    my ( $self, $file ) = @_;

    my $z = Archive::Zip->new($file);
    return $z->memberNames;
}

sub extract {
    my ( $self, $file ) = @_;

    my $z = Archive::Zip->new($file);
    $z->extractTree;

    return 1;
}

sub type {
    my $self = shift;
    return 'zip';
}

1;

# ABSTRACT: Archive::Any wrapper around Archive::Zip

=head1 SYNOPSIS

B<DO NOT USE THIS MODULE DIRECTLY>

Use L<Archive::Any> instead.

=head1 DESCRIPTION

Wrapper around L<Archive::Zip> for L<Archive::Any>.

=cut
