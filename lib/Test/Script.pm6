use IO::Capture::Simple;
use Test;

unit module Test::Script;

subset Script of Str where .IO.e && / \.p6 || \.raku/;

sub output-is(Script $script,
              Str $desired-output,
              Str $msg,
              :@args,
              :%env ) is export {
    my $output;
    try {
        @*ARGS = @args;
        for %env.keys -> $k {
            %*ENV{$k} = %env{$k};
        }
        $output = capture_stdout {
            require $script;
        }
        capture_stdout_off;

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