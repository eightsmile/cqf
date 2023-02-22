# CML

We are facing the problem that minimise variances subject to a constraint for returns.

$$ \min_w \frac{1}{2}w^T \Sigma w \quad s.t. \quad r^* + (\mu - r^* \mathbb{1})^Tw=m$$

We construct the Lagrangian,

$$ \mathscr{L}(w, \lambda) = \frac{1}{2}w^T \Sigma w +\lambda \bigg(m-r^* - (\mu - r^* \mathbb{1})^Tw\bigg) $$

F.O.C. w.r.t. $w$, 

$\Sigma w -\lambda (\mu - r^*\mathbb{1})=0$, **so** $ w =\Sigma^{-1}\lambda (\mu - r^*\mathbb{1})$

F.O.C. w.r.t. $\lambda$,

$r^* + (\mu - r^* \mathbb{1})^Tw=m$

, substitute $w$ into the above equation (the constraint), and solve for $\lambda$,

$\lambda = \frac{m-r^*}{(\mu - r^* \mathbb{1})^T\Sigma^{-1}(\mu - r^* \mathbb{1})}$, which is a scalar, because $m, r^*$ are scalars.

Then plug it back into $w$,

$$w^* = \frac{(m-r^*)\Sigma^{-1}(\mu-r^*\mathbb{1})}{(\mu - r^* \mathbb{1})^T\Sigma^{-1}(\mu - r^* \mathbb{1})}$$





$$min_{w} \frac{1}{2}w^T \Sigma w$$

$$s.t.\quad  r_f + w^T (\mu - r_f \mathbb{1}) = m$$

Apply the Lagrangian Method,

$$L(x,\lambda) = \frac{1}{2}w^t\Sigma w + \lambda \bigg(m - r_f + w^T (\mu - r_f \mathbb{1})\bigg)$$

F.O.C.  w.r.t. w
$\frac{\partial L}{\partial w} = \Sigma w - \lambda(\mu - r_f \mathbb{1})$

$$w^* = \lambda \Sigma^{-1} (\mu - r_f \mathbb{1})$$


F.O.C. w.r.t. $\lambda$
$$r_f + w^T (\mu - r_f \mathbb{1}) = m$$
, substitute $w^*$ into the above function we could solve for $\lambda^*$

$$\lambda^* = \frac{m-r}{\big( \mu - r_f \mathbb{1} \big)^T \Sigma^{-1}\big( \mu - r_f \mathbb{1} \big) }$$

So,

$$w^* = \frac{(m-r)\Sigma^{-1}(\mu - r_f \mathbb{1})}{\big( \mu - r_f \mathbb{1} \big)^T \Sigma^{-1}\big( \mu - r_f \mathbb{1} \big) }$$