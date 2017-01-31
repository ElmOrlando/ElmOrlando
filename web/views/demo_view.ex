defmodule ElmOrlando.DemoView do
  use ElmOrlando.Web, :view

  def render("index.json", %{demos: demos}) do
    %{data: render_many(demos, ElmOrlando.DemoView, "demo.json")}
  end

  def render("show.json", %{demo: demo}) do
    %{data: render_one(demo, ElmOrlando.DemoView, "demo.json")}
  end

  def render("demo.json", %{demo: demo}) do
    %{id: demo.id,
      name: demo.name,
      category: demo.category,
      liveDemoUrl: demo.liveDemoUrl,
      sourceCodeUrl: demo.sourceCodeUrl}
  end
end
