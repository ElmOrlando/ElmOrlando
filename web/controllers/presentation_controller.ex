defmodule ElmOrlando.PresentationController do
  use ElmOrlando.Web, :controller

  alias ElmOrlando.Presentation

  def index(conn, _params) do
    presentations = Repo.all(Presentation)
    render(conn, "index.json", presentations: presentations)
  end

  def create(conn, %{"presentation" => presentation_params}) do
    changeset = Presentation.changeset(%Presentation{}, presentation_params)

    case Repo.insert(changeset) do
      {:ok, presentation} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", presentation_path(conn, :show, presentation))
        |> render("show.json", presentation: presentation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ElmOrlando.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    presentation = Repo.get!(Presentation, id)
    render(conn, "show.json", presentation: presentation)
  end

  def update(conn, %{"id" => id, "presentation" => presentation_params}) do
    presentation = Repo.get!(Presentation, id)
    changeset = Presentation.changeset(presentation, presentation_params)

    case Repo.update(changeset) do
      {:ok, presentation} ->
        render(conn, "show.json", presentation: presentation)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(ElmOrlando.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    presentation = Repo.get!(Presentation, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(presentation)

    send_resp(conn, :no_content, "")
  end
end
