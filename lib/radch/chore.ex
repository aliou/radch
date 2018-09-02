defmodule Radch.Chore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chores" do
    field(:note, :string)
    field(:period, DateTime.Range)

    belongs_to(:user, Radch.User)

    timestamps()
  end

  @doc false
  def changeset(chore, attrs) do
    changeset =
      chore
      |> cast(attrs, [:user_id, :note, :period])
      |> cast_assoc(:user)
      |> validate_required([:user_id, :period])
  end
end
