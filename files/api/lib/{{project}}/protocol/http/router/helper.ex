defmodule {{project_cap}}.Protocol.HTTP.Router.Helper do
  defmacro __using__(_) do
    quote do
      use Plug.Builder
      use Concerto, [root: "#{System.cwd!}/web",
                     ext: ".ex",
                     module_prefix: {{project_cap}}.Resource]

      import unquote(__MODULE__)
      @before_compile unquote(__MODULE__)

      def match(%{private: %{mazurka_route: _} } = conn, _opts) do
        conn
      end
      def match(%Plug.Conn{} = conn, _opts) do
        case match(conn.method, conn.path_info) do
          {module, params} ->
            conn
            |> put_private(:mazurka_route, module)
            |> put_private(:mazurka_resource, module)
            |> put_private(:mazurka_resource_params, %{})
            |> put_private(:mazurka_params, params)
          nil ->
            conn
            |> put_private(:mazurka_route, {{project_cap}}.Resource.Error.GET)
            |> put_private(:mazurka_resource, {{project_cap}}.Resource.Error.GET)
            |> put_private(:mazurka_resource_params, %{})
            |> put_private(:mazurka_params, %{})
        end
      end

      defp dispatch(%Plug.Conn{private: %{mazurka_route: route} } = conn, _opts) do
        Mazurka.Protocol.HTTP.Router.Handler.__handle__(conn, route)
      end
    end
  end

  for fun <- [:get, :post, :put, :delete] do
    method = fun |> to_string() |> String.upcase()
    defmacro unquote(fun)(path, module) do
      compile(unquote(method), path, module)
    end
  end

  defp compile(method, path, resource) do
    quote bind_quoted: [method: method,
                        path: path,
                        resource: resource] do

      {method, match, params, map_params, list_params} = Mazurka.Protocol.HTTP.Router.__route__(method, path)
      def match(unquote(method), unquote(match)) do
        {unquote(resource), unquote(map_params)}
      end

      {resolve_method, resolve_match} = Mazurka.Protocol.HTTP.Router.__resolve__(method, match)
      def resolve(unquote(resource), unquote(map_params)) do
        {unquote(resolve_method), unquote(resolve_match)}
      end
      def resolve(unquote(resource), unquote(list_params)) do
        {unquote(resolve_method), unquote(resolve_match)}
      end
    end
  end

  defmacro __before_compile__(_) do
    quote do
      defoverridable resolve: 2

      def resolve(resource, params) do
        case super(resource, params) do
          nil ->
            {:error, :not_found}
          {method, path_info} ->
            {:ok, method, path_info, %{} }
        end
      end
    end
  end
end
