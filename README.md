# hw4. Interactive web service for PCA and CA analysis

### Name: 賴映君

### ID: 113753208

### ShinyApps link: [link](https://cying0211.shinyapps.io/113753208/)

## Objective

- Create an interactive web service using ShinyApp to perform Principal Component Analysis (PCA) and Correspondence Analysis (CA).

<p align="center">
<img src="/images/PCA.png" width="48%" height="48%" >
<img src="/images/CA.png" width="48%" height="48%" >
<p/>

## Getting Started

1. **Integrate Example Script**: Integrating the folllowing script into a Shiny application. While `ggbiplot` is recommended for creating biplots in PCA, feel free to explore and use other packages suitable for PCA and CA if necessary.

```
data(iris)
# log transform
log.ir <- log(iris[, 1:4])
ir.species <- iris[, 5]

# apply PCA - scale. = TRUE is highly advisable, but the default is FALSE.
ir.pca <- prcomp(log.ir,center = TRUE, scale. = TRUE)

library(ggbiplot)
g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, groups = ir.species)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', legend.position = 'top')
print(g)

```

1. **Installation of ggbiplot**: The `ggbiplot` package is not available on CRAN and must be installed from GitHub using the following command in RStudio:

```
devtools::install_github("vqv/ggbiplot")

```

