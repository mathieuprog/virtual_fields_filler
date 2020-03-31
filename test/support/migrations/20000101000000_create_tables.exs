defmodule VirtualFieldsFiller.CreateTables do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add(:name, :string)

      timestamps()
    end

    create table(:joggers) do
      add(:first_name, :string)
      add(:last_name, :string)
      add(:team_id, references(:teams))

      timestamps()
    end

    create table(:jog_records) do
      add(:time, :integer)
      add(:jogger_id, references(:joggers))

      timestamps()
    end
  end
end
