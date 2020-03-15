defmodule GiftList.Repo do
  use Ecto.Repo,
    otp_app: :gift_list,
    adapter: Ecto.Adapters.Postgres
end
