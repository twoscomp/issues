defmodule Issues.TableFormatterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  import Issues.TableFormatter

  @test_data [
    %{k1: "a1", k2: "a2", k3: "a3", k4: "a4"},
    %{k1: "b1", k2: "b2", k3: "b3", k4: "b4"},
    %{k1: "c1", k2: "c2", k3: "c3", k4: "c4"},
    %{k1: "d1", k2: "d2", k3: "d3", k4: "d4"},
    %{k1: "ee1", k2: "e2", k3: "e3", k4: "e4"}
  ]

  test "returns column values correctly" do
    assert ["a1", "b1", "c1", "d1", "ee1"] = get_col_values(@test_data, :k1)
  end

  test "column widths are calculated properly" do
    headers = [:k1, :k2, :k3]

    assert [3, 2, 2] = get_col_widths(@test_data, headers)
  end

  test "table is printed properly" do
    headers = [:k1, :k2, :k3]

    expected = """
    k1  | k2 | k3
    ----+----+---
    a1  | a2 | a3
    b1  | b2 | b3
    c1  | c2 | c3
    d1  | d2 | d3
    ee1 | e2 | e3
    """

    result =
      capture_io(fn ->
        print_table(@test_data, headers)
      end)

    assert expected == result
  end
end
