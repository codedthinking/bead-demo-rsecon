## How bead Solves Our Problems

| Problem | bead Solution |
|---------|---------------|
| "What data did we use?" | Every bead remembers exact version |
| "It worked on my machine" | Exact same setup for everyone |
| "That person left" | Work stays reproducible |
| Team uses different tools | Language agnostic |
| Complex pipelines | Chain beads together |

## Real Research Example

- Multiple datasets connected
- Many cleaning steps
- Green = using latest data version
- Some steps outdated
- bead tracks entire dependency graph

## bead in Practice

### Step 1: Create workspace
```bash
bead new health-analysis
```

### Step 2: Load inputs
```bash
bead input add wdi-data
bead input add health-metrics
```

### Step 3: Run analysis
```bash
python clean_data.py
R --file=analyze.R
```

### Step 4: Save snapshot
```bash
bead save figure1-v2
```

## Why bead is Different

- **Simple**: 4 commands to learn
- **Universal**: Any language, any tool
- **Portable**: Just ZIP files
- **Secure**: Data stays on your servers
- **Transparent**: Open source, no vendor lock-in

## For Research Software Engineers

- Minimal learning curve for researchers
- No infrastructure requirements
- Works with existing workflows
- Complements version control
- Enables true reproducibility

## Get Started

### Installation
```bash
pip install bead
```

## Key Takeaways

1. **Data provenance is hard** - especially with changing teams
2. **Existing tools too complex** - for heterogeneous research teams  
3. **bead keeps it simple** - focuses on one thing well
4. **Reproducibility becomes automatic** - not an afterthought

### Contact and Acknowledgements
- Web: [bead.zip](https://bead.zip)
- GitHub: [github.com/e3krisztian/bead](https://github.com/e3krisztian/bead)


![](images/erc-logo.png){ width=20% }

This project has received funding from the European Research Council (ERC) under the European Union's Horizon 2020 research and innovation programme (grant agreement No 313164). The views expressed are those of the authors and do not necessarily reflect those of the ERC or the European Commission.

## References

- **World Development Indicators**: [data.worldbank.org/indicator](https://data.worldbank.org/indicator)
- **DVC (Data Version Control)**: [dvc.org](https://dvc.org)
- **Apache Airflow**: [airflow.apache.org](https://airflow.apache.org)
- **dbt**: [getdbt.com](https://www.getdbt.com)
- **KNIME**: [knime.com](https://knime.com)