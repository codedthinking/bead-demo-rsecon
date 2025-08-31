
## The Editor Says You Have One Week

- Journal editor: "substantial revision invited"
- Reviewers liked Figure 1 (life expectancy vs GDP per capita)
- Concern about health data source
- You need to:
  - Address reviewer concerns
  - Redo analysis with new data
  - Recreate Figure 1
  - Submit within one week

## But Your Submission is Months Old

- Research submitted months ago
- Team has been improving data cleaning since then
- Different statistical methods now
- **First question**: How did I actually produce Figure 1?

## Research Results are Functions

$$\text{Figure 1} = f(\text{code}, \text{data})$$

- Results depend on both algorithms and data
- Code under version control (Git) -> Yes
- Tagged commit at submission -> Yes
- **But what about the data?**

## Data is Also a Function

$$\text{data}_1 = f(\text{code}_2, \text{data}_2)$$

- Data produced by wrangling/cleaning steps
- Which countries dropped?
- What transformations applied?
- Feature engineering details?
- **Chain of data provenance**

## Real-World Data Pipelines

- Multiple datasets merged
- Many cleaning steps  
- Different versions coexisting
- Green = using latest version
- Red/yellow = outdated dependencies
- Complex dependency graph

## The Data Provenance Problem

### Why it's complex:
1. **Frequent changes**: Code and data both evolve
2. **Complex pipelines**: Many steps, multiple datasets
3. **Tool heterogeneity**: Python, R, SQL, DuckDB all in one project

## Team Dynamics Make it Worse

- Master/PhD students graduate and leave
- Different team members use different tools
- **Every meeting starts with**:
  - "Who knows how to reproduce this?"
  - "Who has the data?"
  - "That person already left..."

## Existing Solutions

### Version Control (Git)
- Great for code
- Not suitable for large binary data

### Data Version Control (DVC)
- Similar spirit to bead
- More complex than needed
- [dvc.org](https://dvc.org)

### Orchestration Tools
- Apache Airflow (Python) - [airflow.apache.org](https://airflow.apache.org)
- dbt (SQL) - [getdbt.com](https://www.getdbt.com)
- KNIME (no-code) - [knime.com](https://knime.com)
- Too complex for heterogeneous teams

## Enter bead

**A command-line tool that ensures your output is a function of your input**

- Much simpler than alternatives
- Language agnostic
- Works with heterogeneous teams
- Different experience levels
- Different operating systems

## What bead Does NOT Do

### Not a code runner
- You run your own code
- Python, R, Stata, SQL - doesn't matter

### Not a file delivery system
- File system stores your files
- You copy/move files yourself

### Only requirement:
- Works with flat files on file system
- Files not too big (20GB works fine)

## What bead Enforces

### Input data is immutable
- Cannot modify raw data
- Forces good practices
- Preserves data lineage

## Core bead Concepts

### The bead
- Self-contained computational unit
- Contains code, data, results
- Packaged as ZIP file
- Remembers exact provenance

### Simple Commands
```bash
bead new my-analysis
bead input add source-data
bead save 
```

## Demo Time

Let's see bead in action with a real example...


