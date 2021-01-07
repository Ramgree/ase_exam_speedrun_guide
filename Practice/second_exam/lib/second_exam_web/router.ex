defmodule SecondExamWeb.Router do
  use SecondExamWeb, :router

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

  scope "/", SecondExamWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/games/start", GameController, :start
    post "/games/play", GameController, :play
    resources "/games", GameController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SecondExamWeb do
  #   pipe_through :api
  # end
end
