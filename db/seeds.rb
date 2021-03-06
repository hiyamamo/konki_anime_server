# config utf-8

require "./models/tv_stations.rb"

tv_station = TvStation.create([
  {:name => "TOKYO_MX"},
  {:name => "テレビ東京系"},
  {:name => "フジテレビ"},
  {:name => "日本テレビ"},
  {:name => "TBS"},
  {:name => "テレ玉"},
  {:name => "テレビ神奈川"},
  {:name => "チバテレビ"},
  {:name => "テレビ北海道"},
  {:name => "MBS"},
  {:name => "テレビ大阪"},
  {:name => "KBS_京都"},
  {:name => "サンテレビ"},
  {:name => "CBC"},
  {:name => "テレビ愛知"},
  {:name => "とちぎテレビ"},
  {:name => "群馬テレビ"},
  {:name => "信越放送"},
  {:name => "岐阜放送"},
  {:name => "三重テレビ"},
  {:name => "TVQ"},
  {:name => "BS11"},
  {:name => "ANIMAX"},
  {:name => "AT-X"},
  {:name => "NHK Eテレ"},
  {:name => "BSジャパン"},
  {:name => "TUT"},
  {:name => "BS-TBS"},
  {:name => "テレビせとうち"},
  {:name => "ABC朝日放送"},
  {:name => "読売テレビ"},
  {:name => "仙台放送"},
  {:name => "静岡放送"},
  {:name => "西日本放送"},
])
