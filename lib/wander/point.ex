defmodule Wander.Point do
  @behaviour Ecto.Type

  # Return the underlying Postgrex type.
  def type, do: :point

  # Never blank
  def blank?, do: false

  def load(%Postgrex.Point{} = point), do: {:ok, point}
  def load(_), do: :error

  def dump(%Postgrex.Point{} = point), do: {:ok, point}
  def dump(_), do: :error

  # You can implement casting logic here. For example, if you allow
  # those geometries to somehow be given as strings.
  def cast(%Postgrex.Point{} = point), do: {:ok, point}
  def cast(_), do: :error
end
