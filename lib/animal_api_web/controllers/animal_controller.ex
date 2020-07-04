defmodule AnimalApiWeb.AnimalController do
  use AnimalApiWeb, :controller

  alias AnimalApi.Animals
  alias AnimalApi.Animals.Animal

  action_fallback AnimalApiWeb.FallbackController

  def index(conn, _params) do
    animals = Animals.list_animals()
    render(conn, "index.json", animals: animals)
  end

  def create(conn, %{"animal" => animal_params}) do
    with {:ok, %Animal{} = animal} <- Animals.create_animal(animal_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.animal_path(conn, :show, animal))
      |> render("show.json", animal: animal)
    end
  end

  def show(conn, %{"id" => id}) do
    animal = Animals.get_animal!(id)
    render(conn, "show.json", animal: animal)
  end

  def update(conn, %{"id" => id, "animal" => animal_params}) do
    animal = Animals.get_animal!(id)

    with {:ok, %Animal{} = animal} <- Animals.update_animal(animal, animal_params) do
      render(conn, "show.json", animal: animal)
    end
  end

  def delete(conn, %{"id" => id}) do
    animal = Animals.get_animal!(id)

    with {:ok, %Animal{}} <- Animals.delete_animal(animal) do
      send_resp(conn, :no_content, "")
    end
  end
end
