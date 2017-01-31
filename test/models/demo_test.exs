defmodule ElmOrlando.DemoTest do
  use ElmOrlando.ModelCase

  alias ElmOrlando.Demo

  @valid_attrs %{name: "some content", category: "some category", liveDemoUrl: "some content", sourceCodeUrl: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Demo.changeset(%Demo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Demo.changeset(%Demo{}, @invalid_attrs)
    refute changeset.valid?
  end
end
