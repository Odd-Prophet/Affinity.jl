module Affinity
export @html

using MacroTools

macro html(body)
  return body
end

end