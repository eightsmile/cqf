# ARCH

## 1. Some Facts

- Volatility is more likely to increase when the stock market falls, which is when leverage (D/E) increases.
- Volatility does depend on some macroeconomic variables.
- Volatility increases when the amount of relevant information per unit time increases.
- Volatility correlates with trading volume, but it is inappropriate to say that one variable causes the other.

## 2. The Family of ARCH

- AR - Autoregressive
- CH - Conditional Heteroskedastic

ARCH models are defined by **conditional density function**. A specific model is given by defining the: **(1) conditional mean, (2) conditional variance, and (3) shape of the density.**

## 3. GARCH(1,1) - the simplest credible example

$$r_t | r_{t-1},r_{t-2}... \sim N(\mu, h_t)$$

$$ h_t = \omega + \alpha (r_{t+1} - \mu)^2 + \beta \  h_{t-1} $$

- **conditional means** are constant and equal to $\mu$.
- **conditional densities** are all normal.
- ($h_t$ stands for heteroskedasticity. In other words, it is just the variance but varies over time)

### Parameter Vector, $\theta=(\mu, \omega, \alpha,\beta)$.

- To Ensure $h_t$ is positive, require: $\omega \geq 0, \alpha \geq0, \beta\geq0$.
- To Ensure a stationarity, require: $\alpha + \beta < 1$.

### For Daily return, typically we have:

- $\alpha$ is close to zero. Often, $\alpha < 0.1$.
- $\alpha + \beta$ is close to one. Often, $\alpha + \beta > 0.95$.

### Why $GARCH(1,1)$ is good (,with $\alpha + \beta < 1$ ) ? Because there are some facts of the GARCH model.

- Returns are kurtosis which exceeds 3, that fact is compatible with the stylised fact of return. Also may even be infinite. ($h_t$ is the squared of normal).
- Returns are uncorrelated, because  conditional mean does not depend on previous returns (previous returns are already in conditions!).
- The autocorrelations of squared excess returns, $s_t = (r_t - \mu)^2$, exist when the kurosis is finite and then they are all positive.
- $s_t = (r_t - \mu)^2$ for GARCH(1,1) have the same shape as those of an ARMA(1,1): $\rho_{\tau, s} = C (\alpha +\beta)^{\tau}$, $\tau >0$.

### Variance Forecasts

Let the information set be, $I_{t} = \{r_t, r_{t-1}, ...\}$.

The **condition variance** is then, 

$$\mathbb{Var}(r_t| I_{t-1})=h_t$$

$$\mathbb{Var}(r_{t+1}| I_{t-1})=V + (\alpha + \beta)^n(h_t-V)\quad n=1,2,..$$

, which depend on the unconditional variance, $V = \mathbb{Var}(r_t)=\frac{\omega}{1-\alpha -\beta}$.



## Why is index volatility Asymmetric?

Asymmetric effects are found in the U.S. indices throughout the 1990s,.  The magnitude of the effect is time-varying and it has become stronger in recent years.

The effects are weaker for individual firms than for indices. **Correlations between firm returns increases when the market falls**, which explains the higher index asymmetric.

## Parameter Estimation - for those ARCH Models

The parameters $\theta$ are obtained by selecting the values that are "most likely" for the observed data. The likelihood function is $L(\theta)$.

$$L(\theta) = f(r_1, r_2,...,r_n|\theta) $$

$$L(\theta) = f(r_1|\theta)f(r_2|I_1, \theta)...f(r_n|I_{n-1},\theta) $$

When the conditional densities are normal,

$$ r_t | I_{t-1},\theta \sim N\bigg(\mu_t(\theta),h_t(\theta)\bigg) $$

So, $f( r_t | I_{t-1},\theta) = \frac{1}{\sqrt{2\pi h_t(\theta)}}e^{-\frac{(r-\mu_t(\theta))^2}{2 h_t(\theta)}}$.

We then build the log-likelihood function, ( we let $z_t(\theta) = \frac{r_t - \mu_t(\theta)}{\sqrt{h_t(\theta)}}$ )

$$ logL(\theta) = \sum_i^n log(f_i) = -\frac{1}{2} \sum \bigg[  log(2\pi) + log(h_t(\theta)) + z_t^2(\theta)  \bigg]$$

## Hypothesis Testing

 We consider the normal distribution's family: t-distributions. There are three parameters of it, $V$, mean, variance, and degree of freedom. T-distribution is fat-tailed.

Let $\xi = 1/v$. The hypothesis is the following:

$H_0: \xi =0 \quad H_A:\xi >0$

To test the null:

- Estimate the model twice, based on the null and the alternative.
- Let $L_0$ and $L_1$ be the maximum values of log-likelihood function for the two hypotheses.
- Compare $2(L_1 - L_0)$ with the $\chi^2$. 

## Empirical Results

We found that based on the historical data:

- Volatility is not correlated with returns.
- Volatility shocks persist.
