# IP核-lpm_counter使用介绍

### 简介*Altera IP核*是面向*Altera*可编程逻辑门阵列（FPGA）芯片优化的、实现电子设计中常用功能的封装模块。一般来说它比用户自己实现的模块，效率更高。下面只介绍几种输入引脚变化对lpm_counter的功能的影响。

### 1、输入信号只有clk

[![rVhtht.png](https://s3.ax1x.com/2020/12/12/rVhtht.png)](https://imgchr.com/i/rVhtht)

当输入只有clk信号时，计数器会对clk信号的脉冲进行计数。

### 2、输入信号只有clk和cin

当输入信号有clk和cin时，计数器会对cin进行脉冲信号的计数，clk时钟用于同步，即只有在clk信号的上升沿，才会检测cin信号是否为1，为1则计数加1。如果cin信号一直为1，那么计数器实质上又是在统计clk脉冲个数，反之则计数不增加。在官方文档中cin信号默认是高电平（即引用时不控制该输入引脚），与本测试效果相符合。

[![rV5lod.png](https://s3.ax1x.com/2020/12/12/rV5lod.png)](https://imgchr.com/i/rV5lod)

[![rVIC1P.png](https://s3.ax1x.com/2020/12/12/rVIC1P.png)](https://imgchr.com/i/rVIC1P)

### 3、输入信号为clk，cin，cin_en时

cin_en控制计数器进行计数，当cin_en为1时允许计数，为0时停止计数，此时计数值一直保持原有值，不归零。

### 4、输入信号为clk, cin, cin_en, sclr时

sclr为同步清零信号，sclr=1时有效，并且当clk信号出现上升沿且sclr=1时，才能会使得当前信号计数清零。反正在上升沿没有出现sclr=1的情况，则无法清零。

[![rVHXi4.png](https://s3.ax1x.com/2020/12/12/rVHXi4.png)](https://imgchr.com/i/rVHXi4)

### 5、输入信号为clk, cin, cin_en, aclr时

aclr为异步清零信号，aclr=1时，立刻执行清零操作。



