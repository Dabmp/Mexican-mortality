# -----------------------------------------------------------------------------------------
# 1. Récupérer l'état du distant
git fetch origin

# 2. Voir la divergence
git log --oneline --graph --all -10

# 3. Rebaser mes modifications sur le main distant
git pull --rebase origin main
# (ou : git rebase origin/main)

# 4. Résoudre les éventuels conflits, puis :
git add -A
git rebase --continue

# 5. Pousser
git push origin main
git log --oneline -3 origin/main
ls README.md CONTRIBUTING.md data/README.md

git pull

# quarto render pour régénérer un docs/ sans code, et vous recommittez docs/.
# -----------------------------------data------------------------------------------------------
# Et les fichiers de output
cp "H:/Mon Drive/Broni/Projet R Mortality/Output/20260519 Profils par cause/deces.rda" data/
  cp "H:/Mon Drive/Broni/Projet R Mortality/Output/20260519 Profils par cause/deces.rds" data/

# -----------------------------------------------------------------------------------------
  # 1. Commitez vos .qmd locaux dans une branche de sauvegarde
  git stash

# 2. Pull
git pull origin main

# 3. Récupérez vos .qmd (le stash les restaurera)
git stash pop

# -----------------------------------------------------------------------------------------
# 1. Sauvegarder vos .qmd
mv ES /tmp/es-backup && mv EN /tmp/en-backup

# 2. Pull
git pull origin main

# 3. Restaurer vos .qmd dans les nouveaux dossiers minuscules
mkdir -p es en
cp /tmp/es-backup/*.qmd es/
  cp /tmp/en-backup/*.qmd en/
  
  # 4. Rendre
  quarto render
# -----------------------------------------------------------------------------------------
# Important pour vos futurs pushes
# Quand vous ferez quarto render puis git add -A && git push, vérifiez que les .qmd ne sont pas inclus :
  
  # Avant de committer, vérifiez
  git status

# Si vous voyez es/*.qmd ou en/*.qmd en "staged", ne les ajoutez pas :
git reset es en index.qmd

# Committez seulement docs/
git add docs/
  git commit -m "docs: update rendered site"
git push origin main