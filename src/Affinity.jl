module Affinity
export compile

buffer = ""

paired = [
  "html", "head", "title", "style", "script",
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
    function ($(Symbol("$el")))(;props...)
      tag = $("$el")
      attrs = parse_attributes(props)

      put_buffer!("<$(tag)$(attrs)></$(tag)>")
    end
  end

  @eval begin
    function ($(Symbol("$el")))(text; props...)
      tag = $("$el")
      attrs = parse_attributes(props)

      put_buffer!(string("<$(tag)$(attrs)>", text, "</$(tag)>"))
    end
  end

  @eval begin
    function ($(Symbol("$el")))(children::Function; props...)
      tag = $("$el")
      attrs = parse_attributes(props)

      put_buffer!("<$(tag)$(attrs)>")
      children()
      put_buffer!("</$(tag)>")
    end
  end
end

for el in unpaired
  @eval begin
    function ($(Symbol("$el")))(; props...)
      tag = $("$el")
      attrs = parse_attributes(props)

      put_buffer!("<$(tag)$(attrs)>")
    end
  end
end

function text(str)
  put_buffer!(str)
end

function raw(html)
  put_buffer!(html)
end

function put_buffer!(str)
  global buffer *= str
end

function clear_buffer!()
  global buffer = ""
end

function parse_attributes(attrs)
  str = ""

  for (k, v) in attrs
    str *= " $(replace(String(k), '_' => '-'))=\"$v\""
  end

  return str
end

function compile(template; params=Dict())
  global context = params
  clear_buffer!()
  return eval(Meta.parse(template))
end

end