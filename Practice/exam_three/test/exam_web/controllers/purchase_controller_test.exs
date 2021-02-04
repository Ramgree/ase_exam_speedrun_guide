defmodule ExamWeb.PurchaseControllerTest do
  use ExamWeb.ConnCase

  alias Exam.{Repo, User, Product, Purchase}
  alias Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  test "R1 - Positive", %{conn: conn} do
    conn = post conn, "/purchase/search", %{purchase: [match: "pan", bid: 0.5]}
    conn = get conn, redirected_to(conn)

    pants = Repo.one(from p in Product, where: p.name == "pants")

    assert pants.unit > 0.5

    assert html_response(conn, 200) =~ ~r/you have to offer more for pants/
  end

  test "R1 - Negative", %{conn: conn} do
    conn = post conn, "/purchase/search", %{purchase: [match: "head", bid: 1.0]}
    conn = get conn, redirected_to(conn)

    headphones = Repo.one(from p in Product, where: p.name == "headphones")

    headset = Repo.one(from p in Product, where: p.name == "headset")

    assert headphones.unit < headset.unit

    assert html_response(conn, 200) =~ ~r/headphones/

  end

  test "R2 - Positive", %{conn: conn} do

    conn = post conn, "/purchase/search", %{purchase: [match: "head", bid: 1.0]}
    conn = get conn, redirected_to(conn)
    conn = post conn, "/purchase/buy", %{purchase: [bid: "50", email: "stress98@ut.ee", product_id: "1", pin: "666666"]}
    conn = get conn, redirected_to(conn)

  end

end
