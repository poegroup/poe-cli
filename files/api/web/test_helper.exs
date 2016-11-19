defmodule Test.{{project_cap}}.Resource do
  defmacro __using__(_) do
    resource = __CALLER__.module |> Module.split() |> tl() |> Module.concat()
    quote do
      use Mazurka.Plug.Test, router: {{project_cap}}.Router,
                             resource: unquote(resource)
      import unquote(__MODULE__)
    end
  end

  defmacro seed(module, params \\\\ Macro.escape(%{})) do
    quote do
      unquote(module).seed(unquote(params))
    end
  end
end

ExUnit.start()
