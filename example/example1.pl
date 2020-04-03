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

sub main {
    my $observable = _generate();
    _output($observable);
}

sub _generate {
    return observable_from_sub {
        say '=== generate: begin ===';
        say 'yield => 1';
        $_->next(1);
        say 'yield => 2';
        $_->next(2);
        say 'yield => 3';
        yield 3;
        say '=== generate: done ===';
    };
}

sub _output {
    my ($observable) = @_;

    px_subscribe { say 'subscribe <= ' . $_ }
    px_map       { $_ + 1 }
    px_filter    { $_ > 10 }
    px_map       { $_ * 10 }
    $observable;
}

main;
