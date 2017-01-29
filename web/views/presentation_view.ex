defmodule ElmOrlando.PresentationView do
  use ElmOrlando.Web, :view

  def render("index.json", %{presentations: presentations}) do
    %{data: render_many(presentations, ElmOrlando.PresentationView, "presentation.json")}
  end

  def render("show.json", %{presentation: presentation}) do
    %{data: render_one(presentation, ElmOrlando.PresentationView, "presentation.json")}
  end

  def render("presentation.json", %{presentation: presentation}) do
    %{id: presentation.id,
      name: presentation.name,
      category: presentation.category,
      author: presentation.author,
      url: presentation.url}
  end
end
