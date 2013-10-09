
use Test::More;

eval "use Test::Pod::Coverage";
plan skip_all => "Test::Pod::Coverage required for testing POD" if $@;

plan tests => 2;
pod_coverage_ok( "Archive::Any", "Pod documentation coverage" );
pod_coverage_ok( "Archive::Any::Plugin", "Plugin documentation coverage" );
