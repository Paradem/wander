defmodule NearbyControllerTest do
  use Wander.ConnCase

  alias Wander.Location
  alias Postgrex.Point

  setup do
    {
      :ok,
      conn: conn(),
      locations: [
        %Location{ name: "Terrassa castle", longlat: %Point{y: 41.559977, x: 2.016617} },
        %Location{ name: "Terrassa Masia Freixa", longlat: %Point{y: 41.5630095, x: 2.0020335} },
        %Location{ name: "Terrassa Torre del Palau", longlat: %Point{y: 41.562043, x: 2.0092323} },
      ] |> Enum.map(&Repo.insert/1)
    }
  end

  test "it returns a nearby response", %{conn: conn} do
    conn = get conn, nearby_path(conn, :index), lat: "41.5630095", lng: "2.0020335"
    response = json_response(conn, 200)

    assert Map.keys(response) == ["locations", "q"]
    assert Enum.count(response["locations"]) == 1

    location = response["locations"] |> hd
    assert location["name"] == "Terrassa Masia Freixa"
    assert location["lat"] == 41.5630095
    assert location["lng"] == 2.0020335
  end
end
