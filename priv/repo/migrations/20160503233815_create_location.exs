defmodule Wander.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :details, :map
      add :lat, :float
      add :lng, :float
      add :city_id, references(:cities)
      add :g_details, :map
      add :g_summary, :map
      add :g_place_id, :string
      add :g_rating, :decimal
      add :g_details_queried_at, :datetime
      add :is_displayed, :boolean, default: false
      add :is_notifiable, :boolean, default: false
      add :is_go_hereable, :boolean, default: false
      add :is_you_are_hereable, :boolean, default: false
      add :is_welcomeable, :boolean, default: false
      add :website, :string

      timestamps
    end

    create index(:locations, ["ll_to_earth(lat, lng)"], using: :gist)
    create index(:locations, [:city_id, :is_welcomeable])

  end
end
