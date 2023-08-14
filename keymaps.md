# keymap setting

`<leader> = <space> `

## general

- `<leader> + bc` 关闭当前 `buf`
- `J, K` 在 visual mode 下将选中内容向下/上移动

## lsp

in normal mode

- `g+D`: 跳转声明
- `g+d`: 跳转定义
- `K` : 查看定义悬停框，
- `gi` : 查看实现
- `ctrl + K` : 查看函数签名
- `<leader> + wa` : 增加工作路径
- `<leader> + wr` : 移除工作路径
- `<leader> + wl` : 打印所有工作路径
- `<leader> + da` : 查看诊断
- `<leader> + D` : 查看类型定义
- `<leader> + rn` : 变量重命名
- `<leader> + ca` : 执行可用的代码行为
- `gr` : 查看引用
- `<leader> + f` 格式化代码

## telescope

- `<leader> + ff` : 显示当前文件夹下（包括子文件夹中）所有的文件 
- `<leader> + fg` : 查找所有满足条件的行 
- `<leader> + <space>` : 查看当前buf
- `<leader> + fh ` : 查看nvim的help文档 
- `<leader> + ?` : 查看过去所有打开的旧文件
- `<leader> + /` : 查找当前buf的内容

## flash.nvim

- `s` : 开启jump模式
