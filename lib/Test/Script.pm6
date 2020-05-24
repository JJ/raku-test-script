use IO::Capture::Simple;
use Test;

unit module Test::Script;

subset Script of Str where .IO.e && / \.p6 || \.raku/;

sub output-is(Script $script,
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

sub output-like(Script $script,
                Regex $desired-output,
                Str $msg ) is export {
    my $output;
    try {
        $output = capture_stdout {
            require $script;
        }
    }
    like( $output, $desired-output, $msg);

}