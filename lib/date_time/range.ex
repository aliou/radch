# TODO: Enumerable protocol
defmodule DateTime.Range do
  @enforce_keys [:lower, :upper]
  defstruct [:lower, :upper, lower_inclusive: true, upper_inclusive: true]

  @type t :: %__MODULE__{
          lower: DateTime.t(),
          upper: DateTime.t(),
          lower_inclusive: boolean(),
          upper_inclusive: boolean()
        }

  @spec new(DateTime.t(), DateTime.t(), boolean(), boolean()) :: t
  @doc "Create a new DateTime Range"
  def new(lower, upper, lower_inclusive \\ true, upper_inclusive \\ true),
    do: %__MODULE__{
      lower: lower,
      upper: upper,
      lower_inclusive: lower_inclusive,
      upper_inclusive: upper_inclusive
    }
end
