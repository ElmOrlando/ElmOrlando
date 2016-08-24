defmodule ElmOrlando.PageController do
  use ElmOrlando.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
