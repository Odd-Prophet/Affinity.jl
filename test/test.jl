include("src/Affinity.jl")

using .Affinity

@affinity begin
  div() do
    h1() do
      text("Hello")
    end
    
    span("Span Text")
  end
end