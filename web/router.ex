defmodule ElmOrlando.Router do
  use ElmOrlando.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElmOrlando do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", ElmOrlando do
    pipe_through :api

    resources "/demos", DemoController, except: [:new, :edit]
  end
end
