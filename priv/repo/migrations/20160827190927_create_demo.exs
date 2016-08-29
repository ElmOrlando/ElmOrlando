defmodule ElmOrlando.Repo.Migrations.CreateDemo do
  use Ecto.Migration

  def change do
    create table(:demos) do
      add :name, :string
      add :liveDemoUrl, :string
      add :sourceCodeUrl, :string

      timestamps()
    end

  end
end
