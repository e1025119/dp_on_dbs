# dpdb
Solve dynamic programming problems on tree decompositions using databases

## Requirements

### htd

[htd on github](https://github.com/TU-Wien-DBAI/htd/)

### Database
[PostgreSQL](https://www.postgresql.org)

### Python
* Python 3
* psycopg2
```
pip install -r requirements.txt
```

## Configuration
Basic configuration (database connection, htd path, ...) are configured in **config.json**

## Usage

```
python dpdb.py [GENERAL-OPTIONS] <PROBLEM> [PROBLEM-SPECIFIC-OPTIONS] <INPUT-FILE>
```

### Currently implemented problems
* SAT 
* #SAT
* Minimum Vertex Cover

For additional help use
```
python dpdb.py --help
```
or 
```
python dpdb.py <PROBLEM> --help
```
for problem specific help/options

## TODO / Future Work

###Parallel setup

Setup is currently not concurrent.
For some instances setup is even the bottleneck right now.

###Indexing

Currently no indices are created. It is an open problem to investigate whether good indices can be determined just by the structure of the problem.

Oracle's Bitmap Indices also seem worth a try (Oracle Enterprise Feature)

###Resume / Re-run

Re-construct input from database to be able to run the same instance again (without needing a seed for htd) or to resume previously unfinished jobs.
