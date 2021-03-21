defmodule Flightex do
  alias Flightex.Users.CreateUser
  alias Flightex.Bookings.CreateBooking
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Bookings.Agent, as: BookingAgent

  def start_agents do
    UserAgent.start_link(%{})
    BookingAgent.start_link(%{})
  end

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate create_booking(user_id, params), to: CreateBooking, as: :call

  def get_booking(booking_id) do
    booking_id |> BookingAgent.get()
  end
end
