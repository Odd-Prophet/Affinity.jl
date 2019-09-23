include("src/Affinity.jl")

using .Affinity

@affinity begin
  div() do
    h1(class="title", id="test") do
      text("Hello")
    end

    for i = 1:3
      span(i, class="span")
      span("Hi")
    end
  end
end