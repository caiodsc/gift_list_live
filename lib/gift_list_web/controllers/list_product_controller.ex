defmodule GiftListWeb.ListProductController do
  use GiftListWeb, :controller

  alias GiftList.GiftLists
  alias GiftList.GiftLists.ListProduct

  def index(conn, _params) do
    list_products = GiftLists.list_list_products()
    render(conn, "index.html", list_products: list_products)
  end

  def new(conn, _params) do
    changeset = GiftLists.change_list_product(%ListProduct{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"list_product" => list_product_params}) do
    case GiftLists.create_list_product(list_product_params) do
      {:ok, list_product} ->
        conn
        |> put_flash(:info, "List product created successfully.")
        |> redirect(to: Routes.list_product_path(conn, :show, list_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list_product = GiftLists.get_list_product!(id)
    render(conn, "show.html", list_product: list_product)
  end

  def edit(conn, %{"id" => id}) do
    list_product = GiftLists.get_list_product!(id)
    changeset = GiftLists.change_list_product(list_product)
    render(conn, "edit.html", list_product: list_product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "list_product" => list_product_params}) do
    list_product = GiftLists.get_list_product!(id)

    case GiftLists.update_list_product(list_product, list_product_params) do
      {:ok, list_product} ->
        conn
        |> put_flash(:info, "List product updated successfully.")
        |> redirect(to: Routes.list_product_path(conn, :show, list_product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", list_product: list_product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list_product = GiftLists.get_list_product!(id)
    {:ok, _list_product} = GiftLists.delete_list_product(list_product)

    conn
    |> put_flash(:info, "List product deleted successfully.")
    |> redirect(to: Routes.list_product_path(conn, :index))
  end
end
