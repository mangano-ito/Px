package t::Observable;

use lib 'lib';
use strict;
use warnings;

use Test2::V0;
use Test2::API ();

use parent qw(Test::Class); 

use Px::Observable;

sub _new : Tests {
    my $observable = Px::Observable->new();
    is $observable, object {
        prop blessed     => 'Px::Observable';
        call is_disposed => F;
        etc;
    }
}

sub _dispose : Tests {
    my $observable = Px::Observable->new();
    is $observable->is_disposed(), F;
    $observable->dispose();
    is $observable->is_disposed(), T;
}

sub _next : Tests {
    subtest 'a value should be delivered' => sub {
        my $observable = Px::Observable->new();
        my $value = undef;
        $observable->subscribe(sub { $value = $_; });
        $observable->next(2);
        is $value, 2;
    };
    subtest 'values should be delivered' => sub {
        my $observable = Px::Observable->new();
        my $values = [];
        $observable->subscribe(sub { push $values->@*, $_; });
        $observable->next(1);
        $observable->next(2);
        $observable->next(3);
        $observable->next(4);
        $observable->next(5);
        is $values, [1, 2, 3, 4, 5];
    };
}

sub _subscribe : Tests {
    subtest 'values should be subscribed' => sub {
        my $observable = Px::Observable->new();
        my $value = undef;
        $observable->subscribe(sub { $value = $_; });
        $observable->next(2);
        is $value, 2;
    };
    subtest 'values should not be delivered if disposed' => sub {
        my $observable = Px::Observable->new();
        my $value = undef;
        $observable->subscribe(sub { $value = $_; });
        $observable->dispose();
        $observable->next(2);
        is $value, U;
    };
}

sub _map : Tests {
    subtest 'values should be mapped once.' => sub {
        my $px = Px::Observable->new();
        my $value = undef;
        $px->map(sub { $_ * 10 })->subscribe(sub { $value = $_; });
        $px->next(2);
        is $value, 20;
    };
    subtest 'values should be mapped multiple times.' => sub {
        my $px = Px::Observable->new();
        my $value = undef;
        $px->map(sub { $_ * 10 })
            ->map(sub { $_ + 1 })
            ->subscribe(sub { $value = $_; });
        $px->next(2);
        is $value, 21;
    };
}

sub _filter : Tests {
    subtest 'values should be filtered if matched.' => sub {
        my $px = Px::Observable->new();
        my $value = undef;
        $px->filter(sub { $_ > 10 })->subscribe(sub { $value = $_; });
        $px->next(2);
        is $value, U;
    };
    subtest 'values should not be filtered if not matched.' => sub {
        my $px = Px::Observable->new();
        my $value = undef;
        $px->filter(sub { $_ < 10 })->subscribe(sub { $value = $_; });
        $px->next(2);
        is $value, 2;
    };
}

__PACKAGE__->runtests;

!!1;
