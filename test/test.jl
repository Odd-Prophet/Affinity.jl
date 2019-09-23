include("src/Affinity.jl")

using .Affinity

@affinity begin
  div() do
    h1() do
      text("Hello")
    end

    for i = 1:5
      span(i)
    end
  end
end