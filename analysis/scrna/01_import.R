source("R/common.R")
bootstrap()
samples <- read_samples()
objects <- lapply(seq_len(nrow(samples)), function(i) {
  s <- samples[i, ]
  if (!dir.exists(s$data_path)) stop("数据目录不存在：", s$data_path)
  counts <- Read10X(s$data_path)
  if (is.list(counts)) {
    if (!"Gene Expression" %in% names(counts)) stop("多模态输入缺少 Gene Expression")
    counts <- counts[["Gene Expression"]]
  }
  obj <- CreateSeuratObject(counts, project = s$sample_id)
  for (col in setdiff(names(samples), "data_path")) obj[[col]] <- s[[col]]
  pattern <- if (s$species == "human") "^MT-" else "^mt-"
  if (!any(grepl(pattern, rownames(obj)))) stop("未识别到线粒体基因；请核对基因命名。")
  obj[["percent.mt"]] <- PercentageFeatureSet(obj, pattern = pattern)
  obj
})
if (length(objects) == 1L) {
  obj <- RenameCells(objects[[1]], add.cell.id = samples$sample_id[1])
} else {
  obj <- merge(objects[[1]], y = objects[-1], add.cell.ids = samples$sample_id)
}
checkpoint(obj, "01_import")
