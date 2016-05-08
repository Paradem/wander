defmodule Wander.Repo.Migrations.CreateGeofence do
  use Ecto.Migration

  def change do
    create table(:geofences) do
      add :lat, :float
      add :lng, :float

      timestamps
    end

    create index(:geofences, ["ll_to_earth(lat, lng)"], using: :gist)

  end
end
