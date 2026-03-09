use strict;
use warnings;
use Test::More;
use FindBin '$Bin';

local @ARGV = 'dummy';
my $cpanspec = "$Bin/../cpanspec";
require $cpanspec;

subtest 'find_doc exclusion' => sub {
    my @files = (
        'lib/Foo.pm',
        'README',
        'Changes',
        'CLAUDE.md',
        'GEMINI.md',
        'AGENTS.md',
        'other.txt',
    );

    my %config;
    my @doc = main::find_doc(\%config, 'Foo-Bar-0.01', @files);

    ok(!grep(/^CLAUDE\.md$/i, @doc), "CLAUDE.md excluded from %doc");
    ok(!grep(/^GEMINI\.md$/i, @doc), "GEMINI.md excluded from %doc");
    ok(!grep(/^AGENTS\.md$/i, @doc), "AGENTS.md excluded from %doc");
    ok(grep(/^README$/, @doc), "README included in %doc");
    ok(grep(/^Changes$/, @doc), "Changes included in %doc");
};

done_testing;
