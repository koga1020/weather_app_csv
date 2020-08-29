# weather_app_csv

気象庁の年間降水量のxmlデータをcsvへ変換、表示用に加工
(①xml→csv変換工程と②csvをインストールするパターン)

## Installation

## メモ
(①xml→csv変換手順は別途手順有)
②csvをインストールして使う
表示用に使用するcsvは下記ファイルを使用

気象庁/最新の気象データ/csv/日降水量
https://www.data.jma.go.jp/obd/stats/data/mdrr/docs/csv_dl_readme.html

このcsvをUTF-8形式で保存して使用する
https://www.data.jma.go.jp/obd/stats/data/mdrr/pre_rct/alltable/predaily00_rct.csv

## 手順ss
1. プロジェクト作成
  $ mix new weather_app
  $ cd weather_app
2.  mix.exsを修正。
  defp deps do
    [
      {:csv, "~> 2.3.1"}
    ]
  end
3. 依存の取得
  $ mix deps.get
4. インストールしたcsv(UTF-8で保存)をmix.exsがあるフォルダと同じ場所に格納
　「predail00_rct-utf8.csv」が使用可能なcsvファイル
5. iex起動
  $ iex -S mix
6. 読み込み確認
  File.stream!("predaily00_rct_utf8.csv") |> CSV.decode() |> Enum.to_list()