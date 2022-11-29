use Test;
use Test::Script;
use lib <.>;

constant FILENAME = 'bad-hello.p6';
my $filename = FILENAME.IO.e ?? FILENAME !! "t/" ~ FILENAME;

error-like $filename, /"Did you mean"/, "Tests regex with bad script";

done-testing;
