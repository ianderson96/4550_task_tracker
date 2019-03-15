defmodule Tasktracker.Underlings do
  @moduledoc """
  The Underlings context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Underlings.Underling

  @doc """
  Returns the list of underlings.

  ## Examples

      iex> list_underlings()
      [%Underling{}, ...]

  """
  def list_underlings do
    Repo.all(Underling)
  end

  def list_underlings_for_user(id) do
    Repo.all(Underling)
    |> Enum.filter(fn x -> x.manager_id == id end)
  end

  def list_underlings_for_select(id) do
    Repo.all(Underling)
    |> Enum.filter(fn x -> x.manager_id == id end)
    |> Enum.map(fn u ->
      email = Tasktracker.Users.get_user!(u.underling_id).email
      id = u.underling_id
      {email, id}
    end)
  end

  @doc """
  Gets a single underling.

  Raises `Ecto.NoResultsError` if the Underling does not exist.

  ## Examples

      iex> get_underling!(123)
      %Underling{}

      iex> get_underling!(456)
      ** (Ecto.NoResultsError)

  """
  def get_underling!(id), do: Repo.get!(Underling, id)

  def get_manager(id) do
    manager = Repo.get_by(Underling, underling_id: id)
    Tasktracker.Users.get_user!(manager.manager_id).email
  end

  @doc """
  Creates a underling.

  ## Examples

      iex> create_underling(%{field: value})
      {:ok, %Underling{}}

      iex> create_underling(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_underling(attrs \\ %{}) do
    cset = Underling.changeset(%Underling{}, attrs)
    uID = cset.changes.underling_id
    user = Repo.get_by(Underling, underling_id: uID)

    if user do
      from(li in Underling, where: li.underling_id == ^uID) |> Repo.delete_all()
      Repo.insert(cset)
    else
      Repo.insert(cset)
    end
  end

  @doc """
  Updates a underling.

  ## Examples

      iex> update_underling(underling, %{field: new_value})
      {:ok, %Underling{}}

      iex> update_underling(underling, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_underling(%Underling{} = underling, attrs) do
    underling
    |> Underling.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Underling.

  ## Examples

      iex> delete_underling(underling)
      {:ok, %Underling{}}

      iex> delete_underling(underling)
      {:error, %Ecto.Changeset{}}

  """
  def delete_underling(%Underling{} = underling) do
    Repo.delete(underling)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking underling changes.

  ## Examples

      iex> change_underling(underling)
      %Ecto.Changeset{source: %Underling{}}

  """
  def change_underling(%Underling{} = underling) do
    Underling.changeset(underling, %{})
  end
end
