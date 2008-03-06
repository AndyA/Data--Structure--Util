#!/usr/bin/env perl

use strict;
use warnings;
use lib qw( blib/lib blib/arch );
use Data::Structure::Util qw( signature );

my $obj3 = bless { key1 => 1 };
my $sig3 = signature( $obj3 );
$obj3->{key1} = 1;
my $sig4 = signature( $obj3 );
print "$sig3\n$sig4\n";
