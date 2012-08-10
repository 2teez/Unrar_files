#!/usr/bin/perl
use warnings;
use strict;
use File::Find qw(find);

  find(\&scan_dir,$ARGV[0]);

  sub scan_dir{
     return if $_ eq '.' or $_ eq '..';
    print $_,$/;
   }