---
layout: page
title: "Method of Simulated Moments in R"
description: ""
---
{% include JB/setup %}


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<!-- MathJax scripts -->
<script type="text/javascript" src="https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

</head>


<body>

<p>This document details section <em>12.5.6. Unobserved Heterogeneity Example</em>. The original source code giving the results from table 12.3 are available from the authors&#39; site <a href="http://cameron.econ.ucdavis.edu/mmabook/mmaprograms.html">here</a> and written for Stata. This is an attempt to translate the code to R.</p>

<p>Consult the original source code if you want to read the authors&#39; comments. If you want the R source code without all the commentaries, grab it here. This is not guaranteed to work, nor to be correct. It could set your pet on fire and/or eat your first born. Use at your own risk. I may, or may not, expand this example. Corrections, constructive criticism are welcome.</p>

<p>The model is the same as the one described here, so I won&#39;t go into details. The moment condition used is \( E[(y_i-\theta-u_i)]=0 \), so we can replace the expectation operator by the empirical mean:</p>

<p>\[ \dfrac{1}{N} \sum_{i=1}^N(y_i - \theta - E[u_i])=0 \]</p>

<p>Supposing that \( E[\overline{u}] \) is unknown, we can instead use the method of simulated moments for \( \theta \) defined by:</p>

<p>\[ \dfrac{1}{N} \sum_{i=1}^N(y_i - \theta - \dfrac{1}{S} \sum_{s=1}^S u_i^s)=0 \]</p>

<h3>Import the data</h3>

<p>You can consult the original source code to see how the authors simulated the data. To get the same results, and verify that I didn&#39;t make mistakes I prefer importing their data directly from their website.</p>

<pre><code class="r">data &lt;- read.table(&quot;http://cameron.econ.ucdavis.edu/mmabook/mma12p2mslmsm.asc&quot;)
u &lt;- data[, 1]
e &lt;- data[, 2]
y &lt;- data[, 3]
numobs &lt;- length(u)
simreps &lt;- 10000
</code></pre>

<h3>Simulation</h3>

<p>In the code below, we simulate the equation defined above:</p>

<pre><code class="r">usim &lt;- -log(-log(runif(simreps)))
esim &lt;- rnorm(simreps, 0, 1)

isim &lt;- 0
while (isim &lt; simreps) {

    usim = usim - log(-log(runif(simreps)))
    esim = esim + rnorm(simreps, 0, 1)

    isim = isim + 1

}

usimbar = usim/simreps
esimbar = esim/simreps

theta = y - usimbar - esimbar

theta_msm &lt;- mean(theta)
approx_sterror &lt;- sd(theta)/sqrt(simreps)
</code></pre>

<p>These steps yield the following results:</p>

<pre><code>## Theta MSM= 1.188 Approximate Standard Error= 0.01676
</code></pre>

</body>

