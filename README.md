---
title: My Custom Document Definition and Handlers
author: Adam Prescott
date: 2025-06-27T14:48:18-0300
keywords: readme file, doctype, document handling, organization, standards
version: 1.0
---

This directory holds the stylesheets and handlers for my new document format. 
It's part of my new standard, and will be used extensively. Keep the directory 
and its contents well guarded! 

# Rules

- All documents are XML from now on 
- The <?xml version="1.0" encoding="utf-8"?> header is omitted 
- All texts are hard-wrapped at 80ch 
- Generic elements will be used as much as possible, especially in metadata 
fields 
- XML indentation will be as human-readable as possible 
- Comments will be used to organize the text 
- Modularization will be done with &entity; 
- Inline Unicode symbols like dash, smart-quotes, etc. will be handled with a 
post-processor---they won't be inserted into the HTML, not even through 
entities, for readability 
- Documents will be divided between header (metadata) and body (content) 
- All document manipulation will be done with XSLT (except typographic 
post-processing to replace quotes and such) 
- Whatever can be done with `xsltproc`and `libxml2-utils`will be done, so that 
I won't need any extra tools 
- Documents will not have hard-coded DOCTYPE declaration---this will be used as 
parameter when processing the document itself 

