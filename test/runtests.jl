using CondaBinDeps, Compat.Test, BinDeps

netcdf = library_dependency("netcdf", aliases = ["libnetcdf" "libnetcdf4"])
provides(CondaBinDeps.Manager, "libnetcdf", netcdf)
