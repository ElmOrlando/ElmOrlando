defmodule ElmOrlando.PresentationControllerTest do
  use ElmOrlando.ConnCase

  alias ElmOrlando.Presentation
  @valid_attrs %{author: "some content", category: "some content", name: "some content", url: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, presentation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    presentation = Repo.insert! %Presentation{}
    conn = get conn, presentation_path(conn, :show, presentation)
    assert json_response(conn, 200)["data"] == %{"id" => presentation.id,
      "name" => presentation.name,
      "category" => presentation.category,
      "author" => presentation.author,
      "url" => presentation.url}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, presentation_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, presentation_path(conn, :create), presentation: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Presentation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, presentation_path(conn, :create), presentation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    presentation = Repo.insert! %Presentation{}
    conn = put conn, presentation_path(conn, :update, presentation), presentation: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Presentation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    presentation = Repo.insert! %Presentation{}
    conn = put conn, presentation_path(conn, :update, presentation), presentation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    presentation = Repo.insert! %Presentation{}
    conn = delete conn, presentation_path(conn, :delete, presentation)
    assert response(conn, 204)
    refute Repo.get(Presentation, presentation.id)
  end
end
