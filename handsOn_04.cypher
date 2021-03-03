match (p1:Person)-[r1:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(p2:Person)
where p1.name = "Keanu Reeves"
return p1.name as Actor1, m.title as Movie, p2.name as Actor2;

// 暗黙的なGroup By
match (p1:Person)-[r1:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(p2:Person)
where p1.name = "Keanu Reeves"
return p1.name as Who, m.title as Movie, collect(p2.name) as Actors, count(p2.name) as ActorsNumber;
