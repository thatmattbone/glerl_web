defmodule Glerl.WebWeb.Router do
  use Glerl.WebWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {Glerl.WebWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Glerl.WebWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/second-home", PageController, :second_home
  end

  # Other scopes may use custom stacks.
  # scope "/api", Glerl.WebWeb do
  #   pipe_through :api
  # end
end
