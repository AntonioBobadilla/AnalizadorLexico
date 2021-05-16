defmodule Rdesc do
  @moduledoc """
  Documentation for `Rdesc`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Rdesc.hello()
      :world

  """


  def hello do
    {:ok, file} = File.open("index.html", [:write]) 
    IO.write(file," <link rel='stylesheet' href='styles.css'>")
    IO.write(file,"<pre>")
    IO.write(file,"<code>")
    arr = File.read("file.ex") |> elem(1) |> String.to_charlist() |> :lexer.string() |> elem(1)
    control(file, arr )
    IO.write(file,"</code>")
    IO.write(file,"</pre>")
  end

  
  def control(_,[]), do: true
  
  def control(file,[{token,_,chars}|tail]) do
    aux(file,token,chars)
    if (Enum.member?(['def','defmodule'],chars)) do
      auxFuncion(file,tail)
    else
      control(file,tail)
    end 
  end

  def auxFuncion(_,[]), do: true
  def auxFuncion(file,[{_,_,'do'}|tail]) do
    IO.write(file, "<span style='color:red;'>"<> to_string('do') <> "</span>")
    control(file,tail)
  end 
  def auxFuncion(file,[{_,_,chars}|tail]) do
    IO.write(file, "<span style='color:purple;'>"<> to_string(chars) <> "</span>")
    auxFuncion(file,tail)
  end

  def aux(file,:indentado, chars), do: IO.write(file, to_string(chars))
  def aux(file,:comment, chars), do: IO.write(file, "<span style='color:blue;'>"<> to_string(chars) <> "</span>")
  def aux(file,:pipe,_), do: IO.write(file, "<span style='color:red;'>|></span>")
  def aux(file,:keyword, chars), do: IO.write(file, "<span style='color:red;'>"<> to_string(chars) <> "</span>")
  def aux(file,:dot, chars), do: IO.write(file,  to_string(chars) )
  def aux(file,:function, chars), do: IO.write(file, "<span style='color:brown;'>"<> to_string(chars) <> "</span>")
  def aux(file,_, chars), do:  IO.write(file, to_string(chars)) 
end
