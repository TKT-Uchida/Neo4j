// MATCH (j:JOB) DETACH DELETE j;
// MATCH (j:TABLE) DETACH DELETE j;
// MATCH (j:REPORT) DETACH DELETE j;

// ノード作成
// （MERGEはCREATEと違って、カンマ区切りでMERGE()の中に複数指定できない）
// JOB
MERGE (j1:Job {name: 'Job1', group: 'A', cycle: 'Day'})
MERGE (j2:Job {name: 'Job2', group: 'B', cycle: 'Day'})
MERGE (j3_1:Job {name: 'Job3-1', group: 'C', cycle: 'Day'})
MERGE (j3_2:Job {name: 'Job3-2', group: 'C', cycle: 'Month'})
MERGE (j3_3:Job {name: 'Job3-3', group: 'C', cycle: 'Day'})
MERGE (j4_1:Job {name: 'Job4-1', group: 'D', cycle: 'Month'})
MERGE (j4_2:Job {name: 'Job4-2', group: 'D', cycle: 'Day'})
// TABLE
MERGE (tbl1_1:Table {name: 'Table1-1', type: 'Master', column: 5})
MERGE (tbl1_2:Table {name: 'Table1-2', type: 'Transaction', column: 11})
MERGE (tbl1_3:Table {name: 'Table1-3', type: 'Transaction', column: 20})
MERGE (tbl2_1:Table {name: 'Table2-1', type: 'Transaction', column: 23})
MERGE (tbl2_2:Table {name: 'Table2-2', type: 'Master', column: 8})
MERGE (tbl2_3:Table {name: 'Table2-3', type: 'Transaction', column: 16})
// REPORT
MERGE (rpt1_1:Report {name: 'Report1-1', type: 'Word'})
MERGE (rpt1_2:Report {name: 'Report1-2', type: 'Excel'})
MERGE (rpt1_3:Report {name: 'Report1-3', type: 'Word'})
MERGE (rpt2_1:Report {name: 'Report2-1', type: 'Word'})
MERGE (rpt2_2:Report {name: 'Report2-2', type: 'Excel'})
MERGE (rpt2_3:Report {name: 'Report2-3', type: 'Excel'})

// リレーション作成
// (JOB)-[:NEXT]->(JOB)
MERGE (j1)-[:NEXT]->(j2)
MERGE (j2)-[:NEXT]->(j3_1)
MERGE (j2)-[:NEXT]->(j3_2)
MERGE (j2)-[:NEXT]->(j3_3)
MERGE (j3_2)-[:NEXT]->(j4_1)
MERGE (j3_3)-[:NEXT]->(j4_2)
// (JOB)-[:UPDATE]->(TABLE)
MERGE (j3_1)-[:UPDATE]->(tbl1_1)
MERGE (j4_1)-[:UPDATE]->(tbl2_1)
MERGE (j4_2)-[:UPDATE]->(tbl2_2)
MERGE (j4_2)-[:UPDATE]->(tbl2_3)
MERGE (j3_3)-[:UPDATE]->(tbl1_2)
MERGE (j3_3)-[:UPDATE]->(tbl1_3)
// (TABLE)-[:SELECT]->(REPORT)
MERGE (tbl1_1)-[:SELECT]->(rpt1_1)
MERGE (tbl2_1)-[:SELECT]->(rpt2_1)
MERGE (tbl2_1)-[:SELECT]->(rpt2_2)
MERGE (tbl2_2)-[:SELECT]->(rpt2_3)
MERGE (tbl1_2)-[:SELECT]->(rpt1_2)
MERGE (tbl1_3)-[:SELECT]->(rpt1_3);
