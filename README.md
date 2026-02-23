[![Actions Status](https://github.com/librasteve/Air-Plugin-Asciinema/actions/workflows/test.yml/badge.svg)](https://github.com/librasteve/Air-Plugin-Asciinema/actions)

NAME
====

Air::Plugin::Asciinema

SYNOPSIS
========

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

DESCRIPTION
===========

Air::Plugin::Asciinema is a plugin for the Raku [Air module](https://raku.land/zef:librasteve/Air)
that implements the [Asciinema Player](https://docs.asciinema.org/manual/player/).

Take a look at the folder structure in [Air::Examples] and place your `.cast` files in `/static/demos/`.

Three useful commands to record your own terminal sessions are:

```commandline
asciinema --help
asciinema rec  -q -i 1 demoN.cast --overwrite
asciinema play -q -s 2 demoN.cast
```

AUTHOR
======

librasteve <librasteve@furnival.net>

COPYRIGHT AND LICENSE
=====================

Copyright 2026 Stephen Roe.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.


