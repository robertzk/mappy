Mappy [![Build Status](https://travis-ci.org/robertzk/mappy.svg?branch=master)](https://travis-ci.org/robertzk/mappy) [![Coverage Status](https://coveralls.io/repos/robertzk/mappy/badge.svg?branch=master)](https://coveralls.io/r/robertzk/mappy)
===========

Register shortcuts in R sessions.

This package provides the ability to create shortcuts for use in the
interactive R console to prevent yourself from writing commonly used
expressions multiple times.

For example, if you frequently find yourself typing `some_annoyingly$long_expression`,
you can bind it to `S` by writing `mappy(S = some_annoyingly$long_expression)`.

Now, typing `S` in your interactive R console executes the expression
in full each time. Note that mappy relies on the `~/.R/mappy` file (which it will
create the first time it needs it) to make this work between sessions.
If you wish to use a different file, set `options(mappy.directory = "/your/dir")`.

Mappy shortcuts do not apply outside of [interactive R sessions](https://stat.ethz.ch/R-manual/R-devel/library/base/html/interactive.html).

# Operations

```R
mappy(S = some_expression) # some_expression is now bound to S
                           # This will persist between R sessions.
unmappy("S")  # Will unmap the expression bound to S.
mappy_all() # A named list of all mapped expressions.
```

# Installation

This package is not yet available from CRAN (as of March 22, 2015).
To install the latest development builds directly from GitHub, run this instead:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("robertzk/director") # A dependency
devtools::install_github("robertzk/mappy")
```

You should then add `library(mappy)` to your `~/.Rprofile` to ensure it loads 
on session startup.
