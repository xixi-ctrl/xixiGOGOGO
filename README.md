# xixiGOGOGO · 单细胞 RNA-seq 分析

以 Seurat v5 为核心的可扩展研究项目骨架。当前提供 10x 数据导入、QC、LogNormalize、可选 Harmony 整合、聚类、探索性 marker 检测与人工注释导入；空间转录组与供者层面的 pseudobulk 为后续扩展入口，尚未实现完整统计分析。

## 目录约定

| 路径 | 用途 |
| --- | --- |
| `analysis/scrna/` | 按编号执行的单细胞分析脚本 |
| `analysis/pseudobulk/` | 原始 counts 聚合、供者层面统计的扩展约定 |
| `analysis/spatial/` | 空间数据及坐标、图像分析扩展约定 |
| `R/` | 共用函数，避免在多个脚本重复代码 |
| `config/` | 参数、匿名化样本清单与注释模板 |
| `data/raw/` | 原始矩阵，只读，按 sample_id 分目录 |
| `data/interim/` | 分阶段 Seurat RDS 检查点 |
| `data/processed/` | 最终注释对象与后续分析输入 |
| `results/figures/`, `results/tables/`, `results/logs/` | 图、表、运行环境记录 |
| `reports/` | 报告源文件与分析说明 |
| `scripts/`, `tests/`, `docs/` | 环境初始化、检查和复现文档 |

数据和生成结果默认不进入 Git；仅跟踪占位文件与说明。不要上传患者身份信息、临床原始记录或未获授权的图像。

## 快速开始

从仓库根目录运行，建议使用独立 R 环境和 Seurat 5.x：

```bash
Rscript scripts/setup.R
cp config/samples.example.csv config/samples.csv
cp config/annotations.example.csv config/annotations.csv
# 编辑 samples.csv 与 config/analysis.R，放入真实 10x 数据
Rscript scripts/run_scrna.R
# 检查 QC、聚类和 markers，填写 annotations.csv 后再运行
Rscript analysis/scrna/06_annotation.R
```

`run_scrna.R` 仅执行 01–05，不自动赋予细胞类型。默认不整合；根据批次设计选择 Harmony，不能把疾病分组当作批次消除。QC 阈值和聚类参数都是起始示例，需按物种、平台和数据质量验证。

如已生成并提交 `renv.lock`，使用 `Rscript -e 'renv::restore()'` 恢复。当前没有经过安装验证的 lockfile；首次环境验证后执行 `renv::snapshot(type = "all")` 并提交，详见 [复现说明](docs/reproducibility.md)。

## 分析原则

- 人和鼠分别分析；跨物种映射需要独立设计。
- `sample_id` 标识组织/文库，`donor_id` 标识独立生物学供者；同一供者多块组织不能作为独立重复。
- 单细胞 marker 检测用于探索和注释；组间推断优先使用供者层面 pseudobulk，保留原始 RNA counts。
- 检查 doublets、环境 RNA、样本 QC 与批次混杂；当前模板未实现 doublet/环境 RNA 校正。
- 注释需要多基因证据和人工核验；marker 表与参数变更须留存。

参考：[Seurat v5](https://satijalab.org/seurat/articles/seurat5_essential_commands.html)、[整合工作流](https://satijalab.org/seurat/articles/seurat5_integration)。
