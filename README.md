---
author:
- Krisztián Fekete
- Miklós Koren
authors:
- Krisztián Fekete
- Miklós Koren
date: 2025-09-10
subtitle: a provenance tool
title: bead
toc-title: Table of contents
---

## The Editor Says You Have One Week

-   Journal editor: "substantial revision invited"
-   Reviewers liked Figure 1 (life expectancy vs GDP per capita)
-   Concern about health data source
-   You need to:
    -   Address reviewer concerns
    -   Redo analysis with new data
    -   Recreate Figure 1
    -   Submit within one week

## But Your Submission is Months Old

-   Research submitted months ago
-   Team has been improving data cleaning since then
-   Different statistical methods now
-   **First question**: How did I actually produce Figure 1?

## Research Results are Functions

$$\text{Figure 1} = f(\text{code}, \text{data})$$

-   Results depend on both algorithms and data
-   Code under version control (Git) -\> Yes
-   Tagged commit at submission -\> Yes
-   **But what about the data?**

## Data is Also a Function

$$\text{data}_1 = f(\text{code}_2, \text{data}_2)$$

-   Data produced by wrangling/cleaning steps
-   Which countries dropped?
-   What transformations applied?
-   Feature engineering details?
-   **Chain of data provenance**

## Real-World Data Pipelines

-   Multiple datasets merged
-   Many cleaning steps\
-   Different versions coexisting
-   Green = using latest version
-   Red/yellow = outdated dependencies
-   Complex dependency graph

## The Data Provenance Problem

### Why it's complex:

1.  **Frequent changes**: Code and data both evolve
2.  **Complex pipelines**: Many steps, multiple datasets
3.  **Tool heterogeneity**: Python, R, SQL, DuckDB all in one project

## Team Dynamics Make it Worse

-   Master/PhD students graduate and leave
-   Different team members use different tools
-   **Every meeting starts with**:
    -   "Who knows how to reproduce this?"
    -   "Who has the data?"
    -   "That person already left..."

## Existing Solutions

### Version Control (Git)

-   Great for code
-   Not suitable for large binary data

### Data Version Control (DVC)

