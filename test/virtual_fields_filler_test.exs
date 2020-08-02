defmodule VirtualFieldsFillerTest do
  use ExUnit.Case
  import VirtualFieldsFiller.Factory
  alias VirtualFieldsFiller.Repo
  alias VirtualFieldsFiller.Team
  require Ecto.Query
  import VirtualFieldsFiller

  doctest VirtualFieldsFiller

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  setup :insert_demo_data

  def insert_demo_data(_) do
    team = insert(:team)

    jogger1 = insert(:jogger, %{first_name: "Alice", last_name: "Doe", team: team})
    jogger2 = insert(:jogger, %{first_name: "Bob", last_name: "Doe", team: team})

    insert(:jog_record, %{time: 95, jogger: jogger1})
    insert(:jog_record, %{time: 60, jogger: jogger1})
    insert(:jog_record, %{time: 55, jogger: jogger2})

    :ok
  end

  test "virtual fields filled" do
    team =
      Team
      |> QueryBuilder.preload(joggers: :jog_records)
      |> Repo.one()
      |> fill_virtual_fields()

    Enum.each(team.joggers, fn jogger ->
      assert jogger.full_name == "#{jogger.first_name} #{jogger.last_name}"

      Enum.each(jogger.jog_records, fn jog_record ->
        assert jog_record.time_hours == div(jog_record.time, 60)
        assert jog_record.time_minutes == rem(jog_record.time, 60)
      end)
    end)
  end

  test "virtual fields filled with not loaded association" do
    team =
      Team
      |> QueryBuilder.preload(:joggers)
      |> Repo.one()
      |> fill_virtual_fields()

    Enum.each(team.joggers, fn jogger ->
      assert jogger.full_name == "#{jogger.first_name} #{jogger.last_name}"
    end)
  end
end
