defmodule ElmOrlando.PresentationTest do
  use ElmOrlando.ModelCase

  alias ElmOrlando.Presentation

  @valid_attrs %{author: "some content", category: "some content", name: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Presentation.changeset(%Presentation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Presentation.changeset(%Presentation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
