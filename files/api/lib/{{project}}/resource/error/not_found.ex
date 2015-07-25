defmodule {{project_cap}}.Resource.Error.NotFound do
  use Mazurka.Resource

  mediatype Mazurka.Mediatype.Hyperjson do
    action do
      %{
        "error" => %{
          "message" => "Not found"
        }
      }
    end
  end
end