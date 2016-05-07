defmodule NearbyControllerTest do
  use Wander.ConnCase

  alias Wander.Location
  alias Wander.City
  alias Wander.Geofence
  alias Wander.CuratedCollection
  alias Wander.CuratedCollectionLocation
  alias Postgrex.Point

  setup do
    cities = [%City{ name: "Terrassa" }]
    |> Enum.map(&Repo.insert!/1)

    locations = [
      %Location{ name: "Terrassa castle", longlat: %Point{y: 41.559977, x: 2.016617}, city_id: hd(cities).id },
      %Location{ name: "Terrassa Masia Freixa", longlat: %Point{y: 41.5630095, x: 2.0020335}, city_id: hd(cities).id },
      %Location{ name: "Terrassa Torre del Palau", longlat: %Point{y: 41.562043, x: 2.0092323}, city_id: hd(cities).id },
      %Location{ name: "Terrassa Centre", longlat: %Point{y: 41.562043, x: 2.0092323}, city_id: hd(cities).id, is_welcomeable: true },
    ]
    |> Enum.map(&Repo.insert!/1)

    geofences = [%Geofence{longlat: %Point{y: 41.5630095, x: 2.0020335}}]
    |> Enum.map(&Repo.insert!/1)

    curated_collections = [%CuratedCollection{name: "Col1"}]
    |> Enum.map(&Repo.insert!/1)

    locations
    |> Enum.map(&(%CuratedCollectionLocation{location_id: &1.id, curated_collection_id: hd(curated_collections).id}))
    |> Enum.map(&Repo.insert!/1)

    {
      :ok,
      conn: conn(),
      cities: cities,
      locations: locations,
      geofences: geofences,
      curated_collections: curated_collections
    }
  end

  test "it returns a nearby response", %{conn: conn, curated_collections: curated_collections} do
    conn = get conn, nearby_path(conn, :index), lat: "41.5630095", lng: "2.0020335"
    response = json_response(conn, 200)

    assert Map.keys(response) == ["city", "curatedCollections", "locations", "neighborhoods", "q"]
    assert Enum.count(response["locations"]) == 1

    location = response["locations"] |> hd
    assert location["name"] == "Terrassa Masia Freixa"
    assert location["lat"] == 41.5630095
    assert location["lng"] == 2.0020335
    assert location["curatedCollections"] == Enum.map(curated_collections, &(&1.id))

    assert response["city"]["name"] == "Terrassa"

    assert hd(response["neighborhoods"])["name"] == "Terrassa Centre"

    assert Enum.map(response["curatedCollections"], &(&1["id"])) == Enum.map(curated_collections, &(&1.id))
  end
end
