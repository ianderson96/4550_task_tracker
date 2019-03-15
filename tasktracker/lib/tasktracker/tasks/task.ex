defmodule Tasktracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :desc, :string
    field :title, :string, null: false
    field :minutes, :integer
    field :completed, :boolean, null: false
    has_many :timeblocks, Tasktracker.Timeblocks.Timeblock

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :desc, :minutes, :completed])
    |> validate_required([:title, :desc, :minutes, :completed])
  end
end
