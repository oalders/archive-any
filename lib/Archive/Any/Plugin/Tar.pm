package Archive::Any::Plugin::Tar;

use strict;
use base 'Archive::Any::Plugin';

use Archive::Tar;
use Cwd;

sub can_handle {
    return (
        'application/x-tar',  'application/x-gtar',
        'application/x-gzip', 'application/x-bzip2',
    );
}

sub files {
    my ( $self, $file ) = @_;
    my $t = Archive::Tar->new( $file );
    return $t->list_files;
}

sub extract {
    my ( $self, $file ) = @_;

    my $t = Archive::Tar->new( $file );
    return $t->extract;
}

sub type {
    my $self = shift;
    return 'tar';
}

1;

# ABSTRACT: Archive::Any wrapper around Archive::Tar

=head1 SYNOPSIS

Do not use this module directly.  Instead, use L<Archive::Any>.

=cut

=head1 SEE ALSO

L<Archive::Any>, L<Archive::Tar>

=cut
