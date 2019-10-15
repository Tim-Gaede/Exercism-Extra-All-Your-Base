using Test

include("all_your_base.jl")


# Tests adapted from `problem-specifications//canonical-data.json` @ v2.3.0



@testset "single bit to one decimal" begin
    @test rebase(2, [1], 10) == [1]
end

@testset "binary to single decimal" begin
    @test rebase(2, [1, 0, 1], 10) == [5]
end

@testset "single decimal to binary" begin
    @test rebase(10, [5], 2) == [1, 0, 1]
end

@testset "binary to multiple decimal" begin
    @test rebase(2, [1, 0, 1, 0, 1, 0], 10) == [4, 2]
end

@testset "decimal to binary" begin
    @test rebase(10, [4, 2], 2) == [1, 0, 1, 0, 1, 0]
end

@testset "trinary to hexadecimal" begin
    @test rebase(3, [1, 1, 2, 0], 16) == [2, 10]
end

@testset "hexadecimal to trinary" begin
    @test rebase(16, [2, 10], 3) == [1, 1, 2, 0]
end

@testset "15 bit integer" begin
    @test rebase(97, [3, 46, 60], 73) == [6, 10, 45]
end

@testset "empty list" begin
    @test rebase(2, [], 10) == []
end

@testset "single zero" begin
    @test rebase(10, [0], 2) == []
end

@testset "multiple zeroes" begin
    @test rebase(10, [0, 0, 0], 2) == []
end

@testset "leading zeros" begin
    @test rebase(7, [0, 6, 0], 10) == [4, 2]
end

@testset "input base is one" begin
    @test_throws DomainError rebase(1, [0], 10)
end

@testset "input base is zero" begin
    @test_throws DomainError rebase(0, [], 10)
end

@testset "input base is negative" begin
    @test_throws DomainError rebase(-2, [1], 10)
end

@testset "negative digit" begin
    @test_throws DomainError rebase(2, [1, -1, 1, 0, 1, 0], 10)
end

@testset "invalid positive digit" begin
    @test_throws DomainError rebase(2, [1, 2, 1, 0, 1, 0], 10)
end

@testset "output base is one" begin
    @test_throws DomainError rebase(2, [1, 0, 1, 0, 1, 0], 1)
end

@testset "output base is zero" begin
    @test_throws DomainError rebase(10, [7], 0)
end

@testset "output base is negative" begin
    @test_throws DomainError rebase(2, [1], -7)
end

@testset "both bases are negative" begin
    @test_throws DomainError rebase(-2, [1], -7)
end
