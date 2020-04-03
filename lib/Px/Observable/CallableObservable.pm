package Px::Observable::CallableObservable;

use parent qw(Px::Observable);

sub new {
    my ($class, $fn) = @_;

    return bless {
        _fn => $fn,
    }, $class;
}

sub _do_after_subscribe {
    my $self = shift;

    local $_ = $self;
    $self->{_fn}->();
}

!!1;
