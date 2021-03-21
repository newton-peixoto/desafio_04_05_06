defmodule Flightex.Bookings.CreateBooking do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(user_id, %{
        data_completa: data_completa,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino
      }) do
    with {:ok, user} <- UserAgent.get(user_id),
         {:ok, booking} <- Booking.build(user.id, cidade_origem, cidade_destino, data_completa) do
      save_booking({:ok, booking})
    end
  end

  defp save_booking({:ok, %Booking{} = booking}) do
    BookingAgent.save(booking)
    {:ok, booking.id}
  end

  defp save_booking({:error, _reason} = error), do: error
end
