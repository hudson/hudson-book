#!/bin/bash

rm -rf target
mkdir -p target/images
mkdir -p target/figs

# Convert the images
cd content/figs/
./convert.sh
cd ../..

# Build the Single HTML Page Version
asciidoc -o target/book-hudson.html content/book-hudson.doc


# Build the PDF
rm -rf target/images
rm -rf target/figs
cp -r content/figs target
cp -r content/images target
#a2x -v -k -fpdf -dbook --dblatex-opts=" -P latex.output.revhistory=0" -D target content/book-hudson.doc

# Build the Chunked HTML
#a2x -v -k -fchunked -dbook --dblatex-opts=" -P latex.output.revhistory=0" -D target content/book-hudson.doc