using CiteDown
using CommonMark
using Test

@testset "Test extracting YAML header from file" begin
    f = joinpath("data", "img.md")
    (yaml, md) = CiteDown.pageparts(f)

    cdsettings = CiteDown.settings(yaml)


    @test cdsettings isa CiteDown.Settings
    @test cdsettings.ict == "http://www.homermultitext.org/ict2/?"
end