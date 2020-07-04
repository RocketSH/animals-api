defmodule AnimalApi.AnimalsTest do
  use AnimalApi.DataCase

  alias AnimalApi.Animals

  describe "animals" do
    alias AnimalApi.Animals.Animal

    @valid_attrs %{country_of_origin: "some country_of_origin", length: 120.5, name: "some name", weight: 120.5}
    @update_attrs %{country_of_origin: "some updated country_of_origin", length: 456.7, name: "some updated name", weight: 456.7}
    @invalid_attrs %{country_of_origin: nil, length: nil, name: nil, weight: nil}

    def animal_fixture(attrs \\ %{}) do
      {:ok, animal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Animals.create_animal()

      animal
    end

    test "list_animals/0 returns all animals" do
      animal = animal_fixture()
      assert Animals.list_animals() == [animal]
    end

    test "get_animal!/1 returns the animal with given id" do
      animal = animal_fixture()
      assert Animals.get_animal!(animal.id) == animal
    end

    test "create_animal/1 with valid data creates a animal" do
      assert {:ok, %Animal{} = animal} = Animals.create_animal(@valid_attrs)
      assert animal.country_of_origin == "some country_of_origin"
      assert animal.length == 120.5
      assert animal.name == "some name"
      assert animal.weight == 120.5
    end

    test "create_animal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Animals.create_animal(@invalid_attrs)
    end

    test "update_animal/2 with valid data updates the animal" do
      animal = animal_fixture()
      assert {:ok, %Animal{} = animal} = Animals.update_animal(animal, @update_attrs)
      assert animal.country_of_origin == "some updated country_of_origin"
      assert animal.length == 456.7
      assert animal.name == "some updated name"
      assert animal.weight == 456.7
    end

    test "update_animal/2 with invalid data returns error changeset" do
      animal = animal_fixture()
      assert {:error, %Ecto.Changeset{}} = Animals.update_animal(animal, @invalid_attrs)
      assert animal == Animals.get_animal!(animal.id)
    end

    test "delete_animal/1 deletes the animal" do
      animal = animal_fixture()
      assert {:ok, %Animal{}} = Animals.delete_animal(animal)
      assert_raise Ecto.NoResultsError, fn -> Animals.get_animal!(animal.id) end
    end

    test "change_animal/1 returns a animal changeset" do
      animal = animal_fixture()
      assert %Ecto.Changeset{} = Animals.change_animal(animal)
    end
  end
end
