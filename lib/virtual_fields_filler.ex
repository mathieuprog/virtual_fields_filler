defmodule VirtualFieldsFiller do
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

      case Map.fetch!(entity, field_name) do
        nested when is_list(nested) or is_struct(nested) ->
          struct(entity, [
            {field_name, fill_virtual_fields(nested)}
          ])
        _ ->
          entity
      end
    end)
  end
end
