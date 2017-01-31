defmodule ElmOrlando.ResourceController do
  use ElmOrlando.Web, :controller

  alias ElmOrlando.Resource

  def index(conn, _params) do
    resources = Repo.all(Resource)
    render(conn, "index.json", resources: resources)
  end

  def create(conn, %{"resource" => resource_params}) do
    changeset = Resource.changeset(%Resource{}, resource_params)

    case Repo.insert(changeset) do
      {:ok, resource} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", resource_path(conn, :show, resource))
        |> render("show.json", resource: resource)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ElmOrlando.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    resource = Repo.get!(Resource, id)
    render(conn, "show.json", resource: resource)
  end

  def update(conn, %{"id" => id, "resource" => resource_params}) do
    resource = Repo.get!(Resource, id)
    changeset = Resource.changeset(resource, resource_params)

    case Repo.update(changeset) do
      {:ok, resource} ->
        render(conn, "show.json", resource: resource)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ElmOrlando.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    resource = Repo.get!(Resource, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(resource)

    send_resp(conn, :no_content, "")
  end
end
