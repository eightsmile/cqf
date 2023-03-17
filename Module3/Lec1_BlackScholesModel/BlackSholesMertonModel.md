# Black Sholes Merton Model - An Introduction of P.D.E. for Option Pricing

## Notations

$$ V(S,t;\sigma, \mu; E, T;r) $$

- $S, t$ - variables
- $\sigma, \mu$ - parameters associated with the asset price
- $E,T$ - parameters associated with the option
- $r$ - risk free rate

Assume the underlying follows a lognormal random walk, with known volatility

$$ \frac{dS}{S} = \mu dt + \sigma dX$$

## Assumptions

$$dS = \mu\ S\ dt + \sigma \ S \ dX$$

$$\Pi = V(S,t) - \Delta S$$

**Intuition**: $S$ move brings $V$ move.

$$d\Pi = dV - \Delta \ dS$$

From Ito IV, 

$$dV = \frac{\partial V}{\partial t} dt+ \frac{\partial V}{\partial S} dS +\frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2}dt$$

Thus, $d\Pi$ is,

$$ d\Pi = \frac{\partial V}{\partial t} dt+ \frac{\partial V}{\partial S} dS +\frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2} dt- \Delta \ dS $$

$$d\Pi = \bigg( \frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2} \bigg)dt + \bigg(\frac{\partial V}{\partial S} - \Delta\bigg)dS$$

There are the deterministic term, first term of the RHS, and the stochastic term. We could find that the change of $\Pi$ ( $d\Pi$ ) contains risks.

To **eliminate the risks**, we set $\Delta = \frac{\partial V}{\partial S}$, or $\frac{V^+ - V^-}{S^+ - S^-}$. That is also named '**Delta Hedging**'.

## Derivation / No Arbitrage - Black-Scholes Equation

- Now, we get the equation $d\Pi = \bigg( \frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2} \bigg)dt$
- Compared it with the risk-free return, (save money in the bank), $d\Pi = r\Pi \ dt$

By No Arbitrage, those two equations are equal,

$$\bigg( \frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2} \bigg)dt =  r\Pi \ dt$$

Rearrange it, and eliminate $dt$, 

$$\frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2} -  r\Pi =0$$

, and replace $\Pi = V(S,t) - \Delta S = V -S \frac{\partial V}{\partial S}$

$$\frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2}  + rS \frac{\partial V}{\partial S}-  r V=0$$

This is the **Black-Scholes Equation**!

There are all parameters in the BS equation except the drift. The drift rate $\mu$ is replaced by $r$ in the risk-neutral context.

## Relax Assumptions

### Options on Dividend-paying Equity

Assume that the asset receives a **continuous** and **constant** dividend yield, $D$. Thus, during $dt$, each asset receives an amount $D\ S\ dt$. $\Delta$ is the amount of the asset held in the portfolio.

$$d\Pi = \bigg( \frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2} \bigg)dt + \bigg(\frac{\partial V}{\partial S} - \Delta\bigg)dS - D\Delta S dt$$

As a result, 

$$\frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2}  + (r-D)\ S \frac{\partial V}{\partial S}-  r V=0$$

### Currency Options

A $r_f$ replace $D$ in the above equation as the **foreign rate**.

$$\frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2}  + (r-r_f)\ S \frac{\partial V}{\partial S}-  r V=0$$

### Commodity Options

For Example, if there is the **cost of carry** of those commodities.

Let us introduce $q$ as the fraction of value of commodity.

$$\frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2}  + (r+q)\ S \frac{\partial V}{\partial S}-  r V=0$$

## Solving the Equation and the Greeks

- Use **transformation** & **substitution** to **reduce the Black-Sholes Equation to a Heat Equation** that we can solve.
- Solve the Heat Equation using **Similarity Reduction.**
- **Unwind** all steps to get solutions in terms of the original variables.

### **Derivation**:

Let's clarify, we aim to solve the below equation.

$$\frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2}  + rS \frac{\partial V}{\partial S}-  r V=0$$

#### **Step 1.** Rewrite (discount) option value.

$$V(S,t) = e^{-r(T-t)U(S,t)}$$

$$\frac{\partial V}{\partial t} = r\ e^{-r(T-t)}U + e^{-r(T-t)}\frac{\partial U}{\partial t}$$

Take our differential equation to

$$ \frac{\partial U}{\partial t} + \frac{1}{2}\sigma^2S^2 \frac{\partial^2 U}{\partial S^2} + rS\frac{\partial U}{\partial S}=0  $$

#### Step 2. Replace $T-t$

Substitute $\tau = T-t$ into the equation.

