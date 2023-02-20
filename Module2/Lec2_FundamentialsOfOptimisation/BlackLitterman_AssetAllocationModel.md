# Black-Litterman Asset Allocation Model

- Purpose: Calculate the **expected excess return**, and then solve for the **optimation portfolio**. The Inspiring fact of that model is that it allow people to incorporate their views on stocks.

The BLM combines info from two sources to create an estimate of expected returns. 

1. What does the current market tell us about the expected excess returns?
   - Implied excess equilibirum returns.
2. Views of people about particular stocks or financial assets or real assets.

## Model Building Blocks

$$ E(r-r_f) = \bigg[(\tau \Sigma)^{-1} + P^T \Omega^{-1}P\bigg]^{-1} \bigg[(\tau \Sigma)^{-1}\Pi + P^T \Omega^{-1}Q\bigg]$$

### Denoted Notation

- $\tau$ is a scalar, as the Black and Litterman assume the varianace is proportional to the variances?.
- $\Sigma$ is the variance-corvariance matrix for all assets under consideration.
- $\Omega$ the Uncertainty surrounding your views.
- $\Pi$ is the **Implied Excess Returns**.
- $Q$ is the Views on Expected Excess Return for some or all assets.
- $P$ is a Matrix identifying which assets you have views about.

## Implication

Let's look as the **second term** (the numerator) firstly.

$$(\tau \Sigma)^{-1}\Pi + P^T \Omega^{-1}Q$$

-  $(\tau \Sigma)^{-1} $  is the **weight**.  - Weights: how confident the investor about his views relative to the implied excess return. **"Measure of Confidence"**.
- The weights multiplied by the  $\Pi$, excess return, means the weighted return.
- $\Omega$ is the uncertainty, so with higher uncertainty, $\Omega^{-1}$ is getting smaller, which would then make the second term smaller.
- $\Omega^{-1}$ here is the weights for your views.
- Thus, the second part is the weighted average return combining with the implied excess return with our views.

The, for the **first temr** (the denominator),

- The first term is there to ensure that the weights assigned to applied **excess returns** and **our views** are up to 1.

**In other words,** the whole equation is like a weighted average. For example, 

 $$\frac{a\times Implied\ Excess Return +b\times Our \ Views}{a+b}$$

-  $a = (\tau S)^{-1}$
- $b = P^T \Omega ^{-1}$
- Implied Excess Return is: $\Pi$
- Our Views is: $Q$

---------------------

# Derivation

## Weighted Average of ( Part1 + Part2 )

Bayes

## Part 1. Implied Excess Return in Equilibrium - $\Pi$

### Main Logic of Black-Litterman Model

- We still aim to maximise our portfolio return, by choosing weight $w^*$ , subject to a penalty term (with risk aversion). One thing different is we not maximise the pure return, but **excess return**.

Assume the utility function we aim to maximise is the following,

$$U = w^TR - \frac{1}{2}\lambda w^T\Sigma w,\quad s.t. \ w^t\cdot\vec{\mathbb{1}} = 1$$

- $w$ is the **weight matrix**.
- $R$ is the **excess return**.
- $\lambda$ is the **risk aversion**.
- $\Sigma$ is the **Variance-Covarience matrix** of $R$.

F.O.C. $ \frac{dU}{dw}=R - \lambda \Sigma w $, we get $R=\lambda \Sigma w $, and $ w^* = \frac{1}{\lambda} \Sigma^{-1}R $

**Implied Equilibrium Excess Return**, $R = \Pi$, is our destination of **Part 1**. However, we only observe the current/previous market value of $R_m$, and that $R_m$ might not be good. Instead, we need to use the optimisation result. In other words, we need to input $\Pi = \lambda \Sigma w$. 

A few questions we are encountering with, 

