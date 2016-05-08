defmodule Wander.NearbyController do
  use Wander.Web, :controller

  alias Wander.Location
  alias Wander.City
  alias Wander.CuratedCollection
  alias Wander.Distance

  @nearby_distance {0.5, :km}

  def index(conn, %{"lat" => lat, "lng" => lng}) do
    json conn, nearby(String.to_float(lat), String.to_float(lng))
  end

  defp nearby(lat, lng) do
    %{q: %{lat: lat, lng: lng}}
    |> with_locations
    |> with_city
    |> with_neighborhoods
    |> with_curated_collections
  end

  defp with_locations(%{q: %{lat: lat, lng: lng}} = response) do
    locations = Location
    |> Location.with_curated_collections
    |> Distance.within_distance(@nearby_distance, lat, lng)
    |> Repo.all
    |> Location.with_api_fields

    response |> Map.merge(%{locations: locations})
  end

  defp with_city(%{locations: []} = response), do: response

  defp with_city(%{locations: locations, q: %{lat: lat, lng: lng}} = response) do
    city = (from city in City, where: city.id == ^hd(locations).city_id)
    |> Repo.one!
    |> City.with_geofences(@nearby_distance, lat, lng)

    response |> Map.merge(%{city: city})
  end

  defp with_neighborhoods(%{city: %{id: city_id}} = response) do
    neighborhoods = Location.neighborhoods(Location, city_id)
    |> Repo.all

    response |> Map.merge(%{neighborhoods: neighborhoods})
  end
  defp with_neighborhoods(response), do: response

  defp with_curated_collections(response) do
    curated_collections = (from c in CuratedCollection)
    |> Repo.all

    response |> Map.merge(%{curatedCollections: curated_collections})
  end
end
