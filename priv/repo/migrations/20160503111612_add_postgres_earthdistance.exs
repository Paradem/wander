defmodule Repo.Migrations.CreateEarthdistanceExtension do
  use Ecto.Migration

  def up do
    execute "CREATE extension cube;"
    execute "CREATE extension earthdistance;"
  end

  def down do
    execute "DROP extension cube;"
    execute "DROP extension earthdistance;"
  end
end
