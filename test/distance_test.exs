defmodule DistanceTest do
  use Wander.ConnCase

  alias Wander.Distance
  alias Wander.Repo
  alias Postgrex.Point

  test "it doesn't fail" do
    assert Wander.Location |> Distance.within_distance(1, %Point{y: 0.5, x: 0.5}) |> Repo.all == []
    assert Wander.Geofence |> Distance.within_distance(1, %Point{y: 0.5, x: 0.5}) |> Repo.all == []
  end
end
