defmodule GiftListWeb.Router do
  use GiftListWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_live_layout, {GiftListWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GiftListWeb do
    pipe_through :browser

    #get "/", PageController, :index

    resources "/lists", ListController
    resources "/products", ProductController

    live "/", GiftListLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", GiftListWeb do
  #   pipe_through :api
  # end
end
