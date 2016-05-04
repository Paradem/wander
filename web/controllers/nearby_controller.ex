defmodule Wander.NearbyController do
  use Wander.Web, :controller
  alias Wander.Location
  alias Postgrex.Point

  @nearby_distance {0.5, :km}

  def index(conn, %{"lat" => lat, "lng" => long}) do
    response = %Point{y: String.to_float(lat), x: String.to_float(long)}
    |> nearby

    json conn, response
  end

  defp nearby(%Point{} = point) do
    %{}
    |> with_q(point)
    |> with_locations(point)
    #|> with_city
    #|> with_neighborhoods
    #|> with_curated_collections
  end

  defp with_q(response, %Point{} = point) do
    response |> Map.merge(%{q: %{lat: point.y, lng: point.x}})
  end

  defp with_locations(response, %Point{} = point) do
    locations = Location
    |> Location.within_distance(@nearby_distance, point)
    |> Repo.all
    |> Location.as_backwards_compatible

    response |> Map.merge(%{locations: locations})
  end
end
