defmodule VirtualFieldsFiller.Factory do
  use ExMachina.Ecto, repo: VirtualFieldsFiller.Repo

  def team_factory do
    %VirtualFieldsFiller.Team{
      name: "A"
    }
  end

  def jogger_factory do
    %VirtualFieldsFiller.Jogger{
      first_name: "Jane",
      last_name: "Smith",
      team: build(:team)
    }
  end

  def jog_record_factory do
    %VirtualFieldsFiller.JogRecord{
      time: "95",
      jogger: build(:jogger)
    }
  end
end
