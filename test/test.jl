include("src/Affinity.jl")

using .Affinity

@affinity begin
  div() do
    h1(class="title", id="test") do
      text("Hello")
    end

    img(src="#")

    for i = 1:3
      span(i, class="span")
      span("Hi")
    end
  end
end

template_str = read("test/template.jl", String)
html = Affinity.compile(template_str)

println(html)