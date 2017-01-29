defmodule ElmOrlando.Resource do
  use ElmOrlando.Web, :model

  schema "resources" do
    field :name, :string
    field :category, :string
    field :url, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :category, :url])
    |> validate_required([:name, :category, :url])
  end
end
