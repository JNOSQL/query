# Eclipse NoSQL Aphrodite

Eclipse JNoSQL Aphrodite is the project that contains the syntax query to JNoSQL API.

The general concepts about the statements:

* It ends with a break line `\n`
* It is case sensitive
* All keywords must be in lowercase
* The goals are to look like SQL, however simpler
* Even with this query, a specific implementation may not support an operation, condition, so on. E.g: Column family may not support query with equals operator in a different column than the key itself.
* The goal of the API is not about forgotten the specific behavior that there is in a particular database. These features matter, that's why there's an extensible API.

# Column and Document 
## Select

The select statement reads one or more fields for one or more entities. It returns a result-set of the entities matching the request, where each entity contains the fields for corresponding to the query.

```sql
select_statement ::=  SELECT ( select_clause | '*' )
                      FROM entity_name
                      [ WHERE where_clause ]
                      [ SKIP (integer) ]
                      [ LIMIT (integer) ]
                      [ ORDER BY ordering_clause ]
```

#### Sample

```sql
select * from God
select  name, age ,adress.age from God order by name desc age desc
select  * from God where birthday between "01-09-1988" and "01-09-1988" and salary = 12
select  name, age ,adress.age from God skip 20 limit 10 order by name desc age desc
```

## Insert

Inserting data for an entity is done using an INSERT statement:

```sql

insert_statement ::=  INSERT entity_name (name = value, (`,` name = value) *) TTL
```

#### Sample:


```sql
insert God (name = "Diana", age = 10)
insert God (name = "Diana", age = 10, power = {"sun", "god"})
```

## Update

Updating an entity is done using an **UPDATE** statement:


```sql

insert_statement ::=  UPDATE entity_name (name = value, (`,` name = value) *)
```

#### Sample:


```sql
update God (name = "Diana", age = 10)
update God (name = "Diana", age = 10, power = {"sun", "god"})
```

## Delete

Deleting either an entity or fields uses the **DELETE** statement

```sql
delete_statement ::=  DELETE [ simple_selection ( ',' simple_selection ) ]
                      FROM entity_name
                      WHERE where_clause
```

#### Sample:


```sql
delete from God
delete  name, age ,adress.age from God order by name desc age desc
```

### WHERE

The WHERE clause specifies a filter to the result. It is composed of one or more conditions appended with the **AND** | **OR** operator.

#### Conditions

The conditions are composed by name where the operation gonna happen, the operator then the value to be measurable.

#### Operators

The Operators are:


| Operator | Description |
| ------------- | ------------- |
| **=**         | Equal to |
| **>**         | Greater than|
| **<**         | Less than |
| **>=**        | Greater than or equal to |
| **<=**        | Less than or equal to |
| **BETWEEN**   | TRUE if the operand is within the range of comparisons |
| **NOT**       | Displays a record if the condition(s) is NOT TRUE	|
| **AND**       | TRUE if all the conditions separated by AND is TRUE|
| **OR**        | TRUE if any of the conditions separated by OR is TRUE|
| **LIKE**      |TRUE if the operand matches a pattern	|
| **IN**        |TRUE if the operand is equal to one of a list of expressions	|

#### The value

the value is the last element in a condition, and it defines what it 'll go to be used, with an operator, in a field.

There are five types:

* number, where if it is a decimal, will become double, otherwise, long. E.g.: `age = 20`, `salary =12.12`
* string one or more characters:  among two double quotes `"`. E.g.: name = "Ada Lovelace"
* Convert: convert is a function where given the first value parameter, as number or string, it will convert to the class type of the second one. E.g.: `birthday = convert("03-01-1988", java.time.LocalDate)`
* parameter: the parameter is a dynamic value, which means, it does not define the query, it'll replace in the execution time. The parameter is at `@` followed by a name. E.g.: `age = @age`
* array: A sequence of elements that can be either number or string that is between braces ` {` `}`. E.g.: `power = {"Sun", "hunt"}`

### SKIP

The **SKIP** option to a **SELECT** statement defines where the query should start,

### LIMIT

The **LIMIT** option to a **SELECT** statement limits the number of rows returned by a query, 

### ORDER BY

The ORDER BY clause allows selecting the order of the returned results. It takes as argument a list of column names along with the order for the column (**ASC** for ascendant and **DESC** for the descendant, omitting the order being equivalent to **ASC**). 

### TTL

It defines the time to live of an object that is composed of the integer value and then the unit that might be `day`, `hour`, `minute`, `second`, `microsecond`, `millisecond`, `nanosecond`. E.g.: `ttl 10 second`
