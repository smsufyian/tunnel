defmodule Tunnel.Repo do
  use Ecto.Repo,
    otp_app: :tunnel,
    adapter: Ecto.Adapters.Postgres
end
