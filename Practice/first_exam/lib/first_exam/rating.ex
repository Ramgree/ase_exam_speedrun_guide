defmodule FirstExam.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :email, :string
    field :rating, :float
    belongs_to :product, FirstExam.Product

    timestamps()
  end

  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:email, :rating, :product_id])
    |> validate_required([:email, :rating, :product_id])
    |> foreign_key_constraint(:product_id)
    |> unique_constraint(:email, name: :ratings_email_product_id_index)
    |> validate_number(:rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 5)
    |> validate_format(:email, ~r/@/)

  end

end
