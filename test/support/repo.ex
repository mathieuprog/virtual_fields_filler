defmodule VirtualFieldsFiller.Repo do
  use Ecto.Repo,
    otp_app: :virtual_fields_filler,
    adapter: Ecto.Adapters.Postgres
end
