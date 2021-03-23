defmodule Flightex.Users.AgentTest do
  use ExUnit.Case
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  describe "save/1" do
    test "Should save a User" do
      UserAgent.start_link(%{})
      {:ok, user} = User.build("Newton", "newton@email.com", "12345678900")
      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    test "should return an existing user by uuid" do
      UserAgent.start_link(%{})
      {:ok, user} = User.build("Newton", "newton@email.com", "12345678900")
      UserAgent.save(user)

      assert {:ok,
              %Flightex.Users.User{
                cpf: "12345678900",
                email: "newton@email.com",
                id: user.id,
                name: "Newton"
              }} == UserAgent.get(user.id)
    end

    test "should return an error when user does not exist" do
      UserAgent.start_link(%{})
      assert {:error, "User Not Found"} == UserAgent.get("random_id")
    end
  end
end
