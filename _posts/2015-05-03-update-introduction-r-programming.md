---
layout: post
title: "Update to Introduction to programming econometrics with R"
description: ""
category: 
tags: [R]
---
{% include JB/setup %}


This semester I taught a course on applied econometrics with the R programming language. For this, I created a document that I gave to my students and shared online. This is the kind of document I would have liked to read when I first started using R. I already had some programming experience in C and Pascal but this is not necessarily the case for everyone that is confronted to R when they start learning about econometrics.

This is why the beginning of the document focuses more on general programming knowledge and techniques, and then only on econometrics. People online seemed to like the document, as I've received some positive comments by David Smith from Revolution R (read his blog post about the document [here](http://blog.revolutionanalytics.com/2015/01/introduction-to-applied-econometrics-with-r.html)) and Dave Giles which links to David's blog post [here](http://davegiles.blogspot.fr/2015/04/introduction-to-applied-econometrics.html?spref=tw). People on twitter have also retweeted David's and Dave's tweets to their blog posts and I've received some requests by people to send them the PDF by email (because they live in places where Dropbox is not accessible unfortunately).

The document is still a work in progress (and will probably remain so for a long time), but I've added some new sections about reproducible research and thought that this update could warrant a new blog post. 

For now, only linear models are reviewed, but I think I'll start adding some chapters about non-linear models soonish. The goal for these notes, however, is not to re-invent the wheel: there are lots of good books about econometrics with R out there and packages that estimate a very wide range of models. What I want for these notes, is to focus more on the programming knowledge an econometrician needs, in a very broad and general sense. I want my students to understand that R is a true programming language, and that they need to use every feature offered by such a language, and not think of R as a black box into which you only type pre-programmed commands, but also be able to program their own routines.

Also, I've made it possible to create the PDF using a Makefile. This may be useful for people that do not have access to Dropbox, but are familiar with git.

You can compile the book in two ways: first download the whole repository:

`git clone git@bitbucket.org:b-rodrigues/programmingeconometrics.git`

and then, with Rstudio, open the file *appliedEconometrics.Rnw* and knit it. Another solution is to use the Makefile. Just type:

`make`

inside a terminal (should work on GNU+Linux and OSX systems) and it should compile the document. You may get some message about "additional information" for some R packages. When these come up, just press Q on your keyboard to continue the compilation process.

Get the notes [here](https://cloud.openmailbox.org/index.php/s/ghZwBxMb24tWGSL).

As always, if you have questions or suggestions, do not hesitate to send me an email: [brodrigues@unistra.fr](mailto:brodrigues@unistra.fr) and I sure hope you'll find these notes useful!
