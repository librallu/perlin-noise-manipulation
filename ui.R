shinyUI(pageWithSidebar(
  headerPanel("Perlin Noise Exemples"),
  sidebarPanel(
    sliderInput("mul", "Noise Impact :", min = 0., max = 1., value = 0.7, step = 0.05),
    sliderInput("subspace", "Subspace Length :", min=2,max=20,value=5,step=1),
    br(),
    radioButtons("choice", label="Color Theme", list("Black and White"=1, "Sky"=2,"Fire"=3), selected=1),
    br(),
    radioButtons("method", label="Interpolation Method", list("Linear"=1, "Sinusoidal"=2,"quadratic"=3), selected=3)
  ),
  mainPanel(
    HTML("
         <p>Hi ! The algorithm used in this application is called the Perlin Noise, it was designed by <strong>Ken Perlin</strong>.
         He designed it for making better textures for film Tron.</p>
         <p>With this application, you can create your own textures or world. Please move some parameters
      to see how the image behaves.</p>
      <ul>
        <li>source : <a href=\"http://webstaff.itn.liu.se/~stegu/TNM022-2005/perlinnoiselinks/perlin-noise-math-faq.html\" alt=\"webstaff.itn.liu.se\">webstaff.itn.liu.se</a></li>
        <li>application sources on github : <a href=\"https://github.com/librallu/perlin-noise-manipulation.git\" alt=\"github\">github</a></li>
      </ul>
    "),
    imageOutput("image", height = 300, width=300)
  )
))
