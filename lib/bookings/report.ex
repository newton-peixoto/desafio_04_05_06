defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def create(initial_date, final_date) do
    with {:ok, initial} <- parse_date(initial_date),
         {:ok, final} <- parse_date(final_date) do
      booking_list = build_booking_list(initial, final)
      File.write("rreport.csv", booking_list)
      {:ok, "Report generated successfully"}
    end
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

  defp parse_date(date) when is_bitstring(date) do
    case NaiveDateTime.from_iso8601(date) do
      {:ok, date} -> {:ok, date}
      {:error, _reason} -> {:error, "Invalid date, cannot convert string to date"}
    end
  end

  defp parse_date(%NaiveDateTime{} = date), do: date

  defp parse_date(_date), do: {:error, "Invalid date"}
end
