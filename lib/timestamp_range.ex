defmodule Timestamp.Range do
  @moduledoc """
  Returns an inclusive range between two DateTimes.
  """

  @behaviour Ecto.Type

  @enforce_keys [:first, :last]
  defstruct [:first, :last, opts: []]

  @type t :: %__MODULE__{
          first: NaiveDateTime.t(),
          last: NaiveDateTime.t(),
          opts: [
            lower_inclusive: boolean(),
            upper_inclusive: boolean()
          ]
        }

  @spec new(
          NaiveDateTime.t() | DateTime.t(),
          NaiveDateTime.t() | DateTime.t(),
          Keyword.t()
        ) :: t
  @doc ~S"""
  Create a new Timestamp.Range.

  ## Examples

      iex> Timestamp.Range.new(DateTime.from_unix!(0), DateTime.from_unix!(1))
      %Timestamp.Range{
        first: DateTime.from_unix!(0) |> DateTime.to_naive(),
        last: DateTime.from_unix!(1) |> DateTime.to_naive(),
        opts: [lower_inclusive: true, upper_inclusive: false]
      }

  """
  def new(first, last, opts \\ [])

  def new(%DateTime{} = first, %DateTime{} = last, opts) do
    new(DateTime.to_naive(first), DateTime.to_naive(last), opts)
  end

  @default_opts [lower_inclusive: true, upper_inclusive: false]

  def new(%NaiveDateTime{} = first, %NaiveDateTime{} = last, opts) do
    opts = Keyword.merge(@default_opts, opts)

    %__MODULE__{
      first: first,
      last: last,
      opts: opts
    }
  end

  @impl Ecto.Type
  def type, do: :tsrange

  @impl Ecto.Type
  def cast(term)
  def cast(%Timestamp.Range{} = range), do: {:ok, range}
  def cast(_), do: :error

  @impl Ecto.Type
  def load(term)

  def load(%Postgrex.Range{} = range) do
    {:ok,
     Timestamp.Range.new(
       range.lower,
       range.upper,
       lower_inclusive: range.lower_inclusive,
       upper_inclusive: range.upper_inclusive
     )}
  end

  def load(_), do: :error

  @impl Ecto.Type
  def dump(%Timestamp.Range{} = range) do
    [lower_inclusive: lower_inclusive, upper_inclusive: upper_inclusive] = range.opts

    {:ok,
     %Postgrex.Range{
       lower: range.first,
       upper: range.last,
       lower_inclusive: lower_inclusive,
       upper_inclusive: upper_inclusive
     }}
  end

  def dump(_), do: :error
end

defimpl Inspect, for: Timestamp.Range do
  # TODO: Replicate the representation from Postgres ? (with `[]` and `()`).
  def inspect(%Timestamp.Range{first: first, last: last}, _) do
    "#Timestamp.Range<" <> inspect(first) <> ", " <> inspect(last) <> ">"
  end
end
