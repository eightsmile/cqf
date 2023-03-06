# Stylised Facts

## Stylised Fact 1. The Distribution of Return is Not Normal

- 1. Fat Tail -  Extreme Values / Outliers
- 2. Approximately symmetric
- 3. High peak

Why don't we see a normal distribution of return?

- Volatility Clustering

We thus cannot say which distribution can best describe returns.

- Student-t dist, Generalised error, variance-gamma, might be used

## Stylised Fact 2. There almost No Correlation between Returns for Different Days

Sample Correlation, $\rho_{\tau} = corr(r_t, r_{t+\tau})$, for a stochastic process $\{r_t\}$.

$$ \hat{\rho}_{\tau} = \frac{\sum_{t=1}^{n-\tau} (r_t - \bar{r})(r_{t+\tau}-\bar{r}) }{\sum_{t=1}^n (r_t - \bar{r})^2} $$

One of the test for serial correlation, Box-Pierce test statistics,

$$Q_k = n\sum_{\tau=1}^k \hat{\rho}_\tau^2 = \sum_{\tau=1}^k z_{\tau^2} $$

$$Q_k \sim \chi_k^2$$

The Null Hypothesis is normally, $H_0:$ the series is i.i.d. 

## Stylised Fact 3. There is Positive Dependence between Absolute Returns on Nearby Days, likewise for Squared Returns.

<img src="/Users/mie/Desktop/Screenshot 2023-03-02 at 13.10.03.png" alt="Screenshot 2023-03-02 at 13.10.03" style="zoom: 25%;" />

See figure above. $Corr(r_t, r_{t+u})$ is fluctuating around '0', while $Corr(r^2_t, r^2_{t+u})$ and $Corr(|r_t|, |r_{t+u}|)$ is different from zero.

We reject the null hypothesis that absolute returns come from i.i.d. distributed.

Why is that?

- Volatility Clustering can explain.

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