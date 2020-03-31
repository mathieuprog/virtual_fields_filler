defmodule VirtualFieldsFiller.Team do
  use QueryBuilder, assoc_fields: [:joggers]
  use Ecto.Schema

  schema "teams" do
    field(:name, :string)

    has_many(:joggers, VirtualFieldsFiller.Jogger)

    timestamps(type: :utc_datetime)
  end
end
