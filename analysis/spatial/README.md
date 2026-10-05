# 空间转录组扩展入口（尚未实现）

计划脚本：01_import.R → 02_qc.R → 03_normalize.R → 04_mapping.R → 05_spatial_statistics.R。

原始数据放 `data/raw/spatial/<sample_id>/`，包括 counts、坐标、组织图像、比例尺与平台输出。根据平台选用 Seurat 空间读取函数；当前 scRNA 入口不读取空间数据。输出放 `data/processed/spatial/`、`results/figures/spatial/`、`results/tables/spatial/`。

保留 donor_id、sample_id、section_id 和平台；检查图像配准、组织内 spot、坐标单位与分辨率。多切片保留供者对应关系。spot 不是独立生物学重复；细胞类型映射须验证参考数据适用性，报告不确定性和空间自相关处理。扩展依赖须进入 renv.lock。
