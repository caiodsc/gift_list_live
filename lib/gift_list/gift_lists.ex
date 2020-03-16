defmodule GiftList.GiftLists do
  @moduledoc """
  The GiftLists context.
  """

  import Ecto.Query, warn: false
  alias GiftList.Repo

  alias GiftList.GiftLists.List

  @doc """
  Returns the list of lists.

  ## Examples

      iex> list_lists()
      [%List{}, ...]

  """
  def list_lists do
    Repo.all(List)
  end

  @doc """
  Gets a single list.

  Raises `Ecto.NoResultsError` if the List does not exist.

  ## Examples

      iex> get_list!(123)
      %List{}

      iex> get_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_list!(id), do: Repo.get!(List, id)

  def get_list_or_create_by_session!(session) do
    list = List |> where([l], l.session == ^session) |> Repo.one
    case list do
      nil -> %List{session: session} |> Repo.insert()
      list -> {:ok, list}
    end
  end

  @doc """
  Creates a list.

  ## Examples

      iex> create_list(%{field: value})
      {:ok, %List{}}

      iex> create_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list(attrs \\ %{}) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a list.

  ## Examples

      iex> update_list(list, %{field: new_value})
      {:ok, %List{}}

      iex> update_list(list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_list(%List{} = list, attrs) do
    list
    |> List.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a list.

  ## Examples

      iex> delete_list(list)
      {:ok, %List{}}

      iex> delete_list(list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_list(%List{} = list) do
    Repo.delete(list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking list changes.

  ## Examples

      iex> change_list(list)
      %Ecto.Changeset{source: %List{}}

  """
  def change_list(%List{} = list) do
    List.changeset(list, %{})
  end

  alias GiftList.GiftLists.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{source: %Product{}}

  """
  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end

  alias GiftList.GiftLists.ListProduct

  @doc """
  Returns the list of list_products.

  ## Examples

      iex> list_list_products()
      [%ListProduct{}, ...]

  """
  def list_list_products do
    Repo.all(ListProduct)
  end

  @doc """
  Gets a single list_product.

  Raises `Ecto.NoResultsError` if the List product does not exist.

  ## Examples

      iex> get_list_product!(123)
      %ListProduct{}

      iex> get_list_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_list_product!(id), do: Repo.get!(ListProduct, id)

  def get_list_product_or_create_by_list_and_product_id!(list, product_id) do
    list_product = ListProduct |> where([lp], lp.list_id == ^list.id and lp.product_id == ^product_id) |> Repo.one
    case list_product do
      nil -> %ListProduct{list_id: list.id, product_id: product_id, quantity: 0} |> Repo.insert()
      list_product -> {:ok, list_product}
    end
  end

  @doc """
  Creates a list_product.

  ## Examples

      iex> create_list_product(%{field: value})
      {:ok, %ListProduct{}}

      iex> create_list_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list_product(attrs \\ %{}) do
    %ListProduct{}
    |> ListProduct.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a list_product.

  ## Examples

      iex> update_list_product(list_product, %{field: new_value})
      {:ok, %ListProduct{}}

      iex> update_list_product(list_product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_list_product(%ListProduct{} = list_product, attrs) do
    list_product
    |> ListProduct.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a list_product.

  ## Examples

      iex> delete_list_product(list_product)
      {:ok, %ListProduct{}}

      iex> delete_list_product(list_product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_list_product(%ListProduct{} = list_product) do
    Repo.delete(list_product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking list_product changes.

  ## Examples

      iex> change_list_product(list_product)
      %Ecto.Changeset{source: %ListProduct{}}

  """
  def change_list_product(%ListProduct{} = list_product) do
    ListProduct.changeset(list_product, %{})
  end
end
