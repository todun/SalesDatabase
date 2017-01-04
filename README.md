# README #

## running the sql script
In a terminal, from the directory containing the sql script, excute the following statements

1. `cd /path/to/root/of/project`
2. `createdb -h localhost`
3. `psql -f salesdatabase.sql`

## postgres` setup on osx
1. `brew services start postgresql` # launch postgresql in terminal 
2. `psql -d postgres` # connect to interactive RDBMS from terminal

## running from IDEA DataGrip
1. install postgre drivers
2. setup psql on local computer
3. start psql on local computer
4. start postgre on DataGrip
4. execute DDL and DML from console

## Assumptions
- PostgreSql SQL dialect
- duplicates removed
- added additional records to the `Orders` table to facilitate testing of different years

## References
- IDEA DataGrip documentation
- PostgreSql documentation
- Stackoverflow
- w3schools
- Postgresql documentation

## Dependencies
- postgresql 9.6.1
