# use 5.008;

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
  META_MERGE => {
    'no_index' => {
      'directory' => 'inc',
    },
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
