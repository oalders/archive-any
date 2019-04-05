package Archive::Any::Zip;

use strict;
use warnings;

use base 'Archive::Any';

use Archive::Zip qw(:ERROR_CODES);
use Cwd;

sub new {
    my ( $class, $file ) = @_;

    my $self = bless {}, $class;

    Archive::Zip::setErrorHandler( sub { } );
    $self->{handler} = Archive::Zip->new($file);
    return unless $self->{handler};

    $self->{file} = $file;

    return $self;
}

sub files {
    my ($self) = shift;

    $self->{handler}->memberNames;
}

sub extract {
    my ( $self, $dir ) = @_;

    my $orig_dir;
    if ($dir) {
        $orig_dir = getcwd;
        chdir $dir;
    }

    $self->{handler}->extractTree;

    if ($dir) {
        chdir $orig_dir;
    }

    return 1;
}

sub type {
    return 'zip';
}

__END__

=pod

=head1 SYNOPSIS

B<DO NOT USE THIS MODULE DIRECTLY>

Use L<Archive::Any> instead.

=head1 DESCRIPTION

Wrapper around L<Archive::Zip> for L<Archive::Any>.

=cut

1;

# ABSTRACT: Archive::Any wrapper around Archive::Zip
