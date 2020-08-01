defmodule AnimalApi.Animals.Animal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "animals" do
    field :country_of_origin, :string
    field :length, :float
    field :name, :string
    field :weight, :float

    timestamps()
  end

  @doc false
  def changeset(animal, attrs) do
    animal
    |> cast(attrs, [:name, :weight, :length, :country_of_origin])
    |> validate_required([:name, :weight, :length, :country_of_origin])
    |> unique_constraint(:name)
  end
end
