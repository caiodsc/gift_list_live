defmodule GiftListWeb.Plugs.SetCsrfToken do
  import Plug.Conn

  def init(_args) do
  end

  def call(conn, _args) do
    csrf_token = conn |> fetch_session("_csrf_token")

    case csrf_token do
      is_nil ->
        Plug.CSRFProtection.get_csrf_token
        conn |> put_session("_csrf_token", Process.get(:plug_unmasked_csrf_token))
      csrf_token -> conn
    end
  end
end
