# CiteDown.jl

Use URNs in markdown links.  The current version supports citing images by URN and using a [citable image service](https://cite-architecture.github.io/CitableImage.jl/stable/) to resolve URNs to image data.


## Quick example

### Write markdown like this

```
---
ict: "http://www.homermultitext.org/ict2/?"  
iiif:
    service: "http://www.homermultitext.org/iipsrv"
    path: "/project/homer/pyramidal/deepzoom"
maxheight: 500
---

Highlighted title:

 ![title](urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1639,0.1667,0.4738,0.04948) 
```


### Generate markdown like this

Use the `rewrite` function to generate markdown with embedded images.Configuring the `ict` setting means that the displayed image will also be linked to an interactive image browser.

```
Highlighted title:

[![Rewrittten link to title](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA001RN_0002.tif/pct:16.39,16.67,47.38,4.948/500,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1639,0.1667,0.4738,0.04948)
```


### What you get

In a markdown environment like a github repository's README, that produces something like the following, with the embedded image linked to an external image browser.

> Highlighted title:
>
> [![Rewrittten link to title](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA001RN_0002.tif/pct:16.39,16.67,47.38,4.948/500,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1639,0.1667,0.4738,0.04948)


## Setting up a command-line script

Create a file with the following contents:
       
```julia
using CiteDown
for f in ARGS
	 print(rewrite(f))
end
```

Then define an alias for your shell that invokes julia with options to optimize startup time.  If you created the file in `/usr/local/bin/citedown.jl` and are using `bash` or `zs` for your shell, define an alias like this:



    alias citedown="julia -O0 --compile=min --startup=no /usr/local/bin/citedown.jl"
 
You can then use the simple `citedown` alias from the command line. Redirect its output to create a new markdown file with URNs replaced by URLs:
 
    citedown FILE.md > NEWFILE.md
 