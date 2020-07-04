defmodule AnimalApi.Repo do
  use Ecto.Repo,
    otp_app: :animal_api,
    adapter: Ecto.Adapters.Postgres
end
