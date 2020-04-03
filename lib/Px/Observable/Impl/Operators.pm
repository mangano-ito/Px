package Px::Observable::Impl::Operators;

use Px::Operator::Map;
use Px::Operator::Filter;

use Px::Observable::CallableObservable;

use Module::Functions qw(get_public_functions);
use Exporter 'import';
our @EXPORT = get_public_functions;

# return: Observable
sub map {
    my (
        $self, # Observable
        $fn,   # (Any) -> Any
    ) = @_;
    
    return $self->lift(
        Px::Operator::Map->new($fn),
    );
}

# return: Observable
sub filter {
    my (
        $self, # Observable
        $fn,   # (Any) -> Bool
    ) = @_;

    return $self->lift(
        Px::Operator::Filter->new($fn),
    );
}

# return: Observable
sub lift {
    my (
        $self,     # Observable
        $operator, # Operator { apply: (Observable, Observable) -> Any }
    ) = @_;

    # FIXME
    return Px::Observable::CallableObservable->new(sub {
        $operator->apply($self, $_);
    });
}

!!1;
