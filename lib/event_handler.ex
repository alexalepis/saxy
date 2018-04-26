defmodule EventHandler do
  @behaviour Saxy.Handler

  @upper_classes ["ContentAPI", "Sport", "SBClass", "SBType"]
  @nested_classes ["Ev", "Inplay", "Scores", "Stats", "Incidents", "Teams", "Mkt", "Seln"]

  def handle_event(:start_document, prolog, state) do
    IO.inspect("Start parsing document")
    {:ok, state}
  end

  def handle_event(:end_document, _data, state) do
    IO.inspect("Finish parsing document")
    {:ok, state}
  end
  
  def handle_event(:start_element, {name, attributes}, state) when name in @upper_classes do
    {:ok, Map.put(state, name, parse_attributes(attributes))}
  end

  def handle_event(:start_element, {name, attributes}, state) when name in @nested_classes do
    {:ok, Map.put(state, name, parse_attributes(attributes))}
  end

  def handle_event(:start_element, {name, attributes}, state) do
    [{parent_name, parent_cont}|rest]=state   
    {:ok, [{parent_name, [{name, attributes}|parent_cont]} | rest]}
  end

  # def handle_event(:start_element, {name, attributes}, state) do
  #   IO.inspect("Start parsing element #{name} with attributes #{inspect(attributes)}")
  #   {:ok, [{name, attributes} | state]}
  # end

  def handle_event(:end_element, name, state) do
    {:ok, state}
  end

  def handle_event(:characters, content, state) do
    IO.inspect("Receive characters #{content} ")
    {:ok, [{"Notes:", content}|state]}
  end

  def parse_attributes(attributes) do
    Enum.reduce(attributes, %{}, fn({key, value}, acc)-> acc=Map.put(acc, key, value) end)
  end

end