**F.K.E**

 $$\frac{\partial U}{\partial \tau} = \frac{1}{2}\sigma^2S^2 \frac{\partial^2 U}{\partial S^2} + rS\frac{\partial U}{\partial S}$$

#### Step 3. Write down in terms of the log S

Let $\xi = log\ S$

So, we get

$$\frac{\partial}{\partial S} =\frac{\partial .}{\partial \xi}\cdot \frac{d \xi}{d S}  = e^{-\xi}\frac{\partial}{\partial \xi}  $$

, and

 $$\frac{\partial^2}{\partial S^2} = e^{-2\xi}\frac{\partial^2}{\partial \xi^2} -e^{-2\xi}\frac{\partial}{\partial \xi}  $$

Now, the Black-Scholes equation becomes, (A constant coefficient P.D.E)

 $$\frac{\partial U}{\partial \tau} = \frac{1}{2}\sigma^2 \frac{\partial^2 U}{\partial \xi^2} + (r-\frac{1}{2}\sigma^2)\frac{\partial U}{\partial \xi}$$

#### Step 4. Chain Rule II

$x=\xi + (r-\frac{1}{2}\sigma^2)\tau $, and $U=W(x,\tau)$.

Let $x$ be the above, and $\tau$ remains to be $\tau$. This is a translation of the coordinate system. It's a bit like using the forward price of the asset instead of the spot price as a variable.

After doing that, the Black-Scholes becomes, 

$$ \frac{\partial W}{\partial \tau} = \frac{1}{2}\sigma^2 \frac{\partial^2 W}{\partial x^2}  $$

( Remember we do the similar in the P.D.E, and it is like that $ \frac{\partial p}{\partial t'} = c^2\frac{\partial^2 p}{\partial y'^2}  $, $c^2$ is replaced by $\sigma^2$ )

#### Finally

We can solve the equation to find a **special solution**, which is called the **Fundamental Solution** or call it **Source Solution**.

$$W_f(X,\tau;x') = \frac{1}{\sigma\sqrt{2\pi \tau}}e^{-\frac{(x-x')^2}{2\sigma^2\tau}}$$

