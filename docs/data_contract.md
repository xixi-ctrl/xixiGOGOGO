# 数据契约

`config/samples.csv` 每行一份 10x 文库。必需列：sample_id（唯一）、donor_id、condition、batch（技术批次）、species（human/mouse）、data_path（相对根目录或绝对路径）。样本和供者用匿名编码。示例只有两份样本，用于格式演示，不能支持可靠的组间推断。

`data/raw/<sample_id>/filtered_feature_bc_matrix/` 包含 matrix.mtx(.gz)、barcodes.tsv(.gz)、features.tsv(.gz)。当前读取基因符号；Ensembl ID 输入需先制定基因与线粒体映射。原始数据只读，转换文件放 interim。多模态输入仅使用 Gene Expression。

最终 `data/processed/scrna_annotated.rds` 保留 RNA 原始 counts、标准化表达、降维和 sample_id/donor_id/condition/batch/species/cell_type 元数据。人工注释表每行 cluster → cell_type，需完整覆盖聚类结果并注明 marker 依据。

数据/结果默认被忽略，说明和占位被跟踪。大文件应使用受控数据存储，仓库保留来源、校验值和获取说明；公开临床元数据需单独审核并匿名化。同一供者多块组织保留不同 sample_id 和相同 donor_id。
