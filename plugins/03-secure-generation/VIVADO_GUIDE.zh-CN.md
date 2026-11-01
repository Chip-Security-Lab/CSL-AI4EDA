# CSL_HDLGen for Vivado

工具名称统一为 `CSL_HDLGen`。为兼容已有安装，`hdlgen::` Tcl 命令、环境变量和 `.hdlgen` 数据目录保持不变；升级只更新显示名称，不迁移或删除历史结果。工具栏继续使用 G 图标。

本版基于本地 HDLChat for Vivado 的接入方案：**G 按钮选择命令行或独立窗口，两种入口共用一个后台、模型配置和生成记录**。独立窗口是 Edge/Chrome 无地址栏应用窗口，找不到兼容浏览器时回退到默认浏览器；不是 Vivado 停靠面板。Tkinter 只用于小型模式选择面板。

CSL_HDLGen 保留自己的 SecV / SecFSM 二元路由、代码/安全报告/安全知识三个输出、SecV 低功耗优化，并增加显式确认的本地文件写入。

## 安装与升级

需要 Python 3.10+，建议包含 tkinter；不需要 Neo4j、第三方 Python 包或手动启动网页服务器。在 Vivado Tcl Console 中执行：

```tcl
set ::env(HDL_SECURITY_PYTHON) {<python-executable>}
source {<extracted-folder>/CSL_HDLGen-for-Vivado/vivado_plugin/install.tcl}
```

使用分发包时，将上述安装路径替换为解压目录下的 `CSL_HDLGen-for-Vivado/vivado_plugin/install.tcl`。目录结构必须保留，不能只复制 Tcl 文件。

点击 G 图标（Tools > Custom Commands > CSL_HDLGen: Choose Mode）选择：
- 命令行：显示命令使用教程，在 Tcl Console 输入生成需求。
- 独立窗口：打开或唤回网页助手。
- 关闭选择面板或按 Esc：取消，不启动生成。

升级前关闭旧助手并执行 `hdlgen::shutdown`（旧版没有此命令时跳过），然后重新 source 安装脚本。自定义按钮保存绝对脚本路径，移动插件目录后需要重新安装。Python 环境变量若只在 Console 设置，重启 Vivado 后需要再次设置，或预先设置用户环境变量。

## 窗口使用

1. 在“模型设置”配置兼容接口地址、模型名称和 API Key。配置仅存于本次服务内存；Tcl 与窗口共享，关闭窗口后重开仍保留，Vivado 退出后不保留。
2. 默认约每两秒跟随 Sources 中选中的 HDL 文件。下拉列表可固定当前工程内的文件，勾选“跟随 Vivado Sources 选择”恢复跟随；切换工程后自动解除固定并隔离生成记录。
3. 填写需求并生成。勾选“基于当前结果继续”可带入上一版需求与代码，提出补充要求；“新建”开始独立的一轮。
4. 查看安全代码、安全报告和安全知识。“写入差异”显示本轮生成代码相对于生成时磁盘文件的变化。
5. SecV 的模型生成结果可以单独进行低功耗优化；SecFSM 不显示优化按钮。优化使用选中版本的代码，不重新生成基线。
6. 根据需求选择“复制代码”“加入工程（新文件）”或“写入当前文件”。生成本身不会修改工程文件。

无模型时必须明确选择“演示模板”；模板仅用于演示流程，不保证覆盖需求。窗口与命令行均会显示未验证提示。

## 写入当前文件

“当前文件”指**当前 Vivado 工程内、Sources 中选中且与本轮结果绑定的磁盘 HDL 文件**，不是任意操作系统窗口的活动文件，也不是未保存的编辑器缓冲区。

- 写入前保存 Vivado 编辑器内容，查看代码/差异，确认提示中的完整目标路径。
- 如果窗口固定的文件与 Sources 选择不一致，写入按钮禁用；先在 Sources 选中目标文件。
- 工程切换、文件选择变化、目标内容自生成后发生变化、生成结果被外部修改时，拒绝覆盖。
- 先保存原始字节备份，再通过同目录临时文件替换目标；符号链接、硬链接和超过 2 MB 的目标拒绝写入。
- 成功后显示备份路径；请在 Vivado 中重新加载文件，避免用旧编辑器缓冲覆盖新内容。
- 写入是整文件替换，不是局部补丁。生成代码采用 Verilog-2005，输出为 `.v` 文件；写入后尝试将 Vivado 文件类型设置为 Verilog 并更新编译顺序。失败时返回警告，不会撤销已经完成的磁盘写入。现有 `.sv` 文件仍可绑定为输入或写入目标。
- 恢复时先关闭/重新加载编辑器，将报告中的 `original.backup` 内容复制回原目标。备份不会自动删除。

Tcl 在实际执行时再次核对工程、Sources 选择和磁盘内容。不执行模型生成的 Tcl；不会自动综合、仿真或实现。无法检测所有未保存编辑器状态，使用者仍需按提示先保存。

## Tcl 命令

```tcl
hdlgen::launch
hdlgen::help
hdlgen::open

hdlgen::generate {生成一个32位寄存器，仅允许最高权限写入}
hdlgen::ask {生成一个包含 IDLE 和 RUN 状态的安全 FSM}
hdlgen::demo {生成一个安全寄存器}

hdlgen::status
hdlgen::optimize latest
hdlgen::import_result latest
hdlgen::write_current latest -confirm
```

`ask` 是 `generate` 的别名。每条生成命令是独立一轮，输出阶段进度、代码、报告、知识和结果 ID；窗口可查看同一结果并继续修改。首次未配置模型时打开设置窗口并等待。生成任务在后台运行，Tcl 用事件循环等待结果，不使用阻塞式模型调用。

`latest` 可替换为明确的结果 ID；写入必须携带 `-confirm`，建议使用已核对的具体 ID。导入新文件会检查同名模块，不自动移除用户旧源码；处理冲突后可以重试。

## 数据和服务生命周期

默认结果目录：
```text
<用户主目录>/.hdlgen/vivado-runtime/results/<结果ID>/
  design.v
  design.security.txt
  design.security.json
  design.knowledge.json
  record.json
  before.bin
  target.txt
  original.backup   # 确认写入后才创建
```

结果和原文件快照以明文保存在本机；按工程隔离显示，重启服务可读取已完成记录。导入工程的源码直接引用结果路径，不要删除正在被工程引用的目录。

默认模型只接收需求、检索知识、生成代码。仅勾选“将当前文件内容提供给模型”才附加当前源文件；本机仍会读取当前文件制作差异/写入检查，以及读取工程 HDL 做同名模块检查。API Key 不写入结果或配置文件。

本地 HTTP 服务绑定 127.0.0.1 随机端口，API 校验实例凭据与来源；Tcl 桥只接受固定操作。同一 Vivado 实例复用服务和窗口，Vivado 退出或执行 `hdlgen::shutdown` 后服务停止。不要把运行目录中的认证描述文件分享给他人。


## 验证与限制

程序与知识库和当前原工程一致；本候选仅整理便携文档并附公开案例。未新增真实 Vivado GUI、模型生成、综合、仿真或功耗验收。报告和低功耗建议仍需工程验证，当前代码提取器每次保留一个 module。

## 卸载

```tcl
source {<extracted-folder>/CSL_HDLGen-for-Vivado/vivado_plugin/uninstall.tcl}
```

移除入口并停止共享服务，不删除结果或备份。移动插件目录后需重新安装入口。完整保存的案例在分发包 examples/ 中。
