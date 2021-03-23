defmodule Flightex.Booking.CreateBookingTest do
  use ExUnit.Case
  alias Flightex.Bookings.CreateBooking
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Users.Agent, as: UserAgent

  describe "call/1" do
    test "with valid parameter should return a Booking" do
      BookingAgent.start_link(%{})
      UserAgent.start_link(%{})

      {:ok, user_id} =
        Flightex.create_user(%{name: "Newton", email: "teste@teste.com", cpf: "12345678900"})

      response =
        CreateBooking.call(user_id, %{
          data_completa: "2020-03-03 00:00:00",
          cidade_origem: "Catalão",
          cidade_destino: "Londres"
        })

      assert {:ok, _bookingId} = response
    end

    test "should return a error when the user does not exists" do
      BookingAgent.start_link(%{})
      UserAgent.start_link(%{})

      response =
        CreateBooking.call("random_user", %{
          data_completa: "2020-03-03 00:00:00",
          cidade_origem: "Catalão",
          cidade_destino: "Londres"
        })

      assert {:error, "User Not Found"} = response
    end
  end
end
