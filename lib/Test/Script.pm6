=begin pod

=head1 NAME

Test::Script - Test-run a script

=head1 SYNOPSIS

    use Test::Script;

    output-is "script.p6", "hello: goodbye\n", "Two args ",
            args => ["--msg=goodbye", "hello"];

    output-like "script.p6, /"hello → goodbye"/, "Prints environment ",
            env => { "hello" => "goodbye" };

    variable-ok "script.p6", '$foo', "Variable exists and is set";
    variable-is "script.p6", '$foo', <bar baz>, "Variable exists and has value";

=head1 DESCRIPTION

This module is intended as a white-box test for scripts. Instead of running
them as black boxes, it incorporates them into the current program, allowing
better examination of its internal workings.

For the time being, it's just the output, but in the roadmap is the
examination of variable values and other dynamic stuff.

=end pod

use Test;

unit module Test::Script;

subset Script of Str where .IO.e && / \.p6 || \.raku/;

#| Check the output of a $script, provided optional arguments and environment
sub output-is(Script $script,
              Str $desired-output,
              Str $msg,
              :@args,
              :%env ) is export {
    my $output= get-output( $script, :@args, :%env );
    is( $output, $desired-output, $msg);

}

#| Check the output via a regular expression
sub output-like(Script $script,
                Regex $desired-output,
                Str $msg,
                :@args,
                :%env  ) is export {
    my $output= get-output( $script, :@args, :%env );
    like( $output, $desired-output, $msg);

}

#| Checks that it fails in an expected way
sub error-like(Script $script,
                Regex $desired-output,
                Str $msg,
                :@args,
                :%env  ) is export {
    my $output= get-err( $script, :@args, :%env );
    like( $output, $desired-output, $msg);

}

sub get-output(Script $script,
              :@args,
              :%env ) {
    my $output;
    my $stdout = $*OUT;
    $*OUT = class {
        method print(*@args) {
            $output ~= @args.join;
        }
        method flush {}
    }
    try {
        @*ARGS = @args.map: ~*;
        for %env.keys -> $k {
            %*ENV{$k} = %env{$k};
        }
        CompUnit::Loader.load-source-file($script.IO);
    }
    $*OUT = $stdout;
    $output;

}

sub get-err(Script $script,
              :@args,
              :%env ) {
    my $output;
    my $stderr = $*ERR;
    $*ERR = class {
        method print(*@args) {
            $output ~= @args.join;
        }
        method flush {}
    }
    try {
        @*ARGS = @args.map: ~*;
        for %env.keys -> $k {
            %*ENV{$k} = %env{$k};
        }
        CompUnit::Loader.load-source-file($script.IO);
        CATCH {
            default {
                $output ~= .message
            }
        }
    }
    $*ERR = $stderr;
    $output;

}

#| Check that a variable exist and is defined
sub variable-ok(Script $script,
                Str $variable,
                Str $message,
               :@args,
               :%env ) is export {
    my %vars = get-vars( $script, :@args, :%env);
    ok(%vars{$variable}, $message);

}

#| Check that a variable has certain value
sub variable-is(Script $script,
                Str $variable,
                Mu \value,
                Str $message,
                :@args,
                :%env ) is export {
    my %vars = get-vars( $script, :@args, :%env);
    is(%vars{$variable}, value, $message);

}

sub get-vars(Script $script,
                :@args,
                :%env ) is export {
    @*ARGS = @args;
    for %env.keys -> $k {
        %*ENV{$k} = %env{$k};
    }
    my $handle = CompUnit::Loader.load-source-file($script.IO);
    return $handle.globalish-package;

}

=begin pod

=head2 CAVEATS

You can't test the same script twice in the same file. As a workaround
(probably temporary), call it under different names such as C<./script.p6> or
C<../dir/script.p6>; alternatively, just use different tests for different
scripts.

=head1 AUTHOR

JJ Merelo <jjmerelo@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2020,2022 JJ Merelo

This library is free software; you can redistribute it and/or modify it under
the Artistic 2.0 license

=end pod
