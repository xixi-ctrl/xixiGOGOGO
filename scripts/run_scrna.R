if (!file.exists("xixiGOGOGO.Rproj")) stop("请从仓库根目录运行")
steps <- sort(list.files("analysis/scrna", pattern = "^0[1-5]_.*[.]R$", full.names = TRUE))
for (step in steps) {
  message("Running: ", step)
  source(step, local = new.env(parent = globalenv()))
}
message("完成 01–05。检查结果并填写注释，再运行 06_annotation.R。")
