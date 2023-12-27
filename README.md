# Linux6.2 源码注释

LiuBing<luiyanbing@126.com>

## IO

read

```c
SYSCALL_DEFINE3(read
    ksys_read()
        vfs_read()
            ext4_file_read_iter()
                generic_file_read_iter()
                    kiocb_write_and_wait()
                        filemap_write_and_wait_range()
                            __filemap_fdatawrite_range()
                                filemap_fdatawrite_wbc()
                                    do_writepages()
                            __filemap_fdatawait_range()
                                filemap_get_folios_tag()
                                folio_wait_writeback()
                    file_accessed()
                    mapping->a_ops->direct_IO()
                
                    filemap_read() // <
                        filemap_get_pages()
                        folio_mark_accessed()
                        copy_folio_to_iter()
                        file_accessed()
```

```c
filemap_get_pages()
    filemap_get_read_batch()
        folio_batch_add()

    page_cache_sync_readahead()
    filemap_get_read_batch()
        folio_batch_add()

    filemap_create_folio()
        filemap_alloc_folio()
        filemap_add_folio()
            __filemap_add_folio()
            workingset_refault()
            folio_add_lru()
        filemap_read_folio()
            ext_read_folio()
                ext4_mpage_readpages()
                    block_read_full_folio()
                        create_page_buffers()
                        ext4_get_block()
        folio_batch_add()

    filemap_readahead()
        page_cache_async_ra()
```

write

```c
SYSCALL_DEFINE3(write  //write系统调用入口
	ksys_write
		vfs_write
			__vfs_write
				new_sync_write
					call_write_iter
						file->f_op->write_iter
							ext4_file_write_iter
								__generic_file_write_iter
									generic_perform_write
										a_ops->write_begin
											ext4_write_begin
												grab_cache_page_write_begin ->
													pagecache_get_page ->
														find_get_entry ---------------- //查找page cache
														__page_cache_alloc ------------ //没找到page cache，则分配一个page对象
														add_to_page_cache_lru --------- //将页面加入page cache基树中，同时也加入active LRU链表
												__block_write_begin	
													__block_write_begin_int
														create_page_buffers
															create_empty_buffers ------	//page没有对应的buffer，创建新的buffer
																alloc_page_buffers
																	alloc_buffer_head
																		kmem_cache_zalloc(bh_cachep //从slab缓存中分配空闲buffer_head结构
																	set_bh_page	------- //设置buffer_head数据指向地址
																attach_page_buffers	
										iov_iter_copy_from_user_atomic ---------------- //将数据从用户空间拷贝到内核空间，也就是page cache上			
										a_ops->write_end
											ext4_write_end
												block_write_end
													__block_commit_write
														mark_buffer_dirty
												ext4_update_inode_size ---------------- //更新文件对应的inode信息
												ext4_mark_inode_dirty ----------------- //标记inode为脏，写入了数据，需要同步到磁盘
```

sync

```c
drop_pagecache_sb ->									//遍历该超级块的所有inode，并尝试释放
	invalidate_mapping_pages ->							//尝试释放该inode对应的page cache
		pagevec_lookup_entries							//根据地址空间查询该inode关联的所有page cache
		invalidate_inode_page ->						//尝试释放查询到的page cache页面
			invalidate_complete_page ->
				remove_mapping ->
					__remove_mapping ->
						__delete_from_page_cache ->
							page_cache_tree_delete   	//将该页面从page cache的基树中删除
						mapping->a_ops->freepage ->		//调用对应文件系统的releasepage函数，释放资源，比如buffer_head
							ext4_releasepage			//对于ext4调用的是ext4_releasepage
		deactivate_file_page							//把页面从活动LRU链表移动到非活动LRU链表
		pagevec_release ->								//释放页面
			__pagevec_release ->
				lru_add_drain							//先将各个pagevec刷到对应LRU链表
				release_pages							//然后针对上面inode的page cache减少页面引用计数，并回收0引用页面
	iput												//回收inode

```
## 文件系统

mkdir

```c
ext4_mkdir ->
	ext4_new_inode_start_handle ->
		__ext4_new_inode ->	------------------------------------------- //为新目录分配inode索引
			new_inode -> 
			ext4_read_inode_bitmap -> --------------------------------- //获取磁盘的inode位图
				sb_getblk -> ------------------------------------------	//读取块设备数据
					__getblk_gfp ->
						__find_get_block ->							
							lookup_bh_lru -----------------------------	//在每CPU变量bh_lrus中查找BH
							__find_get_block_slow -> ------------------	//bh_lrus没找到就要到对应的page cache中查找页面
								find_get_page_flags ->				
									pagecache_get_page -> ------------- //查找page cache
										find_get_entry ---------------- //根据bdev->bd_inode->i_mapping地址空间在page cache基树中查找页面
										page_buffers ------------------	//找到page cache看是否有对应的buffer_head，没有则返回NULL
							bh_lru_install ---------------------------- //如果有找到，把找到的bh放入每CPU bh_lrus中，提高访问速度
						__getblk_slow -> ------------------------------	//CPU变量bh_lrus和page cache中都没有找到目标BH，就需要从块设备读取了
							grow_buffers ->
								grow_dev_page ->
									find_or_create_page ->			
										pagecache_get_page -> ---------	//根据bdev->bd_inode->i_mapping地址空间在page cache基树中查找页面
											find_get_entry 	
											__page_cache_alloc --------	//没找到page cache，创建新页面
											add_to_page_cache_lru -----	//并加入page cache基树，以及LRU链表
									alloc_page_buffers -> -------------	//找到或新建的页面没有buffer_head，创建新的buffer_head
										alloc_buffer_head ->
											kmem_cache_zalloc(bh_cachep	//在slab中分配空闲buffer_head对象
										set_bh_page	------------------- //设置buffer的数据指向地址
									link_dev_buffers -> ---------------	//将page对应的所有buffer_head连成一个环形链表
										attach_page_buffers	-----------	//将buffer关联到对应的page上，将page->private指向buffer_head
```

