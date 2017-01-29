defmodule ElmOrlando.ResourceView do
  use ElmOrlando.Web, :view

  def render("index.json", %{resources: resources}) do
    %{data: render_many(resources, ElmOrlando.ResourceView, "resource.json")}
  end

  def render("show.json", %{resource: resource}) do
    %{data: render_one(resource, ElmOrlando.ResourceView, "resource.json")}
  end

  def render("resource.json", %{resource: resource}) do
    %{id: resource.id,
      name: resource.name,
      category: resource.category,
      url: resource.url}
  end
end
