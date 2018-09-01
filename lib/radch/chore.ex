defmodule Radch.Chore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chores" do
    field(:note, :string)
    field(:period, DateTime.RangeType)

    timestamps()
  end

  @doc false
  def changeset(chore, attrs) do
    chore
    |> cast(attrs, [:note, :period])
    |> validate_required([:period])
  end
end
