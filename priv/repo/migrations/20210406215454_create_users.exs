defmodule SchoolsApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :encrypted_password, :string
      add :phone, :string
      add :address, :string

      timestamps()
    end

  end
end
