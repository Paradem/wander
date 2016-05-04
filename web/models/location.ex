defmodule Wander.Location do
  use Wander.Web, :model
  import Wander.Repo

  schema "locations" do
    field :name, :string
    field :details, :map
    field :longlat, Wander.Point
    field :city_id, :integer
    field :g_details, :map
    field :g_summary, :map
    field :g_place_id, :string
    field :g_rating, :decimal
    field :g_details_queried_at, Ecto.DateTime
    field :is_displayed, :boolean, default: false
    field :is_notifiable, :boolean, default: false
    field :is_go_hereable, :boolean, default: false
    field :is_you_are_hereable, :boolean, default: false
    field :is_welcomeable, :boolean, default: false
    field :website, :string

    timestamps
  end

  @required_fields ~w(name details longlat city_id g_details g_summary g_place_id g_rating g_details_queried_at is_displayed is_notifiable is_go_hereable is_you_are_hereable is_welcomeable website)
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

  def within_distance(query, {_, _} = distance, from_point) do
    distance = distance
    |> Wander.LengthUnitConverter.convert(:mi)
    within_distance(query, distance, from_point)
  end

  def within_distance(query, distance, {lat, long}) do
    within_distance(query, distance, %Postgrex.Point{x: long, y: lat})
  end

  def within_distance(query, distance, from_point) do
    IO.inspect from_point
    from location in query,
      where: distance(location.longlat, ^from_point) <= ^distance
  end
end
