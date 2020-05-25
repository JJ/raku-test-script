use Test;
use Test::Script;
use lib <.>;

subtest "Simple", {
    my $filename = find-filename "hello.p6";
    output-is $filename, "Hello\n", "Tests simple output";
};

subtest "Command line arguments", {
    my $filename = find-filename "args.p6";
    output-is $filename, "hello: goodbye\n", "Two args ",
            args => ["--msg=goodbye", "hello"];
    output-is "./$filename", "hello: True\n", "Boolean arg ",
            args => ["--msg", "hello"];
};

done-testing;

sub find-filename( $filename ) {
    $filename.IO.e ?? $filename !! "t/$filename";
}