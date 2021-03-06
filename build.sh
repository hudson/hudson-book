#!/bin/bash

#fail the script if anything invoked command/script fails
set -e

rm -rf target
rm -rf the-hudson-book # in case it stuck around from a build failure
mkdir -p target/images
mkdir -p target/figs

# Convert the images
echo "--- Converting images - Started ---"
cd content/figs/
./convert.sh
cd ../..
echo "--- Converting images - Finished ---"

# Build the Single HTML Page Version
echo "--- Building single HTML page version - Started ---"
asciidoc -o target/book-hudson.html content/book-hudson.doc
echo "--- Building single HTML page version - Finished ---"

# Build the PDF
rm -rf target/images
rm -rf target/figs
cp -r content/figs target
cp -r content/images target

echo "--- Building PDF version - Started ---"
a2x --no-xmllint -v -k -fpdf -dbook --xsl-file=docbook-xsl/fo.xsl --dblatex-opts=" -P latex.output.revhistory=0 -s ./latex/custom-docbook.sty" -D target content/book-hudson.doc
# this is a hack until Tim tells me how it is supposed to work.. 
#pdftk pdf/resources/hudson-book-cover.pdf pdf/resources/title-page.pdf pdf/resources/blank-page.pdf target/book-hudson.pdf cat output target/tmp.pdf

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=target/tmp.pdf pdf/resources/hudson-book-cover.pdf pdf/resources/title-page.pdf pdf/resources/blank-page.pdf target/book-hudson.pdf
mv target/tmp.pdf target/book-hudson.pdf

echo "--- Building PDF version - Finished ---"

# Build the Chunked HTML
echo "--- Building chunked HTML version - Started ---"
a2x --no-xmllint -v -k -fchunked -dbook --dblatex-opts=" -P latex.output.revhistory=0" -D target content/book-hudson.doc
echo "--- Building chunked HTML page version - Finished ---"


echo "--- Building epub version - Started ---"
a2x --no-xmllint -v -k -fepub -dbook --dblatex-opts=" -P latex.output.revhistory=0" -D target content/book-hudson.doc

echo "--- Building PDF version - Finished ---"

echo "--- Putting site together - Started ---"
cp -rv site/* target
echo "--- Putting site together - Finished ---"

echo "--- Building download archive - Started ---"
mv target the-hudson-book
tar -czf the-hudson-book.tar.gz the-hudson-book
mv the-hudson-book target
mv the-hudson-book.tar.gz target/
echo "--- Building download archive - Finished ---"

echo "--- Build successful. --"
