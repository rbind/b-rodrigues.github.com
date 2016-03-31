---
layout: post
title: "Unit testing with R"
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
<p>I&#39;ve been introduced to unit testing while working with colleagues on quite a big project for which
we use Python.</p>

<p>At first I was a bit skeptical about the need of writing unit tests, but now I must admit that I 
am seduced by the idea and by the huge time savings it allows. Naturally, I was wondering if the 
same could be achieved with R, and was quite happy to find out that it also possible to write unit
tests in R using a package called <code>testthat</code>.</p>

<p>Unit tests (Not to be confused with unit root tests for time series) are small functions that test
your code and help you make sure everything is alright. I&#39;m going to show how the <code>testthat</code> 
packages works with a very trivial example, that might not do justice to the idea of
unit testing. But you&#39;ll hopefully see why writing unit tests is not a waste of your time,
especially if your project gets very complex (if you&#39;re writing a package for example).</p>

<p>First, you&#39;ll need to download and install <code>testthat</code>. Some dependencies will also be installed.</p>

<p>Now, you&#39;ll need a function to test. Let&#39;s suppose you&#39;ve written a function that returns the
nth Fibonacci number:</p>

<pre><code class="r">Fibonacci &lt;- function(n){
    a &lt;- 0
    b &lt;- 1
    for (i in 1:n){
        temp &lt;- b
        b &lt;- a
        a &lt;- a + temp
    }
    return(a)
}
</code></pre>

<p>You then save this function in a file, let&#39;s call it <code>fibo.R</code>. What you&#39;ll probably do once you&#39;ve
written this function, is to try it out:</p>

<pre><code class="r">Fibonacci(5)
</code></pre>

<pre><code>## [1] 5
</code></pre>

<p>You&#39;ll see that the function returns the right result and continue programming. The idea behind
unit testing is write a bunch of functions that you can run after you make changes to your code,
just to check that everything is still running as it should.</p>

<p>Let&#39;s create a script called <code>test_fibo.R</code> and write the following code in it:</p>

<pre><code class="r">test_that(&quot;Test Fibo(15)&quot;,{
  phi &lt;- (1 + sqrt(5))/2
  psi &lt;- (1 - sqrt(5))/2
  expect_equal(Fibonacci(15), (phi**15 - psi**15)/sqrt(5))
})
</code></pre>

<p>The code above uses Binet&#39;s formula, a closed form formula that gives the nth Fibonacci number and compares it 
our implementation of the algorithm. If you didn&#39;t know about Binet&#39;s formula, you could simply compute some numbers
by hand and compare them to what your function returns, for example. The function <code>expect_equal</code> is a function from the 
package <code>testthat</code> and does exactly what it tells. We expect the result of our implementation to be equal to the result of
Binet&#39;s Formula. The file <code>test_fibo.R</code> can contain as many tests as you need. 
Also, the file that contains the tests must start with the string <code>test</code>, so that <code>testthat</code> knows with files it has to run.</p>

<p>Now, we&#39;re almost done, create yet another script, let&#39;s call it <code>run_tests.R</code> and write the following code in it:</p>

<pre><code class="r">library(testthat) 

source(&quot;path/to/fibo.R&quot;)

test_results &lt;- test_dir(&quot;path/to/tests&quot;, reporter=&quot;summary&quot;)
</code></pre>

<p>After running these lines, and if everything goes well, you should see a message like this:</p>

<pre><code>&gt; library(testthat)
&gt; source(&quot;path/to/fibo.R&quot;)
&gt; test_results &lt;- test_dir(&quot;path/to/tests&quot;, reporter=&quot;summary&quot;)

.
Your tests are dandy! 
</code></pre>

<p>Notice the small <code>.</code> over the message? This means that one test was run successfully. You&#39;ll get one dot per successful
test. If you take a look at <code>test_results</code> you&#39;ll see this:</p>

<pre><code>&gt; test_results
         file context          test nb failed skipped error  user system  real
1 test_fibo.R         Test Fibo(15)  1      0   FALSE FALSE 0.004      0 0.006
</code></pre>

<p>You&#39;ll see each file and each function inside the files that were tested, and also whether the test was skipped, failed
etc. This may seem overkill for such a simple function, but imagine that you write dozens of functions that get more
and more complex over time. You might have to change a lot of lines because as time goes by you add new functionality,
but don&#39;t want to break what was working. Running your unit tests each time you make changes can help you pinpoint 
regressions in your code. Unit tests can also help you start with your code. It can happen that sometimes you don&#39;t
know exactly how to start; well you could start by writing a unit test that returns the result you want to have and 
then try to write the code to make that unit test pass. This is called test-driven development.</p>

<p>I hope that this post motivated you to write unit tests and make you a better R programmer!</p>

</body>
