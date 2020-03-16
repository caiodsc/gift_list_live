defmodule GiftListWeb.GiftListLiveView do
  use GiftListWeb, :view

  def number_to_currency(number) do
    Number.Currency.number_to_currency(Decimal.from_float(number), unit: "R$")
  end
end
