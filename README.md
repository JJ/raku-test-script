# Test::Script

Test a script in Raku, checking its output

## Installing

Use `zef instal --deps-only . ` to install only dependencies. There are no
 non-Raku dependencies.

## Running

```perl6
    use Test::Script;

    output-is "script.p6", "hello: goodbye\n", "Two args ",
            args => ["--msg=goodbye", "hello"];

    # Can't use the same name for the script twice
    output-like "./script.p6, /"hello → goodbye"/, "Prints environment ",
            env => { "hello" => "goodbye" };
```

## See also

See documentation [as a POD](lib/Test/Script.pm6).

## License

This module will be licensed under the Artistic 2.0 License (the same as Raku
 itself).
