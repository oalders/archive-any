
use Test::More;

eval "use Test::Pod::Coverage tests => 2";
plan skip_all => "Test::Pod::Coverage required for testing POD" if $@;

pod_coverage_ok( "Archive::Any", "Pod documentation coverage" );
pod_coverage_ok( "Archive::Any::Plugin", "Plugin documentation coverage" );
