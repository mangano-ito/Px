package Px::Operator::Filter;

sub new {
    my ($class, $fn) = @_;

    return bless {
        _fn => $fn,
    };
}

sub apply {
    my ($self, $from, $to) = @_;

    $from->subscribe(sub {
        $to->next($_) if $self->{_fn}->($_);
    });
}

!!1;
