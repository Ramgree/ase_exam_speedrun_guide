defmodule FirstExamWeb.Rating.RatingControllerTest do
  use FirstExamWeb.ConnCase

  alias FirstExam.{Repo, Product, Rating}
  alias Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  test "number range", %{conn: conn} do
    conn = post conn, "/ratings", %{rating: [product_id: 1, email: "rucy@ut.ee", rating: 5.1]}
    assert html_response(conn, 200) =~ ~r/must be less than or equal to 5/
  end

  test "non existing product id", %{conn: conn} do
    conn = post conn, "/ratings", %{rating: [product_id: 10, email: "rucy@ut.ee", rating: 4.0]}
    conn = get conn, redirected_to(conn)
    assert html_response(conn, 200) =~ ~r/Product id not found/
  end

  test "reject rating with same name and email", %{conn: conn} do
    conn = post conn, "/ratings", %{rating: [product_id: 1, email: "rucy@ut.ee", rating: 4.0]}
    conn = get conn, redirected_to(conn)
    conn = post conn, "/ratings", %{rating: [product_id: 1, email: "rucy@ut.ee", rating: 4.0]}
    assert html_response(conn, 200) =~ ~r/has already been taken/
  end

  test "average rating with 0", %{conn: conn} do
    conn = get(conn, "/ratings")

    assigns = conn.assigns.ratings

    haskell_zero_ratings = assigns |> Enum.filter(fn map -> map.name == "haskell" end)

    [ haskell_struct ] = haskell_zero_ratings

    assert haskell_struct.votes == 0

    assert haskell_struct.rate == 0.0

  end

  test "sorted ratings", %{conn: conn} do

    conn = get(conn, "/ratings")

    assigns = conn.assigns.ratings

    assert assigns == assigns |> Enum.sort_by(&{&1.rate, &1.name},:desc)

  end

end
