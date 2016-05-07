defmodule Wander.CuratedCollectionLocationTest do
  use Wander.ModelCase

  alias Wander.CuratedCollectionLocation

  @valid_attrs %{location_id: 1, curated_collection_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CuratedCollectionLocation.changeset(%CuratedCollectionLocation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CuratedCollectionLocation.changeset(%CuratedCollectionLocation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
