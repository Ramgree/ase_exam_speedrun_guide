defmodule FirstExam.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :quantity, :integer
    has_many :ratings, FirstExam.Rating

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :quantity])
    |> validate_required([:name, :quantity])
  end
end
