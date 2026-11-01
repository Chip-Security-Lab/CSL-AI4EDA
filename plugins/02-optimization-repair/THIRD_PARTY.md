# 研究源码与第三方边界

维护者已确认 TVGuider 和 RTL-SCA Repair 两份研究代码属于项目组并授权纳入此项目。它们分别保存在 `vendor/TVGuider/` 与 `vendor/rtl-sca-repair/`。项目组有权许可的原创代码随本仓库采用 MIT；已有第三方权利及引用来源不因合并而改变。

保留两份研究代码的模块、README、项目元数据、测试与规则/知识库。没有复制它们的 Git 历史、实际环境文件、虚拟环境、实验 runs、日志、模型权重或缓存。两处用于密钥脱敏测试的字符串已替换为公开的全零测试值；环境模板只保留空 Key。原始研究目录未修改。

TVGuider 包含 `knowledge/raw/` 和插件使用的 `artifacts/rag/kb/`。知识资料中的原始引用保留；第三方文档、论文、权重和工具本身不因本仓库 MIT 许可而获得再授权。SOURCE_SNAPSHOT.json 记录此次快照版本及筛选说明。

以下工具与库使用本机安装，适用各自许可证或服务条款：AMD Vivado，Python，WSL/Linux，Yosys，Verilator，Icarus Verilog及编译工具。模型 API 由使用者提供自己的接口和密钥。当前插件不依赖 Tk。

VSIX 包含 `installation/` 内的依赖清单和安装脚本，用户主动点击设置中的安装按钮后，从包源安装第三方 Python 依赖到独立用户环境；没有复制开发机的虚拟环境、第三方二进制或已安装包进入 VSIX。Windows 清单只安装实际 BM25/TVIR 路径需要的依赖，不安装 torch/transformers/嵌入模型权重；完整研究项目的 pyproject.toml 仍保留，独立研究用途可能需要额外依赖。自动安装的 Ubuntu/Debian 工具来自发行版仓库，适用各自许可。环境实测版本记录在用户专用目录的 installation-result.json，不含密钥。

源码包不包含用户输入、历史修复记录、个人模型配置或任何实际 API Key。
