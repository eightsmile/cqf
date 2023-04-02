# Girsanov's Theorem

## Statement

We can change the probability measure, and then make a random variable follows a certain probability measure.

- Radon-Nikodym Derivative:

$$Z(\omega) = \frac{\tilde{P}(\omega)}{P(\omega)}$$

- $\tilde{P}(\omega)$  is the risk-neutral probability measure.
- ${P}(\omega)$ is the actual probability measure.
- Properties:
  - $Z(\omega)>0$
  - $\mathbb{E}(Z)=1$
  - As $\tilde{P}(\omega) = Z(\omega) P(\omega)$, so if $Z(\omega)$, then $\tilde{P}(\omega) > P(\omega)$. *vice versa*.

We can calculate that,

$$ \underbrace{\tilde{\mathbb{E}}(X)}_{\text{Expectation under Risk-neutral Probability Measure}} = \underbrace{\mathbb{E}(ZX)}_{\text{Expectation under Actual Probability Measure}} $$

## Proof & Example

Under $(\Omega,\mathcal{F},P)$, $A\in \mathcal{F}$, let $X$ be a random variable $X\sim N(0,1)$. $\mathbb{E}(X)=0$, and $\mathbb{Var}(X)=1$. 

$Y=X+\theta$, $\mathbb{E}(Y)=\theta$, and $\mathbb{Var}(Y)=1$. 

$X$ here is s.d. normal under the actual probability measure.

However, $Y$ here is not standard normal under the current probability $P(.)$, because $\mathbb{E}(Y)\neq0$.

### What do we do?

**We change the probability measure from $P(.)\to\tilde{P}(.)$ to let $Y$ be standard normal under the new probability measure!**

We set the Radon-Nikodym Derivative, 

$$Z(\omega) = exp\{ -\theta\ X(\omega) - \frac{1}{2}\theta^2 \}$$

Now, we can create the probability measure $\tilde{P}(A)$, $A=\{ \omega;Y(\omega)\leq b) \}$

$$\tilde{P}(A) = \int_A Z(\omega)\ dP(\omega)$$

such that $Y=X+\theta$ would be standard normal distributed under the new probability measure $\tilde{P}(A)$.

$$\tilde{P}(A) = \tilde{P}(Y(\omega \leq b)$$

$$  = \int_{\{ Y(\omega)\leq b \} } exp\{ -\theta\ X(\omega) - \frac{1}{2}\theta^2 \} \ dP(\omega)$$

, then change the integral range from the set $A$ to $\Omega$ by multiplying that indicator.

$$  = \int_{\Omega }\mathbb{1}_{ Y(\omega)\leq b }\ exp\{ -\theta\ X(\omega) - \frac{1}{2}\theta^2 \} \ dP(\omega)$$

, change from $dP$ to $dX$,

$$  = \int_{-\infty }^{\infty }\mathbb{1}_{ b-\theta}\ exp\{ -\theta\ X(\omega) - \frac{1}{2}\theta^2 \} \  \frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}X^2(\omega)}  \ dX(\omega)$$

$$  =\frac{1}{\sqrt{2\pi}} \int_{-\infty }^{b-\theta}\ exp\{ -\theta\ X(\omega) - \frac{1}{2}\theta^2- \frac{1}{2}X^2(\omega)\}  \ dX(\omega)$$

$$  =\frac{1}{\sqrt{2\pi}} \int_{-\infty }^{b-\theta}\ exp\Bigg\{ -\frac{1}{2}\bigg(\theta+ X(\omega)\bigg)^2\Bigg\}  \ dX(\omega)$$

, as $Y=X+\theta$, $dY = dX$, we now change $dX$ to $dY$,

$$  =\frac{1}{\sqrt{2\pi}} \int_{-\infty }^{b}\ exp\big\{ -\frac{1}{2}Y(\omega)^2\big\}  \ dY(\omega)$$

, the above is now a standard normal distribution for $Y(\omega)$.

