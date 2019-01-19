defmodule Radch.Assignment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assignments" do
    field(:rank, :string)

    belongs_to(:user, Radch.User)
    belongs_to(:ship, Radch.Ship)

    timestamps()
  end

  @doc false
  # TODO: Validate the rank validity.
  def changeset(assignment, attrs) do
    assignment
    |> cast(attrs, [:user_id, :ship_id, :rank])
    |> cast_assoc(:user)
    |> cast_assoc(:ship)
    |> validate_required([:rank])
  end
end
