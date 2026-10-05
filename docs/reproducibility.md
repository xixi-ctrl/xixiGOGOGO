# 环境与复现

建议 R >= 4.4、Seurat 5.x。具体支持范围须以实际验证的环境为准；当前模板没有安装验证或性能基准。

1. 从根目录运行 `Rscript scripts/setup.R`，首次初始化项目独立的 renv 环境。已有 lockfile 则 restore，不自动升级。
2. 验证安装及小规模数据运行后提交 `renv.lock`、`renv/activate.R`、`renv/settings.json` 和 renv 生成的 `.Rprofile`。lockfile 记录 R 与包版本，但不能安装 R 本身或操作系统库。
3. 在服务器/RStudio 中使用相同 R 版本；记录系统、CPU/RAM、BLAS 和编译依赖。Linux 可能需要 libcurl、SSL、XML、字体/图像开发库，按安装报错配置。
4. 固定 `config/analysis.R` 的 seed，保留匿名化样本清单、输入 SHA256、下载地址/日期、参考基因组与计数软件版本。
5. 每步写入 RDS 与 sessionInfo；重新运行会覆盖相应输出。每个项目/参数组合使用独立目录或工作副本，禁止混用不同运行的检查点。
6. 每次修改上游参数，重新执行该步及所有下游步骤；人工注释后可归档最终配置与对应 Git commit SHA。

语法检查：`Rscript tests/check_structure.R`。此检查不能验证 Seurat 算法输出。真实运行还需检查矩阵读取、QC 留存、批次混杂、marker 合理性和不同分辨率稳定性。

`.Rprofile` 将由 renv 生成；Rscript 从根目录启动才能自动加载项目环境。不要使用 `--vanilla` 绕过激活后仍假定环境已锁定。
