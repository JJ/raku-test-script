use Test;
use Test::Script;
use lib <.>;

constant FILENAME = 'exit-hello.p6';
my $filename = FILENAME.IO.e ?? FILENAME !! "t/" ~ FILENAME;

error-like $filename, /"Hello"/, "Tests regex with bad script";

done-testing;
