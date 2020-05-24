use Test;
use Test::Script;
use lib <.>;

my $filename = "hello.p6".IO.e ?? "hello.p6" !! "t/hello.p6";

output-is $filename, "Hello\n", "Tests simple output";

done-testing;
