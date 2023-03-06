# Value at Risk - VaR

VaR is a probability statement about the potential change in the value of a portfolio.

## Notation

$$Porb(x\leq VaR(X))= 1-c$$

$$ Prob\bigg(z \leq \frac{VaR(X)-\mu}{\sigma}\bigg)=1-c $$

- $c$ - confidence interval, i.e. $c=99\%$. Then $1-c = 1\% $

- $\mu$ and $\sigma$ are for $X$. 

    - For Example, if $X$ is yearly return, 

        then $\mu_{252days}=252\cdot\mu_{1day}$, and $\sigma_{252days}=\sqrt{252}\cdot\sigma_{1day}$

- $x$ here is the return. So, $c$ is the confidence interval, i.e. 99%. 

    - VaR focus on the tail risks. If $x$ stands for return, then tail risk is on the left tail, $z_{1-c}$.

- If $x$ is the loss, the tail risk is on the right tail. $z_c$

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

## Notation

$$ ES_c (X) = \mathbb{E}\bigg[ X|X\leq VAR_c(X) \bigg] $$

- Be attention here, $X$ is a **r.v.**, and $x$ stands for return here! while the only variable in the $ES_c(X)$ is $c$, **the confidence level**, instead of $X$.
- $c$ is the confidence level, i.e. $c$ = 99%.
- If $x$ stands for return, then the VaR is the left-tail, $z_{1-c}$.

$$ ES_c (X) = \mathbb{E}\bigg[ X|X\geq VAR_c(X) \bigg] $$

- If $x$ stands for loss (, which is the negative of return ), then the VaR is the right-tail, $z_{c}$.

## Derivation

### Notation Form

Consider, $x$ is the return, then  $ES_c (X) = \mathbb{E}\bigg[ X|X\leq VAR_c(X) \bigg] $, and $VaR_c(x)=  \mu + z_{1-c}\sigma$, where $c $ is the confidence level $c=99\%$ for example.

$$ES_c(X) = \frac{\int_{-\infty}^{VaR} xf(x)dx }{\int_{-\infty}^{VaR} f(x)dx  } = \frac{\int_{-\infty}^{VaR} x \phi(x)dx }{\int_{-\infty}^{VaR} \phi(x)dx  } =\frac{\int_{-\infty}^{VaR} x \phi(x)dx }{ \Phi(VaR) - \Phi(-\infty)} $$

$$=  \frac{1}{ \Phi(VaR) - \Phi(-\infty) }\int_{-\infty}^{VaR}x \frac{1}{\sqrt{2\pi \sigma^2}} e^{-\frac{(x-\mu)^2}{2\sigma^2}} dx $$

Replace $z = \frac{x-\mu}{\sigma}$, then $x = \mu + z \sigma$, and $dx = \sigma dz$

$$ = \frac{1}{\Phi(VaR)}  \int_{-\infty}^{VaR}(\mu + z\sigma) \frac{1}{\sqrt{2\pi \sigma^2}} e^{-\frac{z^2}{2}}\sigma dz $$

$$ = \frac{1}{\Phi(VaR)}\mu  \int_{-\infty}^{VaR}\frac{1}{\sqrt{2\pi }} e^{-\frac{z^2}{2}} dz + \sigma^2\int_{-\infty}^{VaR}  z \frac{1}{\sqrt{2\pi \sigma^2}} e^{-\frac{z^2}{2}} dz $$

$$ = \frac{1}{\Phi(VaR)}\mu \Phi(VaR) - \frac{\sigma^2}{\Phi(VaR)}\int_{-\infty}^{VaR}  \frac{1}{\sqrt{2\pi \sigma^2}} e^{-\frac{z^2}{2}} d(-\frac{z^2}{2}) $$

$$ = \mu - \frac{\sigma^2}{\Phi(VaR)}  \frac{1}{\sqrt{2\pi \sigma^2}} \int_{-\infty}^{VaR}  e^{-\frac{z^2}{2}} d(-\frac{z^2}{2}) $$

