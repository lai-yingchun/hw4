library(shiny)
library(DT)

fluidPage(
  titlePanel("PCA & CA 分析 - Iris 資料集"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("姓名：賴映君"),
      helpText("學號：113753208"),
      selectInput("pc_x", "選擇主成分 X 軸", choices = c("PC1", "PC2", "PC3"), selected = "PC1"),
      selectInput("pc_y", "選擇主成分 Y 軸", choices = c("PC2", "PC3", "PC1"), selected = "PC2"),
      checkboxInput("scale", "啟用標準化 (scale)", value = TRUE),
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("PCA 雙標圖",
                 plotOutput("pcaPlot", height = "500px", width = "700px"),
                 verbatimTextOutput("pcaSummary")),
        tabPanel("CA 雙標圖",
                 plotOutput("caPlot", height = "500px", width = "700px")),
        tabPanel("資料預覽",
                #  tableOutput("irisData"))
                tabPanel("原始資料表", DT::dataTableOutput("dataTable")),
      )
    )
  )
)
)
