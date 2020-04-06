package Px::Helpers;

use strict;
use warnings;

use Module::Functions qw(get_public_functions);
use Exporter 'import';
our @EXPORT = get_public_functions;
our @EXPORT_OK = get_public_functions;

use Px::Observable::CallableObservable;
use Px::Observable::ArrayObservable;

sub observable_from_sub(&) {
    return Px::Observable::CallableObservable->new(shift);
}

sub observable_from_list(@) {
    return Px::Observable::ArrayObservable->new(@_);
}

sub px_subscribe(&$) {
    my ($fn, $observable) = @_;
    $observable->subscribe($fn);
}

sub px_map(&$) {
    my ($fn, $observable) = @_;
    
    return $observable->map($fn);
}

sub px_filter(&$) {
    my ($fn, $observable) = @_;

    return $observable->filter($fn);
}

sub yield {
    my $observable = $_;
    $observable->next($_) for @_;
}

!!1;
