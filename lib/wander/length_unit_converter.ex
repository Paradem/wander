defmodule Wander.LengthUnitConverter do
  def convert({km, :km}, :m) do
    {km * 1000, :m}
  end

  def convert({m, :m}, :km) do
    {m / 1000, :km}
  end

  def convert({mi, :mi}, :m) do
    {mi * 1609.344, :m}
  end

  def convert({m, :m}, :mi) do
    {m / 1609.344, :mi}
  end

  def convert(from, to) do
    from |> convert(:m) |> convert(to)
  end
end
