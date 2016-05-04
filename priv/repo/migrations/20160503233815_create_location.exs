defmodule Wander.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :details, :map
      add :longlat, :point
      add :city_id, :integer
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

  end
end