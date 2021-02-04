defmodule Exam.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :quantity, :integer
    field :unit, :float

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :unit, :quantity])
    |> validate_required([:name, :unit, :quantity])
    |> unique_constraint(:name, name: :products_name_index)
    |> validate_number(:quantity, greater_than_or_equal_to: 0)
    |> validate_number(:unit, greater_than_or_equal_to: 0)
  end
end
