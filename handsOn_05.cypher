match (a:Person {name: "Nancy Meyers"})-[r:WROTE|PRODUCED|DIRECTED]->(m)
return *;

match (a:Person {name: "Nancy Meyers"})-[r:WROTE|PRODUCED|DIRECTED]->(m)
return a.name as Person, collect(type(r)) as Role, m.title as Movie;

match (a)-[r:WROTE|PRODUCED|DIRECTED]->(m)
return *;

match (a:Person {name: "Nancy Meyers"})-[r:WROTE|PRODUCED|DIRECTED]->(b), (a)-[:WROTE]->(b)
return *;

// WROTEまたはPRODUCEDまたはDIRECTEDのリレーションがあるノードが変数a,bに格納され、
// その変数a,bを使って、WROTEのみのリレーションに絞られる
// 結果、各ノード間のリレーションには必ずWROTEが存在する
match (a:Person)-[r:WROTE|PRODUCED|DIRECTED]->(b), (a)-[:WROTE]->(b)
return *;

match (a:Person)-[r:WROTE|PRODUCED|DIRECTED]->(b), (a)-[:PRODUCED]->(b)
return *;

match (a:Person)-[r:WROTE|PRODUCED|DIRECTED]->(b), (a)-[:DIRECTED]->(b)
return *;

match (a:Person)-[r:WROTE|PRODUCED|DIRECTED]->(b), (a)-[:WROTE]->(b), (a)-[:PRODUCED]->(b)
return *;
// +--------------------------------------------------------------------------------------------------------------------------------------------------------------+
// | a                                             | b                                                                                              | r           |
// +--------------------------------------------------------------------------------------------------------------------------------------------------------------+
// | (:Person {name: "Cameron Crowe", born: 1957}) | (:Movie {tagline: "The rest of his life begins now.", title: "Jerry Maguire", released: 2000}) | [:DIRECTED] |
// | (:Person {name: "Nancy Meyers", born: 1949})  | (:Movie {title: "Something's Gotta Give", released: 2003})                                     | [:DIRECTED] |
// +--------------------------------------------------------------------------------------------------------------------------------------------------------------+

// WROTEとPRODUCEDの両方が存在する
match (a)-[:WROTE]->(b), (a)-[:PRODUCED]->(b)
return *;

// WROTEもしくはPRODUCEDの片方が存在する
match (a)-[:WROTE|PRODUCED]->(b)
return *;

match (a)-[:WROTE]->(b), (a)-[:PRODUCED]->(b), (a)-[:DIRECTED]->(b)
return *;

match (a:Person)-[r:WROTE|PRODUCED|DIRECTED]->(b), (a)-[:WROTE]->(b), (a)-[:DIRECTED]->(b)
return *;
// +--------------------------------------------------------------------------------------------------------------------------------------------------------------+
// | a                                             | b                                                                                              | r           |
// +--------------------------------------------------------------------------------------------------------------------------------------------------------------+
// | (:Person {name: "Cameron Crowe", born: 1957}) | (:Movie {tagline: "The rest of his life begins now.", title: "Jerry Maguire", released: 2000}) | [:PRODUCED] |
// | (:Person {name: "Nancy Meyers", born: 1949})  | (:Movie {title: "Something's Gotta Give", released: 2003})                                     | [:PRODUCED] |
// +--------------------------------------------------------------------------------------------------------------------------------------------------------------+

match (a:Person)-[r:WROTE|PRODUCED|DIRECTED]->(b), (a)-[:PRODUCED]->(b), (a)-[:DIRECTED]->(b)
return *;
// +-----------------------------------------------------------------------------------------------------------------------------------------------------------+
// | a                                             | b                                                                                              | r        |
// +-----------------------------------------------------------------------------------------------------------------------------------------------------------+
// | (:Person {name: "Cameron Crowe", born: 1957}) | (:Movie {tagline: "The rest of his life begins now.", title: "Jerry Maguire", released: 2000}) | [:WROTE] |
// | (:Person {name: "Nancy Meyers", born: 1949})  | (:Movie {title: "Something's Gotta Give", released: 2003})                                     | [:WROTE] |
// +-----------------------------------------------------------------------------------------------------------------------------------------------------------+