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

// MATCHの中にカンマ区切りで続けて書くと１つのクエリと見なされる
// 同じMATCHの中で１度出現したパターンは、二度と出現しない（Cypherの仕様らしい）
// １つ目のパターンで３つのいずれかに該当するものをすべて取得できるが、
// ２つ目のパターンでWROTEの経路（パターン）は出現しなくなるため、WROTEの経路が消失する
// さらに３つ目のパターンでPRODUCEDの経路も消失し、最終的にはDIRECTEDの経路のみ残る、というわけだ
match (a:Person)-[r:WROTE|PRODUCED|DIRECTED]->(b), (a)-[:WROTE]->(b), (a)-[:PRODUCED]->(b)
return *;
// +--------------------------------------------------------------------------------------------------------------------------------------------------------------+
// | a                                             | b                                                                                              | r           |
// +--------------------------------------------------------------------------------------------------------------------------------------------------------------+
// | (:Person {name: "Cameron Crowe", born: 1957}) | (:Movie {tagline: "The rest of his life begins now.", title: "Jerry Maguire", released: 2000}) | [:DIRECTED] |
// | (:Person {name: "Nancy Meyers", born: 1949})  | (:Movie {title: "Something's Gotta Give", released: 2003})                                     | [:DIRECTED] |
// +--------------------------------------------------------------------------------------------------------------------------------------------------------------+

// ちなみにMATCH句を別にすることで、別々のクエリとして発行される
// 下記の要にすればWROTEとPRODUCEDのパターンのみ取得できる
match (a:Person)-[r:WROTE|PRODUCED|DIRECTED]->(b)
match (a:Person)-[:WROTE]->(b)
match (a:Person)-[:PRODUCED]->(b)
return *;
// +---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
// | a                                               | b                                                                                                                                             | r           |
// +---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
// | (:Person {name: "Nora Ephron", born: 1941})     | (:Movie {tagline: "Can two friends sleep together and still love each other in the morning?", title: "When Harry Met Sally", released: 1998}) | [:PRODUCED] |
// | (:Person {name: "Nora Ephron", born: 1941})     | (:Movie {tagline: "Can two friends sleep together and still love each other in the morning?", title: "When Harry Met Sally", released: 1998}) | [:WROTE]    |
// | (:Person {name: "Lilly Wachowski", born: 1967}) | (:Movie {tagline: "Freedom! Forever!", title: "V for Vendetta", released: 2006})                                                              | [:PRODUCED] |
// | (:Person {name: "Lilly Wachowski", born: 1967}) | (:Movie {tagline: "Freedom! Forever!", title: "V for Vendetta", released: 2006})                                                              | [:WROTE]    |
// | (:Person {name: "Lana Wachowski", born: 1965})  | (:Movie {tagline: "Freedom! Forever!", title: "V for Vendetta", released: 2006})                                                              | [:PRODUCED] |
// | (:Person {name: "Lana Wachowski", born: 1965})  | (:Movie {tagline: "Freedom! Forever!", title: "V for Vendetta", released: 2006})                                                              | [:WROTE]    |
// | (:Person {name: "Cameron Crowe", born: 1957})   | (:Movie {tagline: "The rest of his life begins now.", title: "Jerry Maguire", released: 2000})                                                | [:PRODUCED] |
// | (:Person {name: "Cameron Crowe", born: 1957})   | (:Movie {tagline: "The rest of his life begins now.", title: "Jerry Maguire", released: 2000})                                                | [:WROTE]    |
// | (:Person {name: "Cameron Crowe", born: 1957})   | (:Movie {tagline: "The rest of his life begins now.", title: "Jerry Maguire", released: 2000})                                                | [:DIRECTED] |
// | (:Person {name: "Nancy Meyers", born: 1949})    | (:Movie {title: "Something's Gotta Give", released: 2003})                                                                                    | [:WROTE]    |
// | (:Person {name: "Nancy Meyers", born: 1949})    | (:Movie {title: "Something's Gotta Give", released: 2003})                                                                                    | [:DIRECTED] |
// | (:Person {name: "Nancy Meyers", born: 1949})    | (:Movie {title: "Something's Gotta Give", released: 2003})                                                                                    | [:PRODUCED] |
// +---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

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

match (a:Person)-[r:WROTE|PRODUCED|DIRECTED]->(b), (a)-[:WROTE]->(b), (a)-[:PRODUCED]->(b), (a)-[:DIRECTED]->(b)
return *;
// (no rows)

// all: コレクションのすべての要素に対して、条件がTRUEの場合にTRUEを返す
match (a)-[r:WROTE|PRODUCED|DIRECTED]->(b)
with a, b, collect(type(r)) as typeList, ["WROTE", "PRODUCED", "DIRECTED"] as compList
where all(x in compList where x in typeList)
return *;

match (a)-[:WROTE]->(b),  (a)-[:PRODUCED]->(b), (a)-[:DIRECTED]->(b)
return *;

match (a)-[:WROTE]->(b),  (a)-[:PRODUCED]->(b), (a)-[:DIRECTED]->(b)
return a.name as person, b.title as movie;
