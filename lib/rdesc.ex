defmodule Rdesc do

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
  def auxFuncion(file,[{_,_,'('}|tail]) do
    IO.write(file, "<span style='color:purple;'>"<> to_string('(') <> "</span>")
    auxParametros(file, tail)
  end
  def auxFuncion(file,[{_,_,chars}|tail]) do
    if (Enum.member?(['do:', 'do'], chars)) do
      IO.write(file, "<span style='color:red;'>"<> to_string(chars) <> "</span>")
      control(file,tail)
    else
      IO.write(file, "<span style='color:purple;'>"<> to_string(chars) <> "</span>")
      auxFuncion(file,tail)
    end
  end

  def auxParametros(_,[]), do: true
  def auxParametros(file,[{_,_,')'}|tail]) do
    IO.write(file, "<span style='color:purple;'>"<> to_string(')') <> "</span>")
    auxFuncion(file, tail)
  end
  def auxParametros(file,[{token,_,chars}|tail]) do
    aux2(file, token, chars)
    auxParametros(file, tail)
  end



  def aux2(file,:atomo, chars), do: IO.write(file, "<span style='color:yellow;'>"<> to_string(chars) <> "</span>")
  def aux2(file,:dot, chars), do: IO.write(file, "<span style='color:purple;'><i>"<> to_string(chars) <> "</i></span>")
  def aux2(file,_, chars), do: IO.write(file, "<span style='color:green;'><i>"<> to_string(chars) <> "</i></span>")

  def aux(file,:indentado, chars), do: IO.write(file, to_string(chars))
  def aux(file,:atomo, chars), do: IO.write(file, "<span style='color:yellow;'>"<> to_string(chars) <> "</span>")
  def aux(file,:comment, chars), do: IO.write(file, "<span style='color:blue;'>"<> to_string(chars) <> "</span>")
  def aux(file,:pipe,_), do: IO.write(file, "<span style='color:red;'>|></span>")
  def aux(file,:keyword, chars), do: IO.write(file, "<span style='color:red;'>"<> to_string(chars) <> "</span>")
  def aux(file,:bool, chars), do: IO.write(file, "<span style='color:darkcyan;'><i>"<> to_string(chars) <> "</i></span>")
  def aux(file,:dot, chars), do: IO.write(file,  to_string(chars))
  def aux(file,:function, chars), do: IO.write(file, "<span style='color:brown;'>"<> to_string(chars) <> "</span>")
  def aux(file,:modulo, chars), do: IO.write(file, "<span style='color:peru;'>"<> to_string(chars) <> "</span>")
  def aux(file,:fecha, chars), do: IO.write(file, "<span style='color:pink;'>"<> to_string(chars) <> "</span>")
  def aux(file,:bitwise, chars), do: IO.write(file, "<span style='color:crimson;'>"<> to_string(chars) <> "</span>")
  def aux(file,_, chars), do:  IO.write(file, to_string(chars))
end
