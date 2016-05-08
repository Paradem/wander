defmodule Wander.Geofence do
  use Wander.Web, :model

  @derive {Poison.Encoder, only: [:lat, :lng]}

  schema "geofences" do
    field :lat, :float
    field :lng, :float

    timestamps
  end

  @required_fields ~w(lat lng)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
