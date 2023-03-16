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

**Derivation**:

Let's clarify, we aim to solve the below equation.

$$\frac{\partial V}{\partial t}+ \frac{1}{2}\sigma^2S^2\frac{\partial^2 V}{\partial S^2}  + rS \frac{\partial V}{\partial S}-  r V=0$$

Step 1. Rewrite (discount) option value.

$$V(S,t) = $$

54min