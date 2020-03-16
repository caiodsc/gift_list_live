defmodule GiftList.GiftListsTest do
  use GiftList.DataCase

  alias GiftList.GiftLists

  describe "lists" do
    alias GiftList.GiftLists.List

    @valid_attrs %{products_count: 42, session: "some session", total: 120.5}
    @update_attrs %{products_count: 43, session: "some updated session", total: 456.7}
    @invalid_attrs %{products_count: nil, session: nil, total: nil}

    def list_fixture(attrs \\ %{}) do
      {:ok, list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GiftLists.create_list()

      list
    end

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert GiftLists.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert GiftLists.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      assert {:ok, %List{} = list} = GiftLists.create_list(@valid_attrs)
      assert list.products_count == 42
      assert list.session == "some session"
      assert list.total == 120.5
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GiftLists.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      assert {:ok, %List{} = list} = GiftLists.update_list(list, @update_attrs)
      assert list.products_count == 43
      assert list.session == "some updated session"
      assert list.total == 456.7
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = GiftLists.update_list(list, @invalid_attrs)
      assert list == GiftLists.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = GiftLists.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> GiftLists.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = GiftLists.change_list(list)
    end
  end

  describe "products" do
    alias GiftList.GiftLists.Product

    @valid_attrs %{description: "some description", image_url: "some image_url", name: "some name", price: 120.5}
    @update_attrs %{description: "some updated description", image_url: "some updated image_url", name: "some updated name", price: 456.7}
    @invalid_attrs %{description: nil, image_url: nil, name: nil, price: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GiftLists.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert GiftLists.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert GiftLists.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = GiftLists.create_product(@valid_attrs)
      assert product.description == "some description"
      assert product.image_url == "some image_url"
      assert product.name == "some name"
      assert product.price == 120.5
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GiftLists.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = GiftLists.update_product(product, @update_attrs)
      assert product.description == "some updated description"
      assert product.image_url == "some updated image_url"
      assert product.name == "some updated name"
      assert product.price == 456.7
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = GiftLists.update_product(product, @invalid_attrs)
      assert product == GiftLists.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = GiftLists.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> GiftLists.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = GiftLists.change_product(product)
    end
  end

  describe "list_products" do
    alias GiftList.GiftLists.ListProduct

    @valid_attrs %{quantity: 42}
    @update_attrs %{quantity: 43}
    @invalid_attrs %{quantity: nil}

    def list_product_fixture(attrs \\ %{}) do
      {:ok, list_product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GiftLists.create_list_product()

      list_product
    end

    test "list_list_products/0 returns all list_products" do
      list_product = list_product_fixture()
      assert GiftLists.list_list_products() == [list_product]
    end

    test "get_list_product!/1 returns the list_product with given id" do
      list_product = list_product_fixture()
      assert GiftLists.get_list_product!(list_product.id) == list_product
    end

    test "create_list_product/1 with valid data creates a list_product" do
      assert {:ok, %ListProduct{} = list_product} = GiftLists.create_list_product(@valid_attrs)
      assert list_product.quantity == 42
    end

    test "create_list_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GiftLists.create_list_product(@invalid_attrs)
    end

    test "update_list_product/2 with valid data updates the list_product" do
      list_product = list_product_fixture()
      assert {:ok, %ListProduct{} = list_product} = GiftLists.update_list_product(list_product, @update_attrs)
      assert list_product.quantity == 43
    end

    test "update_list_product/2 with invalid data returns error changeset" do
      list_product = list_product_fixture()
      assert {:error, %Ecto.Changeset{}} = GiftLists.update_list_product(list_product, @invalid_attrs)
      assert list_product == GiftLists.get_list_product!(list_product.id)
    end

    test "delete_list_product/1 deletes the list_product" do
      list_product = list_product_fixture()
      assert {:ok, %ListProduct{}} = GiftLists.delete_list_product(list_product)
      assert_raise Ecto.NoResultsError, fn -> GiftLists.get_list_product!(list_product.id) end
    end

    test "change_list_product/1 returns a list_product changeset" do
      list_product = list_product_fixture()
      assert %Ecto.Changeset{} = GiftLists.change_list_product(list_product)
    end
  end
end
