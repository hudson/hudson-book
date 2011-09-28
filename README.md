# Building the Book

To build this book, you will need:

  - aciidoc (and dependencies like pdftex, docbook and so on)
  - convert command from ImageMagick
  - bash
  
Note that this build has been tested on Ubuntu 11.04 and OSX 10.6. If
you want to use Windows you are on your own..

Run:

   ./build.sh

Outputs:

Single HTML File
target/book-hudson.html

PDF File
target/book-hudson.pdf

A bunch of HTML Files
target/book-hudson.chunked/index.html

# Installing Asciidoc and Prerequisites

First, you'll need to install Python 2.6.5.  If Python isn't available
in your platforms default package manager, you can always download a
version of Python from http://www.python.org

To build these books, you will need the latest version of asciidoc.
You can find comprehensive installation instructions here:
http://www.methods.co.nz/asciidoc/INSTALL.html

Asciidoc alone is sufficient to generate HTML versions of this books.
If you need to also generate PDF output, you will need to download
additional prerequisites necessary to run a2x and dblatex.  The
asciidoc site provides a list of required software here:
http://www.methods.co.nz/asciidoc/README.html

Note: The default version of asciidoc installed by apt-get on Ubuntu
10.04 isn't compatible with this build, you'll need to be using the
most recent version as of Summer 2011.

# Customizing the PDF Output

The PDF output is configured to produce output in the Crown Quartto format.  This is an EU format that approximates the size of a standard programming text.   At 7.444" x 9.681" is "feel" more like a tech book when compared to the standard 8.5" x 11" format.   This size was selected because Lulu's US Trade format is an unrealistic width (6") for a book that needs to present program listings.

To customize the PDF output, look at the LaTeX style in latex/custom-docbook.sty.   This style adds customizations to the built-in docbook style that ships with dblatex.   It alters the page width, height, as well as the headers.   LaTeX is very customizable, but you'll need to know your way around LaTeX to do anything worth doing.   If you've never used LaTeX before, give yourself some time to figure out the tool, it is cryptic.

# Notes for Authors

If you have access to this Github, you are likely working on book
content.  The following sections outline some of the mechanics and
guidelines used for this content.

## Filling Paragraphs

Paragraphs are filled to 70 characters.  This makes it easier to read,
correct, and work with the text of the book.

In Emacs, you can configure paragraph filling to be something that is
automatic (not recommended for highly technical content), or you can
just use M-q which will fill the current paragraph.

### Paragraphs and Lists in Asciidoc

To facilitate an easier approach to filling paragraphs, all Asciidoc
lists tend to leave a single blank line between list elements.  While
it is possible to configure the emacs variables "paragraph-start" and
"paragraph-separate" to address this issue, you should still leave a
single blank line between list elements to increase readability for
content authors.

In addition to a single space between list element, paragraphs are
indented with two spaces in a list element.

### Paragraphs and Variable Lists

When this material was in Docbook XML, the authors made heavy use of
variable lists to write long, sometimes one or two pages, for specific
varlistentry elements.  While this approach works in Docbook, it is
impossible to define program listings and examples that fall under a
varlistentry in Asciidoc as there is no real concept of defining
variable list boundaries beyond simple indentation.

In Asciidoc, avoid using variable lists with long sections, and also
make sure to use indentation for variable lists that contain
paragraphs of text.

## Spell Checking with ispell

One of the challenges with technical writing is that there are so many
technical terms in a given document it becomes challenging to keep
track of dictionary customizations that allow you to create typo-free
documents.  One of the reasons for this is that XmlMind provided an
example of how not to write a spell checker + the fact that XML wasn't
amenable to tools like ispell.

Well Asciidoc is very friendly for a spell-checking mechanism. Most of
the Modules files and classes are grouped into a single,
class-specific directory.  Each of these directories contains a
ispell.dict file which contains a dictionary for each document.  This
allows us to standardize on a list of technical terms in a document
and make sure that we're all ignoring terms like
"distributionManagement" in a coordinated approach.

In other words, we're pushing a shared dictionary of technical terms
into source control.

### Spell Checking in Emacs

All of the files should be preconfigured to point to an ispell.dict
file.  This configuration shows up at the end of the Asciidoc file in
a comment block.  Just fire up "ispell-buffer" and use the interactive
interface: "i" adds a custom term to the dictionary, "r" allows you to
alter the word manually, and there should be a list of keys at the top
of the screen providing quick replacement alternatives.

### Spell Checking in Vim

No idea.  I don't know anyone who uses vi.  Here's a web page:
http://www.vim.org/scripts/script.php?script_id=465

### Other Editors

The possibilities are limitless, but I'm not sure how to integrate
with other editors.  The ispell format is compatible with aspell as
well, and I'm sure almost any text editor worth using allows you to
point to a custom dictionary.

## Example Formatting and Indentation

Eventually, this material will be able to reference material that can
be compiled and tested as a part of the build.  In the meantime, the
authors are still copying examples and code directly into the
Asciidoc.  One challenge is formatting and indentation for Code
samples.

The following approach is used in Emacs to make sure that all code
examples are properly indented and formatted:

* Select a region that contains code to be indented.  Usually this is
  an example or a program listing.

* Narrow your buffer to contain just this code. (Note that narrowing
  your buffer is a bit risky, use this option with care.)

* Change to the appropriate mode for you code sample.  If you are
  dealing with an XML sample, use "xml-mode".  If you are working with
  Java, use "java-mode".

* With the region still selected, execute "indent-region".

In general, our code samples must fit within 80 characters to render
properly in a PDF.

