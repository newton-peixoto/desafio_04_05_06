defmodule Flightex.Users.User do
  @keys [:id, :name, :email, :cpf]
  @enforce_keys [:name, :email, :cpf]

  defstruct @keys

  def build(name, email, cpf) do
    uuid = UUID.uuid4()

    {
      :ok,
      %__MODULE__{
        id: uuid,
        name: name,
        email: email,
        cpf: cpf
      }
    }
  end
end
