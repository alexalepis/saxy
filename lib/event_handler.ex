defmodule EventHandler do
  @behaviour Saxy.Handler

  @upper_classes ["ContentAPI", "Sport", "SBClass", "SBType"]

  def handle_event(:start_document, prolog, state) do
    IO.inspect("Start parsing document")
    {:ok, state}
  end

  def handle_event(:end_document, _data, state) do
    IO.inspect("Finish parsing document")
    {:ok, state}
  end
  
  def handle_event(:start_element, {name, attributes}, state) when name in @upper_classes do
    {:ok, [{name, attributes} | state]}
  end

  def handle_event(:start_element, {name, attributes}, state) do
    {:ok, [{name, attributes} | state]}
  end

  def handle_event(:start_element, {name, attributes}, state) do
    [{parent_name, parent_cont}|rest]=state   
    {:ok, [{parent_name, [{name, attributes}|parent_cont]} | rest]}
  end

  # def handle_event(:start_element, {name, attributes}, state) do
  #   IO.inspect("Start parsing element #{name} with attributes #{inspect(attributes)}")
  #   {:ok, [{name, attributes} | state]}
  # end

  def handle_event(:end_element, _, state) do
    {:ok, state}
  end

  def handle_event(:characters, content, state) do
    IO.inspect("Receive characters #{content} ")
    {:ok, [{"Notes:", content}|state]}
  end

end