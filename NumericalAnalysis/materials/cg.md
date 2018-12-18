[TOC]

# Conjugate Gradient

主要用于求解$Ax=b, A\in S_+^n\text{且}A\succ 0$的情形。

考虑函数：
$$
f(x) = \frac{1}{2}x^TAx-p^Tx, A\succ0
$$
则有结论：设$A$对称正定，则$Ax^*=p \iff f(x^*) = \min_{x\in R^n}f(x)$ 

充分性很容易证明，对任意的$y$，利用$Ax =b$，有：
$$
\begin{split}
f(y) - f(x) &= \frac{1}{2}y^TAy-p^Ty-\frac{1}{2}x^TAx+p^Tx\\
&=\frac{1}{2}(y-x)^TA(y-x)   \\
& \ge 0
\end{split}
$$
必要性，假设$f$在$x$处取得最小，则对任意的$y=x+w$，有：
$$
\begin{split}
f(x+w) - f(x) &= \frac{1}{2}(x+w)^TA(x+w) -p^T(x+w) - \frac{1}{2}x^TAx +p^Tx\\
&=\frac{1}{2}w^TAw+w^T(Ax-p)\\
&\ge 0\text{  恒成立}
\end{split}
$$
取$g(w) = \frac{1}{2}w^TAw-w^T(p-Ax)$，则只需要$g(w)$的最小值大于等于0即可，而从充分性的证明中我们知道，$w=A^{-1}(p-Ax)$的时候$g$将取得最小值，于是：
$$
\begin{split}
\inf g(w) = -\frac{1}{2}(p-Ax)^TA^{-1}(p-Ax) \ge 0
\end{split}
$$
$A$正定，那么$A^{-1}$也正定，于是上面只能指望等号成立，及$p-Ax=0$，于是有$x$是方程的解。