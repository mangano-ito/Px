# Px

An **experimental**, **incomplete** and **non-official** Rx implementation for Perl.

## Example

Try this example:

```perl
use strict;
use warnings;
use feature qw(say);

use Px::Helpers qw(
    observable_from_sub
    px_subscribe
    px_map
    px_filter
    yield
);

my $px = observable_from_sub {
    say '=== generate: begin ===';
    say 'yield => 1';
    $_->next(1);
    say 'yield => 2';
    $_->next(2);
    say 'yield => 3';
    yield 3;
    say '=== generate: done ===';
};

px_subscribe { say 'value = ' . $_ }
px_map       { $_ * 10 }
px_map       { $_ + 1 }
px_filter    { $_ > 15 }
px_map       { $_ * 10 }
$px;
```

```sh
carton exec -- perl -Ilib example/example1.pl
```

You get:

```
=== generate: begin ===
yield => 1
yield => 2
subscribe <= 21
yield => 3
subscribe <= 31
=== generate: done ===
```
