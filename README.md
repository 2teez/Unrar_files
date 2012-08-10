This perl script 'e_func.pl' unrar files saved in different folders in a directory. Placed the new folder on the user Desktop, with both the rar files and the unrar files. The unrar will only work on *ix OS, but on Win OS, everyother thing will be done expect the "unrar" -ing of the files.

Example:

    e_func.pl archive         # on Win Os
    
    # On Linux Os
    $ chmod +x e_func.pl      # step 1
    $ ./e_func.pl archive/    # step 2

TODO

Use Module Archive::Unrar from www.cpan.org to unrar on win OS.
