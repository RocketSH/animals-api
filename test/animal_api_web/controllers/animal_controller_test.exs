defmodule AnimalApiWeb.AnimalControllerTest do
  use AnimalApiWeb.ConnCase

  alias AnimalApi.Animals
  alias AnimalApi.Animals.Animal

  @create_attrs %{
    country_of_origin: "some country_of_origin",
    length: 120.5,
    name: "some name",
    weight: 120.5
  }
  @update_attrs %{
    country_of_origin: "some updated country_of_origin",
    length: 456.7,
    name: "some updated name",
    weight: 456.7
  }
  @invalid_attrs %{country_of_origin: nil, length: nil, name: nil, weight: nil}

  def fixture(:animal) do
    {:ok, animal} = Animals.create_animal(@create_attrs)
    animal
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all animals", %{conn: conn} do
      conn = get(conn, Routes.animal_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create animal" do
    test "renders animal when data is valid", %{conn: conn} do
      conn = post(conn, Routes.animal_path(conn, :create), animal: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.animal_path(conn, :show, id))

      assert %{
               "id" => id,
               "country_of_origin" => "some country_of_origin",
               "length" => 120.5,
               "name" => "some name",
               "weight" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.animal_path(conn, :create), animal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update animal" do
    setup [:create_animal]

    test "renders animal when data is valid", %{conn: conn, animal: %Animal{id: id} = animal} do
      conn = put(conn, Routes.animal_path(conn, :update, animal), animal: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.animal_path(conn, :show, id))

      assert %{
               "id" => id,
               "country_of_origin" => "some updated country_of_origin",
               "length" => 456.7,
               "name" => "some updated name",
               "weight" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, animal: animal} do
      conn = put(conn, Routes.animal_path(conn, :update, animal), animal: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete animal" do
    setup [:create_animal]

    test "deletes chosen animal", %{conn: conn, animal: animal} do
      conn = delete(conn, Routes.animal_path(conn, :delete, animal))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.animal_path(conn, :show, animal))
      end
    end
  end

  defp create_animal(_) do
    animal = fixture(:animal)
    %{animal: animal}
  end
end
