# NAME

Archive::Any - Single interface to deal with file archives.

[![Build Status](https://travis-ci.org/oalders/archive-any.png?branch=master)](https://travis-ci.org/oalders/archive-any)

# VERSION

version 0.0946

# SYNOPSIS

    use Archive::Any;

    my $archive = Archive::Any->new( 'archive_file.zip' );

    my @files = $archive->files;

    $archive->extract;

    my $type = $archive->type;

    $archive->is_impolite;
    $archive->is_naughty;

# DESCRIPTION

This module is a single interface for manipulating different archive formats.
Tarballs, zip files, etc.

- **new**

        my $archive = Archive::Any->new( $archive_file );
        my $archive_with_type = Archive::Any->new( $archive_file, $type );

    $type is optional.  It lets you force the file type in case Archive::Any can't
    figure it out.

- **extract**

        $archive->extract;
        $archive->extract( $directory );

    Extracts the files in the archive to the given $directory.  If no $directory is
    given, it will go into the current working directory.

- **files**

        my @file = $archive->files;

    A list of files in the archive.

- **mime\_type**

        my $mime_type = $archive->mime_type();

    Returns the mime type of the archive.

- **is\_impolite**

        my $is_impolite = $archive->is_impolite;

    Checks to see if this archive is going to unpack into the current directory
    rather than create its own.

- **is\_naughty**

        my $is_naughty = $archive->is_naughty;

    Checks to see if this archive is going to unpack **outside** the current
    directory.

# DEPRECATED

- **type**

        my $type = $archive->type;

    Returns the type of archive.  This method is provided for backwards
    compatibility in the Tar and Zip plugins and will be going away **soon** in
    favor of `mime_type`.

# PLUGINS

For detailed information on writing plugins to work with Archive::Any, please
see the pod documentation for [Archive::Any::Plugin](https://metacpan.org/pod/Archive::Any::Plugin).

# SEE ALSO

Archive::Any::Plugin

# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Archive::Any

You can also look for information at:

- MetaCPAN

    [https://metacpan.org/module/Archive::Any](https://metacpan.org/module/Archive::Any)

- Issue tracker

    [https://github.com/oalders/archive-any/issues](https://github.com/oalders/archive-any/issues)

# AUTHORS

- Clint Moore
- Michael G Schwern (author emeritus)
- Olaf Alders (current maintainer)

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Michael G Schwern, Clint Moore, Olaf Alders.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
