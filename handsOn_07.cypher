match (p:Person {name: "Your Name"})
match (m:Movie {title: "Your Movie"})
create (p)-[:ACTED_IN]->(m);

match (p:Person)-[:ACTED_IN]->(m:Movie)
where p.name = "Your Name"
return *;
