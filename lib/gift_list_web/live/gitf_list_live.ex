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
    session_token = Phoenix.Controller.get_csrf_token() #session["_csrf_token"]

    {:ok, list} = GiftLists.get_list_or_create_by_session!(session_token)

    list = Repo.preload(list, :products)

    products = GiftLists.list_products

    socket = socket
             |> assign(%{
                count: 0,
                list: list,
                products: products
              })

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(GiftListLiveView, "page.html", assigns)
  end

  def handle_event("increment", params, socket) do
    count = socket.assigns.count + 1
    socket = assign(socket, :count, count)
    {:noreply, socket}
  end

  def handle_event("decrement", %{teste: t}, socket) do
    count = socket.assigns.count - 1
    socket = assign(socket, :count, count)
    {:noreply, socket}
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
end
