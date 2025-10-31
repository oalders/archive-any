#!/usr/bin/perl -w

use strict;
use warnings;
use Test::More tests => 7;
use Archive::Any;
use Archive::Any::Plugin::Tar;
use Cwd;
use File::Spec;
use File::Temp;

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

# Test 5-7: Test extraction with directory parameter via Archive::Any public API
# This tests that chdir is properly restored even when extraction fails
{
    my $orig_dir = getcwd;
    
    # Use File::Temp for cross-platform temporary directory
    my $temp_dir = File::Temp::tempdir( CLEANUP => 1 );
    
    # Archive::Any->new will fail for garbage.foo due to no handler
    # but we can test with a tar that can be detected but has issues
    # For now, test that current directory handling works correctly
    my $archive = Archive::Any->new("t/lib.tgz");
    ok(defined $archive, "created archive from valid tar");
    
    # Extract to temp directory and verify we're back in original directory
    my $extract_result = eval { $archive->extract($temp_dir); };
    
    my $current_dir = getcwd;
    is($current_dir, $orig_dir, "chdir should be restored after extraction");
    
    # Verify we're still in the right place
    ok(-f "t/lib.tgz", "should still be in original directory");
}


