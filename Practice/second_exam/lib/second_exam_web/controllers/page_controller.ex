defmodule SecondExamWeb.PageController do
  use SecondExamWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
