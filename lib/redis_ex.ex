defmodule RedisEx do
  use RedisEx.Conf
  use RedisEx.Client
  use RedisEx.Commands
  
  def start do
    :application.start(:redis_ex)
  end
  
  def stop do
    :application.stop(:redis_ex)
  end
end