# db-design-coursework

![University](https://img.shields.io/badge/Aston%20University-6B2FA0?style=flat-square)
![Year](https://img.shields.io/badge/BSc%20Computer%20Science%20·%20Year%201-3a3a3a?style=flat-square)
![Module](https://img.shields.io/badge/Internet%20Applications%20%26%20Databases-3a3a3a?style=flat-square)
![Coursework](https://img.shields.io/badge/Coursework%2020%25-3a3a3a?style=flat-square)

A normalised (3NF) relational MySQL database for a software company's project management system, designed for the DG1IAD module at Aston University.

![Preview](./preview.png)

---

## Files

| File | Description |
|---|---|
| `schema.sql` | `CREATE TABLE` statements for the full database schema |
| `queries.sql` | `INSERT`, `UPDATE`, and `SELECT` statements |

## Schema

Six tables normalised to third normal form:

- **Skill** - skills with name and type (e.g. Frontend, Backend, Design)
- **Client** - client organisations with contact preferences
- **Project** - projects linked to clients, with phase tracking and budget
- **PoolMember** - staff available for assignment, linked to a project when assigned
- **PoolMemberSkill** - junction table linking members to skills with experience level (junior, mid, expert)
- **ProjectSkill** - junction table linking projects to required skills

## Queries

- Insert seed data: 6 skills, 2 clients, 2 pool members, 1 project
- Match pool members to a project based on required skills
- Auto-assign matched members to the project via `UPDATE`
- Report: all pool members with their skills and experience levels
- Report: all projects with assigned members and client
- Report: skills grouped by type

## What I Learned

- Designing a relational schema from scratch and normalising to 3NF
- Using junction tables to model many-to-many relationships
- Writing subqueries and `JOIN` chains to match members to project requirements
- Enforcing data integrity with foreign keys, `CHECK` constraints, and `ENUM` types
- Keeping SQL readable and maintainable without relying on GUI export tools

## Known Limitations

- Schema is designed for MySQL specifically; some constraints may behave differently in other engines
- No stored procedures or triggers; logic is handled at the query level

## Running Locally

1. Open MySQL and create a new database
2. Run `schema.sql` to create the tables
3. Run `queries.sql` to insert data and run reports
