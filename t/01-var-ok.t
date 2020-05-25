use Test;
use Test::Script;
use lib <.>;

my $filename = "args-in-var.p6".IO.e ?? "args-in-var.p6" !! "t/args-in-var.p6";

variable-ok $filename, '$var', :args([1]), "Variable exists and is defined";

done-testing;
