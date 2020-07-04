defmodule AnimalApiWeb.PageController do
  use AnimalApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
