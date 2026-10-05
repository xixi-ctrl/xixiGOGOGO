# Pseudobulk 扩展入口（尚未实现）

输入：`data/processed/scrna_annotated.rds` 的 RNA 原始 counts 和供者元数据；输出建议放 `data/processed/pseudobulk/` 与 `results/tables/pseudobulk/`。

计划脚本：01_aggregate.R → 02_design.R → 03_differential_expression.R → 04_enrichment.R。独立函数放 R/，参数放 config/。

按 donor_id × cell_type 聚合原始整数 counts；同一供者多组织不能当独立供者，是否合并应根据设计决定。配对/纵向设计可保留 donor_id × condition/timepoint × cell_type 并在统计模型中处理供者。不要聚合 log-normalized 或整合后表达作为 count 模型输入。

统计实现可选 edgeR/DESeq2，安装后更新 lockfile。预先检查细胞数、低表达过滤、每组独立供者数、设计矩阵秩与 batch/condition 混杂；报告效应量、FDR 和独立供者 n。若把 HAVCR2 作为连续变量，应在供者层面定义变量、协变量与模型，避免用细胞数扩充统计 n。
