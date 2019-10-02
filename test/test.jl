include("src/Affinity.jl")

using .Affinity

template_str = read("test/template.jl", String)
html = Affinity.compile(template_str)

println(html)