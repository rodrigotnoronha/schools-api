defmodule SchoolsApi.Repo do
  use Ecto.Repo,
    otp_app: :schools_api,
    adapter: Ecto.Adapters.Postgres
end
