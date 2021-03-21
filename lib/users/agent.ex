defmodule Flightex.Users.Agent do
  alias Flightex.Users.User

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  def get(user_id), do: Agent.get(__MODULE__, &get_user(&1, user_id))

  defp get_user(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "User Not Found"}
      user -> {:ok, user}
    end
  end

  def update_state(state, %User{id: user_id} = user), do: Map.put(state, user_id, user)
end
