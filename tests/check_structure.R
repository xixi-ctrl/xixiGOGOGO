# 无需 Seurat：解析所有 R 文件并验证模板元数据。
files <- list.files(".", pattern = "[.]R$", recursive = TRUE, full.names = TRUE)
files <- files[!grepl("/renv/", files)]
for (f in files) parse(f)
source("R/common.R")
source("config/analysis.R")
config$samples <- "config/samples.example.csv"
s <- read_samples()
stopifnot(nrow(s) == 2L, !anyDuplicated(s$sample_id))
message("R 语法和样本清单检查通过；未运行真实数据分析。")
