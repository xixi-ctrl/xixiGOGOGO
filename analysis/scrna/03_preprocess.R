source("R/common.R")
bootstrap()
obj <- load_checkpoint("02_qc")
DefaultAssay(obj) <- "RNA"
# 显式合并后按技术批次拆分，而不是按 condition 拆分。
obj[["RNA"]] <- JoinLayers(obj[["RNA"]])
if (!config$integration %in% c("none", "harmony")) stop("未知整合方法")
if (config$integration == "harmony") {
  if (length(unique(obj$batch)) < 2L) stop("Harmony 需要至少两个 batch")
  if (!requireNamespace("harmony", quietly = TRUE)) stop("需要安装 harmony 并更新 lockfile")
  obj[["RNA"]] <- split(obj[["RNA"]], f = obj$batch)
}
obj <- NormalizeData(obj)
obj <- FindVariableFeatures(obj, nfeatures = config$variable_features)
obj <- ScaleData(obj, features = VariableFeatures(obj))
npcs <- min(config$npcs, length(VariableFeatures(obj)) - 1L, ncol(obj) - 1L)
if (npcs < 2L) stop("细胞或可变基因数量不足。")
obj <- RunPCA(obj, npcs = npcs)
if (config$integration == "harmony")
  obj <- IntegrateLayers(obj, method = HarmonyIntegration, orig.reduction = "pca", new.reduction = "harmony")
checkpoint(obj, "03_preprocess")
