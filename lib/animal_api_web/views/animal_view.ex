defmodule AnimalApiWeb.AnimalView do
  use AnimalApiWeb, :view
  alias AnimalApiWeb.AnimalView

  def render("index.json", %{animals: animals}) do
    %{data: render_many(animals, AnimalView, "animal.json")}
  end

  def render("show.json", %{animal: animal}) do
    %{data: render_one(animal, AnimalView, "animal.json")}
  end

  def render("animal.json", %{animal: animal}) do
    %{id: animal.id,
      name: animal.name,
      weight: animal.weight,
      length: animal.length,
      country_of_origin: animal.country_of_origin}
  end
end
