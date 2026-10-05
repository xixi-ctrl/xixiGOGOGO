bootstrap <- function() {
  if (!file.exists("xixiGOGOGO.Rproj")) stop("请从仓库根目录运行。")
  source("config/analysis.R", local = .GlobalEnv)
  if (!requireNamespace("Seurat", quietly = TRUE)) stop("先运行 scripts/setup.R")
  if (packageVersion("Seurat") < "5.0.0") stop("需要 Seurat >= 5")
  suppressPackageStartupMessages(library(Seurat))
  set.seed(config$seed)
  for (p in c("data/interim", "data/processed", "results/figures", "results/tables", "results/logs"))
    dir.create(p, recursive = TRUE, showWarnings = FALSE)
}
read_samples <- function() {
  if (!file.exists(config$samples)) stop("请复制并填写 config/samples.csv")
  x <- read.csv(config$samples, stringsAsFactors = FALSE, check.names = FALSE)
  cols <- c("sample_id", "donor_id", "condition", "batch", "species", "data_path")
  if (!all(cols %in% names(x)) || !nrow(x)) stop("样本清单缺少必需列或为空。")
  if (anyNA(x[cols]) || any(vapply(x[cols], function(z) any(!nzchar(trimws(z))), logical(1))))
    stop("样本清单存在缺失值。")
  if (anyDuplicated(x$sample_id)) stop("sample_id 必须唯一。")
  if (length(unique(x$species)) != 1L || !all(x$species %in% c("human", "mouse")))
    stop("每次运行仅支持一种物种：human 或 mouse。")
  x
}
checkpoint <- function(object, name) {
  saveRDS(object, file.path("data/interim", paste0(name, ".rds")))
  capture.output(sessionInfo(), file = file.path("results/logs", paste0(name, "_session.txt")))
}
load_checkpoint <- function(name) {
  p <- file.path("data/interim", paste0(name, ".rds"))
  if (!file.exists(p)) stop("缺少上一步输出：", p)
  readRDS(p)
}
