package Px::Operator::Map;

sub new {
    my ($class, $fn) = @_;

    return bless {
        _fn => $fn,
    };
}

sub apply {
    my ($self, $from, $to) = @_;

    $from->subscribe(sub {
        my $value = $self->{_fn}->($_);
        $to->next($value);
    });
}

!!1;
