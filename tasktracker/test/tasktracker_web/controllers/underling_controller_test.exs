defmodule TasktrackerWeb.UnderlingControllerTest do
  use TasktrackerWeb.ConnCase

  alias Tasktracker.Underlings

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:underling) do
    {:ok, underling} = Underlings.create_underling(@create_attrs)
    underling
  end

  describe "index" do
    test "lists all underlings", %{conn: conn} do
      conn = get(conn, Routes.underling_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Underlings"
    end
  end

  describe "new underling" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.underling_path(conn, :new))
      assert html_response(conn, 200) =~ "New Underling"
    end
  end

  describe "create underling" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.underling_path(conn, :create), underling: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.underling_path(conn, :show, id)

      conn = get(conn, Routes.underling_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Underling"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.underling_path(conn, :create), underling: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Underling"
    end
  end

  describe "edit underling" do
    setup [:create_underling]

    test "renders form for editing chosen underling", %{conn: conn, underling: underling} do
      conn = get(conn, Routes.underling_path(conn, :edit, underling))
      assert html_response(conn, 200) =~ "Edit Underling"
    end
  end

  describe "update underling" do
    setup [:create_underling]

    test "redirects when data is valid", %{conn: conn, underling: underling} do
      conn = put(conn, Routes.underling_path(conn, :update, underling), underling: @update_attrs)
      assert redirected_to(conn) == Routes.underling_path(conn, :show, underling)

      conn = get(conn, Routes.underling_path(conn, :show, underling))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, underling: underling} do
      conn = put(conn, Routes.underling_path(conn, :update, underling), underling: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Underling"
    end
  end

  describe "delete underling" do
    setup [:create_underling]

    test "deletes chosen underling", %{conn: conn, underling: underling} do
      conn = delete(conn, Routes.underling_path(conn, :delete, underling))
      assert redirected_to(conn) == Routes.underling_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.underling_path(conn, :show, underling))
      end
    end
  end

  defp create_underling(_) do
    underling = fixture(:underling)
    {:ok, underling: underling}
  end
end
