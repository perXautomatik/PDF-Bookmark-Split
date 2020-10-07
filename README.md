# PDF-Bookmark-Split
Simple powershell script to split pdfs into separate files where sorted repeated bookmarks are joined together and exported as a single file, renaming the files according to the bookmarks name

the script is uploaded as is, no warranty obeusly, and no credit to me as most brunt work is done in the netlibrary 
This is a powershell + net dll turned into a binary for easer use att my workplace, the program used to make this conversion is included in this build (in accordance with Fatih Kodak's aproval, see the file license.txt)

the functionallity that was required for this binary was as such;

portable, no configuration on usercomputer
  onDrop functionallity 
  no input required
  output same folder as input file
  expect duplicate bookmarks 
  
TODO:
    sort bookmarks before exporting, in case input file is not already sorted.
