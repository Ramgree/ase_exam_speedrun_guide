defmodule FirstExamWeb.Router do
  use FirstExamWeb, :router

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

  scope "/", FirstExamWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/ratings", RatingController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FirstExamWeb do
  #   pipe_through :api
  # end
end
