match (p1:Person)-[:ACTED_IN]->(m:Movie)<--()
where p1.name = "Keanu Reeves"
return p1, m;

match (p1:Person)-[:ACTED_IN]->(m:Movie)<--(:Person)
where p1.name = "Keanu Reeves"
return p1, m;

match (p1:Person)-[:ACTED_IN]->(m:Movie)<--(p2)
where p1.name = "Keanu Reeves"
return p1, m, p2;

match (p1:Person)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(p2)
where p1.name = "Keanu Reeves"
return p1, m, p2;

match (p1:Person)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-(p2:Person)
where p1.name = "Keanu Reeves"
return p1, m, p2;

match (p1:Person)-[r1:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(p2:Person)
where p1.name = "Keanu Reeves"
return p1, p2, m, r1, r2;

// 実行計画
explain match (p1:Person)-[r1:ACTED_IN]->(m:Movie)<-[r2:ACTED_IN]-(p2:Person)
where p1.name = "Keanu Reeves"
return p1, p2, m;