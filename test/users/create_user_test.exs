defmodule Flightex.Users.CreateUserTest do
  use ExUnit.Case
  alias Flightex.Users.CreateUser
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/1" do
    test "with valid parameter should return a User" do
      UserAgent.start_link(%{})
      response = CreateUser.call(%{name: "Newton", email: "Peixoto", cpf: "12345678900"})

      assert {:ok, _uuid} = response
    end

    test "with invalid parameter should return an Error" do
      UserAgent.start_link(%{})
      response = CreateUser.call(%{a: "Newton", email: "Peixoto", cpf: "12345678900"})

      assert {:error, "Invalid parameters!"} = response
    end
  end
end
