[![Actions Status](https://github.com/librasteve/Air-Plugin-Asciinema/actions/workflows/test.yml/badge.svg)](https://github.com/librasteve/Air-Plugin-Asciinema/actions)

# Air::Plugin::Asciinema

## Synopsis

```raku
#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Asciinema;

my $site =
site :register[Air::Plugin::Asciinema.new],
    page
        main [
            div [
                h3 '1. Arithmetic';
                asciinema '/static/demos/demo1.cast';
            ];
            div [
                h3 '2. Powers & Roots';
                asciinema '/static/demos/demo2.cast';
            ];
        ];
;

$site.serve;
```

## Description

Air::Plugin::Asciinema is a plugin for the Raku [Air module](https://raku.land/zef:librasteve/Air)
that implements the [Asciinema Player](https://docs.asciinema.org/manual/player/).

Take a look at the folder structure in [Air::Examples] and place your `.cast` files in `/static/demos/`.

Three useful commands to record your own terminal sessions are:

```commandline
asciinema --help
asciinema rec  -q -i 1 demoN.cast --overwrite
asciinema play -q -s 2 demoN.cast
```

## Installation

If you already have [Air](https://raku.land/zef:librasteve/Air) installed, then:

 - `zef install Air::Plugin::Asciinema`

Otherwise, follow the Air::Examples [Getting Started](https://github.com/librasteve/Air-Examples/blob/main/README.md#getting-started)

 - `cd Air-Examples`
 - `raku bin/22-asciinema.raku`
 - point browser to `http://localhost:3000`

## Author

librasteve <librasteve@furnival.net>

## Copyright and License

Copyright 2026 Stephen Roe.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.


