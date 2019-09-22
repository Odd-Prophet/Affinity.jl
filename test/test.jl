include("src/Affinity.jl")

using .Affinity

@macroexpand @html begin
  print("Hello")
  2+2
end