use Test;
use Test::Script;
use lib <.>;

subtest "Environment ", {
    my $filename = find-filename "env.p6";
    output-like $filename, /"hello → goodbye"/, "Prints environment ",
            env => { "hello" => "goodbye" };
};

done-testing;

sub find-filename( $filename ) {
    $filename.IO.e ?? $filename !! "t/$filename";
}