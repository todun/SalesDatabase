# README #

## postgres` setup on osx
1. launch `postgresql` on terminal with : `brew services start postgresql`
2. connect to database from terminal with `psql -d postgres`

## running the sql script
In a terminal, from the directory containing the sql script, excute the following statements
`createdb -h localhost`
`psql -f salesdatabase.sql`

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

## Documentation
- IDEA DataGrip documentation
- PostgreSql documentation
- Stackoverflow
- w3schools
- Postgresql documentation
