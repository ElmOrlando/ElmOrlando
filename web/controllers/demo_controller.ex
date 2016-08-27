defmodule ElmOrlando.DemoController do
  use ElmOrlando.Web, :controller

  alias ElmOrlando.Demo

  def index(conn, _params) do
    demos = Repo.all(Demo)
    render(conn, "index.json", demos: demos)
  end

  def create(conn, %{"demo" => demo_params}) do
    changeset = Demo.changeset(%Demo{}, demo_params)

    case Repo.insert(changeset) do
      {:ok, demo} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", demo_path(conn, :show, demo))
        |> render("show.json", demo: demo)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ElmOrlando.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    demo = Repo.get!(Demo, id)
    render(conn, "show.json", demo: demo)
  end

  def update(conn, %{"id" => id, "demo" => demo_params}) do
    demo = Repo.get!(Demo, id)
    changeset = Demo.changeset(demo, demo_params)

    case Repo.update(changeset) do
      {:ok, demo} ->
        render(conn, "show.json", demo: demo)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ElmOrlando.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    demo = Repo.get!(Demo, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(demo)

    send_resp(conn, :no_content, "")
  end
end
