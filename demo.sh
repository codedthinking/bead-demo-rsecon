## ⚡ Inspiration
#:- Data Journalism
#:- Human concept of story
#:  - Characters, setting, events, theme or message
#:  - Variable scope
#:  - Stories are composable
#:  - Helps us to make sense of the world

## 📐 Design
#:- ISBN / ISSN
#:  - Identification of books and series with code
#:- Task scope
#:- Local first
#:- Integrity

## 🎬 Demo
#:Conference session classification by title
#:
#:Inputs:
#:
#:- list of sessions
#:- session theme classification rules
#:
#:Output:
#:
#: - list of sessions extended with theme

## ⚙️ Setup
: workspace - where we work
mkdir /demo/workspace
cd /demo/workspace
: box - storage for beads
mkdir /demo/bead-box
bead box add demo /demo/bead-box
bead box list

## 📁 First bead
bead new sessions
cd sessions
cat > output/sessions.csv <<EOF
title,speaker
AI in Healthcare,Alice
Blockchain for Banking,Bob
Solar Panel Efficiency,Charlie
Team Building Workshop,Diana
EOF
bead save
bead discard
cd ..
: quick look into the created archive
unzip -p /demo/bead-box/sessions_*.zip data/* | csvlook -
## 📁 Second bead
bead new theme-aliases
cd theme-aliases
cat > output/theme_aliases.csv <<EOF
alias,canonical_theme
ai,artificial intelligence
blockchain,blockchain
solar,sustainability
EOF
bead save
bead discard
cd ..

## 🔗 Composition
bead new classifier
cd classifier
bead input add sessions
bead input add theme-aliases
cat > run.sh <<EOF
duckdb <<SQL
CREATE TABLE sessions AS SELECT * FROM 'input/sessions/sessions.csv';
CREATE TABLE aliases AS SELECT * FROM 'input/theme-aliases/theme_aliases.csv';

COPY (
  SELECT s.*, a.canonical_theme as theme
  FROM sessions s
  LEFT JOIN aliases a ON lower(s.title) LIKE '%' || lower(a.alias) || '%'
) TO 'output/classified_sessions.csv';
SQL
EOF
bash run.sh
bead save
csvlook output/classified_sessions.csv
bead discard
cd ..

## ✨ Automatic Updates
: Create an improved version of the theme-aliases bead.
bead edit theme-aliases --review
cd theme-aliases
cat >> output/theme_aliases.csv <<EOF
team,collaboration
workshop,collaboration
healthcare,healthcare
EOF
bead save
bead discard
cd ..
#:cls
: Use the improved input to re-classify
bead edit classifier
cd classifier
cat run.sh
bead input load
bead input update theme-aliases
bash run.sh
bead save
csvlook output/classified_sessions.csv
bead discard
cd ..

# 🖼️ Visual Wrap-up
rm /demo/bead-box/theme-aliases*
bead box sync
bead web png session-themes.png

#
#:![session-themes.png](images/session-themes.png)

# ⚙️ Internal Details
unzip -v /demo/bead-box/sessions_*.zip | tail -9
bead new internals
cd internals
bead input add classifier
cat .bead-meta/bead
bead discard

# 🧩 Similar ideas

#:- kaggle notebook
#:   - https://www.kaggle.com/code#:~:text=New,-Notebook
#:- nix flake
#:   - https://nixos.wiki/wiki/Flakes#Flake_schema
#:- orderly2 (RSECON24 talk)
#:   - https://youtu.be/lkPgihFQbrk


# 🐙 Source
#:<style>
#:#qrgithub {
#:  position: absolute;
#:  top: 0;
#:  right: 50%;
#:}
#:</style>
#:https://github.com/e3krisztian/bead {{< qrcode https://github.com/e3krisztian/bead qrgithub width=300 height=300 >}}
