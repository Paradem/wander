defmodule Wander.Geofence do
  use Wander.Web, :model

  @derive {Poison.Encoder, only: [:longlat]}

  schema "geofences" do
    field :longlat, Wander.Point

    timestamps
  end

  @required_fields ~w(longlat)
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
