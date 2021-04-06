defmodule SchoolsApi.Repo.Migrations.CreateSchools do
  use Ecto.Migration

  def change do
    create table(:schools) do
      add :name, :string
      add :address, :string
      add :phone, :string

      timestamps()
    end

  end
end
