# Security Detection Plugin 使用说明

[插件介绍](README.zh-CN.md) · [English guide](USER_GUIDE.md)

## 安装内容与当前状态

需要同时下载 **VSIX 前端和配套运行 ZIP**。单独安装 VSIX 不含 Python 后端及检测引擎，不能完成检测。本地候选将前端 **0.1.1** 与所提供的后端快照配对；后端 FastAPI 元数据仍为 **0.1.0**，没有为对齐展示而修改版本。

插件整合 VerilogLAVD 结构检查、VeriPVD 权限分析，并提供 Vivado Tcl 入口。当前分发没有独立浏览器前端。运行 ZIP 中的 Python、Tcl 等运行代码仍可读。候选 VSIX 仅去除一份内部开发交接记录，保留的前端文件及版本元数据不变。

本次整理完成压缩包完整性、目录和示例保留检查，没有执行真实 VS Code 交互、Neo4j/引擎扫描或模型请求。第三方再分发声明仍有待补齐项，见[第三方说明](THIRD_PARTY_NOTICES.md)。

## 1. 准备环境

| 环境 | 说明 |
| --- | --- |
| VS Code | 桌面版 1.85+，现有文档以 Windows 流程为准 |
| 后端 Python | 3.10+，建议使用独立虚拟环境 |
| VerilogLAVD | Python 3.12+ 及对应依赖 |
| VeriPVD | 按现有方案使用独立 Python 3.10 环境 |
| Icarus Verilog | LAVD 的 pyverilog 预处理需要；也用于可选的修复建议编译检查 |
| Neo4j | LAVD 需要专用、可清空的数据库，填写自己的连接和密码 |
| 模型接口 | 模型权限分析和修复建议需要自己的受支持模型及 API Key |
| Vivado | 仅使用 Tcl 入口时需要，VS Code 扫描不要求安装 |

**LAVD 构图会清空当前连接的 Neo4j 数据库，并按文件重建。务必使用专用空数据库，不要连接存有其他工作数据的数据库。** 这些系统软件不在运行包中。依赖下载和模型阶段需要网络；现有 API 工作流不要求 GPU 或本地模型权重。

## 2. 解压并安装依赖

从同一 Release 下载：

- `csl-rtl-seccheck-0.1.1.vsix`
- `csl-rtl-seccheck-runtime-0.1.1.zip`

将运行 ZIP 解压到可写位置。在解压后的 `RTL-SecCheck-runtime` 根目录打开终端。保留 `backend/`、`third_party/`、三份 requirements、`examples/` 和 `tcl/` 的相对结构。

先安装所需 Python 版本，再使用 Windows `py` 启动器分别创建环境：

```bat
py -3.12 -m venv backend\.venv
backend\.venv\Scripts\python.exe -m pip install -r requirements.txt

py -3.12 -m venv third_party\VerilogLAVD\.venv
third_party\VerilogLAVD\.venv\Scripts\python.exe -m pip install -r requirements-lavd.txt

py -3.10 -m venv third_party\VeriPVD\.venv
third_party\VeriPVD\.venv\Scripts\python.exe -m pip install -r requirements-pvd.txt
```

根目录 requirements 只安装后端，不等于已经安装两个检测引擎。使用现成 VSIX 不需要 Git、Node.js、npm 或自行编译扩展。依赖清单沿用上游版本范围，未锁定完整环境；全新机器兼容性仍需实测。

## 3. 安装 VSIX 并连接运行目录

1. VS Code 扩展页右上角 **… → 从 VSIX 安装…**，选择 VSIX，按提示重载。
2. 安装后的显示名为 **CSL_RTL_SecCheck**，扩展 ID 为 `csl-local.csl-rtl-seccheck`。
3. 在 VS Code 设置中将 `cslRtlSeccheck.projectRoot` 指向解压后的运行根目录，即含有 `backend/main.py` 与 `start.bat` 的那一层。运行目录在扩展安装位置之外，应明确设置。
4. 本地使用时，`cslRtlSeccheck.backendUrl` 保持 `http://127.0.0.1:8321`。
5. 打开插件面板及“连接与扫描设置”，确认两个引擎的目录、各自解释器与 Neo4j 信息。

首次启动后端会创建 `backend/settings.json`。运行包提供 `backend/settings.example.json`，凭据和 `rtl_dir` 扫描目标留空，引擎路径为相对路径。通过设置面板或本地文件填写自己的连接、密码、模型名和 API Key。引擎目录和解释器的相对路径从运行根目录解析；扫描目标的相对路径则取决于后端进程工作目录，因此请使用目录选择器或填写目标 RTL 目录的绝对路径。`verilavlvd_path`、`verilavlvd_python` 是当前后端实际使用的历史字段拼写，请保留。

模型名必须符合包内服务商路由；不能假设任意模型别名或兼容网关均可使用。未配置 Key 时，VeriPVD 仅执行结构阶段，模型权限分析与修复建议会受限。连接检查可能访问所选服务；执行模型阶段会发送 RTL 与相关分析上下文。

`backend/settings.json` 在本机保存凭据，不能随发布包共享。`scans/` 和日志也由运行生成，不属于待上传材料。

## 4. 启动并运行现有示例

扩展会检查后端，在已配置的运行目录中尝试启动。也可以在运行根目录手动运行并保留终端窗口：

```bat
backend\.venv\Scripts\python.exe -m uvicorn --app-dir backend main:app --host 127.0.0.1 --port 8321
```

1. LAVD 扫描前确认 Icarus 在 PATH 中、专用 Neo4j 数据库已启动。
2. 通过目录选择器选中运行包中的 `examples/demo_soc`，或填写该目录的绝对路径，将原有六个 `.v` 文件保留在一起。
3. 选择“双引擎”“仅 LAVD”或“仅 PVD”，开始扫描。
4. 同时查看报告、引擎日志和警告；模块依赖图辅助理解上下文。
5. 如需修复建议，在单条 finding 中请求，检查建议及实际编译结果后再决定采用。

[示例说明](examples/README.md)列出保留文件。RTL 原文件按提供内容完整保留；它是扫描输入，不是 testbench，没有在本次整理中断言固定检出数量。查看示例本身不调用模型。

## 5. 使用 Vivado Tcl 入口

同一个运行包含 `tcl/seccheck.tcl`，仍依赖已准备的后端与引擎，不是另一个独立安装包。在 Vivado Tcl Console 中将下面路径替换成实际解压位置：

```tcl
source {/path/to/RTL-SecCheck-runtime/tcl/seccheck.tcl}
seccheck help
seccheck scan {/path/to/RTL-SecCheck-runtime/examples/demo_soc} both
seccheck status
seccheck report
```

还有 `seccheck start`、`seccheck fix <finding_id>` 和 `seccheck graph`。graph 命令导出 JSON；交互式依赖图在 VS Code 面板查看。

## 6. 结果边界与更新

结构命中、模型判断和修复建议需要人工复核。引擎错误或模型阶段缺失时的空报告，不表示设计通过安全检查。修复建议编译通过也不代表功能、形式或物理安全成立。本快照不承诺完整覆盖上游论文所有模式，也没有复现论文评测结果。

更新时使用匹配的前端和运行包，重启后端，避免旧 Python 模块仍在运行。单独备份本机配置与有用报告。默认用户包排除了上游研究数据集、重复压缩包及 notebook；依赖这些数据的论文批量实验不在本包范围。普通扫描通过 `backend/lavd_bridge.py` 读取用户选择的 RTL 目录。
