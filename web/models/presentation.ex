defmodule ElmOrlando.Presentation do
  use ElmOrlando.Web, :model

  schema "presentations" do
    field :name, :string
    field :category, :string
    field :author, :string
    field :url, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :category, :author, :url])
    |> validate_required([:name, :category, :author, :url])
  end
end
