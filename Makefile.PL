use 5.008;

use strict;

use lib qw(inc);
use Config;
use Devel::CheckLib;
use ExtUtils::MakeMaker;

# Check that we have a C compiler
check_lib_or_exit();

my %mm_args = (
    ( MM->can( 'signature_target' ) ? ( SIGN => 1 ) : () ),
    NAME          => 'Data::Structure::Util',
    AUTHOR        => 'Andy Armstrong <andy@hexten.net>',
    VERSION_FROM  => 'lib/Data/Structure/Util.pm',
    ABSTRACT_FROM => 'lib/Data/Structure/Util.pm',
    PL_FILES      => {},
    PREREQ_PM     => {
        'Digest::MD5'  => 0,
        'Scalar::Util' => '1.01',
        'Test::More'   => 0,
        'Test::Pod'    => 0,
        'Test::Simple' => 0,
    },
    LIBS   => [''],
    DEFINE => '',
    INC    => '',
    dist   => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Data-Structure-Util-*' },
);

{
    local $^W = 0;    # Silence warning about non-numeric version
    if ( $ExtUtils::MakeMaker::VERSION >= '6.31' ) {
        $mm_args{LICENSE} = 'perl';
    }
}

WriteMakefile( %mm_args );

package MY;

sub metafile {
    my @lines = split /\n/, shift->SUPER::metafile_target( @_ );

    my @exclude = qw( Devel::CheckLib IO::CaptureOutput );
    my $pad     = ' ' x 4;
    die "Can't parse Makefile fragment"
      unless $lines[-2] =~ /^([^']*').*?('[^']*)$/;
    splice @lines, -1, 0, map { "$1$_$2" } (
        'no_index:', "${pad}package:",
        map { "${pad}${pad}- $_" } @exclude
    );

    return join "\n", @lines;
}
