defmodule {{project_cap}}.HTTP.Router.Helper do
  defmacro __using__(_) do
    quote do
      use Plug.Builder
      use Concerto, [root: "#{System.cwd!}/web",
                     ext: ".ex",
                     module_prefix: {{project_cap}}.Resource]

      import unquote(__MODULE__)

      def match(%{private: %{mazurka_route: _}\} = conn, _opts) do
        conn
      end
      def match(%Plug.Conn{} = conn, _opts) do
        case match(conn.method, conn.path_info) do
          {module, params} ->
            conn
            |> put_private(:mazurka_route, module)
            |> put_private(:mazurka_resource, module)
            |> put_private(:mazurka_params, params)
          nil ->
            conn
            |> put_private(:mazurka_route, {{project_cap}}.Resource.Error.GET)
            |> put_private(:mazurka_resource, {{project_cap}}.Resource.Error.GET)
            |> put_private(:mazurka_params, %{})
        end
      end

      defp dispatch(%Plug.Conn{private: %{mazurka_route: route, mazurka_params: params}\} = conn, _opts) do
        accept = [
          {"application", "json", %{}\},
          {"text", "*", %{}\},
        ]
        conn = %{params: input} = fetch_query_params(conn)
        {body, content_type, conn} = route.action(accept, params, input, conn, __MODULE__)
        conn
        |> handle_body(body, content_type)
        |> handle_transition()
        |> handle_invalidation()
        |> handle_response()
        |> send_resp()
      end

      def resolve(affordance = %{resource: resource, params: params}, source, conn) do
        case resolve(resource, params) do
          {method, path} ->
            %{affordance |
              host: conn.host,
              port: conn.port,
              scheme: conn.scheme |> to_string,
              method: method,
              path: "/" <> (Stream.concat(conn.script_name, path) |> Enum.join("/")),
              fragment: affordance.opts[:fragment],
              query: case URI.encode_query(affordance.input) do
                "" -> nil
                other -> other
              end
            }
          nil ->
            nil
        end
      end

      def resolve_resource(resource_name, _source, _conn) do
        resolve_module(resource_name)
      end

      defp handle_body(conn, body, content_type) do
        body = case content_type do
          {"application", subtype, _} when subtype in ["json", "hyper+json"] ->
            Poison.encode_to_iodata!(body)
          {"text", _, _} ->
            body
        end
        %{conn | resp_body: body, state: :set}
      end

      defp handle_transition(conn = %{private: %{mazurka_transition: transition}\}) do
        %{conn | status: 303}
        |> put_resp_header("location", to_string(transition))
      end
      defp handle_transition(conn) do
        conn
      end

      defp handle_invalidation(conn = %{private: %{mazurka_invalidations: invalidations}\}) do
        # TODO
        conn
      end
      defp handle_invalidation(conn) do
        conn
      end

      defp handle_response(conn = %{status: status}) do
        %{conn | status: status || 200}
      end
    end
  end
end
