defmodule Tasktracker.TaskLists.ListItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list_items" do
    belongs_to :user, Tasktracker.Users.User
    belongs_to :task, Tasktracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(list_item, attrs) do
    list_item
    |> cast(attrs, [:user_id, :task_id])
    |> validate_required([:user_id, :task_id])
    |> unique_constraint(:task_id, name: :list_item_user_id_task_id_index)
  end
end
