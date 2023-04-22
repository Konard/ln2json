// Links Notation Grammar to JSON translator

Expression = expression:(_ (Link) _)* 
{
  var result = [];
  for (var i = 0; i < expression.length; i++)
    result.push(expression[i][1]);
  return result;
}

IdentityOrLink = Identity / Link

Link = "(" id:(IdOrNull) _
source:(IdentityOrLink) _ target:(IdentityOrLink) _ ")"
{
	const parsedSource = typeof source == 'string' ? parseInt(source, 10) : NaN;
	const parsedTarget = typeof source == 'string' ? parseInt(target, 10) : NaN;
	if (!isNaN(parsedSource)) source = parsedSource;
    if (!isNaN(parsedTarget)) target = parsedTarget;
	return id ? { [id]: [source, target] } : [source, target];
}

IdOrNull = idParts:(_ Identity _ ":" / "")
{ if(idParts.length > 1) { return idParts[1]; } else { return null; } }

Identity "identity" = [0-9a-zA-Zа-яёА-ЯЁ]+ { return text(); }

_ "whitespace" = [ \t\n\r]*
