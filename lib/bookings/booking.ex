defmodule Flightex.Bookings.Booking do
  @keys [:id, :data_completa, :cidade_origem, :cidade_destino, :id_usuario]
  @enforce_keys [:data_completa, :cidade_origem, :cidade_destino, :id_usuario]

  defstruct @keys

  def build(id_usuario, cidade_origem, cidade_destino, %NaiveDateTime{} = data_completa) do
    uuid = UUID.uuid4()

    {
      :ok,
      %__MODULE__{
        id: uuid,
        id_usuario: id_usuario,
        cidade_origem: cidade_origem,
        cidade_destino: cidade_destino,
        data_completa: data_completa
      }
    }
  end

  def build(_id_usuario, _cidade_origem, _cidade_destino, _data_completa) do
    {:error, "Invalid parameters!"}
  end
end
