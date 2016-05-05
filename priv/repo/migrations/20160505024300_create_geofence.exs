defmodule Wander.Repo.Migrations.CreateGeofence do
  use Ecto.Migration

  def change do
    create table(:geofences) do
      add :longlat, :point

      timestamps
    end

  end
end
