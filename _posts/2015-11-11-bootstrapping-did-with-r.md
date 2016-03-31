---
layout: post
title: "Bootstrapping standard errors for difference-in-differences estimation with R"
description: ""
category: 
tags: [R]
---
{% include JB/setup %}


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<!-- MathJax scripts -->
<script type="text/javascript" src="https://c328740.ssl.cf1.rackcdn.com/mathjax/2.0-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

</head>

<body>
<p>I’m currently working on a paper (with my colleague Vincent Vergnat who is also a Phd candidate at BETA) where I want to estimate the causal impact of the birth of a child on hourly and daily wages as well as yearly worked hours. For this we are using non-parametric difference-in-differences (henceforth DiD) and thus have to bootstrap the standard errors. In this post, I show how this is possible using the function <code>boot</code>.</p>
<p>For this we are going to replicate the example from Wooldridge’s <em>Econometric Analysis of Cross Section and Panel Data</em> and more specifically the example on page 415. You can download the data for R <a href="/assets/files/kielmc.RData">here</a>. The question we are going to try to answer is <em>how much does the price of housing decrease due to the presence of an incinerator in the neighborhood?</em></p>
<p>First put the data in a folder and set the correct working directory and load the <code>boot</code> library.</p>
<pre class="r"><code>library(boot)
setwd(&quot;/home/path/to/data/kiel data/&quot;)
load(&quot;kielmc.RData&quot;)</code></pre>
<p>Now you need to write a function that takes the data as an argument, as well as an indices argument. This argument is used by the <code>boot</code> function to select samples. This function should return the statistic you’re interested in, in our case, the DiD estimate.</p>
<pre class="r"><code>run_DiD &lt;- function(my_data, indices){
    d &lt;- my_data[indices,]
    return(
        mean(d$rprice[d$year==1981 &amp; d$nearinc==1]) - 
        mean(d$rprice[d$year==1981 &amp; d$nearinc==0]) - 
        (mean(d$rprice[d$year==1978 &amp; d$nearinc==1]) - 
        mean(d$rprice[d$year==1978 &amp; d$nearinc==0]))
    )
}</code></pre>
<p>You’re almost done! To bootstrap your DiD estimate you just need to use the boot function. If you have cpu with multiple cores (which you should, single core machines are quite outdated by now) you can even parallelize the bootstrapping.</p>
<pre class="r"><code>boot_est &lt;- boot(data, run_DiD, R=1000, parallel=&quot;multicore&quot;, ncpus = 2)</code></pre>
<p>Now you should just take a look at your estimates:</p>
<pre class="r"><code>boot_est</code></pre>
<pre><code>## 
## ORDINARY NONPARAMETRIC BOOTSTRAP
## 
## 
## Call:
## boot(data = data, statistic = run_DiD, R = 1000, parallel = &quot;multicore&quot;, 
##     ncpus = 2)
## 
## 
## Bootstrap Statistics :
##     original    bias    std. error
## t1* -11863.9 -553.3393    8580.435</code></pre>
<p>These results are very similar to the ones in the book, only the standard error is higher.</p>

<p>You can get confidence intervals like this:</p>
<pre class="r"><code>quantile(boot_est$t, c(0.025, 0.975))</code></pre>
<pre><code>##       2.5%      97.5% 
## -30186.397   3456.133</code></pre>
<p>or a t-statistic:</p>
<pre class="r"><code>boot_est$t0/sd(boot_est$t)</code></pre>
<pre><code>## [1] -1.382669</code></pre>
<p>Or the density of the replications:</p>
<pre class="r"><code>plot(density(boot_est$t))</code></pre>

<div style="text-align:center;">
    <img src="/assets/images/density_did.png" width="670" height="450" /></a>
</div>

<p>Just as in the book, we find that the DiD estimate is not significant to the 5% level.</p>


</body>
