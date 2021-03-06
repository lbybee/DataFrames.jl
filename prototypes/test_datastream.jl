module TestDataStream
    using Base.Test
    using DataArrays
    using DataFrames

    path = Pkg.dir("DataFrames",
                   "test",
                   "data",
                   "separators",
                   "sample_data.csv")

    ds = readstream(path, nrows = 1)
    n = start(ds)
    (df, n) = next(ds, n)
    @assert done(ds, n) == false
    (df, n) = next(ds, n)
    @assert done(ds, n) == false
    (df, n) = next(ds, n)
    @assert done(ds, n) == true

    path = Pkg.dir("DataFrames",
                   "test",
                   "data",
                   "scaling",
                   "10000rows.csv")

    ds = readstream(path, nrows = 100)
    n = start(ds)
    (df, n) = next(ds, n)
    @assert done(ds, n) == false

    ds = readstream(path, nrows = 5)

    for minibatch in ds
        @assert isa(minibatch, DataFrame)
    end

    # means = colmeans(ds)
    # @assert abs(means[1, 4] - (-0.005686449)) < 10e-4
    # @assert abs(means[1, 5] - 19.01197) < 10e-4

    # vars = colvars(ds)
    # @assert abs(vars[1, 4] - 0.98048) < 10e-4
    # @assert abs(vars[1, 5] - 0.989416) < 10e-4

    # (mins, maxs) = colranges(ds)
    # @assert abs(mins[1, 4] - (-4.33635)) < 10e-4
    # @assert abs(mins[1, 5] - 15.6219) < 10e-4
    # @assert abs(maxs[1, 4] - 3.86857) < 10e-4
    # @assert abs(maxs[1, 5] - 22.574) < 10e-4

    # covariances = cov(ds)
    # for i in 1:ncol(covariances)
    #     if isna(covariances[i, i])
    #         @assert isna(vars[1, i])
    #     else
    #         @assert abs(covariances[i, i] - vars[1, i]) < 10e-4
    #     end
    # end
    # @assert abs(covariances[4, 4] - 0.980479916) < 10e-4
    # @assert abs(covariances[4, 5] - 0.009823644) < 10e-4
    # @assert abs(covariances[5, 4] - 0.009823644) < 10e-4
    # @assert abs(covariances[5, 5] - 0.989415811) < 10e-4

    # correlations = cor(ds)
    # for i in ncol(correlations)
    #     for j in ncol(correlations)
    #         true_value = covariances[i, j] / sqrt(covariances[i, i] * covariances[j, j])
    #         if isna(true_value)
    #             @assert isna(correlations[i, j])
    #         else
    #             @assert abs(correlations[i, j] - true_value) < 10e-4
    #         end
    #     end
    # end

    # Deal with different delimiters
    path = Pkg.dir("DataFrames",
                   "test",
                   "data",
                   "separators",
                   "sample_data.csv")
    ds = readstream(path)
    for row in ds
        @assert size(row, 1) <= 1
    end

    path = Pkg.dir("DataFrames",
                   "test",
                   "data",
                   "separators",
                   "sample_data.tsv")
    ds = readstream(path)
    for row in ds
        @assert size(row, 1) <= 1
    end

    path = Pkg.dir("DataFrames",
                   "test",
                   "data",
                   "separators",
                   "sample_data.wsv")
    ds = readstream(path)
    for row in ds
        @assert size(row, 1) <= 1
    end

    # # DataFrame to DataStream conversion
    # df = DataFrame(A = 1:25)

    # ds = DataStream(df, 5)

    # for mini in ds
    #     @assert nrow(mini) <= 5
    # end

    # colmeans(ds)
end
