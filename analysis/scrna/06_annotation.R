source("R/common.R")
bootstrap()
obj <- load_checkpoint("05_markers")
p <- "config/annotations.csv"
if (!file.exists(p)) stop("请填写人工核验后的 config/annotations.csv")
a <- read.csv(p, colClasses = "character")
if (!all(c("cluster", "cell_type") %in% names(a))) stop("需要 cluster 和 cell_type 列")
if (anyNA(a) || anyDuplicated(a$cluster) || any(!nzchar(a$cell_type)) ||
    any(grepl("REPLACE", a$cell_type))) stop("注释包含缺失、重复或占位值")
labels <- a$cell_type[match(as.character(obj$seurat_clusters), a$cluster)]
if (anyNA(labels)) stop("必须覆盖所有 cluster")
names(labels) <- colnames(obj)
obj$cell_type <- labels
saveRDS(obj, "data/processed/scrna_annotated.rds")
write.csv(obj[[]], "results/tables/cell_metadata.csv")
capture.output(sessionInfo(), file = "results/logs/06_annotation_session.txt")
