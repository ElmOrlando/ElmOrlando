defmodule ElmOrlando.ResourceTest do
  use ElmOrlando.ModelCase

  alias ElmOrlando.Resource

  @valid_attrs %{category: "some content", name: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Resource.changeset(%Resource{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Resource.changeset(%Resource{}, @invalid_attrs)
    refute changeset.valid?
  end
end
