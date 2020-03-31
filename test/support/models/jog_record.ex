defmodule VirtualFieldsFiller.JogRecord do
  use QueryBuilder, assoc_fields: [:jogger]
  use Ecto.Schema
  alias __MODULE__

  schema "jog_records" do
    field(:time, :integer)
    field(:time_hours, :string, virtual: true)
    field(:time_minutes, :string, virtual: true)

    belongs_to(:jogger, VirtualFieldsFiller.Jogger)

    timestamps(type: :utc_datetime)
  end

  def fill_virtual_fields(%JogRecord{time: time} = jogger) do
    jogger
    |> Map.put(:time_hours, div(time, 60))
    |> Map.put(:time_minutes, rem(time, 60))
  end
end
