package Tags;
use strict;
use warnings;
use utf8;

use Gimei qw(gimei);

use constant uniq_tags => {
    # 対象の名前
    '{TARGET_NAME}' => [],
    # おじさんの一人称
    '{FIRST_PERSON}' => [
        "僕",
        "ボク",
        "ﾎﾞｸ",
        "俺",
        "オレ",
        "ｵﾚ",
        "小生",
        "オジサン",
        "ｵｼﾞｻﾝ",
        "おじさん",
        "オイラ",
    ],
    # 曜日
    '{DAY_OF_WEEK}' => [
        "月", "火", "水", "木", "金", "土", "日",
    ],
    # 地名
    '{LOCATION}' => [
        "愛知", "青森", "秋田", "石川", "茨城", "岩手", "愛媛", "大分", "大阪", "岡山", "沖縄", "香川", "鹿児島", "神奈川", "岐阜", "京都", "熊本", "群馬", "高知", "埼玉", "佐賀", "滋賀", "静岡", "島根", "千葉", "東京", "徳島", "栃木", "鳥取", "富山", "長崎", "長野", "奈良", "新潟", "兵庫", "広島", "福井", "福岡", "福島", "北海道", "三重", "宮城", "宮崎", "山形", "山口", "山梨", "和歌山",
    ],
    # 外食
    '{RESTAURANT}' => [
        "お寿司🍣",
        "イタリアン🍝",
        "バー🍷",
        "ラーメン屋さん🍜",
        "中華🍜",
    ],
    # 食べ物
    '{FOOD}' => [
        "お惣菜",
        "サラダ",
        "おにぎり🍙",
        "きんぴらごぼう",
        "ピッツァ🍕",
        "パスタ🍝",
        "スイーツ🍮",
        "ケーキ🎂",
    ],
    # 天気
    '{WEATHER}' => [
        "曇り",
        "晴れ",
        "快晴",
        "大雨",
        "雨",
        "雪",
        "台風🌀",
    ],
    # 下ネタの後は「ナンチャッテ」「冗談（笑）」を使う(README.md 参考文献[2])
    '{NANCHATTE}' => [
        "ﾅﾝﾁｬｯﾃ{EMOJI_POS}",
        "ナンチャッテ{EMOJI_POS}",
        "なんちゃって{EMOJI_POS}",
        "なんてね{EMOJI_POS}",
        "冗談{EMOJI_POS}",
        "", # おじさんはたまに本気
    ],
    # TODO: 「かな？」と「かい？」の語尾の違いも組み込んでも良いかもしれない
    # おじさんの欲望の地、ホテル
    '{HOTEL}' => [
        "ホテル🏨",
        "ホテル🏩",
        "旅館",
    ],
    # デートの種類
    '{DATE}' => [
        "デート❤",
        "カラオケ🎤",
        "ドライブ🚗",
    ],
    # おじさんは比喩で相手を持ち上げる (川柳)
    '{METAPHOR}' => [
        "天使",
        "女神",
        "女優さん",
        "お姫様",
    ],
};

use constant flex_tags => {

    '{EMOJI_POS}' => [
        "😃♥ ",
        "😃☀ ",
        "😃",
        "😃✋",
        "❗",
        "😄",
        "😆",
        "😚",
        "😘",
        "😚",
        "💕",
        "💗",
        "😍",
        "😁",
        "😋",
        "😂",
        "😊",
        "🎵",
        "(^_^)",
        "(^o^)",
        "(^з<)",
        "（笑）",
    ],
    '{EMOJI_NEG}' => [
        "💦",
        "💔",
        "😱",
        "😰",
        "😭",
        "😓",
        "😣",
        "😖",
        "😥",
        "😢",
        "(◎ ＿◎;)",
        "(T_T)",
        "^^;",
        "(^_^;",
        "(・_・;",
        "(￣Д￣；；",
        "(^▽^;)",
        "(-_-;)",
    ],
    '{EMOJI_NEUT}' => [
        "💤",
        "😴",
        "🙂",
        "🤑",
        "✋",
        "😪",
        "🛌",
        "😎",
        "😤",
        "😒",
        "😙",
        "😏",
        "😳",
        "😌",
        "（￣▽￣）",
        "(＃￣З￣)",
        "(^^;;",
    ],
    '{EMOJI_ASK}' => [
        "⁉",
        "❓",
        "❗❓",
        "🤔",
        "😜⁉️",
        "✋❓",
        "（￣ー￣?）",
    ],

};

# ConvertTags ; message内にあるタグを置換して結果を返す
sub convert_tags {
    my ($message, %opt) = @_;

    my $target_name = $opt{target_name};
    # 引数として名前が存在した場合にはそれを使う
    my $random_name_suffix = random_name_suffix();
    if ($target_name) {
        uniq_tags->{'{TARGET_NAME}'} = [$target_name . $random_name_suffix];
    } else {
        # 指定がない場合には gimei から選定
        my $gimei = gimei;
        my $value = @{$gimei}[int rand scalar @{$gimei}];
        my $random_first_name = random_first_name($value);
        uniq_tags->{'{TARGET_NAME}'} = [$random_first_name . $random_name_suffix];
    }
    my $uniq_tags = uniq_tags;
    my $flex_tags = flex_tags;

    for my $type (keys %{$uniq_tags}) {
        my $value = @{Tags::uniq_tags->{$type}}[int rand scalar @{Tags::uniq_tags->{$type}}];
        $message =~ s/$type/$value/g;
    }

    for my $type (keys %{$flex_tags}) {
        my $content;
        my $pattern = Tags::flex_tags->{$type};
        my $emoji_number = $opt{number} // 4;
        if ($emoji_number) {
            $content = combine_multiple_patterns($pattern, $emoji_number);
        } else {
            # Ojisan could be seriously
            $content = "。";
        }
        $message =~ s/$type/$content/g;
    }
    $message;
}

# combineMultiplePatterns: 複数のパターンをnumber分ランダムにつなげる
sub combine_multiple_patterns {
    my ($patterns, $number) = @_;
    my $result;
    for my $i (1 .. $number) {
        last unless scalar @{$patterns};
        my $index = int rand scalar @{$patterns};
        $result .= @{$patterns}[$index];
        splice(@{$patterns}, $index, 1);
    }
    return $result;
}

# gimei から女性の名前を無作為に選定
sub random_first_name {
    my $random_value = shift;
    my $n = int rand(2);
    if ($n == 0) {
        return $random_value->[0];
    } elsif ($n == 1) {
        return $random_value->[1];
    } else {
        return $random_value->[2];
    }
}

sub random_name_suffix {
    my $n = int rand(100);
    if ($n < 5) {
        # たまに呼び捨てにするおじさん
        return '';
    } elsif ($n < 20) {
        # "時に「◯◯チャン」とカタカナにしてくるのも、おじさんの常套手段だ。"(README.md 参考文献[2])
        return 'チャン';
    } elsif ($n < 40) {
        # "「〇〇チャン」をさらに半角で表現する、そんなおじさんもいる"
        return 'ﾁｬﾝ';
    } else {
        # 多くの場合「ちゃん」にする
        return "ちゃん";
    }
}

1;
