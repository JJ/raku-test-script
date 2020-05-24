use Test;
use Test::Script;
use lib <.>;

my $filename = "random.p6".IO.e ?? "random.p6" !! "t/random.p6";

output-like $filename, /\d/, "Tests regex";

done-testing;
