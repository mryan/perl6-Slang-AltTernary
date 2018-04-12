NAME
====

Slang::AltTernary - blah blah blah

SYNOPSIS
========

    use Slang::AltTernary;

    ^10.pick < 5 ???
        Yes say "Heads"
        No  say "Tails"

DESCRIPTION
===========

Slang::AltTernary is a toy for learning about modifying perl6 parsing with slangs.

It supplements perl6 with two things;
    * A two-element enum, AltBool, where Yes === True and No === False; and
    * a new infix operator, ???, which functions in much the same way as
    perl6's ternary operator 'infix::<??  !!>'.  

The difference is instead of seperating the truthful branch from the falsey 
branch with '!!', AltTernary preceedes each with one of the AltBool enums.

It's not intended that this module be used for anything other than exploring
the use of slangs - use in any real code is discouraged.  You've been warned.

AUTHOR
======

Martin Ryan <mryan50@fastmail.fm>

COPYRIGHT AND LICENSE
=====================

Copyright 2018 Martin Ryan

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

