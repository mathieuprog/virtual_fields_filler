# Virtual Fields Filler

Fill the virtual fields for your Ecto structs and nested structs recursively.

In your Schema, add the `fill_virtual_fields/1` function:

```elixir
defmodule MyApp.User do
  @behaviour VirtualFieldsFiller
  use Ecto.Schema
  alias __MODULE__

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:full_name, :string, virtual: true)
    timestamps(type: :utc_datetime)
  end

  def fill_virtual_fields(%User{} = user) do
    first_name = Map.fetch!(user, :first_name)
    last_name = Map.fetch!(user, :last_name)

    Map.put(user, :full_name, "#{first_name} #{last_name}")
  end
end
```

Then, after fetching a user (or list of users) from your DB, call `VirtualFieldsFiller.fill_virtual_fields/1`:

```elixir
import VirtualFieldsFiller

User
|> Repo.get!(id)
|> fill_virtual_fields()
```



If you use [QueryBuilder](https://github.com/mathieuprog/query_builder), you may organize your code as follows:


```elixir
# in your controller:

Blog.get_article_by_id(article_id, preload: [:category, comments: :user])

# in the Blog context

def get_article_by_id(id, opts \\ []) do
  QueryBuilder.where(Article, id: id)
  |> QueryBuilder.from_list(opts)
  |> Repo.one!()
  |> fill_virtual_fields()
end
```

As `QueryBuilder` encourages to pass the association names that needs to be preloaded to the Context function, you may
call `fill_virtual_fields/1` in the Context function, right after the call to the `Repo` function, so that any nested
struct gets its virtual fields filled.

## Installation

Add `virtual_fields_filler` for Elixir as a dependency in your `mix.exs` file:

```elixir
def deps do
  [
    {:virtual_fields_filler, "~> 0.3.0"}
  ]
end
```

## HexDocs

HexDocs documentation can be found at [https://hexdocs.pm/virtual_fields_filler](https://hexdocs.pm/virtual_fields_filler).
