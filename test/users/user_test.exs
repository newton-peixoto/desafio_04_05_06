defmodule Flightex.Users.UserTest do
  use ExUnit.Case
  alias Flightex.Users.User

  describe "build/3" do
    test "with valid parameter should return a User" do
      response = User.build("Newton", "newton@email.com", "12345678900")

      assert {:ok,
              %Flightex.Users.User{
                cpf: "12345678900",
                email: "newton@email.com",
                id: _uuid,
                name: "Newton"
              }} = response
    end
  end
end
