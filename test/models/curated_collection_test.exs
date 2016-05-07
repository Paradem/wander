defmodule Wander.CuratedCollectionTest do
  use Wander.ModelCase

  alias Wander.CuratedCollection

  @valid_attrs %{code: "some content", description: "some content", emoji: "some content", is_third_party: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CuratedCollection.changeset(%CuratedCollection{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CuratedCollection.changeset(%CuratedCollection{}, @invalid_attrs)
    refute changeset.valid?
  end
end
