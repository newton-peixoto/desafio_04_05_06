defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  alias Flightex.Bookings.Report
  alias Flightex.Users.CreateUser
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.CreateBooking
  alias Flightex.Bookings.Agent, as: BookingAgent

  describe "create/2" do
    test "should generate report from saved data" do
      UserAgent.start_link(%{})
      BookingAgent.start_link(%{})
      {:ok, user_id} = CreateUser.call(%{name: "Newton", email: "Peixoto", cpf: "12345678900"})

      CreateBooking.call(user_id, %{
        data_completa: "2029-03-03 19:00:00",
        cidade_origem: "Catalão",
        cidade_destino: "Londres"
      })

      CreateBooking.call(user_id, %{
        data_completa: "2029-03-03 19:00:00",
        cidade_origem: "Catalão",
        cidade_destino: "Londres"
      })

      CreateBooking.call(user_id, %{
        data_completa: "2029-03-03 19:00:00",
        cidade_origem: "Catalão",
        cidade_destino: "Londres"
      })

      CreateBooking.call(user_id, %{
        data_completa: "2029-03-03 19:00:00",
        cidade_origem: "Catalão",
        cidade_destino: "Londres"
      })

      Report.create("2019-01-01 00:00:00", "2030-01-01 00:00:00")

      assert "#{user_id},Catalão,Londres,2029-03-03 19:00:00\n#{user_id},Catalão,Londres,2029-03-03 19:00:00\n" <>
               "#{user_id},Catalão,Londres,2029-03-03 19:00:00\n" <>
               "#{user_id},Catalão,Londres,2029-03-03 19:00:00\n" == File.read!("rreport.csv")
    end
  end
end
