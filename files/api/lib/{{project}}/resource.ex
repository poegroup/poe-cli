defmodule {{project_cap}}.Resource do
  defmacro __using__(_opts) do
    quote do
      use Mazurka.Resource

      file = __ENV__.file
      method = file |> Path.basename(".ex")
      web = Path.join(System.cwd!, "web")
      rel = Path.relative_to(file, web)
      path = case Path.dirname(rel) do
               "." -> []
               l -> Path.split(l)
             end

      expected = Concerto.Utils.format_module({{project_cap}}.Resource, path, method)

      if expected != __MODULE__ do
        require Logger
        Logger.warn "#{rel} does not match module format. Expected #{inspect(expected)}, got #{inspect(__MODULE__)}"
      end
    end
  end
end
