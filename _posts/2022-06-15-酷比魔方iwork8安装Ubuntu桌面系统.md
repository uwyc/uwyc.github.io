# 酷比魔方iwork8安装Ubuntu桌面系统

![About](/img/2022-06-15.png)

## 准备工具

* 酷比魔方iwork8（U80GT）
* Ubuntu 22.04 LTS 64位桌面系统[^ubuntu-desktop]
* Rufus[^rufus]启动盘制作工具
* micro USB转USB和扩展坞

其中，扩展坞是必不可少的线材，因为需要键盘和鼠标进入BIOS和安装选项设置。

[^ubuntu-desktop]: <https://ubuntu.com/download/desktop>
[^rufus]: <https://rufus.ie/zh/>

## 制作支持32位UEFI的启动盘

使用Rufus制作U盘后，由于Ubuntu最新版本的安装镜像已经放弃了32位的UEFI启动支持，所以需要替换原来的EFI文件。

> 参考 <https://www.jianshu.com/p/ef9601c984fe>

将U盘原先的内容，如下：

```cmd
EFI
└── BOOT
    ├── BOOTx64.EFI
    ├── grubx64.efi
    └── mmx64.efi
```

替换成Debian32位安装镜像[^debian-iso]内容（选择**i386**下载），并修改`grub.cfg`文件内容。

```cmd
EFI
├── boot
│   ├── bootia32.efi
│   └── grubia32.efi
└── debian
    └── grub.cfg
```

以下是`grub.cfg`示例：

```cfg
search --file --set=root /.disk/info
set prefix=($root)/boot/grub
source $prefix/grub.cfg
```

[^debian-iso]: <https://www.debian.org/distrib/netinst>

## 安装32位的grub2配置

当Ubuntu完成安装后，并不能正常进入系统，反而重新进入了安装盘，这时，选择试用LiveCD。

查询设备分区信息。

```bash
sudo fdisk -l
sudo blkid
```

找到EFI分区（**EFI System Partition**）和根目录分区。

在iWork8中，一般是

* `/dev/mmcblk2p1` EFI系统
* `/dev/mmcblk2p2` 根目录

挂载并切换根目录：

```bash
sudo mount /dev/mmcblk2p2 /mnt
sudo mount /dev/mmcblk2p1 /mnt/boot/efi
sudo mount --bind /dev /mnt/dev
sudo mount --bind /dev/pts /mnt/dev/pts
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys
sudo mount --bind /run /mnt/run
sudo chroot /mnt
```

切到根目录环境，安装i386-efi的grub启动器：

```bash
apt update
apt install grub-efi-ia32-bin
grub-install --target i386-efi /dev/mmcblk2
update-grub
```

配置完成后，关机并拔掉U盘，重启机器即可。

## 解决重力感应与显示设置方向不一致的问题

由于系统显示设置与实际屏幕方向不一致，可能会导致触摸不生效的问题，所以需要解决重映射屏幕方向。

> 参考 <https://zhuanlan.zhihu.com/p/38276352>

修改重力感应文件，创建`/etc/udev/hwdb.d/61-sensor-local.hwdb`，以下是我的机器支持的配置：

```file
sensor:modalias:acpi:SMO8500*:dmi:*.*
 ACCEL_MOUNT_MATRIX=1,0,0;0,1,0;0,0,1
```

之后，更新硬件数据库，并重启机器。

```bash
sudo systemd-hwdb update
```

至此，简单的平板改造就完成。
