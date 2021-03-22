# Flightex

Desafio do módulo 2 do curso de elixir da RocketSeat. Permitir a reserva de voos. 


## Instalação

``git clone https://github.com/newton-peixoto/desafio_04_05_06.git``

`` mix deps.get ``




## Utilizando os Módulos

<b> Substiuir YYYY-MM-DD 00:00:00 pela data desejada <b/>

* iex -S mix

* Flightex.start_agents

* {:ok , user_id } = Flightex.create_user(%{name: "John", email: "john@email.com", cpf: "123456789"})

* {:ok , booking_id } Flightex.create_booking(user_id, %{data_completa: ~N[YYYY-MM-DD 00:00:00], cidade_origem: "Cidade1", cidade_destino: "Cidade2"})

* Flightex.get_booking(booking_id)

* alias Flightex.Bookings.Report

* Report.create(~N[YYYY-MM-DD 00:00:00], ~N[YYYY-MM-DD 00:00:00])