#Pkg.add("Plots")
#Pkg.add("DataFrames")

using Plots
using Queryverse
using ElectronDisplay
using Statistics

println("Hola mundo")

Plots.plot([1,2,3], [2,31,1])

df = DataFrame(Name = ["Jon","Bill","Maria","Julia","Mark"], 
               Age = [22,43,81,52,27],
               Salary = [30000,45000,60000,50000,55000]
               )

df |> @mutate(Age2 = _.Age + 1) |> 
    @mutate(Salary = _.Salary + 100) |> 
    @select(-:Name)

df = DataFrame(a=[1,1,2,3], b=[4,5,6,8], c=[10,11,12,13])

df2 = df |>
    @groupby(_.a) |> 
    @map({rows=_, avg=mean(_.b)}) |> 
    @mapmany(_.rows, {__..., _.avg}) |> DataFrame
    @filter(_.b > 5) |>
    @orderby_descending(_.b) |>
    DataFrame

df2 |> vscodedisplay

df2 |> electrondisplay

v = Voyager()
