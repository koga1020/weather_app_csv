defmodule WeatherAppTest do
  use ExUnit.Case
  doctest WeatherApp

  describe "sort_by_updated" do
    test "sort in :asc order by default" do
      assert [
               %{"id" => 1, "updated" => "2020-08-30T10:00:00Z"},
               %{"id" => 2, "updated" => "2020-08-30T12:00:00Z"},
               %{"id" => 3, "updated" => "2020-08-30T14:00:00Z"}
             ] ==
               WeatherApp.sort_by_updated([
                 %{
                   "id" => 2,
                   "updated" => "2020-08-30T12:00:00Z"
                 },
                 %{
                   "id" => 1,
                   "updated" => "2020-08-30T10:00:00Z"
                 },
                 %{
                   "id" => 3,
                   "updated" => "2020-08-30T14:00:00Z"
                 }
               ])
    end

    test "sort in :desc order" do
      assert [
               %{"id" => 3, "updated" => "2020-08-30T14:00:00Z"},
               %{"id" => 2, "updated" => "2020-08-30T12:00:00Z"},
               %{"id" => 1, "updated" => "2020-08-30T10:00:00Z"}
             ] ==
               WeatherApp.sort_by_updated(
                 [
                   %{
                     "id" => 2,
                     "updated" => "2020-08-30T12:00:00Z"
                   },
                   %{
                     "id" => 1,
                     "updated" => "2020-08-30T10:00:00Z"
                   },
                   %{
                     "id" => 3,
                     "updated" => "2020-08-30T14:00:00Z"
                   }
                 ],
                 :desc
               )
    end
  end
end
