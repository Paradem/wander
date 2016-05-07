defmodule Wander.CuratedCollection do
  use Wander.Web, :model

  alias Wander.CuratedCollectionLocation

  @derive {Poison.Encoder, only: [:id, :name, :code, :description, :emoji]}

  schema "curated_collections" do
    field :name, :string
    field :description, :string
    field :code, :string
    field :is_third_party, :boolean, default: false
    field :emoji, :string

    has_many :curated_collections_locations, CuratedCollectionLocation
    has_many :locations, through: [:curated_collections_locations, :curated_collection]

    timestamps
  end

  @required_fields ~w(name description code is_third_party emoji)
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
