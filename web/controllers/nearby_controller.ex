defmodule Wander.NearbyController do
  use Wander.Web, :controller

  alias Wander.Location
  alias Wander.City
  alias Wander.CuratedCollection
  alias Postgrex.Point
  alias Wander.Distance

  @nearby_distance {0.5, :km}

  def index(conn, params) do
    json conn, params |> as_point |> nearby
  end

  defp nearby(point) do
    %{q: %{lat: point.y, lng: point.x}}
    |> with_locations
    |> with_city
    |> with_neighborhoods
    |> with_curated_collections
  end

  defp with_locations(%{q: point} = response) do
    locations = Location
    |> Location.with_curated_collections
    |> Distance.within_distance(@nearby_distance, as_point(point))
    |> Repo.all
    |> Location.with_api_fields

    response |> Map.merge(%{locations: locations})
  end

  defp with_city(%{locations: []} = response), do: response

  defp with_city(%{locations: locations, q: point} = response) do
    city = (from city in City, where: city.id == ^hd(locations).city_id)
    |> Repo.one!
    |> City.with_geofences(@nearby_distance, as_point(point))

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

  defp as_point(%{lat: lat, lng: lng}), do: %Point{y: lat, x: lng}
  defp as_point(%{"lat" => lat, "lng" => lng}) do
    %Point{y: String.to_float(lat), x: String.to_float(lng)}
  end
end
