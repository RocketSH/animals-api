defmodule AnimalApi.Repo.Migrations.AddUniqueIndexOnNameToAnimals do
  use Ecto.Migration

  def change do
    create unique_index(:animals, [:name])
  end
end
