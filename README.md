# AWK

A [Brainfuck](https://en.wikipedia.org/wiki/Brainfuck#Language_design) interprater in (g)AWK, because why not!

## What is AWK

(g)awk is a program for general data processing and tabulation.

````awk '{print $1,$2,$1+$2}' file````

will print and sum the first and second coloms of the file.

However it turns out that awk is turing complete...

## Running

just run:

````awk -f bf.awk [file]````

The (brainfuck) program is taken from stdin unless a file is specifyed. 
If you are using a terminal to enter the (brainfuck) program use ``^d`` to indicate the end of it.

an example program is ``hello.bf``. it can be run with ``awk -f bf.awk hello.bf`` 
