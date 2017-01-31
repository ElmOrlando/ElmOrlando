defmodule ElmOrlando.Repo.Migrations.CreateResource do
  use Ecto.Migration

  def change do
    create table(:resources) do
      add :name, :string
      add :category, :string
      add :url, :string

      timestamps()
    end

  end
end
