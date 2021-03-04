// 推奨のCypherスタイル
// ノードのラベル名は、キャメルケース(CamelCase)で表現し、英字の大文字で始めることを推奨 (例: Person, NetworkAddress）。大文字と小文字を区別
// プロパティキー、変数、パラメーター、エイリアス、ファンクションは、キャメルケース(CamelCase)であり、英字の小文字で始めることを推奨（例:businessAddress)。大文字と小文字を区別
// リレーションシップのタイプは、英字の大文字で表現し、アンダースコアを使用することを推奨（例:ACTED_IN, FOLLOWS）
// Cypherのキーワードは、大文字で書くことを推奨（例: MATCH, RETURN)。大文字と小文字を区別しない
// 文字列は、シングルクォート又はダブルクォートを使用（例:’The Matrix’, “Somethins’s Gotta Give”, ’Somethins\’s Gotta Give’）
// コメントは、２のタイプがあります
// 　　// hogehoge
// 　　/* hogehoge */

// 全経路取得
MATCH (n1:Job)-[r*]-(n2) RETURN *;

// JOB指定で後続のものすべてを取得
MATCH (n1:Job {name: 'Job3-2'})-[r*]->(n2) RETURN *;
// +------------------------------------------------------------------------------------------------------------------------------------------------------+
// | n1                                                  | n2                                                           | r                               |
// +------------------------------------------------------------------------------------------------------------------------------------------------------+
// | (:Job {name: "Job3-2", cycle: "Month", group: "C"}) | (:Job {name: "Job4-1", cycle: "Month", group: "D"})          | [[:NEXT]]                       |
// | (:Job {name: "Job3-2", cycle: "Month", group: "C"}) | (:Table {name: "Table2-1", column: 23, type: "Transaction"}) | [[:NEXT], [:UPDATE]]            |
// | (:Job {name: "Job3-2", cycle: "Month", group: "C"}) | (:Report {name: "Report2-1", type: "Word"})                  | [[:NEXT], [:UPDATE], [:SELECT]] |
// | (:Job {name: "Job3-2", cycle: "Month", group: "C"}) | (:Report {name: "Report2-2", type: "Excel"})                 | [[:NEXT], [:UPDATE], [:SELECT]] |
// +------------------------------------------------------------------------------------------------------------------------------------------------------+

// プロパティ指定で取得
MATCH (n1:Job {name: 'Job3-2'})-[r*]->(n2)
RETURN n1.name, n1.group, n1.cycle, n2.name, n2.group, n2.cycle, n2.type, n2.column;
// +------------------------------------------------------------------------------------------------+
// | n1.name  | n1.group | n1.cycle | n2.name     | n2.group | n2.cycle | n2.type       | n2.column |
// +------------------------------------------------------------------------------------------------+
// | "Job3-2" | "C"      | "Month"  | "Job4-1"    | "D"      | "Month"  | NULL          | NULL      |
// | "Job3-2" | "C"      | "Month"  | "Table2-1"  | NULL     | NULL     | "Transaction" | 23        |
// | "Job3-2" | "C"      | "Month"  | "Report2-1" | NULL     | NULL     | "Word"        | NULL      |
// | "Job3-2" | "C"      | "Month"  | "Report2-2" | NULL     | NULL     | "Excel"       | NULL      |
// +------------------------------------------------------------------------------------------------+
// (存在しないプロパティ値はnull)

// ノードまでの経路をコレクションで表示
MATCH path = (n1:Job {name: 'Job3-2'})-[r*]->(n2)
RETURN n1.name, n1.group, n1.cycle, [x in nodes(path) | x.name] as path, n2.name, n2.group, n2.cycle, n2.type, n2.column;
// +------------------------------------------------------------------------------------------------------------------------------------------------+
// | n1.name  | n1.group | n1.cycle | path                                          | n2.name     | n2.group | n2.cycle | n2.type       | n2.column |
// +------------------------------------------------------------------------------------------------------------------------------------------------+
// | "Job3-2" | "C"      | "Month"  | ["Job3-2", "Job4-1"]                          | "Job4-1"    | "D"      | "Month"  | NULL          | NULL      |
// | "Job3-2" | "C"      | "Month"  | ["Job3-2", "Job4-1", "Table2-1"]              | "Table2-1"  | NULL     | NULL     | "Transaction" | 23        |
// | "Job3-2" | "C"      | "Month"  | ["Job3-2", "Job4-1", "Table2-1", "Report2-1"] | "Report2-1" | NULL     | NULL     | "Word"        | NULL      |
// | "Job3-2" | "C"      | "Month"  | ["Job3-2", "Job4-1", "Table2-1", "Report2-2"] | "Report2-2" | NULL     | NULL     | "Excel"       | NULL      |
// +------------------------------------------------------------------------------------------------------------------------------------------------+

MATCH path = (n1:Job {name: 'Job3-2'})-[r*]->(n2)
RETURN n1.name, n1.group, n1.cycle, [[x in relationships(path) | type(x)], [x in nodes(path) | x.name]] as path, n2.name, n2.group, n2.cycle, n2.type, n2.column;
