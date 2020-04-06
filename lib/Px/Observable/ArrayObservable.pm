package Px::Observable::ArrayObservable;

use parent qw(Px::Observable::CallableObservable);

sub new {
    my ($class, @array) = @_;

    return shift->SUPER::new(sub {
        for my $item (@array) {
            $_->next($item);
        }
    });
}

!!1;
