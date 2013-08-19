defmodule RedisEx.Conf do
  defmacro __using__(_) do
    quote do
      def config do
        :ets.lookup(:redis_conf, :redis_conf)[:redis_conf]
      end
      
      def setup(options // []) do
        :ets.new(:redis_conf, [:set, :protected, :named_table])
        :ets.insert(:redis_conf, {:redis_conf, Keyword.merge(defaults, options)})
        connect
      end
      
      defp defaults do
        [ address: 'localhost',
          port: 6379,
          path: nil,
          timeout: 5000,
          password: nil,
          db: 0,
          driver: nil,
          id: nil,
          tcp_keepalive: 0
        ]
      end
    end
  end
end