defmodule Tasktracker.Timeblocks.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timeblocks" do
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime
    field :minutes, :integer
    belongs_to :task, Tasktracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start_time, :end_time, :minutes, :task_id])
    |> validate_required([:start_time, :end_time, :minutes, :task_id])
  end
end
