defmodule Wander.LocationTest do
  use Wander.ModelCase

  alias Wander.Location

  @valid_attrs %{city_id: 42, details: %{}, g_details: %{}, g_details_queried_at: "2010-04-17 14:00:00", g_place_id: "some content", g_rating: "120.5", g_summary: %{}, is_displayed: true, is_go_hereable: true, is_notifiable: true, is_welcomeable: true, is_you_are_hereable: true, longlat: "some content", name: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Location.changeset(%Location{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Location.changeset(%Location{}, @invalid_attrs)
    refute changeset.valid?
  end
end
