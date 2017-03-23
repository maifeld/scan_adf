# scan_adf
Scan from my Auto-Document Feeder with the command line

Call this on the command line, it will use 'scanimage' to operate the scanner, threshold and despeckle the image with 'convert' on the way to a PDF, then 'joinPDF' to take all the pages into one.  It names the file by the current date and time.
