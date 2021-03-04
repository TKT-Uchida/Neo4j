create (:Person {name: "Your Name"});

match (p:Person)
where p.name = "Your Name"
return p;

create (:Movie {title: "Your Movie"});

match (m:Movie)
where m.title = "Your Movie"
return m;

match (p:Person {name: "Your Name"})
match (m:Movie {title: "Your Movie"})
return p, m;
