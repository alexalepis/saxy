defmodule EventHandler do
  @behaviour Saxy.Handler

  @upper_classes ["ContentAPI", "Sport", "SBClass", "SBType"]
  @nest_classes ["Ev", "Inplay", "Scores", "Stats", "Incidents", "Teams", "Mkt", "Seln"]
  @oneline ["PeriodScore", "Stat", "Incident", "Team", "Price"]

  def handle_event(:start_document, prolog, final) do
    IO.inspect("Start parsing document")
    {:ok,  {final, [], []}}
  end

  def handle_event(:end_document, _data,  {final, acc, stack}) do
    IO.inspect("Finish parsing document")
    {:ok, final}
  end
  
  def handle_event(:start_element, {name, attributes}, {final, acc, stack}) when name in @upper_classes do
    {:ok, {Map.put(final, name, parse_attributes(attributes)), acc, stack}} 
  end

  def handle_event(:start_element, {name, attributes}, {final, acc, stack}) when name in @oneline do
    {:ok, {final,  [{name, parse_attributes(attributes)}|acc], stack}}
  end

  def handle_event(:start_element, {name, attributes}, {final, acc, stack}) do
    {:ok, {final, [{name, parse_attributes(attributes)}|acc], [name | stack]}}
  end

   def handle_event(:end_element, name, {final, acc, stack}) when name in @upper_classes do    
    {:ok, {final, acc, stack}}
  end
  
  def handle_event(:end_element, name, {final, acc, stack}) when name in @oneline do    
    {:ok, {final, acc, stack}}
  end

  def handle_event(:end_element, name, {final, acc, [h|t]=stack}) do  
    IO.inspect name
    {merged, new_acc}=my_merge(acc, name)
    {:ok, {Map.put(final, name, merged), new_acc, t}}
  end

  def my_merge([{acc_name, acc_attr}| acc_rest]=acc, name) do
    if acc_name==name do
      {Map.new([{acc_name, acc_attr}]) , acc_rest}
    else
      my_merge(acc_rest, name, [{acc_name, acc_attr}])   
    end
  end

  def my_merge([{acc_name, acc_attr}| acc_rest]=acc, name, to_be_merged) do
    if acc_name==name do
      {Map.new([{acc_name, acc_attr}| to_be_merged]), acc_rest}
    else
      my_merge(acc_rest, name, [{acc_name, acc_attr}|to_be_merged])   
    end
  end

  # def my_merge([{acc_name, acc_att}], name, last_tag) do
  #   IO.inspect {name, acc_name}
  #   my_merge(acc_t, name, last_tag, [{acc_name, acc_att}])
  # end

  # def my_merge([{acc_name, acc_att}|acc_t], name, last_tag) do
  #   IO.inspect {name, acc_name}
  #   my_merge(acc_t, name, last_tag, [{acc_name, acc_att}])
  # end



  # def my_merge([{acc_name, acc_att}|acc_t], name, last_tag, acc_final) when name == acc_name do
  #   {Map.new(acc_final) , acc_t}
  # end
  # def my_merge([{acc_name, acc_att}|acc_t], name, last_tag, acc_final) do
  #   my_merge(acc_t, name, last_tag, [{acc_name, acc_att}|acc_final])
  # end



  def parse_attributes(attributes) do
    Enum.reduce(attributes, %{}, fn({key, value}, acc)-> acc=Map.put(acc, key, value) end)
  end

end