defmodule Wander.Repo.Migrations.CreateCity do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string
      add :time_zone, :string, default: "Europe/Paris"

      timestamps
    end

  end
end
