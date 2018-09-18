defmodule Issues.TableFormatter do
  def print_table(rows, headers) do
    widths = get_col_widths(rows, headers)
    print_headers(headers, widths)
    print_rows(rows, headers, widths)
  end

  def print_headers(headers, widths) do
    widths
    |> Enum.map(& "~-#{&1}s")
    |> Enum.join(" | ")
    |> :io.format(headers)

    IO.write("\n")

    widths
    |> Enum.map(fn width -> String.duplicate("-", width) end)
    |> Enum.join("-+-")
    |> IO.puts()
  end

  def print_rows(rows, headers, widths) do
    table_values =
      Enum.map(rows, fn row ->
        Enum.map(headers, fn header -> to_string(row[header]) end)
      end)

    row_format =
      widths
      |> Enum.map(& "~-#{&1}s")
      |> Enum.join(" | ")

    Enum.each(table_values, fn row_values ->
      :io.format(row_format, row_values)
      IO.write("\n")
    end)
  end

  def get_col_widths(rows, headers) do
    Enum.map(headers, &get_col_width(rows, &1))
    |> Enum.map(&Enum.max/1)
  end

  def get_col_values(rows, header) do
    Enum.map(rows, & &1[header])
  end

  def get_col_width(rows, header) do
    Enum.map(rows, & get_length(&1[header]))
  end

  def get_length(str) when is_binary(str) do
    String.length(str)
  end

  def get_length(str) do
    String.length(to_string(str))
  end
end
