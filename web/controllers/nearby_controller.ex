defmodule Wander.NearbyController do
  use Wander.Web, :controller

  alias Wander.Location
  alias Wander.City
  alias Postgrex.Point
  alias Wander.Distance

  @nearby_distance {0.5, :km}

  def index(conn, %{"lat" => lat, "lng" => long}) do
    response = %Point{y: String.to_float(lat), x: String.to_float(long)}
    |> nearby

    json conn, response
  end

  defp nearby(%Point{} = point) do
    {response, _ } = {%{}, point}
    |> with_q
    |> with_locations
    |> with_city
    #|> with_neighborhoods
    #|> with_curated_collections
    response
  end

  defp with_q({response, point}) do
    {response |> Map.merge(%{q: %{lat: point.y, lng: point.x}}), point}
  end

  defp with_locations({response, point}) do
    locations = Location
    |> Distance.within_distance(@nearby_distance, point)
    |> Repo.all
    |> Location.as_backwards_compatible

    {response |> Map.merge(%{locations: locations}), point}
  end

  defp with_city({%{locations: []}, _} = input), do: input

  defp with_city({%{locations: locations} = response, point}) do
    city = (from city in City, where: city.id == ^hd(locations).city_id)
    |> Repo.one!
    |> City.with_geofences(@nearby_distance, point)

    {response |> Map.merge(%{city: city}), point}
  end
end
