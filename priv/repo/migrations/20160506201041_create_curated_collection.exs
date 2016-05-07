defmodule Wander.Repo.Migrations.CreateCuratedCollection do
  use Ecto.Migration

  def change do
    create table(:curated_collections) do
      add :name, :string
      add :description, :text
      add :code, :string
      add :is_third_party, :boolean, default: false
      add :emoji, :string

      timestamps
    end

    create table(:curated_collections_locations) do
      add :curated_collection_id, references(:curated_collections)
      add :location_id, references(:locations)
    end

    create index(:curated_collections_locations, [:curated_collection_id, :location_id], unique: true)
    create index(:curated_collections_locations, [:location_id])

  end
end
