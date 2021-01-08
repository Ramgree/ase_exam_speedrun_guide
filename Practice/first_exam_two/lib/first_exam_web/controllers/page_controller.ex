defmodule FirstExamWeb.PageController do
  use FirstExamWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
