---
layout: post
title: "Object Oriented Programming with R: An example with a Cournot duopoly"
description: ""
category: 
tags: [tutorial, R]
---
{% include JB/setup %}

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<!-- MathJax scripts -->
<script type="text/javascript"
  src="https://c328740.ssl.cf1.rackcdn.com/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
</head>

<body>
<p>I started reading <em>Applied Computational Economics &amp; Finance</em> by Mario J. Miranda and Paul L. Fackler. It is a very interesting book that I recommend to every one of my colleagues. The only issue I have with this book, is that the programming language they use is Matlab, which is proprietary. While there is a free as in freedom implementation of the Matlab language, namely Octave, I still prefer using R. In this post, I will illustrate one example the authors present in the book with R, using the package <code>rootSolve</code>. <code>rootSolve</code> implements Newtonian algorithms to find roots of functions; to specify the functions for which I want the roots, I use R&#39;s Object-Oriented Programming (OOP) capabilities to build a model that returns two functions.</p>

<h3>Theoretical background</h3>

<p>The example is taken from Miranda&#39;s and Fackler&#39;s book, on page 35. The authors present a Cournot duopoly model. In a Cournot duopoly model, two firms compete against each other by quantities. Both produce a certain quantity of an homogenous good, and take the quantity produce by their rival as given. </p>

<p>The inverse demand of the good is :</p>

<img src="http://latex.codecogs.com/png.latex?P(q) = q^{-\dfrac{1}{\eta}" alt="P(q) = q^{-\dfrac{1}{\eta}" />

<p>the cost function for firm i is:</p>

<img src="http://latex.codecogs.com/png.latex?C_i(q_i) = P(q_1+q_2)*q_i - C_i(q_i)" alt="C_i(q_i) = P(q_1+q_2)*q_i - C_i(q_i)}" />


<p>and the profit for firm i:</p>

<img src="http://latex.codecogs.com/png.latex?\pi_i(q1,q2) = P(q_1+q_2)q_i - C_i(q_i)" alt="\pi_i(q1,q2) = P(q_1+q_2)q_i - C_i(q_i)" />

<p>The optimality condition for firm i is thus:</p>

<img src="http://latex.codecogs.com/png.latex?\dfrac{\partial \pi_i}{\partial q_i} = (q1+q2)^{-\dfrac{1}{\eta}} - \dfrac{1}{\eta} (q_1+q_2)^{\dfrac{-1}{\eta-1}}q_i - c_iq_i=0." alt="\dfrac{\partial \pi_i}{\partial q_i} = (q1+q2)^{-\dfrac{1}{\eta}} - \dfrac{1}{\eta} (q_1+q_2)^{\dfrac{-1}{\eta-1}}q_i - c_iq_i=0." />


<h3>Implementation in R</h3>

<p>If we want to find the optimal quantities <img src="http://latex.codecogs.com/png.latex?\inline q_1" alt="\inline q_1" />  and  <img src="http://latex.codecogs.com/png.latex?\inline q_2" alt="\inline q_2" /> we need to program the optimality condition and we could also use the jacobian of the optimality condition. The jacobian is generally useful to speed up the root finding routines. This is were OOP is useful. Firt let&#39;s create a new class, called <em>Model</em>:</p>

<pre><code class="r">setClass(Class = &quot;Model&quot;, slots = list(OptimCond = &quot;function&quot;, JacobiOptimCond = &quot;function&quot;))
</code></pre>

<p>This new class has two <em>slots</em>, which here are functions (in general <em>slots</em> are properties of your class); we need the model to return the optimality condition and the jacobian of the optimality condition.</p>

<p>Now we can create a function which will return these two functions for certain values of the parameters, <em>c</em> and  <img src="http://latex.codecogs.com/png.latex?\inline \eta" alt="\inline \eta" /> of the model:</p>

<pre><code class="r">my_mod &lt;- function(eta, c) {
    e = -1/eta

    OptimCond &lt;- function(q) {
        return(sum(q)^e + e * sum(q)^(e - 1) * q - diag(c) %*% q)
    }

    JacobiOptimCond &lt;- function(q) {
        return((e * sum(q)^e) * array(1, c(2, 2)) + (e * sum(q)^(e - 1)) * diag(1, 
            2) + (e - 1) * e * sum(q)^(e - 2) * q * c(1, 1) - diag(c))
    }

    return(new(&quot;Model&quot;, OptimCond = OptimCond, JacobiOptimCond = JacobiOptimCond))

}
</code></pre>

<p>The function <code>my_mod</code> takes two parameters, <code>eta</code> and <code>c</code> and returns two functions, the optimality condition and the jacobian of the optimality condition. Both are now accessible via <code>my_mod(eta=1.6,c = c(0.6,0.8))@OptimCond</code> and <code>my_mod(eta=1.6,c = c(0.6,0.8))@JacobiOptimCond</code> respectively (and by specifying values for <code>eta</code> and <code>c</code>).</p>

<p>Now, we can use the <code>rootSolve</code> package to get the optimal values  <img src="http://latex.codecogs.com/png.latex?\inline q_1" alt="\inline q_1" />  and  <img src="http://latex.codecogs.com/png.latex?\inline q_2" alt="\inline q_2" /> :</p>

<pre><code class="r">library(&quot;rootSolve&quot;)

multiroot(f = my_mod(eta = 1.6, c = c(0.6, 0.8))@OptimCond, start = c(1, 1), 
    maxiter = 100, jacfunc = my_mod(eta = 1.6, c = c(0.6, 0.8))@JacobiOptimCond)
</code></pre>

<pre><code>## $root
## [1] 0.8396 0.6888
## 
## $f.root
##            [,1]
## [1,] -2.220e-09
## [2,]  9.928e-09
## 
## $iter
## [1] 4
## 
## $estim.precis
## [1] 6.074e-09
</code></pre>

<p>After 4 iterations, we get that  <img src="http://latex.codecogs.com/png.latex?\inline q_1" alt="\inline q_1" />  and  <img src="http://latex.codecogs.com/png.latex?\inline q_2" alt="\inline q_2" /> are equal to 0.84 and 0.69 respectively, which are the same values as in the book!</p>

</body>

