defmodule Radch.Ship do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "ships" do
    field(:name, :string)
    field(:ship_class, :string)

    timestamps()
  end

  @doc false
  def changeset(ship, attrs) do
    ship
    |> cast(attrs, [:name, :ship_class])
    |> validate_required([:name, :ship_class])
    |> unique_constraint(:name)
  end
end
