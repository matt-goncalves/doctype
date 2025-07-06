# DOCTYPE

This directory holds the stylesheets and handlers for my new document format. 
It's part of my new standard for articles, blog entries, journal entries, and
novels, and will be used extensively.

# Rules

- All documents are XML using a simple DTD
- The `<?xml version="1.0" encoding="utf-8"?>` instruction is omitted 
- All texts are hard-wrapped at 80ch 
- Generic elements will be used as much as possible, especially in metadata 
  fields 
- XML indentation will be as human-readable as possible 
- Comments will be used to organize the text 
- Modularization will be done with XInclude
- Documents will be divided between header (metadata) and body (content) 
- All document manipulation will be done with XSLT and XPath (using `xmllint`),
  automating as much as possible with Bash
- Whatever can be done with `xsltproc`and `libxml2-utils` will be done, so that 
  I won't need any extra tools 
- Documents will not have hard-coded DOCTYPE declaration---this will be used as 
  parameter when processing the document itself 

# Why

This system is meant for very long term text storage. I want to be able to
write, read, and parse my texts 30 years from now, as easily as I parse my
current ones. XML is the most stable technology for this purpose. I also want to
ensure my texts are easy to read and navigate from the shell---and XPath is an
excellent way of doing that.

I find XML easy to write by hand, and if properly indented, quite readable. I
also have more control than Markdown, in case I need to create a very specific,
custom converter for a specific set of archives.

# License

You can use and modify this system, including its DTDs and stylesheets, however
you want. It's public domain. Just import the `dochandle.sh` file into your
`bashrc` file to have access to the functions defined in `scripts/`, such as
`to-epub` and `to-md`.
