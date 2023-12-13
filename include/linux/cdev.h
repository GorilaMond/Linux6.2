/* SPDX-License-Identifier: GPL-2.0 */
#ifndef _LINUX_CDEV_H
#define _LINUX_CDEV_H

#include <linux/kobject.h>
#include <linux/kdev_t.h>
#include <linux/list.h>
#include <linux/device.h>

struct file_operations;
struct inode;
struct module;

struct cdev {
	// 内核用于管理字符设备驱动， kobject就是内核里最底层的类. 内核里会自动管理此成员
	struct kobject kobj;
	// 通常设为THIS_MODULE, 用于防止驱动在使用中时卸载驱动模块
	struct module *owner;
	// 怎样操作(vfs), 也就是实现当用户进程进行open/read/write等操作时，驱动里对应的操作.
	const struct file_operations *ops;
	// 用来将已经向内核注册的所有字符设备形成链表.
	struct list_head list;
	// 字符设备的设备号，由主设备号和次设备号构成.
	dev_t dev;
	// 隶属于同一主设备号的次设备号的个数.
	unsigned int count;
} __randomize_layout;

void cdev_init(struct cdev *, const struct file_operations *);

struct cdev *cdev_alloc(void);

void cdev_put(struct cdev *p);

int cdev_add(struct cdev *, dev_t, unsigned);

void cdev_set_parent(struct cdev *p, struct kobject *kobj);
int cdev_device_add(struct cdev *cdev, struct device *dev);
void cdev_device_del(struct cdev *cdev, struct device *dev);

void cdev_del(struct cdev *);

void cd_forget(struct inode *);

#endif
