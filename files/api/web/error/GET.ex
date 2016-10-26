defmodule {{project_cap}}.Resource.Error.GET do
  use {{project_cap}}.Resource

  mediatype Hyper do
    action do
      %{
        "error" => %{
          "message" => "Resource not found"
        }
      }
    end
  end
end