- What $\lambda, \Sigma, w$ would be?
- $w_m$: we simply use the current market as a portfolio's weights.
- $\Sigma$: we assume the Variance-Covaraince matrix of those assets keeps unchanged, so we use directly historical or current market data of $\Sigma$.
- $\lambda$: we here assume the market would be in equilibrium under CAPM return, $R = \Pi$, $ \Pi=\lambda_m \Sigma_m w_m $.
    -  Thus, we pre-multiply by $w^T$, $ w^T \Pi = \lambda_m w^T_m \Sigma_m w_m$
    - $ \lambda_m = \frac{w^T \Pi }{w^T_m \Sigma_m w_m} $
    - As, $\sigma^2_m = w^T_m \Sigma_m w_m$ is the risks in our (market) portfolio. We would get, $ \lambda_m = \frac{w^T \Pi }{\sigma_m^2} =\frac{w^T\mathbb{E}(r_m - r_f)}{\sigma^2_m} $. Recall, the **Sharpe Ratio** is defined as $S = \frac{r_p - r_f}{\sigma_p}$, now our portfolio is the market portfolio, so $S_m = \frac{r_m - r_f}{\sigma_p} = \frac{w^TR}{\sigma_m}$ (the current market Sharpe Ratio is the data we can get from such as Bloomberg. Black-Litterman just use $S_m=0.5$). **We finally deduce the risk aversion by inputing data in the current market condition.**
    - $ \lambda_m = \frac{S_m}{\sigma_m} $

Now, inputing $w_m, \Sigma, \lambda_m$, we could then get the $\Pi$, the implied excess return in equilibrium. $ \Pi=\lambda_m \Sigma_m w_m $.

### Prior - P(E)

As we assume the normal distribution of Prior Probability.

$P(E) \sim N(\Pi, \Sigma_{\Pi})$

We have know $\Pi$ already, another parameter $\Sigma_{\Pi}$ is still unknown. How to get that?

Black and Litterman simply assume the Variance-Covariance matrix, $\Sigma_{\Pi}$, the implied excess return in equilibrium, is proportional to the market one, 

$$\Sigma_{\Pi} = \tau \Sigma$$

, where $\tau$ is a scalar and could be considered as a hyper-parameter. 

- $\tau$ could be within (0.01, 0.05), =1, or = 1/T. 

Finally, we finish our work for Part 1. We get the **prior distribution**.

$$P(E) \sim N(\Pi, \tau \Sigma)$$

## Part 2: Views

Assume two views on three assets here.

- Relative View: $Asset_A > Asset_B$ by 1%, $Asset_C > Asset_A$ by 0.5%

- Let denote the **View** vector as, $\mathbb{Q} = \begin{pmatrix} 0.01 \\ 0.005 \end{pmatrix}_{2\times1} = [0.01, 0.005]^T_{2\times 1}$, which is the **return for each view**.
- And the **Link Matrix** $\mathbb{P} = \begin{pmatrix}  1&-1&0\\-1&0&1 \end{pmatrix}$. Two **rows** each represent **View1** and **View2**, and Three **columns** each represents **views to asset A, B, and C.** In this case, View1 is  long one Asset A, short one Asset B and do nothing for asset C. View 2 is short one asset A, do nothing for asset B, long one asset C.
- Let, $\Omega$ the **variance-corvariance matrix of view return** for those assets. Let it be **uncertainty** of our views, then $\Omega^{-1}$ would be the **confidence of views**.
- P.S. surely, there could also be an **Absolute View**, e.g. (0, 1, 0). **Absolute views are expressed as long positions, while relative views are represented long-short positions**.

We know that we view is still the view, not the fact. The difference between views and facts are the error terms, $\epsilon$. So, 

$$\mathbb{Q}+\epsilon = \begin{pmatrix} Q_1 \\Q_2 \end{pmatrix} + \begin{pmatrix} \epsilon_1 \\\epsilon_2 \end{pmatrix} = \begin{pmatrix} 0.01 \\0.005 \end{pmatrix} + \begin{pmatrix} \epsilon_1 \\\epsilon_2 \end{pmatrix}$$

