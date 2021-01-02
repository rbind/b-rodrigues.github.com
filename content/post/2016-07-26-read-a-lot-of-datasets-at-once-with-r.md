---
date: 2016-07-26T00:00:00+00:00
title: "Read a lot of datasets at once with R"
tags: [R]
menu:
  main:
    parent: Blog
    identifier: /blog/readall_R
    weight: 11
---


<p>I often have to read a lot of datasets at once using R. So I’ve wrote the following function to solve this issue:</p>
<pre class="r"><code>read_list &lt;- function(list_of_datasets, read_func){

        read_and_assign &lt;- function(dataset, read_func){
                dataset_name &lt;- as.name(dataset)
                dataset_name &lt;- read_func(dataset)
        }

        # invisible is used to suppress the unneeded output
        output &lt;- invisible(
                sapply(list_of_datasets,
                           read_and_assign, read_func = read_func, simplify = FALSE, USE.NAMES = TRUE))

        # Remove the extension at the end of the data set names
        names_of_datasets &lt;- c(unlist(strsplit(list_of_datasets, &quot;[.]&quot;))[c(T, F)])
        names(output) &lt;- names_of_datasets
        return(output)
}</code></pre>
<p>You need to supply a list of datasets as well as the function to read the datasets to <code>read_list</code>. So for example to read in <code>.csv</code> files, you could use <code>read.csv()</code> (or <code>read_csv()</code> from the <code>readr</code> package, which I prefer to use), or <code>read_dta()</code> from the package <code>haven</code> for STATA files, and so on.</p>
<p>Now imagine you have some data in your working directory. First start by saving the name of the datasets in a variable:</p>
<pre class="r"><code>data_files &lt;- list.files(pattern = &quot;.csv&quot;)

print(data_files)</code></pre>
<pre><code>## [1] &quot;data_1.csv&quot; &quot;data_2.csv&quot; &quot;data_3.csv&quot;</code></pre>
<p>Now you can read all the data sets and save them in a list with <code>read_list()</code>:</p>
<pre class="r"><code>library(&quot;readr&quot;)
library(&quot;tibble&quot;)

list_of_data_sets &lt;- read_list(data_files, read_csv)


glimpse(list_of_data_sets)</code></pre>
<pre><code>## List of 3
##  $ data_1:Classes 'tbl_df', 'tbl' and 'data.frame':  19 obs. of  3 variables:
##   ..$ col1: chr [1:19] &quot;0,018930679&quot; &quot;0,8748013128&quot; &quot;0,1025635934&quot; &quot;0,6246140983&quot; ...
##   ..$ col2: chr [1:19] &quot;0,0377725807&quot; &quot;0,5959457638&quot; &quot;0,4429121533&quot; &quot;0,558387159&quot; ...
##   ..$ col3: chr [1:19] &quot;0,6241767189&quot; &quot;0,031324594&quot; &quot;0,2238059868&quot; &quot;0,2773350732&quot; ...
##  $ data_2:Classes 'tbl_df', 'tbl' and 'data.frame':  19 obs. of  3 variables:
##   ..$ col1: chr [1:19] &quot;0,9098418493&quot; &quot;0,1127788509&quot; &quot;0,5818891392&quot; &quot;0,1011773532&quot; ...
##   ..$ col2: chr [1:19] &quot;0,7455905887&quot; &quot;0,4015039612&quot; &quot;0,6625796605&quot; &quot;0,029955339&quot; ...
##   ..$ col3: chr [1:19] &quot;0,327232932&quot; &quot;0,2784035673&quot; &quot;0,8092386735&quot; &quot;0,1216045306&quot; ...
##  $ data_3:Classes 'tbl_df', 'tbl' and 'data.frame':  19 obs. of  3 variables:
##   ..$ col1: chr [1:19] &quot;0,9236124896&quot; &quot;0,6303271761&quot; &quot;0,6413583054&quot; &quot;0,5573887416&quot; ...
##   ..$ col2: chr [1:19] &quot;0,2114708388&quot; &quot;0,6984538266&quot; &quot;0,0469865249&quot; &quot;0,9271510226&quot; ...
##   ..$ col3: chr [1:19] &quot;0,4941919971&quot; &quot;0,7391538511&quot; &quot;0,3876723797&quot; &quot;0,2815014394&quot; ...</code></pre>
<p>If you prefer not to have the datasets in a list, but rather import them into the global environment, you can change the above function like so:</p>
<pre class="r"><code>read_list &lt;- function(list_of_datasets, read_func){

        read_and_assign &lt;- function(dataset, read_func){
                assign(dataset, read_func(dataset), envir = .GlobalEnv)
        }

        # invisible is used to suppress the unneeded output
        output &lt;- invisible(
                sapply(list_of_datasets,
                           read_and_assign, read_func = read_func, simplify = FALSE, USE.NAMES = TRUE))

}</code></pre>
<p>But I personnally don’t like this second option, but I put it here for completeness.</p>

