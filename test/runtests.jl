using CiteDown
using CommonMark
using Test

@testset "Test extracting YAML header from string" begin

    src = """
    ---
    ict: "http://www.homermultitext.org/ict2/?"
    iiif: 
        service: "http://www.homermultitext.org/iipsrv"
        path: "/project/homer/pyramidal/deepzoom
    ---
    
    Text body follows
"""
    yamlsrc = 
    @test_broken "Results" == "expected"
end