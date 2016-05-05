defmodule Wander.GeofenceTest do
  use Wander.ModelCase

  alias Wander.Geofence

  @valid_attrs %{longlat: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Geofence.changeset(%Geofence{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Geofence.changeset(%Geofence{}, @invalid_attrs)
    refute changeset.valid?
  end
end
