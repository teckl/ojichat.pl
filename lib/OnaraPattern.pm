package OnaraPattern;
use strict;
use warnings;
use utf8;
use Data::Dumper;

sub new {
    my $class = shift;
    my @patterns = @_;
    return bless { emotion => \@patterns } , $class;
}

sub get_message {
    my ($self) = @_;

    my $message;
    for my $emotion (@{$self->{emotion}}) {
        my $onara_messages = Onara->select_template($emotion);
        $message .= @{$onara_messages}[int rand scalar @{$onara_messages}];
    }
    return $message;
}


1;
