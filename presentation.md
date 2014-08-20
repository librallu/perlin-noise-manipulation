Perlin Noise Manipulation
========================================================
author: Luc Libralesso
date: Wed Aug 20 12:06:24 2014
transition: fade

What is 'Perlin Noise Manipulation' application ?
========================================================

This application allows you to 
interact with a very fun algorithm used to generate :
 
 - textures for the film *Tron*
 - world maps in some video games like *Minecraft*
 - And so on...
  
You can find more details here : http://www.noisemachine.com/talk1/index.html


How it can be used ?
========================================================

Go on http://librallu.shinyapps.io/someNoise/

You just need to play with the user interface, move 
some parameters to see what changes on the results.

I think this can be a very usefull app for observating
what are the parameters that gives the better results.


point : Color Theme
========================================================

To make color, we apply a linear transformation for red, green and blue components.
Let's see what does it looks like for Sky theme:

![plot of chunk unnamed-chunk-1](presentation-figure/unnamed-chunk-1.png) 


point : Interpolation Method
========================================================

We can use $3$ types of interpolation.

We can see them on the following plot :

![plot of chunk unnamed-chunk-2](presentation-figure/unnamed-chunk-2.png) 
