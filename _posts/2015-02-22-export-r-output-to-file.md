---
layout: post
title: "Export R output to a file"
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

<p>Sometimes it is useful to export the output of a long-running R command. For example, you might want to run a time consuming regression just before leaving work on Friday night, but would like to get the output saved inside your Dropbox folder to take a look at the results before going back to work on Monday.</p>
<p>This can be achieved very easily using <code>capture.output()</code> and <code>cat()</code> like so:</p>
<pre><code>out &lt;- capture.output(summary(my_very_time_consuming_regression))

cat(&quot;My title&quot;, out, file=&quot;summary_of_my_very_time_consuming_regression.txt&quot;, sep=&quot;\n&quot;, append=TRUE)</code></pre>
<p><code>my_very_time_consuming_regression</code> is an object of class <code>lm</code> for example. I save the output of <code>summary(my_very_time_consuming_regression)</code> as text using <code>capture.output</code> and save it in a variable called <code>out</code>. Finally, I save <code>out</code> to a file called <code>summary_of_my_very_time_consuming_regression.txt</code> with the first sentence being <code>My title</code> (you can put anything there). The file <code>summary_of_my_very_time_consuming_regression.txt</code> doesn’t have to already exist in your working directory. The option <code>sep=&quot;\n&quot;</code> is important or else the whole output will be written in a single line. Finally, <code>append=TRUE</code> makes sure your file won’t be overwritten; additional output will be appended to the file, which can be nice if you want to compare different versions of your model.</p>

</body>