defmodule SaxyParser do
  def parse() do
    {:ok, xml} = :file.read_file("test/test.xml")
    # xml = String.replace(xml, ~r/\sxmlns=\".*\"/, "", global: false)
   

    Saxy.parse_string(xml, EventHandler, %{})

  end
end
