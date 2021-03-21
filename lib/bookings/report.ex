defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(%NaiveDateTime{} = initial_date, %NaiveDateTime{} = final_date) do
    booking_list = build_booking_list(initial_date, final_date)
    booking_list

    File.write("report_#{NaiveDateTime.utc_now()}.csv", booking_list)
    {:ok, "Report generated successfully"}
  end

  defp build_booking_list(initial_date, final_date) do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.filter(&bookings_in_range(&1, initial_date, final_date))
    |> Enum.map(&booking_string/1)
  end

  defp bookings_in_range(booking, initial_date, final_date) do
    NaiveDateTime.compare(booking.data_completa, initial_date) in [:eq, :gt] and
      NaiveDateTime.compare(booking.data_completa, final_date) in [:eq, :lt]
  end

  defp booking_string(%Booking{} = booking) do
    "#{booking.id_usuario},#{booking.cidade_origem},#{booking.cidade_destino}," <>
      "#{booking.data_completa}\n"
  end
end
