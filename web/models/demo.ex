defmodule ElmOrlando.Demo do
  use ElmOrlando.Web, :model

  schema "demos" do
    field :name, :string
    field :category, :string
    field :liveDemoUrl, :string
    field :sourceCodeUrl, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :category, :liveDemoUrl, :sourceCodeUrl])
    |> validate_required([:name, :category, :liveDemoUrl, :sourceCodeUrl])
  end
end
