## 📐 Design
#:- Reproducibility
#:- Integrity
#:- Ease of use
#:- Local first
#:- Task scope
#:- Allow updates
#:  - input changes
#:  - code changes

## ⚡ Inspiration
#:- Data Journalism
#:- Human concept of story
#:  - Stories are composable
#:  - Helps us make sense of the world
#:- Project
#:- Publishing: ISBN / ISSN

## 🎬 Demo
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
: workspace
mkdir /demo/workspace
cd /demo/workspace
: box - storage for beads
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
bead new classifier
cd classifier
bead input add sessions
bead input add theme-aliases
cp -v /demo/files/run.sh .
nl run.sh
bash run.sh
csvlook output/classified_sessions.csv
cowsay -f hellokitty "Diana did not get a theme"
bead save
bead discard
cd ..
clear

: New version of theme-aliases bead.
bead edit theme-aliases --review
cd theme-aliases
cat /demo/files/more_theme_aliases.csv | tee -a output/theme_aliases.csv
: Diana - "Team Building Workshop"
bead save
bead discard
cd ..
clear

: Use the improved input to re-classify sessions
bead edit classifier
cd classifier
cat run.sh
bead status
bead input load
bead input update theme-aliases
bash run.sh
csvlook output/classified_sessions.csv
: ✨ Updated!
bead discard
cd ..
clear

: 🖼️ Visual Overview
rm /demo/bead-box/sessions*
bead box sync
bead web color svg session-themes.svg

## session-themes.svg
#:![](images/session-themes.svg)

: ⚙️ Internals
unzip -v /demo/bead-box/classifier_*.zip | tail -8
: end of demo

# 🧩 Similar ideas
#:+---------------------------------------------------------+--------------------------------------------:+
#:| - kaggle notebook                                       |                                             |
#:|   <https://www.kaggle.com/code>                         | ![](images/kaggle-notebook.svg){width=200}  |
#:+---------------------------------------------------------+---------------------------------------------+
#:| - nix flake                                             |                                             |
#:|   <https://nixos.wiki/wiki/Flakes#Flake_schema>         | ![](images/nix-flakes.svg){width=200}       |
#:+---------------------------------------------------------+---------------------------------------------+
#:| - orderly2 (RSECON24 talk)                              |                                             |
#:|   <https://youtu.be/lkPgihFQbrk>                        | ![](images/orderly2.svg){width=200}         |
#:+---------------------------------------------------------+---------------------------------------------+
#:: {.hover tbl-colwidths="[75,25]"}

# 🐙 Source
#::::: {.columns}
#:::: {.column width="70%"}
#:<br><br><br>
#:<https://github.com/e3krisztian/bead>
#::::
#:::: {.column width="30%"}
#:![](images/e3krisztian-bead.svg){width=300}
#::::
#:::::
