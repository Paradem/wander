defmodule Wander.CuratedCollectionLocation do
  use Wander.Web, :model

  alias Wander.CuratedCollection
  alias Wander.Location

  schema "curated_collections_locations" do
    belongs_to :curated_collection, CuratedCollection
    belongs_to :location, Location
  end

  @required_fields ~w(location_id curated_collection_id)
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
