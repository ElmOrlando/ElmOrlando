defmodule ElmOrlando.DemoControllerTest do
  use ElmOrlando.ConnCase

  alias ElmOrlando.Demo
  @valid_attrs %{liveDemoUrl: "some content", name: "some content", sourceCodeUrl: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, demo_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    demo = Repo.insert! %Demo{}
    conn = get conn, demo_path(conn, :show, demo)
    assert json_response(conn, 200)["data"] == %{"id" => demo.id,
      "name" => demo.name,
      "liveDemoUrl" => demo.liveDemoUrl,
      "sourceCodeUrl" => demo.sourceCodeUrl}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, demo_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, demo_path(conn, :create), demo: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Demo, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, demo_path(conn, :create), demo: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    demo = Repo.insert! %Demo{}
    conn = put conn, demo_path(conn, :update, demo), demo: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Demo, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    demo = Repo.insert! %Demo{}
    conn = put conn, demo_path(conn, :update, demo), demo: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    demo = Repo.insert! %Demo{}
    conn = delete conn, demo_path(conn, :delete, demo)
    assert response(conn, 204)
    refute Repo.get(Demo, demo.id)
  end
end
