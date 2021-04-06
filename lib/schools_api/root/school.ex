defmodule SchoolsApi.Root.School do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schools" do
    field :address, :string
    field :name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(school, attrs) do
    school
    |> cast(attrs, [:name, :address, :phone])
    |> validate_required([:name])
  end
end