$$\epsilon = \begin{pmatrix} \epsilon_1 \\\epsilon_2 \end{pmatrix} \sim N\begin{pmatrix} \begin{pmatrix} 0 \\ 0 \end{pmatrix} ,&  \begin{pmatrix} \omega_{11} && \omega_{12}\\\omega_{21} && \omega_{22} \end{pmatrix} \end{pmatrix} $$

Let $\Omega = \begin{pmatrix} \omega_{11} && \omega_{12}\\\omega_{21} && \omega_{22} \end{pmatrix}$, denote the variance-covariance matrix of the error of views. In other words, $\Omega$ captures the **uncertainty of our viewes.**

​	How to calculate the $\Omega$ matrix? 

- There is not a commonly agreed method of doing so. Several literature gives different methods of mimic $\Omega$.
- He and Litterman suggest, $\Omega = \tau P^T \Sigma P$, where $\tau$ is just a scalar, again. Black and Litterman use $\tau = 0.025$, and some people use $\tau = 1$. Anyway it is just a scalar.

Recall, $\Omega$ represent the **uncertainty**, so $\Omega^{-1}$ means the **confidence**. 

Now, we also assume the Gaussian form of error term. The conditional distribution is now,

$$P(I|E) \sim N(\mathbb{Q}, \Omega)$$

## Question Mark : Combining to Get Posterior

The **Posterior Distribution** is,

$$P(E|I) \sim N\Bigg(\bigg[ (\tau \Sigma)^{-1} + P^T \Omega^{-1}P \bigg]^{-1}\bigg[ (\tau \Sigma)^{-1}\Pi + P^T \Omega^{-1}Q \bigg], \bigg[(\tau \Sigma)^{-1} + P^T \Omega^{-1}P \bigg]^{-1} \Bigg)$$

Thus, the result of Black-Litterman Formula is, (the excess return given analyst's view, I)

$$\hat{R}_I:= E(r-r_f|I) = \bigg[ (\tau \Sigma)^{-1} + P^T \Omega^{-1}P \bigg]^{-1}\bigg[ (\tau \Sigma)^{-1}\Pi + P^T \Omega^{-1}Q \bigg]$$

## Asset Allocation - $w^*$

Recall our optimisation problem,

$$U = w^TR - \frac{1}{2}\lambda w^T\Sigma w$$

$$w^* = \frac{1}{\lambda} \Sigma^{-1}\hat{R_I}$$

, where we plug into our Black-Litterman result, and get the very end result.

## Application Example (3 Assets)

- $\tau = Scalar(1)$
- $\Pi = 3\times 1$ Vector, implied excess return.
- $\Sigma = 3\times 3$ matrix, var-cov matrix.
- $\mathbb{Q} = 2\times 1$ vector, views' return.
- $\mathbb{P} = 2\times 3$ matrix, two views on three assets.
- $\Omega = 2\times 2$ matrix, uncertainty of our view.  

### Weighted Average

**Black and Litterman assess the excess return by calculating the weighted average of $\Pi$ and $\mathbb{Q}$, which is the implied equilibrium return and the views.**

How to assign weights for (1) $\Pi$ and (2) $\mathbb{Q}$ ?

​	The answers of weights respectively are (1) $ (\tau \Sigma)^-1$ , (2)  $\mathbb{P}^T \Omega$

Thus, our weighted average would be,

$$ \underbrace{(\tau \Sigma)^{-1}}_{weight\ on\ \Pi}\Pi + \underbrace{\mathbb{P}^T \Omega^{-1}}_{weight\ on\ \ \mathbb{Q}}\ \mathbb{Q}  $$

### Black-Litterman Formula

$$ E(r-r_f) = \bigg[(\tau \Sigma)^{-1} + \mathbb{P}^T \Omega^{-1}\mathbb{P}\bigg]^{-1} \bigg[(\tau \Sigma)^{-1}\Pi + \mathbb{P}^T \Omega^{-1}\mathbb{Q}\bigg]$$







----------

# Reference

- Implication: https://youtu.be/lIhGv1oYS8U
- Example in Excel: https://youtu.be/RGw2qYWPigA
- Derivation: https://youtu.be/hnSphrrpCiQ
