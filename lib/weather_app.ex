defmodule WeatherApp do
  def xml() do
    xml_map = File.read!("eqvol.xml") |> XmlToMap.naive_map()

    body =
      xml_map["feed"]["#content"]["entry"]
      |> Enum.sort(&(&1["updated"] < &2["updated"]))
      |> Enum.reduce(
        "",
        &(&2 <>
            "#{&1["updated"] |> String.replace("2020-07-201", "")}," <>
            "#{&1["title"]}," <>
            "#{&1["author"]["name"]}," <>
            "#{&1["content"]["#content"] |> String.slice(0..10)}\n")
      )

    File.write!("eqvol.csv", body)
  end

  def csv_headers() do
    csv_lists =
      File.stream!("predaily00_rct-utf8.csv")
      |> CSV.decode!(headers: true)
      |> Enum.to_list()

    csv_lists
    |> Enum.map(
      &[
        &1["都道府県"],
        &1["地点"],
        "#{&1["現在時刻(年)"]}/#{&1["現在時刻(月)"]}/#{&1["現在時刻(日)"]} #{&1["現在時刻(時)"]}:#{&1["現在時刻(分)"]}",
        &1["昨日までの観測史上1位の値(mm)"]
      ]
    )
  end

  def csv() do
    csv_lists =
      File.stream!("predaily00_rct-utf8.csv")
      |> CSV.decode!()
      |> Enum.to_list()
      |> Enum.drop(1)

    maps =
      csv_lists
      |> Enum.map(fn list ->
        list
        |> Enum.with_index()
        |> Enum.reduce(%{}, &(&2 |> Map.put(elem(&1, 1), elem(&1, 0))))
      end)

    maps
    #     |> Enum.sort( & &1[ 13 ] > &2[ 13 ]) #降水量の多い順に並べてくれる
    #     |> Enum.sort( & String.to_float(&1[ 13 ]) > String.to_float(&2[ 13 ])　# String.to_float  文字列を数値に変換
    |> Enum.sort(&(Type.to_number(&1[13]) > Type.to_number(&2[13])))
    |> Enum.map(&[&1[1], &1[2], "#{&1[4]}/#{&1[5]}/#{&1[6]} #{&1[7]}:#{&1[8]}", &1[13]])
  end

  # ランキング
  def top10(datas) do
    datas
    |> Enum.slice(0..9)
  end
end
