
library(png) # For writePNG function


shinyServer(function(input, output, session) {
  output$image <- renderImage({
    # Get width and height of image
    width  <- session$clientData$output_image_width
    height <- session$clientData$output_image_height
  
    # Creates tmp file for the image
    outfile <- tempfile(fileext = ".png")
    
    # Generating image
    mul <- input$mul
    subspace <- input$subspace
    choice <- input$choice
    method <- input$method
    pic <- noise(100,100,subspace,mul,choice,method)
    # Writing image
    writePNG(pic, target = outfile)
    
    # Return a list containing information about the image
    list(src = outfile,
         contentType = "image/png",
         width = width,
         height = height,
         alt = "This is alternate text")
    
  }, deleteFile = TRUE)

})

# Adding some noise to the perlin function
noise <- function(w,h,subspace,mul,choice,method){
  iterations <- 5          # number of iterations to the noise
  img <- perlin(subspace,w,h,method)   # initial perlin noise
  for( i in 2:iterations )
    img <- img + mul^i * perlin(2^i,w,h,method) # applying additional noise to img
  gen_picture(img,w,h,choice)
}

# Make beautiful pictures
gen_picture <- function(img,w,h,choice){
  # make img values between 0 and 1
  maxi <- max(c(img))
  mini <- min(c(img))
  for ( i in 1:w )
    for ( j in 1:h )
      img[i,j] <- (img[i,j]-mini)/(maxi-mini)
  
  # color choice
  if ( choice == 1) blackwhite(img,w,h)
  else if ( choice == 2 ) sky(img,w,h)
  else fire(img,w,h)
}

blackwhite <- function(img,w,h){
  array(c(img,img,img), dim=c(w,h,3))
}

# used to generate cloud textures
sky <- function(img,w,h){
  res <- array(w*h*3, dim=c(w,h,3))
  for ( i in 1:w )
    for ( j in 1:h ){
      v <- img[i,j]
      res[i,j,2] <- (1.-v)*2/3.
      res[i,j,1] <- (1.-v)*4/5.
      res[i,j,3] <- 1.
    }
  res
}

# used to generate cloud textures
fire <- function(img,w,h){
  res <- array(w*h*3, dim=c(w,h,3))
  for ( i in 1:w )
    for ( j in 1:h ){
      v <- img[i,j]
      res[i,j,1] <- 1.
      res[i,j,2] <- 1.-v
      res[i,j,3] <- 0.
    }
  res
}

# create consistent noise
# algorithm here : http://webstaff.itn.liu.se/~stegu/TNM022-2005/perlinnoiselinks/perlin-noise-math-faq.html
perlin <- function(n,w,h,method){
    vector <- array(rnorm(n*n), dim=c(n,n))
    # n and m are vector sizes
    # w and h are image dimentions
    
    noise2d <- function(x,y){
      # getting x0,y0 values as i,j
      i <- floor(x)
      j <- floor(y)
      
      # The 4 grid points bounding (x,y)
      v1 <- vector[i,j]
      v2 <- vector[i+1,j]
      v3 <- vector[i,j+1]
      v4 <- vector[i+1,j+1]

      # vectors going from the grid to (x,y)
      u1 <- c(x,y)-c(i,j)
      u2 <- c(x,y)-c(i+1,j)
      u3 <- c(x,y)-c(i,j+1)
      u4 <- c(x,y)-c(i+1,j+1)

      # calculating s,t,u,v
      s <- sum(v1*u1) 
      t <- sum(v2*u2) 
      u <- sum(v3*u3) 
      v <- sum(v4*u4)

      # now calculating noise2d(x,y) value

      # some interpolation functions
      ease <- function(p) 3*p^2-2*p^3
      linear <- function(p) p
      sinus <- function(p) sin(p*pi/2)
      
      # choose one of ease, linear or sinus
      if ( method == 1 ) choice <- linear
      else if ( method == 2 ) choice <- sinus
      else choice <- ease
      
      p <- choice(x-i)    # get delta between x and i
      q <- choice(y-j)    # get delta between y and j
      mid1 <- (1-p)*s+p*t # get mid point between s and t
      mid2 <- (1-p)*u+p*v # get mid point between u and v
      (1-q)*mid1+q*mid2   # get mid point between mid1, mid2
    }
    
    # defining x,y spaces
    xs <- seq(from=1, to=n, length=w+1)[-(w+1)]
    ys <- seq(from=1, to=n, length=h+1)[-(h+1)]
    outer(xs,ys,Vectorize(noise2d))
}

