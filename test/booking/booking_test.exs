defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case
  alias Flightex.Bookings.Booking

  describe "build/4" do
    test "with valid parameter should return a Booking" do
      response =
        Booking.build(
          "70831e44-5820-4b4c-aae1-87b079a2882f",
          "Catalão",
          "Londres",
          "2020-03-01 00:00:00"
        )

      assert {:ok,
              %Flightex.Bookings.Booking{
                cidade_destino: "Londres",
                cidade_origem: "Catalão",
                data_completa: ~N[2020-03-01 00:00:00],
                id: _uuid,
                id_usuario: "70831e44-5820-4b4c-aae1-87b079a2882f"
              }} = response
    end

    test "with invalid parameter should return an Error" do
      response =
        Booking.build(
          "70831e44-5820-4b4c-aae1-87b079a2882f",
          "Catalão",
          "Londres",
          "2020a-03-01 00:00:00"
        )

      assert {:error, "Invalid date, cannot convert string to date"} == response
    end
  end
end
