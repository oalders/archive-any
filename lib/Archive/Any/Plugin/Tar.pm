package Archive::Any::Plugin::Tar;
use strict;
use base 'Archive::Any::Plugin';

use Archive::Tar;
use Cwd;

=head1 NAME

Archive::Any::Plugin::Tar - Archive::Any wrapper around Archive::Tar

=head1 SYNOPSIS

Do not use this module directly.  Instead, use Archive::Any.

=head1 PLUGINS

Archive::Any requires that your plugin define three methods, all of which are passed the absolute filename of the file.

=over 4

=item B<can_handle>

 Plugin->can_handle();

This returns an array of mime types that the plugin can handle.

=item B<files>

 Plugin->files( $file );

This method returns a list of items inside the archive.

=item B<extract>

 Plugin->extract( $file );
 Plugin->extract( $file, $directory );

This method extracts the contents of the archive $file to the directory $directory or the current working directory.

=back

=cut

sub can_handle {
    return(
           'application/x-tar',
           'application/x-gtar',
           'application/x-gzip',
          );
}

sub files {
    my( $self, $file ) = @_;
    my $t = Archive::Tar->new( $file );
    return $t->list_files;
}

sub extract {
    my ( $self, $file ) = @_;

    my $t = Archive::Tar->new( $file );
	return $t->extract;
}

=head1 AUTHOR

Michael G Schwern E<lt>schwern@pobox.comE<gt>

=head1 SEE ALSO

Archive::Any, Archive::Tar

=cut

1;
