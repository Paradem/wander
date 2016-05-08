defmodule Wander.City do
  use Wander.Web, :model

  alias Wander.Distance
  alias Wander.Repo
  alias Wander.Geofence

  @derive {Poison.Encoder, only: [:id, :name, :time_zone, :geofences]}

  schema "cities" do
    field :name, :string
    field :time_zone, :string

    timestamps
  end

  @required_fields ~w(name time_zone)
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

  def with_geofences(city, distance, lat, lng) do
    geofences = Geofence
    |> Distance.within_distance(distance, lat, lng)
    |> Repo.all
    Map.merge(city, %{geofences: geofences})
  end
end
