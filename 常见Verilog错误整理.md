# 常见Verilog错误整理

### Error (10279): Verilog HDL Port Declaration error at sync_trigger.v(2): input port(s) cannot be declared with type "reg"

错误原因：在一个模块内部，其输入引脚不能使用reg，因为reg变量是寄存器类型，其信号的输入需要驱动，而模块内部的输入引脚本身就是提供信号的，是不存在其他信号对其进行驱动。

解决方案：将变量的类型从reg变为wire.

### Error (12007): Top-level design entity is undefined

错误原因：顶层设计实体并没有相应的module定义，比如你的"Top-level entity"是“counter_ip”，并且你有counter_ip.v的文件，但是你没有在counter_ip.v中定义counter_ip的module，所以报错。因此如果你定义了”xxx“作为你的"Top-level entity"，那么你必须得在某个文件中定义了”xxx“的module（不要求module和所在.v文件同名）。

解决方法：

1、定义一个与"Top-level entity"同名的module

2、更改你的"Top-level entity"，将已经声明的module的作为顶层设计实体，此处注意更改时默认将xxx.v的中xxx作为顶层设计实体，所以一般将xxx.v文件和xxx.v文件中定义的模块同名。

### Error (12153): Can't elaborate top-level user hierarchy

错误原因：因为文件中存在其他错误，导致不能识别顶层设计的层次。

解决方案：先解决其他问题再进行编译。

### Error (10028): Can't resolve multiple constant drivers for net

错误原因：在多个并行模块中对同一个信号进行赋值操作。

解决方案：对一个信号的操作集中到一个并行块中。

