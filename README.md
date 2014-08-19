perlin-noise-manipulation
=========================

A simple Perlin Noise Manipulation Tool with R and shiny

In the web version, the application use a 50x50 image for the output. Perlin 
algorithm can do better, but it's faster for an online version.

An online version is available on shinyapps.io : http://librallu.shinyapps.io/someNoise/

Interactions
============

User can change :
 - noise impact : adds noise to the output
 - subspace length : Choose the peak frequency
 - color theme : [Black and White, Sky, Fire] Change output color theme
 - interpolation method : [linear, sinusoidal, quadratic] linear and sinusoidal are simplier but quadratic method has better rendering.
 