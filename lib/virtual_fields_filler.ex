defmodule VirtualFieldsFiller do
  @callback fill_virtual_fields(struct) :: struct

  def fill_virtual_fields([]), do: []

  def fill_virtual_fields([head | tail]) do
    [
      fill_virtual_fields(head)
      | fill_virtual_fields(tail)
    ]
  end

  def fill_virtual_fields(%{__struct__: _struct_name} = entity) do
    entity =
      if function_exported?(entity.__struct__, :fill_virtual_fields, 1) do
        entity.__struct__.fill_virtual_fields(entity)
      else
        entity
      end

    Map.keys(entity)
    |> Enum.reduce(entity, fn field_name, entity ->
      field_value = Map.fetch!(entity, field_name)

      if is_schema_or_list_of_schemas(field_value) do
        struct(entity, [
          {field_name, fill_virtual_fields(field_value)}
        ])
      else
        entity
      end
    end)
  end

  defp is_schema_or_list_of_schemas(nil), do: false

  defp is_schema_or_list_of_schemas(%{__meta__: _}), do: true

  defp is_schema_or_list_of_schemas([%{__meta__: _} | _]), do: true

  defp is_schema_or_list_of_schemas(_), do: false
end
