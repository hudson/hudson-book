To build this book, you will need:

  - Maven 3
  - An Internet Connection
  - ImageMagick - the Maven build shells out to "convert"
  
Note that this build has been tested on Ubuntu 10.04, 10.10 and OSX 10.6. The dependency on ImageMagick may cause
problems for people using Microsoft Windows.   If you are using Microsoft Windows, we recommend that you upgrade to a real operation system.

Run:

   mvn clean install

And you should see the PDF hudson-complete.pdf in hudson-pdf/target. The PDF file book-hudson.pdf contains the core
content of the book only, but does not yet have the cover sections added.