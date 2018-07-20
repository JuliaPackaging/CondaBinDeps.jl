using CondaBinDeps, Compat.Test, BinDeps
import CondaBinDeps.Conda

# manager for test environment
testenv = :CondaBinDeps_test
TestManager = CondaBinDeps.EnvManager{testenv}

if "libuuid" in Conda._installed_packages(testenv)
    Conda.rm("libuuid", testenv)
end

# force installation by Conda
empty!(BinDeps.defaults)
push!(BinDeps.defaults, BinDeps.PackageManager)

@BinDeps.setup
libuuid = library_dependency("libuuid")
provides(TestManager, "libuuid", libuuid)
@BinDeps.install Dict(:libuuid => :libuuid_lib)

@test "libuuid" in Conda._installed_packages(testenv)

deps = joinpath(@__DIR__, "deps.jl")
@test isfile(deps)
include(deps)
@test isfile(libuuid_lib)

Conda.rm("libuuid", testenv)
