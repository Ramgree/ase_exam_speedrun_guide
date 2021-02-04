defmodule ExamWeb.PurchaseController do
  use ExamWeb, :controller

  import Ecto.Query, only: [from: 2]

  alias Exam.Repo
  alias Exam.{User, Product, Purchase}
  alias Ecto.Changeset

  def index(conn, _params) do

    changeset = %Purchase{}
    |> Purchase.changeset(%{})

    render conn, "search.html", changeset: changeset

  end

  def search(conn, %{"purchase" => query}) do

    get_all_products = Repo.all(from p in Product, select: p)

    query_match = query["query"]

    IO.inspect query_match, label: "query match"

    candidates = get_all_products
      |> Enum.filter(fn product -> String.match?(product.name, ~r/#{query_match}/) == true end)

    case length(candidates) == 0 do

      true ->

      conn
      |> put_flash(:error, "no matches!")
      |> redirect(to: Routes.purchase_path(conn, :index))

      false ->

    end

    {bid, _} = Float.parse(query["bid"])

    IO.inspect candidates, label: "candidates"

    cheapest = Enum.min_by(candidates, fn product -> product.unit end)

    case (cheapest.quantity > 0 ) do
      true ->
        case (bid >= cheapest.unit) do
          true ->
            changeset = %Purchase{}
                        |> Purchase.changeset(%{query: query_match,
              bid: bid})
            render conn, "purchase.html", data: %{
              changeset: changeset,
              product_name: cheapest.name,
              product_id: cheapest.id
            }
          false ->
            conn
            |> put_flash(:error, "you have to offer more for #{cheapest.name}")
            |> redirect(to: Routes.purchase_path(conn, :index))
        end
      false ->
        conn
        |> put_flash(:error, "no items :/")
        |> redirect(to: Routes.purchase_path(conn, :index))
    end

  end

  def buy(conn, %{"purchase" => purchase}) do

    IO.inspect purchase, label: "testib"

    {bid, _} = Float.parse(purchase["bid"])
    email = purchase["email"]
    pin = String.to_integer(purchase["pin"])
    product_id = String.to_integer(purchase["product_id"])

    user = Repo.one(from u in User, where: u.email == ^email)

    case user != nil do

      true ->

        case user.pin == pin do

          true ->

            product = Repo.get(Product, product_id)

            product
            |> Product.changeset(%{})
            |> Changeset.put_change(:quantity, product.quantity - 1)
            |> Repo.insert!

            user
            |> User.changeset(%{})
            |> Changeset.put_change(:balance, user.balance - bid)
            |> Repo.insert!

            conn
            |> put_flash(:info, "#{product.name}, #{bid}, #{user.balance - bid}")
            |> redirect(to: Routes.purchase_path(conn, :index))

        end

    end



  end

end