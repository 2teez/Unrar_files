#!/usr/bin/perl
use warnings;
use strict;

scan_dir( $ARGV[0] );    ## call subroutine

sub scan_dir {
    my ($dir) = @_;
    if ( -d $dir ) {     ## check if directory
        opendir my $dh, $dir or die "can't open directory: $!";
        while ( readdir $dh ) {
            next if $_ eq '.' or $_ eq '..';
            print $_, $/;
            scan_dir("$dir/$_");    ## recursive call
        }
    }
}
