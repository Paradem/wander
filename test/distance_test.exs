defmodule DistanceTest do
  use Wander.ConnCase

  alias Wander.Distance
  alias Wander.Repo

  test "it doesn't fail" do
    assert Wander.Location |> Distance.within_distance(1, 0.5, 0.5) |> Repo.all == []
    assert Wander.Geofence |> Distance.within_distance(1, 0.5, 0.5) |> Repo.all == []
  end
end
