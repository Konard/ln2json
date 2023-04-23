{
  function tryParseInt(value) {
      const parsedValue = typeof value === 'string' ? parseInt(value) : NaN;
    if (!isNaN(parsedValue)) value = parsedValue;
      return value;
  }
  
  function createLink(id, values) {
    id = id ? id.join("") : id;
    id = tryParseInt(id);
    for (let i = 0; i < values.length; i++) {
        values[i] = tryParseInt(values[i]);
    }
    if (id && values.length) {
        return {
          [id]: values
        };
    } else if (id) {
        return id;
    } else {
        return values;
    }
  }
}

links = _ list:linkAndWhitespace* _ { return list; }
linkAndWhitespace = l:anyLink _ { return l; }
identityOrLink = l:multiLineAnyLink { return l; } / i:identity { return createLink(i, []); }
anyLink = multiLineAnyLink / singleLineAnyLink
multiLineAnyLink = multiLinePointLink / multiLineValueLink / multiLineLink
singleLineAnyLink = singleLineLink / singleLineValueLink / singleLinePointLink
multiLineValueAndWhitespace = value:identityOrLink _ { return value; }
multiLineValues = _ list:multiLineValueAndWhitespace+ { return list; }
singleLineValueAndWhitespace = value:identityOrLink __ { return value; }
singleLineValues = __ list:singleLineValueAndWhitespace+ { return list; }
singleLineLink = __ id:(identity) __ ":" v:singleLineValues { return createLink(id, v); }
multiLineLink = "(" _ id:(identity) _ ":" v:multiLineValues ")" { return createLink(id, v); }
singleLineValueLink = v:singleLineValues { return createLink(null, v); }
multiLineValueLink = "(" v:multiLineValues ")" { return createLink(null, v); }
pointLink = id:(identity) { return createLink(id, []); }
singleLinePointLink = __ l:pointLink __ { return l; }
multiLinePointLink = "(" _ l:pointLink _ ")" { return l; }
identity = [0-9a-zA-Zа-яёА-ЯЁ]+
__ = [ \t]*
_ = [ \t\n\r]*