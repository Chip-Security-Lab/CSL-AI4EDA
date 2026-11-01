# 侧信道类型扩展示例

八份文件是可综合的结构风险输入，不是已验证安全电路或每类检测成功的证明。所有文件保持 start/done 接口；T09 包含秘密相关派生时钟，形式工具可能不支持。优化可能移除或重写结构，因此以实际 SDG/测量为准。

T05/T06 份额组：state_s0,state_s1；T07 随机输入：mask_a,mask_b。T08 可声明 bool_share0/bool_share1 为 boolean、arithmetic_value 为 arithmetic；该不安全交汇只用于诊断，不能当作合格转换 gadget。随机输入的独立性与每周期新鲜性均只是外部假设。

对各类正例、相近反例与错误候选的确定性验收见 test_sidechannel_capabilities.py。硬件工具实测另行记录在 DELIVERY_STATUS.md。
