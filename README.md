# Test::Script [![Test-install distro](https://github.com/JJ/raku-test-script/actions/workflows/test.yaml/badge.svg)](https://github.com/JJ/raku-test-script/actions/workflows/test.yaml)

Test a script in Raku, checking its output

## Installing

Use `zef instal --deps-only . ` to install only dependencies. There are no
 non-Raku dependencies.

## Running

```perl6
    use Test::Script;

    output-is "script.p6", "hello: goodbye\n", "Two args ",
            args => ["--msg=goodbye", "hello"];

    output-like "script.p6, /"hello → goodbye"/, "Prints environment ",
            env => { "hello" => "goodbye" };
            
    variable-ok "script.p6", '$foo', "Variable exists and is set";
    variable-is "script.p6", '$foo', <bar baz>, "Variable exists and has value";
    
    error-like "Totally-messed-up-program.p6", /messy/, "Messy program fails";

```

## See also

See documentation [as a POD](lib/Test/Script.pm6).

## License

This module is licensed under the Artistic 2.0 License (the same as Raku
 itself).
