defmodule Tasktracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, null: false
    field :admin, :boolean, default: false, null: false
    has_many :list_items, Tasktracker.TaskLists.ListItem

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :admin])
    |> validate_required([:email, :admin])
  end
end
