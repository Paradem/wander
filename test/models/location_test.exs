defmodule Wander.LocationTest do
  use Wander.ModelCase

  alias Wander.Location
  alias Wander.Distance
  alias Postgrex.Point

  @valid_attrs %{city_id: 42, details: %{}, g_details: %{}, g_details_queried_at: "2010-04-17 14:00:00", g_place_id: "some content", g_rating: "120.5", g_summary: %{}, is_displayed: true, is_go_hereable: true, is_notifiable: true, is_welcomeable: true, is_you_are_hereable: true, longlat: %Point{y: 41.559977, x: 2.016617}, name: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Location.changeset(%Location{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Location.changeset(%Location{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "finds locations within a distance from a point" do
    [
      %Location{ name: "Terrassa castle", longlat: %Point{y: 41.559977, x: 2.016617} },
      %Location{ name: "Terrassa Masia Freixa", longlat: %Point{y: 41.5630095, x: 2.0020335} },
      %Location{ name: "Terrassa Torre del Palau", longlat: %Point{y: 41.562043, x: 2.0092323} },
    ]
    |> Enum.map(&(Repo.insert(&1)))

    assert locations_in_distance({100, :m}, %Point{y: 41.562043, x: 2.0092323}) == ["Terrassa Torre del Palau"]
    assert locations_in_distance({1, :km}, %Point{y: 41.562043, x: 2.0092323}) == ["Terrassa castle", "Terrassa Masia Freixa", "Terrassa Torre del Palau"]
    assert locations_in_distance({750, :m}, %Point{y: 41.559977, x: 2.016617}) == ["Terrassa castle", "Terrassa Torre del Palau"]
    assert locations_in_distance({2, :km}, %Point{y: 41.559977, x: 2.016617}) == ["Terrassa castle", "Terrassa Masia Freixa", "Terrassa Torre del Palau"]
  end

  defp locations_in_distance(distance, latlong) do
    Location
    |> Distance.within_distance(distance, latlong)
    |> select_name
    |> Repo.all
  end

  defp select_name(query) do
    from loc in query, select: loc.name
  end
end
