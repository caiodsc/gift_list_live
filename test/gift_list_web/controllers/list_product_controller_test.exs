defmodule GiftListWeb.ListProductControllerTest do
  use GiftListWeb.ConnCase

  alias GiftList.GiftLists

  @create_attrs %{quantity: 42}
  @update_attrs %{quantity: 43}
  @invalid_attrs %{quantity: nil}

  def fixture(:list_product) do
    {:ok, list_product} = GiftLists.create_list_product(@create_attrs)
    list_product
  end

  describe "index" do
    test "lists all list_products", %{conn: conn} do
      conn = get(conn, Routes.list_product_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing List products"
    end
  end

  describe "new list_product" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.list_product_path(conn, :new))
      assert html_response(conn, 200) =~ "New List product"
    end
  end

  describe "create list_product" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.list_product_path(conn, :create), list_product: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.list_product_path(conn, :show, id)

      conn = get(conn, Routes.list_product_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show List product"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.list_product_path(conn, :create), list_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "New List product"
    end
  end

  describe "edit list_product" do
    setup [:create_list_product]

    test "renders form for editing chosen list_product", %{conn: conn, list_product: list_product} do
      conn = get(conn, Routes.list_product_path(conn, :edit, list_product))
      assert html_response(conn, 200) =~ "Edit List product"
    end
  end

  describe "update list_product" do
    setup [:create_list_product]

    test "redirects when data is valid", %{conn: conn, list_product: list_product} do
      conn = put(conn, Routes.list_product_path(conn, :update, list_product), list_product: @update_attrs)
      assert redirected_to(conn) == Routes.list_product_path(conn, :show, list_product)

      conn = get(conn, Routes.list_product_path(conn, :show, list_product))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, list_product: list_product} do
      conn = put(conn, Routes.list_product_path(conn, :update, list_product), list_product: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit List product"
    end
  end

  describe "delete list_product" do
    setup [:create_list_product]

    test "deletes chosen list_product", %{conn: conn, list_product: list_product} do
      conn = delete(conn, Routes.list_product_path(conn, :delete, list_product))
      assert redirected_to(conn) == Routes.list_product_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.list_product_path(conn, :show, list_product))
      end
    end
  end

  defp create_list_product(_) do
    list_product = fixture(:list_product)
    {:ok, list_product: list_product}
  end
end
