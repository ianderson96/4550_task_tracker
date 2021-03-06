defmodule Tasktracker.TaskLists do
  @moduledoc """
  The TaskLists context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.TaskLists.ListItem

  @doc """
  Returns the list of list_items.

  ## Examples

      iex> list_list_items()
      [%ListItem{}, ...]

  """
  def list_list_items do
    Repo.all(ListItem)
  end

  @doc """
  Gets a single list_item.

  Raises `Ecto.NoResultsError` if the List item does not exist.

  ## Examples

      iex> get_list_item!(123)
      %ListItem{}

      iex> get_list_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_list_item!(id), do: Repo.get!(ListItem, id)

  def get_list_item_by_task(id) do
    user = Repo.get_by(ListItem, task_id: id)

    if user do
      Tasktracker.Users.get_user!(user.user_id).email
    else
      nil
    end
  end

  def get_list_item_id_by_task(id) do
    user = Repo.get_by(ListItem, task_id: id)

    if user do
      Tasktracker.Users.get_user!(user.user_id).id
    else
      nil
    end
  end

  @doc """
  Creates a list_item.

  ## Examples

      iex> create_list_item(%{field: value})
      {:ok, %ListItem{}}

      iex> create_list_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list_item(attrs \\ %{}) do
    cset = ListItem.changeset(%ListItem{}, attrs)
    taskID = cset.changes.task_id
    user = Repo.get_by(ListItem, task_id: taskID)

    if user do
      from(li in ListItem, where: li.task_id == ^taskID) |> Repo.delete_all()
      Repo.insert(cset)
    else
      Repo.insert(cset)
    end
  end

  @doc """
  Updates a list_item.

  ## Examples

      iex> update_list_item(list_item, %{field: new_value})
      {:ok, %ListItem{}}

      iex> update_list_item(list_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_list_item(%ListItem{} = list_item, attrs) do
    list_item
    |> ListItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ListItem.

  ## Examples

      iex> delete_list_item(list_item)
      {:ok, %ListItem{}}

      iex> delete_list_item(list_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_list_item(%ListItem{} = list_item) do
    Repo.delete(list_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking list_item changes.

  ## Examples

      iex> change_list_item(list_item)
      %Ecto.Changeset{source: %ListItem{}}

  """
  def change_list_item(%ListItem{} = list_item) do
    ListItem.changeset(list_item, %{})
  end
end
