package Generator;
use strict;
use warnings;
use utf8;
use Data::Dumper;

use Onara;
use Tags;

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self;
}

# Start ... おじさんの文言を生成
sub start {
    my ($self, %opt) = @_;
    my $selected_message = select_message();

    $selected_message = Tags::convert_tags($selected_message, %opt);

    my $level = $opt{level} || 0;
    if ($level < 0 || $level > 3) {
        die '句読点挿入頻度レベルが不正です: ' . $level;
    }
    my $result = insert_punctuations($selected_message, $level);

    return $result;
}

sub select_message {
    # アルゴリズム (ONARA) を無作為に選定
    my $pattern = Onara->select_pattern();

    $pattern->get_message();
}

# 句読点レベルに応じ、助詞、助動詞の後に句読点を挿入する
sub insert_punctuations {
    my ($message, $level) = @_;
    # TODO:おじさんはあとにまわす
    my $result = $message;
    return $result;
}

1;
