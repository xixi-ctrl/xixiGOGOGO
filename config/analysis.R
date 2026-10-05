# 示例阈值，不能直接视为已验证的最佳参数。
config <- list(
  seed = 2026L, samples = "config/samples.csv",
  min_features = 200L, max_features = 8000L,
  max_counts = 30000L, max_percent_mt = 20,
  variable_features = 2000L, npcs = 30L,
  resolution = 0.5, integration = "none" # "none" 或 "harmony"
)