1. **Connect [Shinyapps.io](http://shinyapps.io/) with RStudio**:
    - In RStudio, manage your [ShinyApps.io](http://shinyapps.io/) accounts by navigating to `Tools → Global Options → Publishing`. This setup is crucial for publishing your application.
    <p align="center">
    <img src="/images/shinyapp_on_rstudio.png" width="70%" height="70%" >
    <p/>
    - Please organize your Shiny application using the following folder structure, replace `110753xxx` with your actual student number.

```
110753xxx
   |-- 110753xxx.R

```

1. **Preview Your Application**: After completing your Shiny application, preview it in the RStudio console using the appropriate command to initiate your app locally.

```
library(shiny)
runApp("110753xxx")

```

1. **Publish**:
    - On the preview screen, locate the `Publish` button in the upper right corner. Click it to deploy your application to [ShinyApps.io](http://shinyapps.io/).
    - Ensure your application's title on [ShinyApps.io](http://shinyapps.io/) follows this format: `NCCU_DS2024_hw4_studentID`.

<p align="center">
<img src="/images/shinyapp_on_rstudio_2.png" width="60%" height="60%" >
<p/>

## Grading Criteria: Peer Evaluation

### 80 points: Base Tasks

- **20 points** Basic Information Display:
    - Display the following on the application's main page: `name`, `student number`.
    - Input data
- **30 points** PCA Analysis Web Application:
    - Develop a Shiny interactive web application to display PCA analysis for the Iris dataset. Users should be able to select which principal component (PC1, PC2, PC3, etc.) to view.
- **30 points** CA Analysis Web Application:
    - Develop a Shiny interactive web application to display CA for the Iris dataset.

### 20 points: Subjective Criteria

- **4 points** Aesthetics 🌷: Visually appealing interface.
- **4 points** Interactivity 🖥️: User-friendly and responsive interaction design.
- **4 points** Content Richness 📖: In-depth information and well-organized content.
- **up to 8 points** Additional Features: Each feature (listed below) is worth 4 points:
    - Detailed PCA results (e.g., variance explained)
    - ...

### Penalties

### Peer Evaluation Non-Participation

- **5 points** per unreviewed classmate: Failure to participate in the peer evaluation process will result in a deduction of 5 points for each classmate's work that is not evaluated.

### Submission Requirements

- **2 points** Missing ShinyApp Link and Student ID: Ensure your ShinyApp link and student ID are prominently displayed at the top of your `Readme.md`. A deduction of 2 points will apply if this information is missing.
- **2 points** Inaccessible ShinyApp Link: Your project must be published on [shinyapps.io](https://www.shinyapps.io/) with a public link that is accessible. If the link is not accessible, 2 points will be deducted.
- **2 points** Non-Compliant Title Format: The title of your ShinyApp must adhere to the format `NCCU_DS2024_hw4_studentID`. Failure to follow this format will result in a 2-point deduction.

Ensure all required elements are correctly implemented to avoid these penalties.

## Important Notes

- **R Version**: Ensure you use R version 4 for this assignment.
- **No Makeup Assignments**: Late submissions will not be accepted.
- **Peer Evaluation Process**:
    - Each student's project will be evaluated by 5-6 randomly selected peers.
    - The final score for each project will be the average of these evaluations.
    - Students are required to participate in evaluating others' projects; failure to do so will result in point deductions.
    - Peer evaluations will commence one week after the assignment due date.

## Examples

- https://changlab.shinyapps.io/ggvisExample/
- https://smalleyes.shinyapps.io/NCCU_DS2023_hw4_110753202/

## References

🗣️:80 分：基礎任務
20分基本資訊顯示：
在應用程式的主頁面上顯示以下內容：name，student number。
輸入資料
30 分PCA 分析 Web 應用程式：
開發一個 Shiny 互動式 Web 應用程式來顯示 Iris 資料集的 PCA 分析。使用者應該能夠選擇要查看哪個主成分（PC1、PC2、PC3 等）。
30 分CA 分析 Web 應用程式：
開發一個 Shiny 互動式 Web 應用程式來顯示 Iris 資料集的 CA。提供我程式碼，並明確區分ui.r、server.r、113753208.r的內容

🤖:

✅ `ui.R` — 使用者介面

```r
library(shiny)

fluidPage(
  titlePanel("PCA & CA 分析 - Iris 資料集"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("姓名：xxx"),
      helpText("學號：113753208"),
      selectInput("pc_x", "選擇主成分 X 軸", choices = c("PC1", "PC2", "PC3"), selected = "PC1"),
      selectInput("pc_y", "選擇主成分 Y 軸", choices = c("PC2", "PC3", "PC1"), selected = "PC2"),
      checkboxInput("scale", "啟用標準化 (scale)", value = TRUE),
      actionButton("showCA", "顯示 CA 分析圖")
    ),
    
    mainPanel(
      plotOutput("pcaPlot"),
      plotOutput("caPlot")
    )
  )
)

```

✅ `server.R` — 伺服端邏輯

```r

library(shiny)
library(ggbiplot)
library(FactoMineR)
library(factoextra)

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
         scale_color_discrete(name = '') +
         theme(legend.direction = 'horizontal',
               legend.position = 'top')
    
    print(g)
  })
  
  output$caPlot <- renderPlot({
    req(input$showCA)
    iris.ca <- CA(iris[, 1:4], graph = FALSE)
    fviz_ca_biplot(iris.ca)
  })
}

```

✅ `113753208.R` — 主啟動檔案（會執行 `ui.R` 與 `server.R`）

```r

library(shiny)

shinyApp(
  ui = source("ui.R")$value,
  server = source("server.R")$value
)

```

📁 資料夾結構範例：

```r
113753208/
│
├── 113753208.R
├── ui.R
└── server.R
```

🗣️:圖忽大忽小可以如何改進

🤖:

當你在 Shiny 應用程式中使用 `ggbiplot` 或 `ggplot2` 畫圖時，**圖形忽大忽小** 通常是因為下列幾個因素造成的：

---

## ✅ 原因與解法

### 🟡 **原因 1：瀏覽器視窗大小變動影響**

Shiny 中 `plotOutput()` 會依據頁面寬度自動調整圖的尺寸。

🔧 **解法：給 plotOutput 固定寬高**

在 `ui.R` 的 `mainPanel()` 裡設定：

```r
mainPanel(
  plotOutput("pcaPlot", height = "600px", width = "800px"),
  plotOutput("caPlot", height = "600px", width = "800px")
)

```

---

### 🟡 **原因 2：ggbiplot 預設會根據資料比例自動調整座標軸**

🔧 **解法：固定 x/y 軸比例或範圍**

你可以在 `ggbiplot` 加上 `coord_fixed()` 或使用 `xlim()` / `ylim()` 來固定圖形範圍。例如：

```r
g <- ggbiplot(ir.pca,
              choices = c(pcs[input$pc_x], pcs[input$pc_y]),
              obs.scale = 1,
              var.scale = 1,
              groups = ir.species) +
     scale_color_discrete(name = '') +
     theme(legend.direction = 'horizontal',
           legend.position = 'top') +
     coord_fixed()

```

---

### 🟡 **原因 3：裝置 DPI 或螢幕縮放造成的比例差異**

Shiny 預設會讓圖片依據瀏覽器顯示裝置渲染，這在高 DPI 螢幕下可能會變形。

🔧 **解法：使用 `renderPlot({...}, res = 96)` 設定 DPI**

在 `server.R` 的 `renderPlot()` 中：

```r
output$pcaPlot <- renderPlot({
  # ... 你的作圖程式碼 ...
}, res = 96)

```

---

## ✳️ 綜合建議修改示範

### ✅ `ui.R`

```r
mainPanel(
  plotOutput("pcaPlot", height = "600px", width = "800px"),
  plotOutput("caPlot", height = "600px", width = "800px")
)

```

### ✅ `server.R`

```r
output$pcaPlot <- renderPlot({
  pcs <- c("PC1" = 1, "PC2" = 2, "PC3" = 3)

  ir.pca <- prcomp(log.ir, center = TRUE, scale. = input$scale)

  g <- ggbiplot(ir.pca,
                choices = c(pcs[input$pc_x], pcs[input$pc_y]),
                obs.scale = 1,
                var.scale = 1,
                groups = ir.species) +
       scale_color_discrete(name = '') +
       theme(legend.direction = 'horizontal',
             legend.position = 'top') +
       coord_fixed()

  print(g)
}, res = 96)  # 設定解析度避免失真

```

---

如果你想要 **根據主成分自動決定 x/y 軸範圍但不讓圖亂縮放**，我也可以幫你動態計算範圍，告訴我即可 🙌

🗣️:幫我豐富畫面，如使用分頁標籤或使資料呈現更完整等，你可以自由發揮，但需要明確告訴我哪幾個檔案程式碼需要修改或新增那些檔案

🤖:

以下是你原本的 Shiny App 改進版，畫面更加豐富，加入了：

1. **分頁標籤（tabsetPanel）**：區分 PCA 與 CA 分析頁面。
2. **資料總覽頁面**：新增一個「資料預覽」分頁讓使用者看到原始資料（Iris 資料集）。
3. **資料表格與說明文字**：使用 `tableOutput` 呈現資料；使用 `verbatimTextOutput` 顯示 PCA Summary。
4. **固定繪圖大小**：設定 `plotOutput` 的 `height` 與 `width`。

---

### 📂 需要的檔案與內容說明

以下假設你的資料夾為：`c:/Users/user/Desktop/nccu/11302DS/hw4/113753208`

### ✅ `ui.R`（**需新增或覆蓋**）

```r
library(shiny)

fluidPage(
  titlePanel("PCA & CA 分析 - Iris 資料集"),

  sidebarLayout(
    sidebarPanel(
      helpText("姓名：賴映君"),
      helpText("學號：113753208"),
      selectInput("pc_x", "選擇主成分 X 軸", choices = c("PC1", "PC2", "PC3"), selected = "PC1"),
      selectInput("pc_y", "選擇主成分 Y 軸", choices = c("PC2", "PC3", "PC1"), selected = "PC2"),
      checkboxInput("scale", "啟用標準化 (scale)", value = TRUE),
      actionButton("showCA", "顯示 CA 分析圖")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("PCA 雙標圖",
                 plotOutput("pcaPlot", height = "500px", width = "700px"),
                 verbatimTextOutput("pcaSummary")),
        tabPanel("CA 雙標圖",
                 plotOutput("caPlot", height = "500px", width = "700px")),
        tabPanel("資料預覽",
                 tableOutput("irisData"))
      )
    )
  )
)

```

---

### ✅ `server.R`（**需新增或覆蓋**）

```r
library(shiny)
library(ggbiplot)
library(FactoMineR)
library(factoextra)

function(input, output) {

  data(iris)
  log.ir <- log(iris[, 1:4])
  ir.species <- iris[, 5]

  pcs <- c("PC1" = 1, "PC2" = 2, "PC3" = 3)

  output$pcaPlot <- renderPlot({
    ir.pca <- prcomp(log.ir, center = TRUE, scale. = input$scale)
    g <- ggbiplot(ir.pca,
                  choices = c(pcs[input$pc_x], pcs[input$pc_y]),
                  obs.scale = 1,
                  var.scale = 1,
                  groups = ir.species) +
         coord_fixed(ratio = 1) +  # 固定圖形比例
         scale_color_discrete(name = '') +
         theme(legend.direction = 'horizontal', legend.position = 'top')
    print(g)
  })

  output$pcaSummary <- renderPrint({
    ir.pca <- prcomp(log.ir, center = TRUE, scale. = input$scale)
    summary(ir.pca)
  })

  output$caPlot <- renderPlot({
    req(input$showCA)
    iris.ca <- CA(iris[, 1:4], graph = FALSE)
    fviz_ca_biplot(iris.ca)
  })

  output$irisData <- renderTable({
    head(iris, 10)
  })
}

```

---

### ✅ `113753208.R`（你可以保留目前版本或改用上述的 `ui.R + server.R` 架構）

如果你使用 `113753208.R`，請包成以下格式（Shiny 單一檔案應用）：

```r
library(shiny)
library(ggbiplot)
library(FactoMineR)
library(factoextra)

ui <- fluidPage(
  titlePanel("PCA & CA 分析 - Iris 資料集"),

  sidebarLayout(
    sidebarPanel(
      helpText("姓名：賴映君"),
      helpText("學號：113753208"),
      selectInput("pc_x", "選擇主成分 X 軸", choices = c("PC1", "PC2", "PC3"), selected = "PC1"),
      selectInput("pc_y", "選擇主成分 Y 軸", choices = c("PC2", "PC3", "PC1"), selected = "PC2"),
      checkboxInput("scale", "啟用標準化 (scale)", value = TRUE),
      actionButton("showCA", "顯示 CA 分析圖")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("PCA 雙標圖",
                 plotOutput("pcaPlot", height = "500px", width = "700px"),
                 verbatimTextOutput("pcaSummary")),
        tabPanel("CA 雙標圖",
                 plotOutput("caPlot", height = "500px", width = "700px")),
        tabPanel("資料預覽",
                 tableOutput("irisData"))
      )
    )
  )
)

server <- function(input, output) {
  data(iris)
  log.ir <- log(iris[, 1:4])
  ir.species <- iris[, 5]
  pcs <- c("PC1" = 1, "PC2" = 2, "PC3" = 3)

  output$pcaPlot <- renderPlot({
    ir.pca <- prcomp(log.ir, center = TRUE, scale. = input$scale)
    g <- ggbiplot(ir.pca,
                  choices = c(pcs[input$pc_x], pcs[input$pc_y]),
                  obs.scale = 1,
                  var.scale = 1,
                  groups = ir.species) +
         coord_fixed(ratio = 1) +
         scale_color_discrete(name = '') +
         theme(legend.direction = 'horizontal', legend.position = 'top')
    print(g)
  })

  output$pcaSummary <- renderPrint({
    ir.pca <- prcomp(log.ir, center = TRUE, scale. = input$scale)
    summary(ir.pca)
  })

  output$caPlot <- renderPlot({
    req(input$showCA)
    iris.ca <- CA(iris[, 1:4], graph = FALSE)
    fviz_ca_biplot(iris.ca)
  })

  output$irisData <- renderTable({
    head(iris, 10)
  })
}

shinyApp(ui = ui, server = server)

```

🗣️:讓使用者查看、排序、搜尋資料。

🤖:

要在你的 Shiny App 中加入 **資料表格呈現（使用 `DT` 套件）**，你需要同時修改兩個檔案：

---

## ✅ 需要修改的檔案：

### 🔧 1. `ui.R` — 增加資料表的顯示區域（建議放入分頁中）

**修改重點：**

- 載入 `DT` 套件（可省略，主要影響程式碼補全）
- 在 `mainPanel()` 的 `tabsetPanel()` 中加入新的頁籤顯示資料表

```r
library(shiny)
library(DT)  # 新增這行

fluidPage(
  titlePanel("PCA & CA 分析 - Iris 資料集"),

  sidebarLayout(
    sidebarPanel(
      helpText("姓名：賴映君"),
      helpText("學號：113753208"),
      selectInput("pc_x", "選擇主成分 X 軸", choices = c("PC1", "PC2", "PC3"), selected = "PC1"),
      selectInput("pc_y", "選擇主成分 Y 軸", choices = c("PC2", "PC3", "PC1"), selected = "PC2"),
      checkboxInput("scale", "啟用標準化 (scale)", value = TRUE),
      checkboxInput("showCA", "顯示 CA 分析圖", value = TRUE)
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("PCA 圖", plotOutput("pcaPlot")),
        tabPanel("CA 圖", plotOutput("caPlot")),
        tabPanel("原始資料表", DT::dataTableOutput("dataTable"))  # 新增這行
      )
    )
  )
)

```

---

### 🔧 2. `server.R` — 增加 `DT` 表格輸出邏輯

**修改重點：**

- 載入 `DT` 套件
- 增加 `output$dataTable` 的 `renderDataTable` 程式碼

```r
library(shiny)
library(ggbiplot)
library(FactoMineR)
library(factoextra)
library(DT)  # 新增這行

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
         scale_color_discrete(name = '') +
         theme(legend.direction = 'horizontal',
               legend.position = 'top') +
         coord_fixed()  # 固定比例
    print(g)
  })

  output$caPlot <- renderPlot({
    req(input$showCA)
    iris.ca <- CA(iris[, 1:4], graph = FALSE)
    fviz_ca_biplot(iris.ca)
  })

  # 新增：資料表格輸出
  output$dataTable <- DT::renderDataTable({
    iris
  })
}

```

---

**部署應用程式**：

完成帳號設定後，重新執行以下命令來部署應用程式：

```r
rsconnect::deployApp("c:/Users/user/Desktop/nccu/11302DS/hw4/113753208")
```