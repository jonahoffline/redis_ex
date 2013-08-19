Code.require_file "test_helper.exs", __DIR__

defmodule RedisExTest do
  use ExUnit.Case, async: true

  test "loads default configuration" do
    RedisEx.setup
    RedisEx.start
    assert RedisEx.config[:address] == 'localhost'
  end
  
  test "overrides default configuration" do
    assert_raise MatchError, fn ->
      RedisEx.setup(address: '127.0.0.1', port: 666, timeout: 5.0)
    end
    assert RedisEx.config[:address] == '127.0.0.1'
    assert RedisEx.config[:port] == 666
    assert RedisEx.config[:timeout] == 5.0
  end
  
  test "connects to redis instance" do
    RedisEx.setup
    RedisEx.start
    
    {:ok, socket} = RedisEx.connect
    RedisEx.close(socket)
  end
  
  test "disconnects from redis instance" do
    RedisEx.setup
    RedisEx.start
    
    {:ok, socket} = RedisEx.connect
    RedisEx.close(socket)
  end
  
  test "gets a key from list" do
    RedisEx.setup
    RedisEx.start
    
    {:ok, socket} = RedisEx.connect
    assert RedisEx.get(socket, "hello") == :ok
    RedisEx.close(socket)
  end
  
  test "sets a key from list" do
    RedisEx.setup
    RedisEx.start
    
    {:ok, socket} = RedisEx.connect
    assert RedisEx.set(socket, ["hello ", "25"]) == :ok
    RedisEx.close(socket)
  end
  
  test "authenticates when provided with a password" do
    RedisEx.setup
    RedisEx.start
    
    {:ok, socket} = RedisEx.connect
    assert RedisEx.authenticate(socket, "666") == :ok
    RedisEx.close(socket)
  end
end
