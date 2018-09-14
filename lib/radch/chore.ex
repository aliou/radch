defmodule Radch.Chore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chores" do
    field(:note, :string)
    field(:range, Timestamp.Range)

    belongs_to(:user, Radch.User)

    timestamps()
  end

  @doc false
  def changeset(chore, attrs) do
    changeset =
      chore
      |> cast(attrs, [:user_id, :note, :range])
      |> cast_assoc(:user)
      |> validate_required([:user_id, :range])

    # The exclusion constraint is actually on both the range and the user_id (see migration),
    # but there doesn't seem to be a way to tell that to Ecto.
    changeset |> exclusion_constraint(:range, name: :no_overlaping_chores_for_user)
  end
end
