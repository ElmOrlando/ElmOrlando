defmodule ElmOrlando.Repo.Migrations.CreatePresentation do
  use Ecto.Migration

  def change do
    create table(:presentations) do
      add :name, :string
      add :category, :string
      add :author, :string
      add :url, :string

      timestamps()
    end

  end
end
