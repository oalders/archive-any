#!/usr/bin/perl -w

use strict;
use warnings;
use Test::More tests => 6;
use Archive::Any::Plugin::Tar;
use Cwd;

# Test that corrupt archive handling doesn't cause runtime errors
# This tests the fix for rt.cpan.org #67509

# Test 1-2: extract method should handle corrupt tar files gracefully
{
    my $result = eval { Archive::Any::Plugin::Tar->extract("t/garbage.foo"); };
    my $error = $@;
    ok(!$error, "extract should not die on corrupt archive");
    ok(!defined $result, "extract should return undef on corrupt archive");
}

# Test 3-4: files method should handle corrupt tar files gracefully
{
    my @files = eval { Archive::Any::Plugin::Tar->files("t/garbage.foo"); };
    my $error = $@;
    ok(!$error, "files should not die on corrupt archive");
    ok(!@files, "files should return empty list on corrupt archive");
}

# Test 5-6: chdir should be restored when _extract fails
{
    my $orig_dir = getcwd;
    
    # Create a temp directory for extraction
    my $temp_dir = "/tmp/test_extract_$$";
    mkdir $temp_dir or die "Cannot create temp dir: $!";
    
    # Try to extract a corrupt file to a different directory
    # The _extract wrapper should restore the directory even on failure
    eval { 
        Archive::Any::Plugin::Tar->_extract("t/garbage.foo", $temp_dir);
    };
    
    my $current_dir = getcwd;
    is($current_dir, $orig_dir, "chdir should be restored after extraction failure");
    
    # Cleanup
    rmdir $temp_dir;
    
    # Verify we're still in the right place
    ok(-f "t/garbage.foo", "should still be in original directory");
}
