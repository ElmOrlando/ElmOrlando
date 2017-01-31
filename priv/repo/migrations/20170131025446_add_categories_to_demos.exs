defmodule ElmOrlando.Repo.Migrations.AddCategoriesToDemos do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :category, :string
    end
  end
end
