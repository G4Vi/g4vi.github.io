#!/usr/bin/perl
use strict; use warnings;
use FindBin;

chdir($FindBin::Bin);

-d 'cs' or die;

sub writeredirect {
    my ($from, $to) = @_;
    open(my $fh, '>', $from) or die;
    print $fh q[<!DOCTYPE html><html><head><meta http-equiv="Refresh" content="0; url='].$to.q['" /></head></html>];
}

sub generateredirects {
    my ($from, $to) = @_;
    mkdir($from);
    opendir(my $dh, $to) or die;
    while(my $file = readdir($dh)) {
        next if(($file eq '.') || ($file eq '..'));
        if(-d "$to/$file") {
            #generateredirects("$from/$file", "$to/$file");
        }
        elsif( -f "$to/$file") {
            print "subsgr " . (substr($file, -4)) ."\n";
            next if(substr($file, -5) ne '.html');
            writeredirect("$from/$file", "../oldsite/$to/$file");
        }
        else {
            die;
        }
    }    
}

# generate the redirects
generateredirects("../cs", "cs");

