defmodule Wander.Distance do
  import Ecto.Query
  import Wander.LengthUnitConverter

  # Distance between two points. Postgrex Point extension is needed (see project config).
  defmacro distance(left, right) do
    quote do
      fragment("? <@> ?", unquote(left), unquote(right))
    end
  end

  def within_distance(query, {_, _} = distance, from_point) do
    {mi, _} = distance |> convert(:mi)
    within_distance(query, mi, from_point)
  end

  def within_distance(query, mi, from_point) do
    from r in query,
      where: distance(r.longlat, ^from_point) <= ^mi
  end
end
