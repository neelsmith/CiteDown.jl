# CiteDown.jl

## TL;DR

Write markdown text with links to citable content identified by URN; configure sources for retrieving citable content in a YAML header; resolve URN values to content referred to by URLs.


## What it is

Markdown is a light-weight, practical format for expressing the structure of textual content.  `Cite2Urn`s and `CtsUrn`s are technology-independent formats for identifying scholarly resources.  The CiteDown.jl package lets you identify linked content in markdown documents with URNs.  You can separately configure sources for resolving the URNs and linking to or embedding content cited by URN in a new, resolved markdown document.

In version `0.1.x`, the CiteDown package supports the use of `Cite2Urn`s to cite images.



## Citation of images in markdown

URNs may be used in *image references*, to embed an image in the document, or in *generic links*.  

Here's a markdown example of an image reference (image would be embedded on the page in markdown-aware applications):

```
The first page of the *Iliad*:  

![illustration](urn:cite2:hmt:vaimg.2017a:VA012RN_0013)
```


Here's a markdown example of a generic link (image would be treated as a hyperlink in markdown-aware applications):

```The first page of the *Iliad* is illustrated on 
[this page](urn:cite2:hmt:vaimg.2017a:VA012RN_0013)
```

Image URNs may include extended citation to identify a region of interest on the image, as in this markdown example:

```
A one-line summary of the first book appears in 
[this image](urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.1554,0.09733,0.3975,0.02652).  

Here it is embedded in the current page:

![detail](urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.1554,0.09733,0.3975,0.02652)
```

## Configuring a YAML header

Example:

```
---
ict: "http://www.homermultitext.org/ict2/?"  
iiif:
    service: "http://www.homermultitext.org/iipsrv"
    path: "/project/homer/pyramidal/deepzoom"
maxheight: 500
---
```

## Generating new markdown resolved to URL values

```@setup example
repository = pwd() |> dirname |> dirname
```

The `rewrite` function takes a file name, and composes a new markdown string.  Compare the source file with the rewritten version.

Source:

```@example example
mdfile = joinpath(repository, "test", "data", "img.md")
read(mdfile, String) |> print
```

Rewritten:

```@example example
using CiteDown
withurls = rewrite(mdfile) 
print(withurls)
```