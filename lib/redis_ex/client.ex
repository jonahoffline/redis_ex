defmodule RedisEx.Client do
  defmacro __using__(_) do
    quote do
      def connect do
        {:ok, socket} = :gen_tcp.connect(config[:address], config[:port], [:binary])
      end
      
      def close(socket) do
        :gen_tcp.close(socket)
      end
  
      def select_database(socket, database) do
        process_command(socket, ["SELECT ", database, "\r\n"])
      end
  
      def authenticate(socket, password) do
        process_command(socket, ["AUTH ", password, "\r\n"])
      end
  
      defp process_command(socket, command) do
        :inet.setopts(socket, [{:active, :false}])
    
        case :gen_tcp.send(socket, command) do
          :ok ->
            case :gen_tcp.recv(socket, 0, config[:timeout]) do
              {:ok, <<"+OK\r\n">>} ->
                :inet.setopts(socket, [{:active, :once}])
                :ok
              {:ok, other} ->
                :inet.setopts(socket, [{:active, :once}])
                :ok
            end
          {:error, reason} ->
            {:error, reason}
        end
      end
    end
  end
end