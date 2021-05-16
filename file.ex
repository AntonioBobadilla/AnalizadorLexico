defmodule Matriz(a,b) do
    def net1 do
  
    [[0,0,	0,	0,	0,	0,	1,	0,	0,	0, 0],
    [0,	0,	0,	0,	0,	0,	0,	1,	0,	1,	0],
    [0,	0,	0,	0,	0,	0,	0,	0,	1,	1,	0],
    [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1],
    [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	1],
    [0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0],
    [0,	1,	1,	0,	0,	0,	0,	0,	0,	0,	0],
    [0,	0,	0,	1,	0,	0,	0,	0,	0,	0,	0],
    [0,	0,	0,	0,	1,	0,	0,	0,	0,	0,	0],
    [0,	0,	0,	1,	1,	0,	0,	0,	0,	0,	0],
    [0,	0,	0,	0,	0,	1,	0,	0,	0,	0,	0]]
    end
    def control(_,[]), do true
    def mapa do
      %{
        A => 6,
        B => 7,
        C => 8,
        D => 9,
        E => 10,
        P0 => 0,
        P1 => 1,
        P2 => 2,
        P3 => 3,
        P4 => 4,
        P5 => 5
      }
    end
  
    def paresord do
    [[P0, A],[A,P1],[A,P2],[P1,B],[P1,D],[P2,C],[P2,D],[D,P3],[D,P4],[C,P4],[P3,E],[P4,E],[E,P5],[B,P3]]
    end
  
    def preset(net,node) do
      Enum.filter(net,fn [_,destino]-> destino == node end) |> Enum.map(fn [origen,_] -> origen end) |> MapSet.new
    end
  
  
    def m0 do
      MapSet.new([P0])
    end
  
    def poset(net,node) do
      Enum.filter(net,fn [origen,_]-> origen == node end) |> Enum.map(fn [_,destino] -> destino  end) |> MapSet.new
    end
  
  
    def fire(net,trans,marking) do
      if MapSet.subset?(preset(net,trans), marking) do 
        MapSet.difference(marking, preset(net,trans)) |> MapSet.union(poset(net,trans))
      else
        marking
      end
    end
  
    def convertir(map) do
      a = MapSet.to_list(map)
      a
    end
  
    def getpos(net,marking) do
      [a|b] = marking
      if b != [] do
        posa = poset(net,a)
        posb = poset(net,hd(b))
        MapSet.union(posa,posb)
      else
        posa = poset(net,a)
        posa
      end
  
    end
  
    def getpres(net,trans) do
      if trans != [] do
        [a|b] = trans
        convertir(preset(net,a)) ++ getpres(net,b)
      else
        [] # este es un comment
      end
    end
  
  
    def enabl(net,marking) do
      trans = getpos(net,marking)
      trans = convertir(trans)
      pres = getpres(net,trans) 
      marking = MapSet.new(marking) 
      pres = MapSet.new(pres) 
      pres = MapSet.intersection(pres,marking) 
      pres
    end
  
  
     def enablement(net,marking) do
       trans = getpos(net,marking)
       if MapSet.subset?(,marking) do
  
       end
     end
  
  
  
  
  
    def enablement(net,marking) do
       if length(marking) == 1 do
         marking = hd(marking)
         trans = poset(net,marking)
         marking = MapSet.new([marking])
         trans = convertir(trans)
         if MapSet.subset?(preset(net,trans),marking) do
           [trans]
         else
           nil
         end
       else
          [a|b]
          trans = poset(net,marking)
        marking = MapSet.new([marking])
          trans = convertir(trans)
          if MapSet.subset?(preset(net,trans),marking) do
            [trans]
         else
            nil
          end
       end
  
    end
  
  end
  