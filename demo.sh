### 📐 Design
#:- Integrity
#:- Ease of use
#:- Reproducibility

### ⚡ Inspiration
#:- Human concept of story
#:  - Stories are composable
#:  - Helps us make sense of the world
#:- Project
#:- Publishing: ISBN / ISSN

### 🎬 Demo
#:
#:Conference session classification by title
#:
#:- Inputs:
#:
#:  - list of sessions
#:  - session theme classification rules
#:
#:- Output:
#:
#:  - list of sessions extended with theme
#:

: ⚙️ Setup
: prepared files
tree /demo
: working directory
mkdir /demo/projects
cd /demo/projects
: box = storage for beads
mkdir /demo/bead-box
bead box add demo /demo/bead-box
bead box list
clear

: 📁 First bead
bead new sessions
cd sessions
cp -v /demo/files/sessions.csv output
csvlook output/sessions.csv
bead save
bead discard
cd ..
clear

: 📁 Second bead
bead new theme-aliases
cd theme-aliases
cp -v /demo/files/theme_aliases.csv output
csvlook output/theme_aliases.csv
bead save
bead discard
cd ..
clear

: 🔗 Computation
bead new possible-tracks
cd possible-tracks
bead input add sessions
bead input add theme-aliases
cp -v /demo/files/run.sh .
nl run.sh
bash run.sh
: No arguments: script, not a tool!
csvlook output/classified_sessions.csv
cowsay -f hellokitty "Diana did not get a theme assigned!"
bead save
bead discard
cd ..
clear

: New version of theme-aliases bead.
bead edit theme-aliases --review
cd theme-aliases
csvlook output/theme_aliases.csv
: Diana - "Team Building Workshop"
cat >> output/theme_aliases.csv <<EOF
team,collaboration
workshop,collaboration
healthcare,healthcare
EOF
csvlook output/theme_aliases.csv
bead save
bead discard
cd ..
clear

: Use the improved input to re-classify sessions
bead edit possible-tracks
cd possible-tracks
nl run.sh
bead status
bead input update theme-aliases
bead input load
bash run.sh
csvlook output/classified_sessions.csv
: ✨ Yay!
bead discard
cd ..
clear

: 🖼️ Visual Overview
rm /demo/bead-box/sessions*
bead box sync
bead web color svg session-themes.svg

### session-themes.svg
#:![](images/session-themes.svg)

: ⚙️ Internals
unzip -v /demo/bead-box/possible-tracks_*.zip | tail -8
: end of demo

### 🧩 Similar ideas
#:+:--------------------------------------------------------+------------------------------------------------------------:+
#:| - kaggle notebook                                       | ![](images/kaggle-notebook.svg){width=200px height=200px}   |
#:|   <https://www.kaggle.com/code>                         |                                                             |
#:+---------------------------------------------------------+-------------------------------------------------------------+
#:| - nix flake                                             | ![](images/nix-flakes.svg){width=200px height=200px}        |
#:|   <https://nixos.wiki/wiki/Flakes#Flake_schema>         |                                                             |
#:+---------------------------------------------------------+-------------------------------------------------------------+
#:: {.hover tbl-colwidths="[75,25]"}

### 🧩 Similar ideas2
#:+:---------------------------------------------------------------+------------------------------------------------------------:+
#:| - orderly2 (RSECON24 talk)                                     | ![](images/orderly2.svg){width=200px height=200px}          |
#:|   <https://youtu.be/lkPgihFQbrk>                               |                                                             |
#:+----------------------------------------------------------------+-------------------------------------------------------------+
#:| - orderly2 (Article)                                           | ![](images/orderly2-article.svg){width=200px height=200px}  |
#:|   <https://mrc-ide.github.io/orderly2/articles/orderly2.html>  |                                                             |
#:+----------------------------------------------------------------+-------------------------------------------------------------+
#:: {.hover tbl-colwidths="[75,25]"}

### 🐙 Source
#::::: {.columns}
#:::: {.column width="70%"}
#:<br><br><br>
#:<https://github.com/e3krisztian/bead>
#::::
#:::: {.column width="30%"}
#:![](images/e3krisztian-bead.svg){width=300px}
#::::
#:::::
