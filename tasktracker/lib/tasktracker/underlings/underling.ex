defmodule Tasktracker.Underlings.Underling do
  use Ecto.Schema
  import Ecto.Changeset

  schema "underlings" do
    belongs_to :manager, Tasktracker.Users.User
    belongs_to :underling, Tasktracker.Users.User

    timestamps()
  end

  @doc false
  def changeset(underling, attrs) do
    underling
    |> cast(attrs, [:manager_id, :underling_id])
    |> validate_required([:manager_id, :underling_id])
    |> unique_constraint(:underling_id, name: :underling_manager_id_underling_id_index)
  end
end
