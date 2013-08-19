defmodule RedisEx.Commands do
  defmacro __using__(_) do
    quote do
      def get(socket, command) do
        process_command(socket, "GET " <> command <> "\r\n")
      end
  
      def set(socket, [command, value]) do
        process_command(socket, "SET " <> command <> value <> "\r\n")
      end
    end
  end
end