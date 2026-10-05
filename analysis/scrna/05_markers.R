source("R/common.R")
bootstrap()
obj <- load_checkpoint("04_cluster")
DefaultAssay(obj) <- "RNA"
obj[["RNA"]] <- JoinLayers(obj[["RNA"]])
markers <- FindAllMarkers(obj, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)
write.csv(markers, "results/tables/cluster_markers.csv", row.names = FALSE)
# 仅用于探索性注释，不能替代供者层面的组间统计。
checkpoint(obj, "05_markers")
