#!/usr/bin/env perl6

for %*ENV.keys.sort -> $k {
    say "$k → %*ENV{$k}" ;
}
