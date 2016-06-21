defmodule {{project_cap}}.Resource.GET do
  use Mazurka.Resource

  mediatype Mazurka.Mediatype.Hyperjson do
    action do
      %{
        "greeting" => Greeting.world()
      }
    end
  end
end