# Properties of High-frequency Asset Returns

## Return Patterns

- **Stylised Fact 1:** Intraday returns are fat-tail distributed. Kurtosis increases as the frequency of price observations increases.
- **Stylised Fact 2:**Traded Assets are almost uncorrelated.
- **Stylised Fact 3:**There is substantial positive dependence among absolute value of returns.

##  Volatility Patterns

There are distinctive volatility patterns depending on:

- The time during the day,
- The day of weeks,
- Scheduled Macroeconomic News Announcements about Unemployment, Trade Balances, GNP, Inflation, Money Supply, etc.
- New in Different Regions of the world, time-zone matters.

## Realised Volatility

$$ \sigma_t = \sqrt{ \sum_{j=1}^N r_{t,j}^2 } $$

- **Stylised Fact 1:**The distribution of daily returns divided by realised volatility, i.e. $\frac{r_t}{\sigma_t}$ is approximately normal.
- **Stylised Fact 2:**The distribution, through time, of $\sigma_t$ is approximately lognormal.
- **Stylised Fact 3:**The autocorrelations of volatility (and its logarithm) decay slowly and resemble those of a 'long memory' process.