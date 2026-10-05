# 执行顺序

| 脚本 | 输入 | 输出 |
| --- | --- | --- |
| 01_import.R | 样本清单与 10x 矩阵 | 01_import.rds |
| 02_qc.R | 01_import | 02_qc.rds、QC 表与图 |
| 03_preprocess.R | 02_qc | 03_preprocess.rds、PCA/可选 Harmony |
| 04_cluster.R | 03_preprocess | 04_cluster.rds、UMAP |
| 05_markers.R | 04_cluster | 05_markers.rds、marker 表 |
| 06_annotation.R | 05_markers + 人工注释表 | 最终注释对象与元数据 |

01–05 输出位于 data/interim。每个脚本可在根目录用 Rscript 单独运行。更改参数后必须重新运行对应上游和下游；模板不进行自动缓存失效检测。
