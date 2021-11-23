# CiteDown.jl

Use URNs in markdown links.  The current version supports citing images by URN and using a [citable image service](https://cite-architecture.github.io/CitableImage.jl/stable/) to resolve URNs to image data.


## Quick example

Write markdown like this:

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


Generate markdown with embedded images.  Configuring the `ict` setting means that the displayed image will also be linked to an interactive image browser.

```
Highlighted title:

[![Rewrittten link to title](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA001RN_0002.tif/pct:16.39,16.67,47.38,4.948/500,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1639,0.1667,0.4738,0.04948)
```

[![Rewrittten link to title](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA001RN_0002.tif/pct:16.39,16.67,47.38,4.948/500,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1639,0.1667,0.4738,0.04948)


In a markdown environment like a github repository's README, that produces something like the following, with the embedded image linked to an external image browser.

> Highlighted title:
>
> [![Rewrittten link to title](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA001RN_0002.tif/pct:16.39,16.67,47.38,4.948/500,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.1639,0.1667,0.4738,0.04948)