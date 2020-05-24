#!/usr/bin/env perl6

sub MAIN( $str, :$msg ) {
    say "$str" ~ ': '~$msg if $msg ;
}
