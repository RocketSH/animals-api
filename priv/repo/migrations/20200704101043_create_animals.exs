defmodule AnimalApi.Repo.Migrations.CreateAnimals do
  use Ecto.Migration

  def change do
    create table(:animals) do
      add :name, :string, null: false
      add :weight, :float, null: false
      add :length, :float, null: false
      add :country_of_origin, :string, null: false

      timestamps()
    end

  end
end
