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

      defp dispatch(conn, _opts) do
        {body, content_type, conn} = conn
        |> handle_accept_header()
        |> handle_action()

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

      defp handle_accept_header(conn) do
        accepts = conn
        |> Plug.Conn.get_req_header("accept")
        |> Stream.map(&Plug.Conn.Utils.list/1)
        |> Stream.concat()
        |> Stream.map(fn(type) ->
          case Plug.Conn.Utils.media_type(type) do
            {:ok, type, subtype, params} ->
              {type, subtype, params}
            _ ->
              nil
          end
        end)
        |> Stream.filter(&!is_nil(&1))
        |> Enum.to_list()
        Plug.Conn.put_private(conn, :mazurka_accepts, accepts)
      end

      defp handle_action(%{private: %{mazurka_route: route, mazurka_params: params, mazurka_accepts: accepts}\} = conn) do
        conn = %{params: input} = fetch_query_params(conn)
        route.action(accepts, params, input, conn, __MODULE__)
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

      defp handle_transition(conn = %{private: %{mazurka_transition: transition}, status: status}) do
        %{conn | status: status || 303}
        |> put_resp_header("location", to_string(transition))
      end
      defp handle_transition(conn) do
        conn
      end

      defp handle_invalidation(conn = %{private: %{mazurka_invalidations: invalidations}\}) do
        Enum.reduce(invalidations, conn, &(put_resp_header(&2, "x-invalidates", &1)))
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
