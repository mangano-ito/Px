use strict;
use warnings;
use feature qw(say);

use Px::Helpers qw(
    observable_from_list
    px_subscribe
    px_map
    px_filter
);

sub main {
    my $observable = observable_from_list 4, 5, 6, 1, 7, 8;
    _output($observable);
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
