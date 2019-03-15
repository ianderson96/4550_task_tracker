defmodule Tasktracker.UnderlingsTest do
  use Tasktracker.DataCase

  alias Tasktracker.Underlings

  describe "underlings" do
    alias Tasktracker.Underlings.Underling

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def underling_fixture(attrs \\ %{}) do
      {:ok, underling} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Underlings.create_underling()

      underling
    end

    test "list_underlings/0 returns all underlings" do
      underling = underling_fixture()
      assert Underlings.list_underlings() == [underling]
    end

    test "get_underling!/1 returns the underling with given id" do
      underling = underling_fixture()
      assert Underlings.get_underling!(underling.id) == underling
    end

    test "create_underling/1 with valid data creates a underling" do
      assert {:ok, %Underling{} = underling} = Underlings.create_underling(@valid_attrs)
    end

    test "create_underling/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Underlings.create_underling(@invalid_attrs)
    end

    test "update_underling/2 with valid data updates the underling" do
      underling = underling_fixture()
      assert {:ok, %Underling{} = underling} = Underlings.update_underling(underling, @update_attrs)
    end

    test "update_underling/2 with invalid data returns error changeset" do
      underling = underling_fixture()
      assert {:error, %Ecto.Changeset{}} = Underlings.update_underling(underling, @invalid_attrs)
      assert underling == Underlings.get_underling!(underling.id)
    end

    test "delete_underling/1 deletes the underling" do
      underling = underling_fixture()
      assert {:ok, %Underling{}} = Underlings.delete_underling(underling)
      assert_raise Ecto.NoResultsError, fn -> Underlings.get_underling!(underling.id) end
    end

    test "change_underling/1 returns a underling changeset" do
      underling = underling_fixture()
      assert %Ecto.Changeset{} = Underlings.change_underling(underling)
    end
  end
end