-   Similar spirit to bead
-   More complex than needed
-   [dvc.org](https://dvc.org)

### Orchestration Tools

-   Apache Airflow (Python) -
    [airflow.apache.org](https://airflow.apache.org)
-   dbt (SQL) - [getdbt.com](https://www.getdbt.com)
-   KNIME (no-code) - [knime.com](https://knime.com)
-   Too complex for heterogeneous teams

## Enter bead

**A command-line tool that ensures your output is a function of your
input**

-   Much simpler than alternatives
-   Language agnostic
-   Works with heterogeneous teams
-   Different experience levels
-   Different operating systems

## What bead Does NOT Do

### Not a code runner

-   You run your own code
-   Python, R, Stata, SQL - doesn't matter

### Not a file delivery system

-   File system stores your files
-   You copy/move files yourself

### Only requirement:

-   Works with flat files on file system
-   Files not too big (20GB works fine)

## What bead Enforces

### Input data is immutable

-   Cannot modify raw data
-   Forces good practices
-   Preserves data lineage

## Core bead Concepts

### The bead

-   Self-contained computational unit
-   Contains code, data, results
-   Packaged as ZIP file
-   Remembers exact provenance

### Simple Commands

``` bash
bead new my-analysis
bead input add source-data
bead save 
```

## Demo Time

Let's see bead in action with a real example...

::: cell
```{=html}
<style>
.top-bottom-layout {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: 100%;
}

.top-content {
  align-self: flex-start;
  font-size: 0.85em;
  height: 60%; /* your desired fixed height */
  width: 100%;
}

.bottom-content {
  align-self: flex-end;
  font-size: 0.85em;
  color: #888;
  display: flex;
  flex-direction: row;
  gap: 1em; /* optional spacing between left/right */
  height: 40%; /* your desired fixed height */
  width: 100%;
}

.bottom-left {
  width: 40%;
  overflow: auto;
}

.bottom-right {
  width: 60%;
  overflow: auto;
}

.terminal {
  background-color: #111;
  color: #0f0;
  font-family: monospace;
  padding: 1em;
  padding-top: 0.5em; /* or 0 if you want it flush */
  line-height: 1.1;
  border-radius: 6px;
  max-height: 360px;
  height: 360px;
  # height: 100%;
  overflow-y: scroll;
  box-shadow: 0 0 10px #000;
  font-size: 0.65em;
  white-space: pre-wrap; /* preserve formatting but wrap long lines */
}

.terminal {
  opacity: 0;
  // visibility: hidden; /* Hide until scrolled */
}
.terminal.scrolled {
  opacity: 1;
  // visibility: visible; /* Show after scrolling */
}

.terminal pre {
  // all: unset; /* removes default pre styling */
  white-space: pre-wrap; /* preserve formatting but wrap long lines */
  font-family: monospace;
  color: inherit;
  background: inherit;
  font-size: 0.8em;
}

/* Prompt */
.terminal .prompt {
  color: #0ff;
  font-weight: bold;
}

/* Command typed by user */
.terminal .command {
  color: #0f0;
  font-weight: bold;
}

/* Output from the system */
.terminal .output {
  color: #fff;
  font-weight: normal;
  font-size: 0.8em;
}

/* terminal cursor */
.cursor {
  display: inline-block;
  // width: 0.2em;
  // margin-left: 0.1em; /* optional spacing from text */
  width: 0.6em;
  height: 1em;
  background-color: #0f0;
  animation: blink 1s step-start infinite;
  vertical-align: bottom;
}

@keyframes blink {
  50% {
    opacity: 0;
  }
}
</style>
```
:::

## Inspiration

-   Data Journalism
-   Human concept of story
    -   Events/Characters/Theme or Message
    -   variable scope
    -   stories are composable
    -   helps us to make sense of the world

## Design

-   ISBN / ISSN
    -   identification of series by opaque id
-   Task scope
-   Local first
-   Integrity

## Environment preparation

###  {#section .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>

</pre>
    </div>
    <div class="bottom-right">
<pre>

</pre>
    </div>
  </div>
</div>
```
###  {#section-1 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>

</pre>
    </div>
    <div class="bottom-right">
<pre>

</pre>
    </div>
  </div>
</div>
```
###  {#section-2 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>

</pre>
    </div>
  </div>
</div>
```
###  {#section-3 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>

</pre>
    </div>
  </div>
</div>
```
###  {#section-4 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span>
<span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>

</pre>
    </div>
  </div>
</div>
```
###  {#section-5 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>

</pre>
    </div>
  </div>
</div>
```
###  {#section-6 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span>
<span class="output">There are no defined boxes
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>

</pre>
    </div>
  </div>
</div>
```
###  {#section-7 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span>
<span class="output">There are no defined boxes
</span><span class="prompt">/demo/workspace $ </span><span class="command">mkdir /demo/bead-box</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>

</pre>
    </div>
  </div>
</div>
```
###  {#section-8 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span>
<span class="output">There are no defined boxes
</span><span class="prompt">/demo/workspace $ </span><span class="command">mkdir /demo/bead-box</span>
<span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-9 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span>
<span class="output">There are no defined boxes
</span><span class="prompt">/demo/workspace $ </span><span class="command">mkdir /demo/bead-box</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box add demo /demo/bead-box</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-10 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span>
<span class="output">There are no defined boxes
</span><span class="prompt">/demo/workspace $ </span><span class="command">mkdir /demo/bead-box</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box add demo /demo/bead-box</span>
<span class="output">Will remember box demo
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-11 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span>
<span class="output">There are no defined boxes
</span><span class="prompt">/demo/workspace $ </span><span class="command">mkdir /demo/bead-box</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box add demo /demo/bead-box</span>
<span class="output">Will remember box demo
</span><span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-12 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo $ </span><span class="command">mkdir /demo/workspace</span>
<span class="prompt">/demo $ </span><span class="command">cd /demo/workspace</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span>
<span class="output">There are no defined boxes
</span><span class="prompt">/demo/workspace $ </span><span class="command">mkdir /demo/bead-box</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead box add demo /demo/bead-box</span>
<span class="output">Will remember box demo
</span><span class="prompt">/demo/workspace $ </span><span class="command">bead box list</span>
<span class="output">Boxes:
-------------
demo: /demo/bead-box
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
## 📁 Step 1: Prepare CSV Files

###  {#section-13 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-14 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-15 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-16 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-17 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-18 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-19 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions
    ├── input
    ├── output
    │   └── sessions.csv
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-20 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions
    ├── input
    ├── output
    │   └── sessions.csv
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
</pre>
    </div>
  </div>
</div>
```
###  {#section-21 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions
    ├── input
    ├── output
    │   └── sessions.csv
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-22 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions
    ├── input
    ├── output
    │   └── sessions.csv
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-23 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-24 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-25 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-26 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-27 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── theme-aliases
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-28 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── theme-aliases
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-29 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── theme-aliases
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-30 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cat &gt; output/theme_aliases.csv &lt;&lt;EOF
alias,canonical_theme
artificial intelligence,artificial intelligence
machine learning,artificial intelligence
ai,artificial intelligence
blockchain,blockchain
distributed ledger,blockchain
sustainability,sustainability
green tech,sustainability
quantum computing,quantum computing
data privacy,data privacy
privacy,data privacy
EOF</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── theme-aliases
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-31 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cat &gt; output/theme_aliases.csv &lt;&lt;EOF
alias,canonical_theme
artificial intelligence,artificial intelligence
machine learning,artificial intelligence
ai,artificial intelligence
blockchain,blockchain
distributed ledger,blockchain
sustainability,sustainability
green tech,sustainability
quantum computing,quantum computing
data privacy,data privacy
privacy,data privacy
EOF</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── theme-aliases
    ├── input
    ├── output
    │   └── theme_aliases.csv
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-32 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cat &gt; output/theme_aliases.csv &lt;&lt;EOF
alias,canonical_theme
artificial intelligence,artificial intelligence
machine learning,artificial intelligence
ai,artificial intelligence
blockchain,blockchain
distributed ledger,blockchain
sustainability,sustainability
green tech,sustainability
quantum computing,quantum computing
data privacy,data privacy
privacy,data privacy
EOF</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead save</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── theme-aliases
    ├── input
    ├── output
    │   └── theme_aliases.csv
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
└── sessions_20250910T150220894148+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-33 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cat &gt; output/theme_aliases.csv &lt;&lt;EOF
alias,canonical_theme
artificial intelligence,artificial intelligence
machine learning,artificial intelligence
ai,artificial intelligence
blockchain,blockchain
distributed ledger,blockchain
sustainability,sustainability
green tech,sustainability
quantum computing,quantum computing
data privacy,data privacy
privacy,data privacy
EOF</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip.
</span><span class="prompt">/demo/workspace/theme-aliases $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── theme-aliases
    ├── input
    ├── output
    │   └── theme_aliases.csv
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-34 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cat &gt; output/theme_aliases.csv &lt;&lt;EOF
alias,canonical_theme
artificial intelligence,artificial intelligence
machine learning,artificial intelligence
ai,artificial intelligence
blockchain,blockchain
distributed ledger,blockchain
sustainability,sustainability
green tech,sustainability
quantum computing,quantum computing
data privacy,data privacy
privacy,data privacy
EOF</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip.
</span><span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead zap</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── theme-aliases
    ├── input
    ├── output
    │   └── theme_aliases.csv
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-35 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cat &gt; output/theme_aliases.csv &lt;&lt;EOF
alias,canonical_theme
artificial intelligence,artificial intelligence
machine learning,artificial intelligence
ai,artificial intelligence
blockchain,blockchain
distributed ledger,blockchain
sustainability,sustainability
green tech,sustainability
quantum computing,quantum computing
data privacy,data privacy
privacy,data privacy
EOF</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip.
</span><span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/theme-aliases
</span><span class="prompt">/demo/workspace/theme-aliases $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-36 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cat &gt; output/theme_aliases.csv &lt;&lt;EOF
alias,canonical_theme
artificial intelligence,artificial intelligence
machine learning,artificial intelligence
ai,artificial intelligence
blockchain,blockchain
distributed ledger,blockchain
sustainability,sustainability
green tech,sustainability
quantum computing,quantum computing
data privacy,data privacy
privacy,data privacy
EOF</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip.
</span><span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/theme-aliases
</span><span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cd ..</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-37 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions</span>
<span class="output">Created &quot;sessions&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">cat &gt; output/sessions.csv &lt;&lt;EOF
title,speaker
Advances in Artificial Intelligence,Alice
Blockchain Basics,Bob
Sustainability in Business,Charlie
Future of Quantum Computing,Diane
Data Privacy and Security,Eric
Machine Learning 101,Fiona
AI Ethics and Impact,Grace
Green Tech Innovations,Henry
Distributed Ledger Technologies,Ian
Effective Team Communication,Julia
EOF</span>
<span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions_20250910T150220894148+0000.zip.
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions
</span><span class="prompt">/demo/workspace/sessions $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="command">bead new theme-aliases</span>
<span class="output">Created &quot;theme-aliases&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd theme-aliases</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cat &gt; output/theme_aliases.csv &lt;&lt;EOF
alias,canonical_theme
artificial intelligence,artificial intelligence
machine learning,artificial intelligence
ai,artificial intelligence
blockchain,blockchain
distributed ledger,blockchain
sustainability,sustainability
green tech,sustainability
quantum computing,quantum computing
data privacy,data privacy
privacy,data privacy
EOF</span>
<span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip.
</span><span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/theme-aliases
</span><span class="prompt">/demo/workspace/theme-aliases $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
## 🛠 Step 2: Load the Data into DuckDB

###  {#section-38 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-39 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-40 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-41 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-42 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-43 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-44 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   └── sessions
    │       └── sessions.csv
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-45 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   └── sessions
    │       └── sessions.csv
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-46 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   ├── sessions
    │   │   └── sessions.csv
    │   └── theme-aliases
    │       └── theme_aliases.csv
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-47 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   ├── sessions
    │   │   └── sessions.csv
    │   └── theme-aliases
    │       └── theme_aliases.csv
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-48 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   ├── sessions
    │   │   └── sessions.csv
    │   └── theme-aliases
    │       └── theme_aliases.csv
    ├── output
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-49 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bash run.sh</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   ├── sessions
    │   │   └── sessions.csv
    │   └── theme-aliases
    │       └── theme_aliases.csv
    ├── output
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-50 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   ├── sessions
    │   │   └── sessions.csv
    │   └── theme-aliases
    │       └── theme_aliases.csv
    ├── output
    │   └── sessions.db
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-51 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead save</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   ├── sessions
    │   │   └── sessions.csv
    │   └── theme-aliases
    │       └── theme_aliases.csv
    ├── output
    │   └── sessions.db
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-52 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-db_20250910T150600233519+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   ├── sessions
    │   │   └── sessions.csv
    │   └── theme-aliases
    │       └── theme_aliases.csv
    ├── output
    │   └── sessions.db
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-53 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-db_20250910T150600233519+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead zap</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-db
    ├── input
    │   ├── sessions
    │   │   └── sessions.csv
    │   └── theme-aliases
    │       └── theme_aliases.csv
    ├── output
    │   └── sessions.db
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-54 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-db_20250910T150600233519+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions-db
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-55 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-db_20250910T150600233519+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions-db
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cd ..</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-56 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-db</span>
<span class="output">Created &quot;sessions-db&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-db</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add sessions</span>
<span class="output">Verifying archive /demo/bead-box/sessions_20250910T150220894148+0000.zip ... OK
Loading new data to sessions ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead input add theme-aliases</span>
<span class="output">Verifying archive /demo/bead-box/theme-aliases_20250910T150340396167+0000.zip ... OK
Loading new data to theme-aliases ... Done
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb output/sessions.db &quot;
-- Load sessions
CREATE TABLE sessions AS
SELECT * FROM read_csv_auto(&#x27;input/sessions/sessions.csv&#x27;);

-- Load aliases
CREATE TABLE theme_aliases AS
SELECT * FROM read_csv_auto(&#x27;input/theme-aliases/theme_aliases.csv&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-db_20250910T150600233519+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions-db
</span><span class="prompt">/demo/workspace/sessions-db $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
## 🔗 Step 3: Match Themes and Group into Lists

###  {#section-57 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-58 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-59 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-60 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-61 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-62 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-63 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-64 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-65 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-66 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-67 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    │   └── sessions_with_themes.csv
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-68 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead save</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    │   └── sessions_with_themes.csv
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-69 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-by-themes_20250910T150800908254+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    │   └── sessions_with_themes.csv
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-70 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-by-themes_20250910T150800908254+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">uvx --from csvkit csvlook output/sessions_with_themes.csv</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    │   └── sessions_with_themes.csv
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-71 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-by-themes_20250910T150800908254+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">uvx --from csvkit csvlook output/sessions_with_themes.csv</span>
<span class="output">| title                               | speaker | matched_themes                            |
| ----------------------------------- | ------- | ----------------------------------------- |
| Advances in Artificial Intelligence | Alice   | [artificial intelligence]                 |
| Blockchain Basics                   | Bob     | [blockchain, artificial intelligence]     |
| Sustainability in Business          | Charlie | [artificial intelligence, sustainability] |
| Future of Quantum Computing         | Diane   | [quantum computing]                       |
| Data Privacy and Security           | Eric    | [data privacy]                            |
| Machine Learning 101                | Fiona   | [artificial intelligence]                 |
| AI Ethics and Impact                | Grace   | [artificial intelligence]                 |
| Green Tech Innovations              | Henry   | [sustainability]                          |
| Distributed Ledger Technologies     | Ian     | [blockchain]                              |
| Effective Team Communication        | Julia   | [NULL]                                    |
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    │   └── sessions_with_themes.csv
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-72 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-by-themes_20250910T150800908254+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">uvx --from csvkit csvlook output/sessions_with_themes.csv</span>
<span class="output">| title                               | speaker | matched_themes                            |
| ----------------------------------- | ------- | ----------------------------------------- |
| Advances in Artificial Intelligence | Alice   | [artificial intelligence]                 |
| Blockchain Basics                   | Bob     | [blockchain, artificial intelligence]     |
| Sustainability in Business          | Charlie | [artificial intelligence, sustainability] |
| Future of Quantum Computing         | Diane   | [quantum computing]                       |
| Data Privacy and Security           | Eric    | [data privacy]                            |
| Machine Learning 101                | Fiona   | [artificial intelligence]                 |
| AI Ethics and Impact                | Grace   | [artificial intelligence]                 |
| Green Tech Innovations              | Henry   | [sustainability]                          |
| Distributed Ledger Technologies     | Ian     | [blockchain]                              |
| Effective Team Communication        | Julia   | [NULL]                                    |
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead zap</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
└── sessions-by-themes
    ├── input
    │   └── sessions-db
    │       └── sessions.db
    ├── output
    │   └── sessions_with_themes.csv
    ├── run.sh
    └── temp
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-73 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-by-themes_20250910T150800908254+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">uvx --from csvkit csvlook output/sessions_with_themes.csv</span>
<span class="output">| title                               | speaker | matched_themes                            |
| ----------------------------------- | ------- | ----------------------------------------- |
| Advances in Artificial Intelligence | Alice   | [artificial intelligence]                 |
| Blockchain Basics                   | Bob     | [blockchain, artificial intelligence]     |
| Sustainability in Business          | Charlie | [artificial intelligence, sustainability] |
| Future of Quantum Computing         | Diane   | [quantum computing]                       |
| Data Privacy and Security           | Eric    | [data privacy]                            |
| Machine Learning 101                | Fiona   | [artificial intelligence]                 |
| AI Ethics and Impact                | Grace   | [artificial intelligence]                 |
| Green Tech Innovations              | Henry   | [sustainability]                          |
| Distributed Ledger Technologies     | Ian     | [blockchain]                              |
| Effective Team Communication        | Julia   | [NULL]                                    |
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions-by-themes
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-74 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-by-themes_20250910T150800908254+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">uvx --from csvkit csvlook output/sessions_with_themes.csv</span>
<span class="output">| title                               | speaker | matched_themes                            |
| ----------------------------------- | ------- | ----------------------------------------- |
| Advances in Artificial Intelligence | Alice   | [artificial intelligence]                 |
| Blockchain Basics                   | Bob     | [blockchain, artificial intelligence]     |
| Sustainability in Business          | Charlie | [artificial intelligence, sustainability] |
| Future of Quantum Computing         | Diane   | [quantum computing]                       |
| Data Privacy and Security           | Eric    | [data privacy]                            |
| Machine Learning 101                | Fiona   | [artificial intelligence]                 |
| AI Ethics and Impact                | Grace   | [artificial intelligence]                 |
| Green Tech Innovations              | Henry   | [sustainability]                          |
| Distributed Ledger Technologies     | Ian     | [blockchain]                              |
| Effective Team Communication        | Julia   | [NULL]                                    |
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions-by-themes
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cd ..</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-75 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">bead new sessions-by-themes</span>
<span class="output">Created &quot;sessions-by-themes&quot;
</span><span class="prompt">/demo/workspace $ </span><span class="command">cd sessions-by-themes</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead input add sessions-db</span>
<span class="output">Verifying archive /demo/bead-box/sessions-db_20250910T150600233519+0000.zip ... OK
Loading new data to sessions-db ... Done
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cat &gt; run.sh &lt;&lt;EOF
duckdb -readonly input/sessions-db/sessions.db &quot;
COPY (
  SELECT
    s.title,
    s.speaker,
    LIST(DISTINCT a.canonical_theme) AS matched_themes
  FROM sessions s
  LEFT JOIN theme_aliases a
    ON LOWER(s.title) LIKE &#x27;%&#x27; || LOWER(a.alias) || &#x27;%&#x27;
  GROUP BY s.title, s.speaker
  ORDER BY s.speaker
) TO &#x27;output/sessions_with_themes.csv&#x27; (HEADER, DELIMITER &#x27;,&#x27;);
&quot;
EOF</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bash run.sh</span>
<span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead save</span>
<span class="output">Successfully stored bead at /demo/bead-box/sessions-by-themes_20250910T150800908254+0000.zip.
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">uvx --from csvkit csvlook output/sessions_with_themes.csv</span>
<span class="output">| title                               | speaker | matched_themes                            |
| ----------------------------------- | ------- | ----------------------------------------- |
| Advances in Artificial Intelligence | Alice   | [artificial intelligence]                 |
| Blockchain Basics                   | Bob     | [blockchain, artificial intelligence]     |
| Sustainability in Business          | Charlie | [artificial intelligence, sustainability] |
| Future of Quantum Computing         | Diane   | [quantum computing]                       |
| Data Privacy and Security           | Eric    | [data privacy]                            |
| Machine Learning 101                | Fiona   | [artificial intelligence]                 |
| AI Ethics and Impact                | Grace   | [artificial intelligence]                 |
| Green Tech Innovations              | Henry   | [sustainability]                          |
| Distributed Ledger Technologies     | Ian     | [blockchain]                              |
| Effective Team Communication        | Julia   | [NULL]                                    |
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">bead zap</span>
<span class="output">Deleted workspace /demo/workspace/sessions-by-themes
</span><span class="prompt">/demo/workspace/sessions-by-themes $ </span><span class="command">cd ..</span>
<span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
# TODOs

-   bead develop
    -   bead input load
-   bead input update
-   ?

# internal details

###  {#section-76 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-77 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">unzip -v /demo/bead-box/sessions-by-themes_*.zip | tail -9</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-78 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">unzip -v /demo/bead-box/sessions-by-themes_*.zip | tail -9</span>
<span class="output">
 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
--------  ------  ------- ---- ---------- ----- --------  ----
     581  Defl:N      316  46% 2025-08-26 22:28 b8d3bb3c  data/sessions_with_themes.csv
     367  Defl:N      244  34% 2025-08-26 22:28 beb2de14  code/run.sh
     602  Defl:N      341  43% 2025-09-10 15:08 98553a61  meta/bead
     471  Defl:N      301  36% 2025-09-10 15:08 24c62594  meta/manifest
--------          -------  ---                            -------
    2021             1202  41%                            4 files
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-79 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">unzip -v /demo/bead-box/sessions-by-themes_*.zip | tail -9</span>
<span class="output">
 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
--------  ------  ------- ---- ---------- ----- --------  ----
     581  Defl:N      316  46% 2025-08-26 22:28 b8d3bb3c  data/sessions_with_themes.csv
     367  Defl:N      244  34% 2025-08-26 22:28 beb2de14  code/run.sh
     602  Defl:N      341  43% 2025-09-10 15:08 98553a61  meta/bead
     471  Defl:N      301  36% 2025-09-10 15:08 24c62594  meta/manifest
--------          -------  ---                            -------
    2021             1202  41%                            4 files
</span><span class="prompt">/demo/workspace $ </span><span class="command">unzip -p /demo/bead-box/sessions-by-themes_*.zip meta/bead</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-80 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">unzip -v /demo/bead-box/sessions-by-themes_*.zip | tail -9</span>
<span class="output">
 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
--------  ------  ------- ---- ---------- ----- --------  ----
     581  Defl:N      316  46% 2025-08-26 22:28 b8d3bb3c  data/sessions_with_themes.csv
     367  Defl:N      244  34% 2025-08-26 22:28 beb2de14  code/run.sh
     602  Defl:N      341  43% 2025-09-10 15:08 98553a61  meta/bead
     471  Defl:N      301  36% 2025-09-10 15:08 24c62594  meta/manifest
--------          -------  ---                            -------
    2021             1202  41%                            4 files
</span><span class="prompt">/demo/workspace $ </span><span class="command">unzip -p /demo/bead-box/sessions-by-themes_*.zip meta/bead</span>
<span class="output">{
    &quot;freeze_name&quot;: &quot;sessions-by-themes&quot;,
    &quot;freeze_time&quot;: &quot;20250910T150800908254+0000&quot;,
    &quot;inputs&quot;: {
        &quot;sessions-db&quot;: {
            &quot;content_id&quot;: &quot;f05f04ceedb53f3fe4bd8f75f8c100fac691feddefff710e0a42786c193d39c1ebcb6c8ea6afe736ef5ba7677b9a9b5d10a69c78945b90782e20a267e0310aed&quot;,
            &quot;freeze_time&quot;: &quot;20250910T150600233519+0000&quot;,
            &quot;kind&quot;: &quot;ecdff661be5a5211546fc0a64a0e6197-f10b02dd-a5df-4ecd-a5de-d28a17f5ce11&quot;
        }
    },
    &quot;kind&quot;: &quot;c34bb3e5eb6f3a6cd27d784fa70100f3-fccc4f1d-e16a-4cdd-9aa0-2fe33c18aa2c&quot;,
    &quot;meta_version&quot;: &quot;aaa947a6-1f7a-11e6-ba3a-0021cc73492e&quot;
}
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-81 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">unzip -v /demo/bead-box/sessions-by-themes_*.zip | tail -9</span>
<span class="output">
 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
--------  ------  ------- ---- ---------- ----- --------  ----
     581  Defl:N      316  46% 2025-08-26 22:28 b8d3bb3c  data/sessions_with_themes.csv
     367  Defl:N      244  34% 2025-08-26 22:28 beb2de14  code/run.sh
     602  Defl:N      341  43% 2025-09-10 15:08 98553a61  meta/bead
     471  Defl:N      301  36% 2025-09-10 15:08 24c62594  meta/manifest
--------          -------  ---                            -------
    2021             1202  41%                            4 files
</span><span class="prompt">/demo/workspace $ </span><span class="command">unzip -p /demo/bead-box/sessions-by-themes_*.zip meta/bead</span>
<span class="output">{
    &quot;freeze_name&quot;: &quot;sessions-by-themes&quot;,
    &quot;freeze_time&quot;: &quot;20250910T150800908254+0000&quot;,
    &quot;inputs&quot;: {
        &quot;sessions-db&quot;: {
            &quot;content_id&quot;: &quot;f05f04ceedb53f3fe4bd8f75f8c100fac691feddefff710e0a42786c193d39c1ebcb6c8ea6afe736ef5ba7677b9a9b5d10a69c78945b90782e20a267e0310aed&quot;,
            &quot;freeze_time&quot;: &quot;20250910T150600233519+0000&quot;,
            &quot;kind&quot;: &quot;ecdff661be5a5211546fc0a64a0e6197-f10b02dd-a5df-4ecd-a5de-d28a17f5ce11&quot;
        }
    },
    &quot;kind&quot;: &quot;c34bb3e5eb6f3a6cd27d784fa70100f3-fccc4f1d-e16a-4cdd-9aa0-2fe33c18aa2c&quot;,
    &quot;meta_version&quot;: &quot;aaa947a6-1f7a-11e6-ba3a-0021cc73492e&quot;
}
</span><span class="prompt">/demo/workspace $ </span><span class="command">unzip -p /demo/bead-box/sessions-by-themes_*.zip data/* | uvx --from csvkit csvlook -</span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
###  {#section-82 .top}

```{=html}
<div class="top-bottom-layout">
  <div class="top-content">
<div class="terminal"><span class="prompt">/demo/workspace $ </span><span class="command">unzip -v /demo/bead-box/sessions-by-themes_*.zip | tail -9</span>
<span class="output">
 Length   Method    Size  Cmpr    Date    Time   CRC-32   Name
--------  ------  ------- ---- ---------- ----- --------  ----
     581  Defl:N      316  46% 2025-08-26 22:28 b8d3bb3c  data/sessions_with_themes.csv
     367  Defl:N      244  34% 2025-08-26 22:28 beb2de14  code/run.sh
     602  Defl:N      341  43% 2025-09-10 15:08 98553a61  meta/bead
     471  Defl:N      301  36% 2025-09-10 15:08 24c62594  meta/manifest
--------          -------  ---                            -------
    2021             1202  41%                            4 files
</span><span class="prompt">/demo/workspace $ </span><span class="command">unzip -p /demo/bead-box/sessions-by-themes_*.zip meta/bead</span>
<span class="output">{
    &quot;freeze_name&quot;: &quot;sessions-by-themes&quot;,
    &quot;freeze_time&quot;: &quot;20250910T150800908254+0000&quot;,
    &quot;inputs&quot;: {
        &quot;sessions-db&quot;: {
            &quot;content_id&quot;: &quot;f05f04ceedb53f3fe4bd8f75f8c100fac691feddefff710e0a42786c193d39c1ebcb6c8ea6afe736ef5ba7677b9a9b5d10a69c78945b90782e20a267e0310aed&quot;,
            &quot;freeze_time&quot;: &quot;20250910T150600233519+0000&quot;,
            &quot;kind&quot;: &quot;ecdff661be5a5211546fc0a64a0e6197-f10b02dd-a5df-4ecd-a5de-d28a17f5ce11&quot;
        }
    },
    &quot;kind&quot;: &quot;c34bb3e5eb6f3a6cd27d784fa70100f3-fccc4f1d-e16a-4cdd-9aa0-2fe33c18aa2c&quot;,
    &quot;meta_version&quot;: &quot;aaa947a6-1f7a-11e6-ba3a-0021cc73492e&quot;
}
</span><span class="prompt">/demo/workspace $ </span><span class="command">unzip -p /demo/bead-box/sessions-by-themes_*.zip data/* | uvx --from csvkit csvlook -</span>
<span class="output">| title                               | speaker | matched_themes                            |
| ----------------------------------- | ------- | ----------------------------------------- |
| Advances in Artificial Intelligence | Alice   | [artificial intelligence]                 |
| Blockchain Basics                   | Bob     | [blockchain, artificial intelligence]     |
| Sustainability in Business          | Charlie | [artificial intelligence, sustainability] |
| Future of Quantum Computing         | Diane   | [quantum computing]                       |
| Data Privacy and Security           | Eric    | [data privacy]                            |
| Machine Learning 101                | Fiona   | [artificial intelligence]                 |
| AI Ethics and Impact                | Grace   | [artificial intelligence]                 |
| Green Tech Innovations              | Henry   | [sustainability]                          |
| Distributed Ledger Technologies     | Ian     | [blockchain]                              |
| Effective Team Communication        | Julia   | [NULL]                                    |
</span><span class="prompt">/demo/workspace $ </span><span class="cursor"></span></div>
  </div>

  <div class="bottom-content">
    <div class="bottom-left">
<pre>
/demo/workspace
</pre>
    </div>
    <div class="bottom-right">
<pre>
/demo/bead-box
├── sessions-by-themes_20250910T150800908254+0000.zip
├── sessions-db_20250910T150600233519+0000.zip
├── sessions_20250910T150220894148+0000.zip
└── theme-aliases_20250910T150340396167+0000.zip
</pre>
    </div>
  </div>
</div>
```
## How bead Solves Our Problems

  Problem                     bead Solution
  --------------------------- ------------------------------------
  "What data did we use?"     Every bead remembers exact version
  "It worked on my machine"   Exact same setup for everyone
  "That person left"          Work stays reproducible
  Team uses different tools   Language agnostic
  Complex pipelines           Chain beads together

## Real Research Example

-   Multiple datasets connected
-   Many cleaning steps
-   Green = using latest data version
-   Some steps outdated
-   bead tracks entire dependency graph

## bead in Practice

### Step 1: Create workspace

``` bash
bead new health-analysis
```

### Step 2: Load inputs

``` bash
bead input add wdi-data
bead input add health-metrics
```

### Step 3: Run analysis

``` bash
python clean_data.py
R --file=analyze.R
```

### Step 4: Save snapshot

``` bash
bead save figure1-v2
```

## Why bead is Different

-   **Simple**: 4 commands to learn
-   **Universal**: Any language, any tool
-   **Portable**: Just ZIP files
-   **Secure**: Data stays on your servers
-   **Transparent**: Open source, no vendor lock-in

## For Research Software Engineers

-   Minimal learning curve for researchers
-   No infrastructure requirements
-   Works with existing workflows
-   Complements version control
-   Enables true reproducibility

## Get Started

### Installation

``` bash
pip install bead
```

## Key Takeaways

1.  **Data provenance is hard** - especially with changing teams
2.  **Existing tools too complex** - for heterogeneous research teams\
3.  **bead keeps it simple** - focuses on one thing well
4.  **Reproducibility becomes automatic** - not an afterthought

### Contact and Acknowledgements

-   Web: [bead.zip](https://bead.zip)
-   GitHub:
    [github.com/e3krisztian/bead](https://github.com/e3krisztian/bead)

![](images/erc-logo.png){width="20%"}

This project has received funding from the European Research Council
(ERC) under the European Union's Horizon 2020 research and innovation
programme (grant agreement No 313164). The views expressed are those of
the authors and do not necessarily reflect those of the ERC or the
European Commission.

## References

-   **World Development Indicators**:
    [data.worldbank.org/indicator](https://data.worldbank.org/indicator)
-   **DVC (Data Version Control)**: [dvc.org](https://dvc.org)
-   **Apache Airflow**: [airflow.apache.org](https://airflow.apache.org)
-   **dbt**: [getdbt.com](https://www.getdbt.com)
-   **KNIME**: [knime.com](https://knime.com)

## 📌 Funny AI Note

-   If no themes match, the list is empty (`[]`), not null.
