defmodule Wander.Location do
  use Wander.Web, :model

  # In order to be compatible with the Rails version, we exclude the :longlat but include :lat and :lng, which can be set with the as_backwards_compatible function.
  @derive {Poison.Encoder, only: [:name, :details, :city_id, :g_details, :g_summary, :g_place_id, :g_place_id, :g_details_queried_at, :is_displayed, :is_notifiable, :is_go_hereable, :is_you_are_hereable, :is_welcomeable, :website, :lat, :lng]}

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
    field :lat, :float, virtual: true
    field :lng, :float, virtual: true

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

  def as_backwards_compatible(locations) when is_list(locations) do
    locations
    |> Enum.map(&as_backwards_compatible/1)
  end

  def as_backwards_compatible(location) do
    %{location | lat: location.longlat.y, lng: location.longlat.x}
  end
end
