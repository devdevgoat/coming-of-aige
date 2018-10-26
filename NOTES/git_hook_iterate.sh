#!/bin/sh
#echo 'test'
#git update-server-info
#pandoc README.md -o README.html --standalone
#pandoc --standalone -o README.html README.md --template ./template.readme.html --title "`basename $(pwd)` :: README.md"
#rm README.md

bookname="Coming_of_Aige"

git diff --cached --name-only |  while read -r -d$'\n' file
do 
if [ ! -z "$file" ] 
# The last line would always be empty, but cond. above is an overkill anyway

then
 # Do something useful with "$line"
 filename="${file%.*}"
 pandoc "$filename".md metadata.yaml -o "EPUB/$filename".epub --toc --toc-depth=1 --epub-cover-image=COVER.png
 git add "EPUB/$filename".epub
fi
done

#compile full book epub
filelist= git ls-files --exclude-standard --full-name "COA_CH*.md" -x NOTES/ -x EPUB/ -x ALTERNATES/ |tr '\n' ' '
pandoc -s COA_CH*.md metadata.yaml -o "EPUB/$bookname".epub --toc --toc-depth=1 --epub-cover-image=COVER.png
git add "EPUB/$bookname".epub