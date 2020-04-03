package Px::Observable;

use strict;
use warnings;

# return: Observable
sub new {
    my (
        $class, # ClassName
    ) = @_;

    return bless {
        _subscriber => undef,
        _disposed   => !!0,
    }, $class;
}

sub next {
    my (
        $self, # Observable
        $item, # Any
    ) = @_;

    return if $self->is_disposed;
    return unless defined $self->{_subscriber};

    local $_ = $item;
    $self->_do_on_next($item);
    $self->{_subscriber}->($item);
    $self->_do_after_next($item);
}

sub subscribe {
    my (
        $self,       # Observable
        $subscriber, # (Any) -> Any
    ) = @_;

    $self->_do_on_subscribe();
    $self->{_subscriber} = $subscriber;
    $self->_do_after_subscribe();
}

# return: Bool
sub is_disposed {
    !!shift->{_disposed};
}

sub dispose {
    shift->{_disposed} = !!1;
}

sub _do_on_next {}
sub _do_after_next {}

sub _do_on_subscribe {}
sub _do_after_subscribe {}

!!1;
