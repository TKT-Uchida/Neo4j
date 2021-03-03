match (p:Person)-[:ACTED_IN]->(m:Movie)
where p.name = "Keanu Reeves"
return p, m;

match (p:Person {name: "Keanu Reeves"})-[:ACTED_IN]->(m:Movie)
return p, m;

match (p:Person {name: "Keanu Reeves"})-->(m:Movie)
return p, m;

match (p:Person {name: "Keanu Reeves"})-->(m)
return p, m;

match (p:Person {name: "Keanu Reeves"})-[]->(m:Movie)
return p, m;