#!/usr/bin/perl
use warnings;
use strict;
use File::Basename qw(dirname basename);
use File::Spec::Functions qw(catfile);
use File::Copy qw(copy);
use Cwd qw(abs_path);


## call subroutine with a sub. ref.
scan_dir( $ARGV[0], \&make_dir_copy_n_unrar_archive );

sub scan_dir {
    my ( $dir, $coderef ) = @_;
    if ( -d $dir ) {    ## check if directory
        $dir = abs_path($dir);    ## get the absolute path of the directory
        chdir($dir);              ## change to the directory
        opendir my $dh, $dir or die "can't open directory: $!";
        while ( defined( $_ = readdir($dh) ) ) {
            next if $_ eq '.' or $_ eq '..';
            ## get every file ending with .rar and call the sub. ref.
            $coderef->($_) if m{\.rar$};
            scan_dir( "$dir/$_", $coderef );    ## recursive call
        }
    }
}

sub make_dir_copy_n_unrar_archive {

    my ($filename) = @_;                        ## get filename
    ( my $name_folder = $filename ) =~
      s{\..+?$}{};    ## modify filename to make new folder

    ## folder will be placed on user' Desktop
    my $new_folder = catfile( $ENV{HOME}, 'Desktop', $name_folder );
    mkdir $new_folder;    ## make folder

    ## get the absolute path of the files
    my $old_file = catfile( dirname($filename), basename($filename) );

    ## copy files to new folder
    copy $old_file, $new_folder;
    my $file = catfile( $new_folder, $filename );

    ## unrar files in their new folders, used only in *nux OS
    system("unrar e $file $new_folder") if $^O ne 'MSWin32';
}