, where $x\sim N(x', \sigma^2 \tau)$.

#### Finally Finally

There are lots of working such as the Dirac Delta function, but we will step straight to the following.

$$ V(S,t) =\frac{e^{-r(T-t)}} {\sigma\sqrt{2\pi (T-t)}}$$

Recall in the step 1, we let $V(S,t) = e^{-r(T-t)U(S,t)}$. So, $U(S,t) =\frac{1} {\sigma\sqrt{2\pi (T-t)}}$.

$U(S,t)$ here is the expected value of the payoff. Probability of stock price goes from $(S,t) \rightarrow (S',T)$.

$$ \int_0^{\infty} e^{-(log(S/S') + (r-\frac{1}{2}\sigma^2)(T-t)^2/2\sigma^2(T-t)}\cdot Payoff(S') \frac{dS'}{S'}$$

This formula works for any European, non-path dependent option on a single lognormal underlying asset. All you need to know is the Payoff function, substitute it in.

### Observation

This is a general formula, because payoff is yet to be specified.

If Substitute the **Call Option inside**, $Payoff = max(S-E,0)$,

$$\text{Call Option Value} = S\ N(d_1) - E \ e^{-r(T-t)}\ N(d_2)$$

, where ( $d_2 = d_1 - \sigma \sqrt{T-t}$ )

$$d_1 = \frac{log(S/E) + (r+\frac{1}{2}\sigma^2)(T-t)}{\sigma \sqrt{T-t}}$$

$$d_2 = \frac{log(S/E) + (r-\frac{1}{2}\sigma^2)(T-t)}{\sigma \sqrt{T-t}}$$

$N(x) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^x e^{-\frac{1}{2}}d\phi$ , which is the c.d.f. of s.d.normal

**When there is  continuous dividend,**

$$\text{Call Option Value} = Se^{D(T-t)}\ N(d_1) - E e^{D(T-t)}\ e^{-r(T-t)}\ N(d_2)$$

, where ( $d_2 = d_1 - \sigma \sqrt{T-t}$ )

$$d_1 = \frac{log(S/E) + (r-D+\frac{1}{2}\sigma^2)(T-t)}{\sigma \sqrt{T-t}}$$

$$d_2 = \frac{log(S/E) + (r-D-\frac{1}{2}\sigma^2)(T-t)}{\sigma \sqrt{T-t}}$$

$N(x) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^x e^{-\frac{1}{2}}d\phi$ , which is the c.d.f. of s.d .normal

## Greeks

### Delta

$$\Delta = \frac{\partial V}{\partial S}$$

By T.S.E.

$$V(S+\delta S, t) = V(S,t) + \frac{\partial V}{\partial S}\delta S + \frac{1}{2}\frac{\partial^2V}{\partial S^2} \delta S^2 + O(\delta S^3)$$

$$\frac{V(S+\delta S)-V(S)}{\delta S}=\Delta = \frac{\partial V}{\partial S}$$

### Gamma

$$\Gamma = \frac{\partial^2 V}{\partial S^2}$$

### Theta

$$\Theta = \frac{\partial V}{\partial t}$$

Sensitivity to change in time.

### Vega

$$Vega = \frac{\partial V}{\partial \sigma}$$

### Rho

$$\rho=\frac{\partial V}{\partial r}$$

### Linearity

Consider an operation $L(.)$; Functions, $f(x)$ and $g(x)$; Scalar $\lambda \in \mathbb{R}$. $L(.)$ is Linear if:

- (1). $L(\lambda f(x))=\lambda L(f(x))$
- (2). $L(f(x)+g(x))=L(f(x))+L(g(x))$

(1) implies if an option cost $V$, then $k$ options cost $k\times V$.

(2) implies if options each cost $V_1$ and $V_2$, then in the portfolio they still cost $(V_1+V_2)$.

$$ \frac{\partial V}{\partial t} + \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2} + rS\frac{\partial V}{\partial S} - rV = 0 $$

### P.D.E. (Kolmogorov) and Black-Scholes Eq

Remember that, if ( the transition density function )

$$dS = \mu Sdt + \sigma S dX$$

, then the backward Kolmogorov equation for the transition probability density function $p(S,t)$ )is

$$ \frac{\partial p}{\partial t} + \frac{1}{2}\sigma^2S^2\frac{\partial^2 p}{\partial S^2} + \mu S\frac{\partial p}{\partial S} = 0 $$

This is the equation that can be used for calculating the expected value of some quantity in the future.

#### Example 1

Assume $U$ is the expected value $U(S,T)=S$, we solve the Backward Kolmogorov equation,

$$ \frac{\partial U}{\partial t} + \frac{1}{2}\sigma^2S^2\frac{\partial^2 U}{\partial S^2} + \mu S\frac{\partial U}{\partial S} = 0 $$

The answer is $U = e^{{\mu(T-t)}}S$

**Derivation**:

Assume $U(S,t)=f(t)S$, and so $ \frac{\partial U}{\partial t} = f' \times S$, $ \frac{\partial^2 U}{\partial S^2} = 0$, $ \frac{\partial U}{\partial S}=f(t)$, the P.D.E. then becomes, 

$$ \frac{d f}{dt} = -\mu \ f(t) $$

$$ \frac{d f}{f(t) } = -\mu\ dt$$

Integrate from $t$ to $T$,

$$ \int_t^T \frac{d f}{f(t) } = -\mu\ \int_t^T dt$$

$$log(f(T)) -log(f(t)) = -\mu(T-t)$$

Since $U(S,T) = Sf(T)=S$, so $f(T) =1$ and $log(f(T))=log(1)=0$, then the above equation becomes,

$$log(f(t)) = \mu(T-t)\Rightarrow f(t) = e^{\mu(T-t)}$$

Thus, $U(S,t) =  e^{\mu(T-t)}S$

#### Example 2

Assume $U(S,T) = S^2$, solve $ \frac{\partial p}{\partial t} + \frac{1}{2}\sigma^2S^2\frac{\partial^2 p}{\partial S^2} + \mu S\frac{\partial p}{\partial S} = 0 $.

#### Example 3

Assume $U(S,T) = max(S-E,0)$, solve $ \frac{\partial p}{\partial t} + \frac{1}{2}\sigma^2S^2\frac{\partial^2 p}{\partial S^2} + \mu S\frac{\partial p}{\partial S} = 0 $.

- P.S. we can find that the only thing we change each time is the final condition.

#### Comparison

**Kolmogorov** - An Expectation

$$\frac{\partial U}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 U}{\partial S^2}  + \mu S \frac{\partial U}{\partial S}=0$$

**Black-Sholes** - Option Value

#### $$\frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2}  + rS \frac{\partial V}{\partial S}-  r V=0$$

There are two differences (1) $r$ and $\mu$ , (2) B-S eq has an extra term.

### Options as Expectation

There are three steps to getting from an expectation to an option value:

1. Replace $\mu$ with $r$.
2. Calculate an expectation (via a P.D.E. or a simulation). - In other words, solve the Backward Kolmogorov eq for $U(S,t)$
3. Take the present value of the expectation . - In other words, multiply by $e^{{-r(T-t)}}$

Those are the basis for the Monte Carlo method for valuing options.	