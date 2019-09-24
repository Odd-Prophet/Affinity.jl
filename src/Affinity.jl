module Affinity
export @affinity

buffer = ""

paired = [
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

unpaired = [
  "meta", "link", "base",
  "area", "br", "col", "embed", "hr", "img", "input", "keygen", "param", "source", "track", "wbr"
]

for el in paired
  @eval begin
    function ($(Symbol("$el")))()
      put_buffer!($("<$el></$el>"))
    end
  end

  @eval begin
    function ($(Symbol("$el")))(text; props...)
      tag = $("$el")
      attrs = ""

      for (k, v) in props
        attrs *= " $k=\"$v\""
      end

      put_buffer!(string("<$(tag)$(attrs)>", text, "</$(tag)>"))
    end
  end

  @eval begin
    function ($(Symbol("$el")))(children::Function; props...)
      tag = $("$el")
      attrs = ""

      for (k, v) in props
        attrs *= " $k=\"$v\""
      end

      put_buffer!("<$(tag)$(attrs)>")
      children()
      put_buffer!("</$(tag)>")
    end
  end
end

for el in unpaired
  @eval begin
    function ($(Symbol("$el")))(;props...)
      tag = $("$el")
      attrs = ""

      for (k, v) in props
        attrs *= " $k=\"$v\""
      end

      put_buffer!("<$(tag)$(attrs)>")
    end
  end
end

function text(str)
  put_buffer!(str)
end

function put_buffer!(str)
  global buffer *= str
end

function clear_buffer!()
  global buffer = ""
end

macro affinity(body)
  clear_buffer!()
  return :( $body )
end

end