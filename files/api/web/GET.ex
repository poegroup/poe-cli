defmodule {{project_cap}}.Resource.GET do
  use {{project_cap}}.Resource

  input name

  mediatype Hyper do
    action do
      %{
        "greeting" => greeting(name || "guest")
      }
    end
  end

  def greeting(name) do
    %{
      "hello" => name
    }
  end
end
