defmodule FirstExam.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :email, :string
    field :rating, :float
    belongs_to :product, FirstExam.Product

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:email, :rating])
    |> validate_required([:email, :rating])
    |> unique_constraint(:email)
  end
end
