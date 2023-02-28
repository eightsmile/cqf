# Value at Risk - VaR

VaR is a probability statement about the potential change in the value of a portfolio.

## Notation

$$ Prob\bigg(\phi \leq \frac{VaR(X)-\mu}{\sigma}\bigg)=1-c $$

- $c$ - confidence interval, i.e. $c=99\%$. Then $1-c = 1\% $

- $\mu$ and $\sigma$ are for $X$. 

    - For Example, if $X$ is yearly return, 

        then $\mu_{252days}=252\cdot\mu_{1day}$, and $\sigma_{252days}=\sqrt{252}\cdot\sigma_{1day}$

- $X$ should be the **loss distribution**.

$$VaR(X) = \mu + \sigma\cdot \Phi^{-1}(1-c)$$

$$VaR(X) = \mu + \sigma\cdot z_{1-c}$$

- I.E.

​		If $c=99\%$, then $1-c=1\%$, so $z_{1-c}=z_{0.01} \approx -2.33$

​		$$VaR(X) = \mu - 2.33\cdot  \sigma$$		

**P.S.**

​	The unit of VaR is the amount of loss, so it should be monetary amount. For example, if the total amount of portfolio is USD 1 million, then $VaR = \$1m \cdot (\mu - 2.33\cdot \sigma)$.

## Loss Distribution

Remember $X$ is a distribution of loss. If we know the distribution of Portfolio Return $R$, $R\sim N(\mu, \sigma^2)$, then what is the dist for $X$?

$$X \sim N(-\mu, \sigma^2)$$

Right! Loss is just the **negative** return. Also, the volatility would not be affected by plus / minus.

# Expected Shortfall (ES)

Expected Shortfall states the Expected Loss during time T conditional on the loss being greater than the $c^{th}$ percentile of the loss distribution.

$$ ES_c (X) = \mathbb{E}\bigg[ X|X\leq VAR_c(X) \bigg] $$

- Be attention here, $X$ is a **r.v.**, while the only variable in the $ES_c(X)$ is $c$, **the confidence level**, instead of $X$.

Derivation, we 'sum up' (integrate) the VaR from $c$ to $1$, conditional on $1-c$.

$$ES_c(X) = \frac{1}{1-c} \int_c^1 VaR_u(X)du$$

$$ ES_c(X) = \frac{1}{1-c} \int_c^1 \bigg( \mu + \sigma\cdot \Phi^{-1}(1-u)  \bigg) du $$

$$ =\mu + \frac{\sigma}{1-c} \int^1_c   \Phi^{-1}(1-u)  du  $$

We let $u = \Phi(Z)$, where $Z \sim N(0,1)$. Then, 

- $du =d(\Phi(z)) =\phi(z) dz$.
- $u\in (c,1)$, so $z = \Phi^{-1}(u)\in (z_c \ , \infty)$

Thus, 

$$  ES_c(X)  =\mu + \frac{\sigma}{1-c} \int^{\infty}_{z_c}   \Phi^{-1}\big(1-\Phi(z)\big)\phi(z)  dz  $$

As $1-\Phi(z) = \Phi(-z)$

$$  ES_c(X)  =\mu + \frac{\sigma}{1-c} \int^{\infty}_{z_c}   \Phi^{-1}(\Phi(-z))\phi(z)  dz = \mu - \frac{\sigma}{1-c} \int^{\infty}_{z_c}    z\phi(z)  dz  $$

$ \int_{z_c}^{\infty} z \phi(z)dz = \int_{z_c}^{\infty} z \frac{1}{\sqrt{2\pi}}e^{\frac{z^2}{2}}dz  = \frac{1}{\sqrt{2\pi}} \int_{z_c}^{\infty} e^{\frac{z^2}{2}}d(e^{\frac{z^2}{2}})$