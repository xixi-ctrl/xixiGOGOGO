# 首次安装需要网络及操作系统编译依赖；已存在 lockfile 时直接 restore。
if (!file.exists("xixiGOGOGO.Rproj")) stop("请从仓库根目录运行")
options(repos = c(CRAN = "https://cloud.r-project.org"))
if (!requireNamespace("renv", quietly = TRUE)) install.packages("renv")
if (file.exists("renv.lock")) {
  renv::restore(prompt = FALSE)
} else {
  renv::init(bare = TRUE, restart = FALSE)
  renv::install(c("Seurat", "harmony"))
  if (packageVersion("Seurat") < "5.0.0") stop("需要 Seurat >= 5")
  renv::snapshot(type = "all", prompt = FALSE)
}