$$ = \mu - \frac{\sigma}{\Phi(VaR)}  \frac{1}{\sqrt{2\pi }}   e^{-\frac{z^2}{2}} |_{-\infty}^{VaR} $$

$$ = \mu - \frac{\sigma}{\Phi(VaR)}  \frac{1}{\sqrt{2\pi }}   e^{-\frac{VaR^2}{2}}= \mu - \frac{\sigma}{\Phi(VaR)}  \phi(VaR)$$

Recall, $VaR_c(x)=  \mu + z_{1-c}\sigma$, so $\phi(VaR_c(x))= \phi(\mu + z_{1-c}\sigma) \leftrightarrow \phi(z_{1-c}) = \phi\bigg( \Phi^{-1}(1-c) \bigg)$, and  $\Phi(VaR_c(x))= \Phi(\mu + z_{1-c}\sigma) \leftrightarrow \phi(z_{1-c}) = \Phi\bigg( \Phi^{-1}(1-c) \bigg) = 1-c$.

Thus,

$$ ES_c(X) =\mu - \frac{\sigma}{\Phi(VaR)}  \phi(VaR)=\mu -\sigma \frac{\phi\big( \Phi^{-1}(1-c) \big)}{1-c}$$

### VaR Form

we 'sum up' (integrate) the VaR from $c$ to $1$, conditional on $1-c$.

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

$ \int_{z_c}^{\infty} z \phi(z)dz = \int_{z_c}^{\infty} z \frac{1}{\sqrt{2\pi}}e^{-\frac{z^2}{2}}dz  = -\frac{1}{\sqrt{2\pi}} \int_{z_c}^{\infty} -e^{\frac{z^2}{2}}d(e^{-\frac{z^2}{2}})$

$=\frac{1}{\sqrt{2\pi}}e^{-\frac{z_c^2}{2}}=\phi(z_c)=\phi\big(\Phi^{-1}(c)\big)$, bring it back to $ES_c(X)$

$$ES_c(X) = \mu - \sigma\frac{ \phi\big(\Phi^{-1}(c)\big)}{1-c}$$

## Morden Portfolio Theory

- $x$ - vector weights
- $R$ - vector of all assets' returns
- $\mu = \mathbb{E}(R)$ - mean return of all assets
- $\Sigma = \mathbb{E}\bigg[ (R-\mu)(R-\mu)^T \bigg]$ - var-cov matrix of all assets

So,

- $\mu_x = x^T \mu$ - becomes a scalar now
- $\sigma^2 = x^T \Sigma x$ - collapse to be a scalar

### Optimisation

- Maximise Expected Return s.t. volatility constraint.

$$ \max_{x} \mu_x \quad s.t. \quad \sigma_x \leq \sigma^* $$

- Minimise Volatility s.t. return constraint.

$$ \min_{x} \sigma_x \quad s.t. \quad \mu_x \geq \mu^* $$

## Portfolio Risk Measures

By definition, the loss of a portfolio is the negative of return, $L(x) = -R(x)$.

The Loss distribution becomes the same normal distribution with x-axis reversed. 

- Volatility of Loss: $\sigma(L(x)) = \sigma_x$, the minus does not matter in the s.d.
- Standard Deviation-based risk measure: $=\mathbb{E}(L(x)) + cz_{c}\sigma(L(x))  $, x-axis is revered, so $z_{1-c}$ for return becomes $z_c$ for loss.
- VaR: $VaR_{\alpha}(x)=inf\bigg\{ \mathscr{l}:Prob\big[ L(x)\leq \mathscr{l} \big] \geq \alpha \bigg\}$
- Expected Shortfall: $ES_{\alpha}(x) = \frac{1}{1-\alpha} \int_{\alpha}^1 VaR_u(x) du$. In other form, $ES_{\alpha}(x)=\mathbb{E}\bigg( L(x)| L(x)\geq VaR_{\alpha}(x) \bigg)$

As $R \sim N(\mu, \Sigma)$, 

- for our portfolio with weights $x$, $mean = \mu$, and $\sigma_x = \sqrt{x^T \Sigma x}$
- for the loss, $mean = -\mu$, and $\sigma_x = \sqrt{x^T \Sigma x}$