# 分析截图 Skill

自动截取屏幕并分析内容

## 触发关键词

- "分析截图"
- "看屏幕"
- "截图分析"
- "屏幕分析"
- "检查屏幕"

## 执行步骤

1. **运行截图脚本**
   ```powershell
   powershell -ExecutionPolicy Bypass -File "D:\AI Project\cap_cn.ps1"
   ```
   - 保存到 `D:\AI Project\截图汇总\scr_YYYY-MM-DD-HH-mm-ss.png`
   - 使用 Unicode 转义处理中文路径，避免编码问题
   - 脚本输出文件路径

2. **分析截图**
   - 使用脚本输出的文件路径
   - 调用 MCP 图片分析工具分析

## 相关文件

- 截图目录：`D:\AI Project\screenshots\` (链接到 `截图汇总`)
- 清除脚本：`D:\AI Project\一键清除截图.bat`
- 截图脚本：`D:\AI Project\cap.ps1`
