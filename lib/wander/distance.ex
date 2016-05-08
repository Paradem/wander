defmodule Wander.Distance do
  import Ecto.Query
  import Wander.LengthUnitConverter

  defmacro near(row_lat, row_lng, user_lat, user_lng, distance_in_meters) do
    quote do
      fragment("earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(?, ?)", unquote(user_lat), unquote(user_lng), unquote(distance_in_meters), unquote(row_lat), unquote(row_lng))
    end
  end

  def within_distance(query, {_, _} = distance, lat, lng) do
    {distance_in_meters, _} = distance |> convert(:m)
    within_distance(query, distance_in_meters, lat, lng)
  end

  def within_distance(query, distance_in_meters, lat, lng) do
    from r in query,
      where: near(r.lat, r.lng, ^lat, ^lng, ^distance_in_meters)
  end
end
