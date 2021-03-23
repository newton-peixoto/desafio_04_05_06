defmodule Flightex.Bookings.AgentTest do
  use ExUnit.Case
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  describe "save/1" do
    test "Should save a Booking" do
      BookingAgent.start_link(%{})

      {:ok, booking} =
        Booking.build(
          "70831e44-5820-4b4c-aae1-87b079a2882f",
          "Catalão",
          "Londres",
          "2020-03-01 00:00:00"
        )

      assert BookingAgent.save(booking) == :ok
    end
  end

  describe "get/1" do
    test "should return an existing Booking by uuid" do
      BookingAgent.start_link(%{})

      {:ok, booking} =
        Booking.build(
          "70831e44-5820-4b4c-aae1-87b079a2882f",
          "Catalão",
          "Londres",
          "2020-03-01 00:00:00"
        )

      BookingAgent.save(booking)

      assert {:ok,
              %Flightex.Bookings.Booking{
                cidade_destino: "Londres",
                cidade_origem: "Catalão",
                data_completa: ~N[2020-03-01 00:00:00],
                id: booking.id,
                id_usuario: "70831e44-5820-4b4c-aae1-87b079a2882f"
              }} == BookingAgent.get(booking.id)
    end

    test "should return an error when Booking does not exist" do
      BookingAgent.start_link(%{})
      assert {:error, "Flight Booking not found"} == BookingAgent.get("random_id")
    end
  end
end
