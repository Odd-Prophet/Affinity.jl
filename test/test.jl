include("src/Affinity.jl")

using .Affinity

@affinity begin
  div() do
    h1() do
      text("Hello")
    end
  end
end