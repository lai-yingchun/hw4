library(shiny)
library(ggbiplot)
library(FactoMineR)
library(factoextra)
library(DT)

function(input, output) {
  
  data(iris)
  log.ir <- log(iris[, 1:4])
  ir.species <- iris[, 5]


  output$pcaPlot <- renderPlot({
    pcs <- c("PC1" = 1, "PC2" = 2, "PC3" = 3)

    ir.pca <- prcomp(log.ir, center = TRUE, scale. = input$scale)
    g <- ggbiplot(ir.pca,
                  choices = c(pcs[input$pc_x], pcs[input$pc_y]),
                  obs.scale = 1,
                  var.scale = 1,
                  groups = ir.species) +
         coord_fixed(ratio = 1) +  # 固定圖形比例
         scale_color_discrete(name = '') +
         theme(legend.direction = 'horizontal', legend.position = 'top')+
         coord_fixed(ratio = 1) +       # 固定XY比例
         xlim(-3, 3) + ylim(-3, 3)      # 固定座標軸範圍，避免忽大忽小

    print(g)
  })
  
  output$pcaSummary <- renderPrint({
    ir.pca <- prcomp(log.ir, center = TRUE, scale. = input$scale)
    summary(ir.pca)
  })

  output$caPlot <- renderPlot({
    iris.ca <- CA(iris[, 1:4], graph = FALSE)
    fviz_ca_biplot(iris.ca)
  })

  output$dataTable <- DT::renderDataTable({
    iris
  })

}
