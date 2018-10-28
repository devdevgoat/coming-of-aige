#!/bin/sh
#rename this file pre-commit (no file extension) and save it to the hidden folder .git/hooks in your git directory
#change this variable to change the output file name of the ebook
#chapter names will be named the same as the source markdown files
bookname="Coming_of_Aige"

#files expected in the root directory:
# git_root_directory
#  -EPUB
#  -NOTES
#  -COVER.png <the books cover image>
#  -metadata.yaml (http://pandoc.org/MANUAL.html#metadata-blocks)
#  -01_chaptername.md <chapter files, can be named anything but chapters will follow alpabetical order and have no spaces

#this section generates an epub version of the files that are being changed
#and saves it to an EPUB folder with the same name. Make sure git_dir/EPUB exists
#and that PANDOC is installed. The resulting epub file will also be commited 
#along with the changes.
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

#this section will convert then create a full ebook from all the .md files 
#in the git root directory. to maintain a README file in markdown, change
#the extention to all caps: readme.MD so that it won't get included in the book
# also change. 
filelist= git ls-files --exclude-standard --full-name "*.md" -x NOTES/ -x EPUB/ -x ALTERNATES/ |tr '\n' ' '
pandoc -s *.md metadata.yaml -o "EPUB/$bookname".epub --toc --toc-depth=1 --epub-cover-image=COVER.png
git add "EPUB/$bookname".epub