use Test::More;
eval "use Test::Perl::Critic( -exclude => ['StringyEval'] )";
plan skip_all => "Test::Perl::Critic not installed." if $@;

all_critic_ok();
