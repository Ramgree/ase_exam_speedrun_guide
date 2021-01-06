defmodule FirstExamWeb.RatingController do
  use FirstExamWeb, :controller

  import Ecto.Query, only: [from: 2]

  alias FirstExam.Repo
  alias FirstExam.{Rating, Product}
  alias Ecto.{Changeset, Multi}

  def index(conn, _params) do
    query = from p in Product,
      left_join: r in Rating,
      on: p.id == r.product_id,
      group_by: p.id,
      select: %{id: p.id, name: p.name, quantity: p.quantity, votes: count(r.id), rate: avg(r.rating) |> coalesce(0)}

    ratings = Repo.all(query)
    |> Enum.sort_by(&{&1.rate, &1.name}, :desc)

    render conn, "index.html", ratings: ratings
  end

  def new(conn, %{"product" => product_params}) do
    changeset = Rating.changeset(%Rating{}, %{})

    product_params = product_params |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)

    IO.inspect product_params, label: "Yeehaw"

    render conn, "new.html", data: %{
      changeset: changeset,
      product: product_params
    }
  end

  def create(conn, %{"rating" => rating_params}) do

    rating_struct = Enum.map(rating_params, fn ({k, v}) -> {String.to_atom(k), v} end)
    |> Enum.into(%{})

    case Repo.get(Product, rating_struct.product_id) do
      nil ->
        conn
        |> put_flash(:error, "Product id not found")
        |> redirect(to: Routes.rating_path(conn, :index))
      product ->
        changeset = %Rating{}
        |> Rating.changeset(rating_struct)
        |> Changeset.put_assoc(:product, product)
        case Repo.insert(changeset) do
          {:ok, struct} ->
            conn
            |> put_flash(:info, "Yeehelow")
            |> redirect(to: Routes.rating_path(conn, :index))
          {:error, changeset} ->
            conn
            |> render "new.html", data: %{
              changeset: changeset,
              product: %{:name => product.name, :id => product.id}
            }
        end
    end

end

end
