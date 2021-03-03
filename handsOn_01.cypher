MATCH (p:Person)
WHERE p.name = "Keanu Reeves"
RETURN p;

MATCH (p:Person {name: "Keanu Reeves"})
RETURN p;

MATCH (p:Person {name: "Keanu Reeves"})
RETURN p.name, p.born;