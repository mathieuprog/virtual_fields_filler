defmodule VirtualFieldsFiller.Jogger do
  use QueryBuilder, assoc_fields: [:team, :jog_records]
  use Ecto.Schema
  alias __MODULE__
  @behaviour VirtualFieldsFiller

  schema "joggers" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:full_name, :string, virtual: true)

    belongs_to(:team, VirtualFieldsFiller.Team)
    has_many(:jog_records, VirtualFieldsFiller.JogRecord)

    timestamps(type: :utc_datetime)
  end

  def fill_virtual_fields(%Jogger{} = jogger) do
    first_name = Map.fetch!(jogger, :first_name)
    last_name = Map.fetch!(jogger, :last_name)

    Map.put(jogger, :full_name, "#{first_name} #{last_name}")
  end
end
