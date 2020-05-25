use Test;
use Test::Script;
use lib <.>;

my $filename = "args-in-var.p6".IO.e ?? "args-in-var.p6" !! "t/args-in-var.p6";

variable-ok $filename, '$var', :args([1]), "Variable exists and is defined";
variable-is $filename, '$var', "1", :args([1]),
        "Variable exists and has the right value";

$filename = "env-in-var.p6".IO.e ?? "env-in-var.p6" !! "t/env-in-var.p6";
variable-is $filename, '$var', True, :env(%(:foo)),
        "Env variable exists and has the right value";
done-testing;
