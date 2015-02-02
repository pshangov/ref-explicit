use strict;
use warnings;

use Test::More tests => 2;

use Ref::Explicit;

subtest 'arrayref' => sub {
    my @array = ( 1..4 );

    my $copy = arrayref @array;

    is_deeply $copy => \@array, 'same content';

    $array[1] = 'changed';

    is $copy->[1] => 'changed', 'the copy is an alias to the original array';

    $copy = arrayref map { $_ } @array;

    $array[2] = 'changed';

    is $copy->[2] => 3, 'the copy is not an alias to the original array';

    my %hash = ( 'a'..'d' );

    $copy = arrayref %hash;

    $hash{a} = 'changed';

    is_deeply [ sort @$copy ] => [ qw/ a c changed d/ ], 'hash copy is an alias';

    my $one   = 'one';
    my $three = 'three';

    $copy = arrayref $one, 2, $three;

    $three = 'trois';

    is_deeply $copy => [ 'one', 2, 'trois' ], 'scalar copy is an alias';

    my @first  = ( 1..3 );
    my @second = ( 100..103 );

    $copy = arrayref @first, @second;

    $copy->[-1] = 'a';
    is $second[-1] => 'a', 'copy is an alias';

    $first[0] = 'b';
    is $copy->[0] => 'b', 'goes both way';



};

subtest 'hashref' => sub {
    my %hash = ( 1..4 );

    my $copy = hashref %hash;

    is_deeply $copy => \%hash, 'same content';

    $hash{1} = 'changed';

    isnt $copy->{1} => 'changed', 'the copy is not an alias to the original hash';
};


