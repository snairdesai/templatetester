##################
### Julia Test ###
##################

# Load packages
import DataFrames
import CSV
import StatsPlots
using DataFrames
using GR
using CSV
using StatsPlots

# Load clean data as DataFrame
df=CSV.read("input/data_cleaned.csv", DataFrame)
df = dropmissing(df)

# Define function to plot data

function yearly_plot(df)
    # Group by year and sum chips
    df=combine(groupby(df, :year), [:chips_sold] .=> sum)
    
    # Divide chips sum by 10000000 to get in millions in DataFrame
    df[!, :chips_sold_sum] = df[!, :chips_sold_sum] ./ 1000000

    # Plot data
    @StatsPlots.df df StatsPlots.scatter(:year, :chips_sold_sum, colour = [:blue], legend=false, xlabel="Year", ylabel="Chips Sold (Millions)", title="Chips Sold by Year")

    # Save plot
    StatsPlots.savefig("output/julia_scatter.png")

end

# Call function
yearly_plot(df)

# Close gksqt plot backend program
run(`killall -9 gksqt`)