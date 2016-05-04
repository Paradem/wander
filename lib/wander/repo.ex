defmodule Wander.Repo do
  use Ecto.Repo, otp_app: :wander

  # Distance between two points. Postgrex Point extension is needed (see project config).
  defmacro distance(left, right) do
    quote do
      fragment("? <@> ?", unquote(left), unquote(right))
    end
  end
end
