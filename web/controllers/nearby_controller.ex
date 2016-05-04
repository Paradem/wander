defmodule Wander.NearbyController do
  use Wander.Web, :controller
  alias Wander.Location

  def index(conn, %{"lat" => lat, "lng" => long}) do
    #locations = Location.within_distance({0.5, :km}, {lat, long}) |> Repo.all
    locations = Location |>
      Location.within_distance(0.5, {String.to_float(lat), String.to_float(long)})
      |> Repo.all
 
    json conn, locations
  end
end
