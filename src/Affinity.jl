module Affinity
export @affinity

using MacroTools

elements = [
  "head", "title", "style", "script",
  "noscript", "template",
  "body", "section", "nav", "article", "aside", "h1", "h2", "h3", "h4", "h5", "h6",
  "header", "footer", "address", "main",
  "p", "pre", "blockquote", "ol", "ul", "li", "dl", "dt", "dd", "figure", "figcaption", "div",
  "a", "em", "strong", "small", "s", "cite", "q", "dfn", "abbr", "data", "time", "code", "var", "samp", "kbd",
  "sub", "sup", "i", "b", "u", "mark", "ruby", "rt", "rp", "bdi", "bdo", "span",
  "ins", "del",
  "iframe", "object", "video", "audio", "canvas",
  "map", "svg", "math",
  "table", "caption", "colgroup", "tbody", "thead", "tfoot", "tr", "td", "th",
  "form", "fieldset", "legend", "label", "button", "select", "datalist", "optgroup",
  "option", "textarea", "output", "progress", "meter",
  "details", "summary", "menuitem", "menu"
]

for el in elements
  @eval begin
    function ($(Symbol("$el")))()
      return string($("<$el></$el>"))
    end
  end

  @eval begin
    function ($(Symbol("$el")))(str::String)
      return string($("<$el>"), str, $("</$el>"))
    end
  end

  @eval begin
    function ($(Symbol("$el")))(inner)
      return string($("<$el>"), inner(), $("</$el>"))
    end
  end
end

function text(str)
  return str
end

macro affinity(body)
  return :( $body )
end

end