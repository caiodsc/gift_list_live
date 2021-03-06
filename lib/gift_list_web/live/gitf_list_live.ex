defmodule GiftListWeb.GiftListLive do
  use Phoenix.LiveView

  import Ecto.Query, warn: false

  alias GiftList.Repo
  alias GiftList.GiftLists
  alias GiftList.GiftLists.List
  alias GiftList.GiftLists.Product
  alias GiftList.GiftLists.ListProduct
  alias GiftListWeb.GiftListLiveView

  def mount(params, session, socket) do
    session_token = session["_csrf_token"]

    {:ok, list} = GiftLists.get_list_or_create_by_session!(session_token)

    list = Repo.preload(list, :products)

    products = GiftLists.list_products

    socket = socket
             |> assign(%{
                count: 0,
                list: list,
                products: products,
                search: ""
              })

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(GiftListLiveView, "page.html", assigns)
  end

  def handle_event("add", %{"product-id" => product_id}, socket) do
    product_id = String.to_integer(product_id)
    product = GiftLists.get_product!(product_id)

    list = socket.assigns.list

    {:ok, list_product} = GiftLists.get_list_product_or_create_by_list_and_product_id!(list, product_id)

    list_product |> ListProduct.changeset(%{quantity: list_product.quantity + 1}) |> Repo.update!
    list = list |> List.changeset(%{total: list.total + product.price}) |> Repo.update!

    list = list |> Repo.preload(:products, force: true)

    socket = assign(socket, :list, list)
    {:noreply, socket}
  end

  def handle_event("remove", %{"product-id" => product_id}, socket) do
    product_id = String.to_integer(product_id)
    product = GiftLists.get_product!(product_id)

    list = socket.assigns.list

    {:ok, list_product} = GiftLists.get_list_product_or_create_by_list_and_product_id!(list, product_id)

    if list_product.quantity == 1 do
      list_product |> Repo.delete!
    else
      list_product |> ListProduct.changeset(%{quantity: list_product.quantity - 1}) |> Repo.update!()
    end

    list = list |> List.changeset(%{total: list.total - product.price}) |> Repo.update!
    list = list |> Repo.preload(:products, force: true)

    socket = assign(socket, :list, list)
    {:noreply, socket}
  end

  def handle_event("remove-all", %{"product-id" => product_id}, socket) do
    product_id = String.to_integer(product_id)
    product = GiftLists.get_product!(product_id)

    list = socket.assigns.list

    {:ok, list_product} = GiftLists.get_list_product_or_create_by_list_and_product_id!(list, product_id)

    list = list |> List.changeset(%{total: list.total - (product.price * list_product.quantity)}) |> Repo.update!

    list_product |> Repo.delete!
    list = list |> Repo.preload(:products, force: true)

    socket = assign(socket, :list, list)
    {:noreply, socket}
  end

  def handle_event("update_products_list", %{"search" => search}, socket) do
    query = from p in Product, where: ilike(p.name, ^"%#{search}%")
    products = Repo.all(query)
    socket = assign(socket, :search, search)
    socket = assign(socket, :products, products)

    {:noreply, socket}
  end
end
