grammar Method;
findBy:'findBy' where? order? EOF;

where: condition (and condition| or condition)* ;
condition: eq | gt | gte | lt | lte | between | in | like;
order: 'OrderBy' orderName (orderName)*;
orderName: variable | variable asc | variable desc;
and: 'And';
or: 'Or';
asc: 'Asc';
desc: 'Desc';
eq: variable | variable not? 'Equals';
gt: variable not? 'GreaterThan';
gte: variable not? 'GreaterThan';
lt: variable not? 'LessThan';
lte: variable not? 'LessThanEqual';
between: variable not? 'Between';
in: variable not? 'In';
like: variable not? 'Like';
not: 'Not';
variable: ANY_NAME;
ANY_NAME: [a-zA-Z_.] [a-zA-Z._0-9]*;
WS: [ \t\r\n]+ -> skip ;
fragment ESC :   '\\' (["\\/bfnrt] | UNICODE) ;
fragment UNICODE : 'u' HEX HEX HEX HEX ;
fragment HEX : [0-9a-fA-F] ;