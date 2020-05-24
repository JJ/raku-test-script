use IO::Capture::Simple;
use Test;

unit module Test::Script;

sub output-is(Str $script where .IO.e && / \.p6 || \.raku/,
              Str $desired-output,
              Str $msg ) is export {
    my $output;
    try {
        $output = capture_stdout {
            require $script;
        }
    }
    is( $output, $desired-output, $msg);

}
