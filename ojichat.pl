#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use FindBin;
use lib "$FindBin::Bin/lib";
use v5.12;
our $VERSION = 'Ojisan Nanchatte (ojichat) command version for perl 0.0.1';

use Encode;
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
use Data::Dumper;
use Pod::Usage 'pod2usage';

use Generator;

main();

sub main {

    GetOptions(
        \my %opt,
        "help|h",
        "version|V",
        "number|e=i",
        "level|p=i",
    );
    pod2usage() if $opt{help};
    return say $VERSION if $opt{version};
    $opt{target_name} = decode_utf8($ARGV[0]);

    my $result = Generator->new->start(%opt);
    say encode_utf8($result);
}

__END__

=encoding utf8

=head1 SYNOPSIS

ojichat [options] [<name>]

Options:

    -h, --help      ヘルプを表示.
    -V, --version   バージョンを表示.<br>    
    -e <number>     絵文字/顔文字の最大連続数 [default: 4].
    -p <level>      句読点挿入頻度レベル [min:0, max:3] [default: 0].
