using CiteDown
using CommonMark
using Test

@testset "Test extracting YAML header from string" begin

    src = """
---
ict: "http://www.homermultitext.org/ict2/?"
iiif: 
    service: "http://www.homermultitext.org/iipsrv"
    path: "/project/homer/pyramidal/deepzoom"
---
    
Text body follows
"""
    yaml = CiteDown.settings(split(src, "\n"))
    @test yaml isa CiteDown.Settings
    @test yaml.ict == "http://www.homermultitext.org/ict2/?"
end