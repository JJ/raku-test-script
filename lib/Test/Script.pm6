use IO::Capture::Simple;
use Test;

unit module Test::Script;

subset Script of Str where .IO.e && / \.p6 || \.raku/;

sub output-is(Script $script,
              Str $desired-output,
              Str $msg,
              :@args,
              :%env ) is export {
    my $output= get-output( $script, :@args, :%env );
    is( $output, $desired-output, $msg);

}

sub output-like(Script $script,
                Regex $desired-output,
                Str $msg,
                :@args,
                :%env  ) is export {
    my $output= get-output( $script, :@args, :%env );
    like( $output, $desired-output, $msg);

}

sub get-output(Script $script,
              :@args,
              :%env ) {
    my $output;
    try {
        @*ARGS = @args;
        for %env.keys -> $k {
            %*ENV{$k} = %env{$k};
        }
        $output = capture_stdout {
            require $script;
        }
   }
    $output;

}
