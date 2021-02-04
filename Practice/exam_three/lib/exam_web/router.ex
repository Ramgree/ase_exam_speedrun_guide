defmodule ExamWeb.Router do
  use ExamWeb, :router

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

  scope "/", ExamWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/purchase/search", PurchaseController, :search
    post "/purchase/buy", PurchaseController, :buy
    resources "/purchase", PurchaseController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExamWeb do
  #   pipe_through :api
  # end
end
