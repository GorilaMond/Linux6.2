	.text
	.intel_syntax noprefix
	.file	"SMS.c"
	.globl	main                            # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 32
	mov	dword ptr [rbp - 4], 0
.LBB0_1:                                # =>This Inner Loop Header: Depth=1
	lea	rdi, [rip + .L.str]
	mov	al, 0
	call	printf@PLT
	lea	rsi, [rbp - 32]
	lea	rdi, [rip + .L.str.1]
	mov	al, 0
	call	__isoc99_scanf@PLT
	lea	rdi, [rbp - 32]
	lea	rsi, [rip + .L.str.2]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB0_3
# %bb.2:
	lea	rdi, [rip + .L.str.3]
	mov	al, 0
	call	printf@PLT
	xor	eax, eax
	add	rsp, 32
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.LBB0_3:                                #   in Loop: Header=BB0_1 Depth=1
	.cfi_def_cfa rbp, 16
	lea	rdi, [rbp - 32]
	lea	rsi, [rip + .L.str.4]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB0_5
# %bb.4:                                #   in Loop: Header=BB0_1 Depth=1
	call	insert
	jmp	.LBB0_15
.LBB0_5:                                #   in Loop: Header=BB0_1 Depth=1
	lea	rdi, [rbp - 32]
	lea	rsi, [rip + .L.str.5]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB0_7
# %bb.6:                                #   in Loop: Header=BB0_1 Depth=1
	call	delete
	jmp	.LBB0_14
.LBB0_7:                                #   in Loop: Header=BB0_1 Depth=1
	lea	rdi, [rbp - 32]
	lea	rsi, [rip + .L.str.6]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB0_9
# %bb.8:                                #   in Loop: Header=BB0_1 Depth=1
	call	update
	jmp	.LBB0_13
.LBB0_9:                                #   in Loop: Header=BB0_1 Depth=1
	lea	rdi, [rbp - 32]
	lea	rsi, [rip + .L.str.7]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB0_11
# %bb.10:                               #   in Loop: Header=BB0_1 Depth=1
	call	show
	jmp	.LBB0_12
.LBB0_11:                               #   in Loop: Header=BB0_1 Depth=1
	lea	rdi, [rip + .L.str.8]
	mov	al, 0
	call	printf@PLT
.LBB0_12:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_13
.LBB0_13:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_14
.LBB0_14:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_15
.LBB0_15:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_16
.LBB0_16:                               #   in Loop: Header=BB0_1 Depth=1
	jmp	.LBB0_1
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	insert                          # -- Begin function insert
	.p2align	4, 0x90
	.type	insert,@function
insert:                                 # @insert
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 64
	call	getData
	mov	qword ptr [rbp - 56], rax
.LBB1_1:                                # =>This Inner Loop Header: Depth=1
	lea	rdi, [rip + .L.str.9]
	mov	al, 0
	call	printf@PLT
	lea	rsi, [rbp - 48]
	lea	rdi, [rip + .L.str.1]
	mov	al, 0
	call	__isoc99_scanf@PLT
	lea	rdi, [rbp - 48]
	lea	rsi, [rip + .L.str.10]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB1_5
# %bb.2:                                #   in Loop: Header=BB1_1 Depth=1
	mov	rdi, qword ptr [rbp - 56]
	call	save
	cmp	eax, -1
	jne	.LBB1_4
# %bb.3:                                #   in Loop: Header=BB1_1 Depth=1
	lea	rdi, [rip + .L.str.11]
	mov	al, 0
	call	printf@PLT
	jmp	.LBB1_1
.LBB1_4:
	lea	rdi, [rip + .L.str.12]
	mov	al, 0
	call	printf@PLT
	mov	rdi, qword ptr [rbp - 56]
	call	clearStuList
	add	rsp, 64
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.LBB1_5:                                #   in Loop: Header=BB1_1 Depth=1
	.cfi_def_cfa rbp, 16
	lea	rdi, [rbp - 48]
	call	checkData
	mov	qword ptr [rbp - 8], rax
	cmp	qword ptr [rbp - 8], 0
	jne	.LBB1_7
# %bb.6:                                #   in Loop: Header=BB1_1 Depth=1
	jmp	.LBB1_1
.LBB1_7:                                #   in Loop: Header=BB1_1 Depth=1
	mov	rdi, qword ptr [rbp - 8]
	mov	rsi, qword ptr [rbp - 56]
	call	searchCode
	mov	qword ptr [rbp - 16], rax
	cmp	qword ptr [rbp - 16], 0
	je	.LBB1_9
# %bb.8:                                #   in Loop: Header=BB1_1 Depth=1
	mov	rsi, qword ptr [rbp - 16]
	mov	rdx, qword ptr [rbp - 16]
	add	rdx, 9
	lea	rdi, [rip + .L.str.13]
	mov	al, 0
	call	printf@PLT
	jmp	.LBB1_1
.LBB1_9:                                #   in Loop: Header=BB1_1 Depth=1
	mov	rax, qword ptr [rbp - 56]
	mov	rax, qword ptr [rax]
	mov	rcx, qword ptr [rax + 32]
	mov	rax, qword ptr [rbp - 8]
	mov	qword ptr [rax + 32], rcx
	mov	rcx, qword ptr [rbp - 8]
	mov	rax, qword ptr [rbp - 56]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rax + 32], rcx
	mov	rax, qword ptr [rbp - 56]
	mov	ecx, dword ptr [rax + 8]
	add	ecx, 1
	mov	dword ptr [rax + 8], ecx
	jmp	.LBB1_1
.Lfunc_end1:
	.size	insert, .Lfunc_end1-insert
	.cfi_endproc
                                        # -- End function
	.globl	delete                          # -- Begin function delete
	.p2align	4, 0x90
	.type	delete,@function
delete:                                 # @delete
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 32
	call	getData
	mov	qword ptr [rbp - 8], rax
	mov	rax, qword ptr [rbp - 8]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 24], rax
.LBB2_1:                                # =>This Inner Loop Header: Depth=1
	lea	rdi, [rip + .L.str.17]
	mov	al, 0
	call	printf@PLT
	lea	rsi, [rbp - 32]
	lea	rdi, [rip + .L.str.1]
	mov	al, 0
	call	__isoc99_scanf@PLT
	lea	rdi, [rbp - 32]
	lea	rsi, [rip + .L.str.10]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB2_5
# %bb.2:                                #   in Loop: Header=BB2_1 Depth=1
	mov	rdi, qword ptr [rbp - 8]
	call	save
	cmp	eax, -1
	jne	.LBB2_4
# %bb.3:                                #   in Loop: Header=BB2_1 Depth=1
	lea	rdi, [rip + .L.str.11]
	mov	al, 0
	call	printf@PLT
	jmp	.LBB2_1
.LBB2_4:
	lea	rdi, [rip + .L.str.12]
	mov	al, 0
	call	printf@PLT
	mov	rdi, qword ptr [rbp - 8]
	call	clearStuList
	add	rsp, 32
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.LBB2_5:                                #   in Loop: Header=BB2_1 Depth=1
	.cfi_def_cfa rbp, 16
	lea	rdi, [rbp - 32]
	mov	rsi, qword ptr [rbp - 8]
	call	searchCode
	mov	qword ptr [rbp - 24], rax
	cmp	qword ptr [rbp - 24], 0
	je	.LBB2_7
# %bb.6:                                #   in Loop: Header=BB2_1 Depth=1
	mov	rax, qword ptr [rbp - 24]
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 16], rax
	mov	rax, qword ptr [rbp - 16]
	mov	rcx, qword ptr [rax + 32]
	mov	rax, qword ptr [rbp - 24]
	mov	qword ptr [rax + 32], rcx
	mov	rsi, qword ptr [rbp - 16]
	mov	rdx, qword ptr [rbp - 16]
	add	rdx, 9
	lea	rdi, [rip + .L.str.18]
	mov	al, 0
	call	printf@PLT
	mov	rdi, qword ptr [rbp - 16]
	call	free@PLT
	mov	rax, qword ptr [rbp - 8]
	mov	ecx, dword ptr [rax + 8]
	add	ecx, -1
	mov	dword ptr [rax + 8], ecx
	jmp	.LBB2_8
.LBB2_7:                                #   in Loop: Header=BB2_1 Depth=1
	lea	rsi, [rbp - 32]
	lea	rdi, [rip + .L.str.19]
	mov	al, 0
	call	printf@PLT
.LBB2_8:                                #   in Loop: Header=BB2_1 Depth=1
	jmp	.LBB2_1
.Lfunc_end2:
	.size	delete, .Lfunc_end2-delete
	.cfi_endproc
                                        # -- End function
	.globl	update                          # -- Begin function update
	.p2align	4, 0x90
	.type	update,@function
update:                                 # @update
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 64
	call	getData
	mov	qword ptr [rbp - 8], rax
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
	lea	rdi, [rip + .L.str.20]
	mov	al, 0
	call	printf@PLT
	lea	rsi, [rbp - 33]
	lea	rdi, [rip + .L.str.1]
	mov	al, 0
	call	__isoc99_scanf@PLT
	lea	rdi, [rbp - 33]
	lea	rsi, [rip + .L.str.10]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB3_5
# %bb.2:                                #   in Loop: Header=BB3_1 Depth=1
	mov	rdi, qword ptr [rbp - 8]
	call	save
	cmp	eax, -1
	jne	.LBB3_4
# %bb.3:                                #   in Loop: Header=BB3_1 Depth=1
	lea	rdi, [rip + .L.str.11]
	mov	al, 0
	call	printf@PLT
	jmp	.LBB3_1
.LBB3_4:
	lea	rdi, [rip + .L.str.12]
	mov	al, 0
	call	printf@PLT
	mov	rdi, qword ptr [rbp - 8]
	call	clearStuList
	add	rsp, 64
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.LBB3_5:                                #   in Loop: Header=BB3_1 Depth=1
	.cfi_def_cfa rbp, 16
	lea	rdi, [rbp - 33]
	mov	rsi, qword ptr [rbp - 8]
	call	searchCode
	mov	qword ptr [rbp - 16], rax
	cmp	qword ptr [rbp - 16], 0
	je	.LBB3_7
# %bb.6:                                #   in Loop: Header=BB3_1 Depth=1
	mov	rax, qword ptr [rbp - 16]
	mov	rsi, qword ptr [rax + 32]
	mov	rax, qword ptr [rbp - 16]
	mov	rdx, qword ptr [rax + 32]
	add	rdx, 9
	lea	rdi, [rip + .L.str.21]
	mov	al, 0
	call	printf@PLT
	lea	rdi, [rip + .L.str.22]
	mov	al, 0
	call	printf@PLT
	lea	rsi, [rbp - 64]
	lea	rdi, [rip + .L.str.1]
	mov	al, 0
	call	__isoc99_scanf@PLT
	lea	rdi, [rbp - 64]
	call	checkData
	mov	qword ptr [rbp - 24], rax
	mov	rax, qword ptr [rbp - 16]
	mov	rax, qword ptr [rax + 32]
	mov	rcx, qword ptr [rax + 32]
	mov	rax, qword ptr [rbp - 24]
	mov	qword ptr [rax + 32], rcx
	mov	rax, qword ptr [rbp - 16]
	mov	rdi, qword ptr [rax + 32]
	call	free@PLT
	mov	rcx, qword ptr [rbp - 24]
	mov	rax, qword ptr [rbp - 16]
	mov	qword ptr [rax + 32], rcx
	jmp	.LBB3_8
.LBB3_7:                                #   in Loop: Header=BB3_1 Depth=1
	lea	rsi, [rbp - 33]
	lea	rdi, [rip + .L.str.23]
	mov	al, 0
	call	printf@PLT
.LBB3_8:                                #   in Loop: Header=BB3_1 Depth=1
	jmp	.LBB3_1
.Lfunc_end3:
	.size	update, .Lfunc_end3-update
	.cfi_endproc
                                        # -- End function
	.globl	createStuNode                   # -- Begin function createStuNode
	.p2align	4, 0x90
	.type	createStuNode,@function
createStuNode:                          # @createStuNode
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 16
	mov	edi, 40
	call	malloc@PLT
	mov	qword ptr [rbp - 16], rax
	cmp	qword ptr [rbp - 16], 0
	jne	.LBB4_2
# %bb.1:
	mov	qword ptr [rbp - 8], 0
	jmp	.LBB4_3
.LBB4_2:
	mov	rdi, qword ptr [rbp - 16]
	xor	esi, esi
	mov	edx, 9
	call	memset@PLT
	mov	rdi, qword ptr [rbp - 16]
	add	rdi, 9
	xor	esi, esi
	mov	edx, 21
	call	memset@PLT
	mov	rax, qword ptr [rbp - 16]
	mov	qword ptr [rax + 32], 0
	mov	rax, qword ptr [rbp - 16]
	mov	qword ptr [rbp - 8], rax
.LBB4_3:
	mov	rax, qword ptr [rbp - 8]
	add	rsp, 16
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end4:
	.size	createStuNode, .Lfunc_end4-createStuNode
	.cfi_endproc
                                        # -- End function
	.globl	createStuList                   # -- Begin function createStuList
	.p2align	4, 0x90
	.type	createStuList,@function
createStuList:                          # @createStuList
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 16
	mov	edi, 16
	call	malloc@PLT
	mov	qword ptr [rbp - 16], rax
	cmp	qword ptr [rbp - 16], 0
	jne	.LBB5_2
# %bb.1:
	mov	qword ptr [rbp - 8], 0
	jmp	.LBB5_5
.LBB5_2:
	mov	rax, qword ptr [rbp - 16]
	mov	dword ptr [rax + 8], 0
	call	createStuNode
	mov	rcx, rax
	mov	rax, qword ptr [rbp - 16]
	mov	qword ptr [rax], rcx
	mov	rax, qword ptr [rbp - 16]
	cmp	qword ptr [rax], 0
	jne	.LBB5_4
# %bb.3:
	mov	qword ptr [rbp - 8], 0
	jmp	.LBB5_5
.LBB5_4:
	mov	rax, qword ptr [rbp - 16]
	mov	qword ptr [rbp - 8], rax
.LBB5_5:
	mov	rax, qword ptr [rbp - 8]
	add	rsp, 16
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end5:
	.size	createStuList, .Lfunc_end5-createStuList
	.cfi_endproc
                                        # -- End function
	.globl	save                            # -- Begin function save
	.p2align	4, 0x90
	.type	save,@function
save:                                   # @save
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 48
	mov	qword ptr [rbp - 16], rdi
	lea	rdi, [rip + .L.str.14]
	lea	rsi, [rip + .L.str.15]
	call	fopen@PLT
	mov	qword ptr [rbp - 24], rax
	cmp	qword ptr [rbp - 24], 0
	jne	.LBB6_2
# %bb.1:
	mov	dword ptr [rbp - 4], -1
	jmp	.LBB6_7
.LBB6_2:
	mov	rax, qword ptr [rbp - 16]
	mov	rax, qword ptr [rax]
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 32], rax
	mov	dword ptr [rbp - 36], 0
.LBB6_3:                                # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [rbp - 36]
	mov	rcx, qword ptr [rbp - 16]
	cmp	eax, dword ptr [rcx + 8]
	jge	.LBB6_6
# %bb.4:                                #   in Loop: Header=BB6_3 Depth=1
	mov	rdi, qword ptr [rbp - 24]
	mov	rdx, qword ptr [rbp - 32]
	mov	rcx, qword ptr [rbp - 32]
	add	rcx, 9
	lea	rsi, [rip + .L.str.16]
	mov	al, 0
	call	fprintf@PLT
	mov	rax, qword ptr [rbp - 32]
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 32], rax
# %bb.5:                                #   in Loop: Header=BB6_3 Depth=1
	mov	eax, dword ptr [rbp - 36]
	add	eax, 1
	mov	dword ptr [rbp - 36], eax
	jmp	.LBB6_3
.LBB6_6:
	mov	rdi, qword ptr [rbp - 24]
	call	fclose@PLT
	mov	dword ptr [rbp - 4], 1
.LBB6_7:
	mov	eax, dword ptr [rbp - 4]
	add	rsp, 48
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end6:
	.size	save, .Lfunc_end6-save
	.cfi_endproc
                                        # -- End function
	.globl	clearStuList                    # -- Begin function clearStuList
	.p2align	4, 0x90
	.type	clearStuList,@function
clearStuList:                           # @clearStuList
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 32
	mov	qword ptr [rbp - 8], rdi
	mov	rax, qword ptr [rbp - 8]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 24], rax
.LBB7_1:                                # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rbp - 24]
	cmp	qword ptr [rax + 32], 0
	je	.LBB7_3
# %bb.2:                                #   in Loop: Header=BB7_1 Depth=1
	mov	rax, qword ptr [rbp - 24]
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 16], rax
	mov	rax, qword ptr [rbp - 16]
	mov	rcx, qword ptr [rax + 32]
	mov	rax, qword ptr [rbp - 24]
	mov	qword ptr [rax + 32], rcx
	mov	rdi, qword ptr [rbp - 16]
	call	free@PLT
	jmp	.LBB7_1
.LBB7_3:
	mov	rax, qword ptr [rbp - 8]
	mov	rdi, qword ptr [rax]
	call	free@PLT
	mov	rdi, qword ptr [rbp - 8]
	call	free@PLT
	add	rsp, 32
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end7:
	.size	clearStuList, .Lfunc_end7-clearStuList
	.cfi_endproc
                                        # -- End function
	.globl	checkData                       # -- Begin function checkData
	.p2align	4, 0x90
	.type	checkData,@function
checkData:                              # @checkData
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 32
	mov	qword ptr [rbp - 16], rdi
	call	createStuNode
	mov	qword ptr [rbp - 24], rax
	mov	dword ptr [rbp - 28], 0
.LBB8_1:                                # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	movsx	ecx, byte ptr [rax + rcx]
	xor	eax, eax
                                        # kill: def $al killed $al killed $eax
	cmp	ecx, 48
	mov	byte ptr [rbp - 29], al         # 1-byte Spill
	jl	.LBB8_4
# %bb.2:                                #   in Loop: Header=BB8_1 Depth=1
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	movsx	ecx, byte ptr [rax + rcx]
	xor	eax, eax
                                        # kill: def $al killed $al killed $eax
	cmp	ecx, 57
	mov	byte ptr [rbp - 29], al         # 1-byte Spill
	jg	.LBB8_4
# %bb.3:                                #   in Loop: Header=BB8_1 Depth=1
	cmp	dword ptr [rbp - 28], 8
	setl	al
	mov	byte ptr [rbp - 29], al         # 1-byte Spill
.LBB8_4:                                #   in Loop: Header=BB8_1 Depth=1
	mov	al, byte ptr [rbp - 29]         # 1-byte Reload
	test	al, 1
	jne	.LBB8_5
	jmp	.LBB8_7
.LBB8_5:                                #   in Loop: Header=BB8_1 Depth=1
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	mov	dl, byte ptr [rax + rcx]
	mov	rax, qword ptr [rbp - 24]
	movsxd	rcx, dword ptr [rbp - 28]
	mov	byte ptr [rax + rcx], dl
# %bb.6:                                #   in Loop: Header=BB8_1 Depth=1
	mov	eax, dword ptr [rbp - 28]
	add	eax, 1
	mov	dword ptr [rbp - 28], eax
	jmp	.LBB8_1
.LBB8_7:
	cmp	dword ptr [rbp - 28], 8
	jge	.LBB8_9
# %bb.8:
	lea	rdi, [rip + .L.str.33]
	mov	al, 0
	call	printf@PLT
	mov	qword ptr [rbp - 8], 0
	jmp	.LBB8_24
.LBB8_9:
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	movsx	eax, byte ptr [rax + rcx]
	cmp	eax, 44
	je	.LBB8_11
# %bb.10:
	lea	rdi, [rip + .L.str.34]
	mov	al, 0
	call	printf@PLT
	mov	qword ptr [rbp - 8], 0
	jmp	.LBB8_24
.LBB8_11:
	mov	eax, dword ptr [rbp - 28]
	add	eax, 1
	mov	dword ptr [rbp - 28], eax
.LBB8_12:                               # =>This Inner Loop Header: Depth=1
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	movsx	eax, byte ptr [rax + rcx]
	cmp	eax, 97
	jl	.LBB8_14
# %bb.13:                               #   in Loop: Header=BB8_12 Depth=1
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	movsx	eax, byte ptr [rax + rcx]
	cmp	eax, 122
	jle	.LBB8_16
.LBB8_14:                               #   in Loop: Header=BB8_12 Depth=1
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	movsx	ecx, byte ptr [rax + rcx]
	xor	eax, eax
                                        # kill: def $al killed $al killed $eax
	cmp	ecx, 65
	mov	byte ptr [rbp - 30], al         # 1-byte Spill
	jl	.LBB8_17
# %bb.15:                               #   in Loop: Header=BB8_12 Depth=1
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	movsx	ecx, byte ptr [rax + rcx]
	xor	eax, eax
                                        # kill: def $al killed $al killed $eax
	cmp	ecx, 90
	mov	byte ptr [rbp - 30], al         # 1-byte Spill
	jg	.LBB8_17
.LBB8_16:                               #   in Loop: Header=BB8_12 Depth=1
	cmp	dword ptr [rbp - 28], 29
	setl	al
	mov	byte ptr [rbp - 30], al         # 1-byte Spill
.LBB8_17:                               #   in Loop: Header=BB8_12 Depth=1
	mov	al, byte ptr [rbp - 30]         # 1-byte Reload
	test	al, 1
	jne	.LBB8_18
	jmp	.LBB8_20
.LBB8_18:                               #   in Loop: Header=BB8_12 Depth=1
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	mov	dl, byte ptr [rax + rcx]
	mov	rax, qword ptr [rbp - 24]
	mov	ecx, dword ptr [rbp - 28]
	sub	ecx, 8
	sub	ecx, 1
	movsxd	rcx, ecx
	mov	byte ptr [rax + rcx + 9], dl
# %bb.19:                               #   in Loop: Header=BB8_12 Depth=1
	mov	eax, dword ptr [rbp - 28]
	add	eax, 1
	mov	dword ptr [rbp - 28], eax
	jmp	.LBB8_12
.LBB8_20:
	mov	rax, qword ptr [rbp - 16]
	movsxd	rcx, dword ptr [rbp - 28]
	movsx	eax, byte ptr [rax + rcx]
	cmp	eax, 0
	je	.LBB8_23
# %bb.21:
	cmp	dword ptr [rbp - 28], 29
	jge	.LBB8_23
# %bb.22:
	lea	rdi, [rip + .L.str.35]
	mov	al, 0
	call	printf@PLT
	mov	qword ptr [rbp - 8], 0
	jmp	.LBB8_24
.LBB8_23:
	mov	rax, qword ptr [rbp - 24]
	mov	qword ptr [rbp - 8], rax
.LBB8_24:
	mov	rax, qword ptr [rbp - 8]
	add	rsp, 32
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end8:
	.size	checkData, .Lfunc_end8-checkData
	.cfi_endproc
                                        # -- End function
	.globl	searchCode                      # -- Begin function searchCode
	.p2align	4, 0x90
	.type	searchCode,@function
searchCode:                             # @searchCode
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 48
	mov	qword ptr [rbp - 16], rdi
	mov	qword ptr [rbp - 24], rsi
	mov	rax, qword ptr [rbp - 24]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 32], rax
	mov	dword ptr [rbp - 36], 0
.LBB9_1:                                # =>This Inner Loop Header: Depth=1
	mov	eax, dword ptr [rbp - 36]
	mov	rcx, qword ptr [rbp - 24]
	cmp	eax, dword ptr [rcx + 8]
	jge	.LBB9_6
# %bb.2:                                #   in Loop: Header=BB9_1 Depth=1
	mov	rax, qword ptr [rbp - 32]
	mov	rdi, qword ptr [rax + 32]
	mov	rsi, qword ptr [rbp - 16]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB9_4
# %bb.3:
	mov	rax, qword ptr [rbp - 32]
	mov	qword ptr [rbp - 8], rax
	jmp	.LBB9_7
.LBB9_4:                                #   in Loop: Header=BB9_1 Depth=1
	mov	rax, qword ptr [rbp - 32]
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 32], rax
# %bb.5:                                #   in Loop: Header=BB9_1 Depth=1
	mov	eax, dword ptr [rbp - 36]
	add	eax, 1
	mov	dword ptr [rbp - 36], eax
	jmp	.LBB9_1
.LBB9_6:
	mov	qword ptr [rbp - 8], 0
.LBB9_7:
	mov	rax, qword ptr [rbp - 8]
	add	rsp, 48
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end9:
	.size	searchCode, .Lfunc_end9-searchCode
	.cfi_endproc
                                        # -- End function
	.globl	show                            # -- Begin function show
	.p2align	4, 0x90
	.type	show,@function
show:                                   # @show
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 48
	call	getData
	mov	qword ptr [rbp - 8], rax
	cmp	qword ptr [rbp - 8], 0
	jne	.LBB10_2
# %bb.1:
	lea	rdi, [rip + .L.str.24]
	mov	al, 0
	call	printf@PLT
	jmp	.LBB10_19
.LBB10_2:
	mov	rax, qword ptr [rbp - 8]
	cmp	dword ptr [rax + 8], 0
	jne	.LBB10_4
# %bb.3:
	lea	rdi, [rip + .L.str.25]
	mov	al, 0
	call	printf@PLT
	jmp	.LBB10_19
.LBB10_4:
	jmp	.LBB10_5
.LBB10_5:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB10_9 Depth 2
	lea	rdi, [rip + .L.str.26]
	mov	al, 0
	call	printf@PLT
	lea	rsi, [rbp - 17]
	lea	rdi, [rip + .L.str.1]
	mov	al, 0
	call	__isoc99_scanf@PLT
	lea	rdi, [rbp - 17]
	lea	rsi, [rip + .L.str.10]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB10_7
# %bb.6:
	lea	rdi, [rip + .L.str.12]
	mov	al, 0
	call	printf@PLT
	jmp	.LBB10_18
.LBB10_7:                               #   in Loop: Header=BB10_5 Depth=1
	mov	rax, qword ptr [rbp - 8]
	mov	rax, qword ptr [rax]
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 32], rax
	lea	rdi, [rbp - 17]
	lea	rsi, [rip + .L.str.27]
	call	strcmp@PLT
	cmp	eax, 0
	jne	.LBB10_13
# %bb.8:                                #   in Loop: Header=BB10_5 Depth=1
	mov	dword ptr [rbp - 36], 0
.LBB10_9:                               #   Parent Loop BB10_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	mov	eax, dword ptr [rbp - 36]
	mov	rcx, qword ptr [rbp - 8]
	cmp	eax, dword ptr [rcx + 8]
	jge	.LBB10_12
# %bb.10:                               #   in Loop: Header=BB10_9 Depth=2
	mov	rsi, qword ptr [rbp - 32]
	mov	rdx, qword ptr [rbp - 32]
	add	rdx, 9
	lea	rdi, [rip + .L.str.28]
	mov	al, 0
	call	printf@PLT
	mov	rax, qword ptr [rbp - 32]
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 32], rax
# %bb.11:                               #   in Loop: Header=BB10_9 Depth=2
	mov	eax, dword ptr [rbp - 36]
	add	eax, 1
	mov	dword ptr [rbp - 36], eax
	jmp	.LBB10_9
.LBB10_12:                              #   in Loop: Header=BB10_5 Depth=1
	jmp	.LBB10_17
.LBB10_13:                              #   in Loop: Header=BB10_5 Depth=1
	lea	rdi, [rbp - 17]
	mov	rsi, qword ptr [rbp - 8]
	call	searchCode
	mov	qword ptr [rbp - 32], rax
	cmp	qword ptr [rbp - 32], 0
	je	.LBB10_15
# %bb.14:                               #   in Loop: Header=BB10_5 Depth=1
	mov	rax, qword ptr [rbp - 32]
	mov	rsi, qword ptr [rax + 32]
	mov	rax, qword ptr [rbp - 32]
	mov	rdx, qword ptr [rax + 32]
	add	rdx, 9
	lea	rdi, [rip + .L.str.29]
	mov	al, 0
	call	printf@PLT
	jmp	.LBB10_16
.LBB10_15:                              #   in Loop: Header=BB10_5 Depth=1
	lea	rdi, [rip + .L.str.30]
	mov	al, 0
	call	printf@PLT
.LBB10_16:                              #   in Loop: Header=BB10_5 Depth=1
	jmp	.LBB10_17
.LBB10_17:                              #   in Loop: Header=BB10_5 Depth=1
	jmp	.LBB10_5
.LBB10_18:
	mov	rdi, qword ptr [rbp - 8]
	call	clearStuList
.LBB10_19:
	add	rsp, 48
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end10:
	.size	show, .Lfunc_end10-show
	.cfi_endproc
                                        # -- End function
	.globl	getData                         # -- Begin function getData
	.p2align	4, 0x90
	.type	getData,@function
getData:                                # @getData
	.cfi_startproc
# %bb.0:
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset rbp, -16
	mov	rbp, rsp
	.cfi_def_cfa_register rbp
	sub	rsp, 32
	call	createStuList
	mov	qword ptr [rbp - 16], rax
	cmp	qword ptr [rbp - 16], 0
	jne	.LBB11_2
# %bb.1:
	mov	qword ptr [rbp - 8], 0
	jmp	.LBB11_12
.LBB11_2:
	mov	rax, qword ptr [rbp - 16]
	mov	rax, qword ptr [rax]
	mov	qword ptr [rbp - 24], rax
	lea	rdi, [rip + .L.str.14]
	lea	rsi, [rip + .L.str.31]
	call	fopen@PLT
	mov	qword ptr [rbp - 32], rax
	cmp	qword ptr [rbp - 32], 0
	jne	.LBB11_4
# %bb.3:
	mov	qword ptr [rbp - 8], 0
	jmp	.LBB11_12
.LBB11_4:
	mov	rdi, qword ptr [rbp - 32]
	call	fgetc@PLT
	cmp	eax, -1
	jne	.LBB11_6
# %bb.5:
	mov	rax, qword ptr [rbp - 16]
	mov	qword ptr [rbp - 8], rax
	jmp	.LBB11_12
.LBB11_6:
	mov	rdi, qword ptr [rbp - 32]
	xor	eax, eax
	mov	esi, eax
	xor	edx, edx
	call	fseek@PLT
.LBB11_7:                               # =>This Inner Loop Header: Depth=1
	mov	rdi, qword ptr [rbp - 32]
	call	feof@PLT
	cmp	eax, 0
	setne	al
	xor	al, -1
	test	al, 1
	jne	.LBB11_8
	jmp	.LBB11_11
.LBB11_8:                               #   in Loop: Header=BB11_7 Depth=1
	call	createStuNode
	mov	rcx, rax
	mov	rax, qword ptr [rbp - 24]
	mov	qword ptr [rax + 32], rcx
	mov	rax, qword ptr [rbp - 24]
	cmp	qword ptr [rax + 32], 0
	jne	.LBB11_10
# %bb.9:
	mov	qword ptr [rbp - 8], 0
	jmp	.LBB11_12
.LBB11_10:                              #   in Loop: Header=BB11_7 Depth=1
	mov	rax, qword ptr [rbp - 24]
	mov	rax, qword ptr [rax + 32]
	mov	qword ptr [rbp - 24], rax
	mov	rdi, qword ptr [rbp - 24]
	mov	rcx, qword ptr [rbp - 32]
	mov	esi, 8
	mov	edx, 1
	call	fread@PLT
	mov	rdi, qword ptr [rbp - 32]
	call	fgetc@PLT
	mov	rdi, qword ptr [rbp - 32]
	mov	rdx, qword ptr [rbp - 24]
	add	rdx, 9
	lea	rsi, [rip + .L.str.32]
	mov	al, 0
	call	__isoc99_fscanf@PLT
	mov	rax, qword ptr [rbp - 16]
	mov	ecx, dword ptr [rax + 8]
	add	ecx, 1
	mov	dword ptr [rax + 8], ecx
	jmp	.LBB11_7
.LBB11_11:
	mov	rdi, qword ptr [rbp - 32]
	call	fclose@PLT
	mov	rax, qword ptr [rbp - 16]
	mov	qword ptr [rbp - 8], rax
.LBB11_12:
	mov	rax, qword ptr [rbp - 8]
	add	rsp, 32
	pop	rbp
	.cfi_def_cfa rsp, 8
	ret
.Lfunc_end11:
	.size	getData, .Lfunc_end11-getData
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"SMS> "
	.size	.L.str, 6

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"%s"
	.size	.L.str.1, 3

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"quit"
	.size	.L.str.2, 5

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"Bye!\n"
	.size	.L.str.3, 6

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"insert"
	.size	.L.str.4, 7

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"delete"
	.size	.L.str.5, 7

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"update"
	.size	.L.str.6, 7

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"show"
	.size	.L.str.7, 5

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"Illegal Input!"
	.size	.L.str.8, 15

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"SMS insert > "
	.size	.L.str.9, 14

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"."
	.size	.L.str.10, 2

	.type	.L.str.11,@object               # @.str.11
.L.str.11:
	.asciz	"Can't save, please check the database.\n"
	.size	.L.str.11, 40

	.type	.L.str.12,@object               # @.str.12
.L.str.12:
	.asciz	"Return.\n"
	.size	.L.str.12, 9

	.type	.L.str.13,@object               # @.str.13
.L.str.13:
	.asciz	"The code already exist and the log is %s,%s.\n"
	.size	.L.str.13, 46

	.type	.L.str.14,@object               # @.str.14
.L.str.14:
	.asciz	".SMSdata"
	.size	.L.str.14, 9

	.type	.L.str.15,@object               # @.str.15
.L.str.15:
	.asciz	"w+"
	.size	.L.str.15, 3

	.type	.L.str.16,@object               # @.str.16
.L.str.16:
	.asciz	"%s,%s\n"
	.size	.L.str.16, 7

	.type	.L.str.17,@object               # @.str.17
.L.str.17:
	.asciz	"SMS delete > "
	.size	.L.str.17, 14

	.type	.L.str.18,@object               # @.str.18
.L.str.18:
	.asciz	"Deleted %s,%s.\n"
	.size	.L.str.18, 16

	.type	.L.str.19,@object               # @.str.19
.L.str.19:
	.asciz	"There's no %s.\n"
	.size	.L.str.19, 16

	.type	.L.str.20,@object               # @.str.20
.L.str.20:
	.asciz	"SMS update > "
	.size	.L.str.20, 14

	.type	.L.str.21,@object               # @.str.21
.L.str.21:
	.asciz	"The log is %s,%s, please input the new log.\n"
	.size	.L.str.21, 45

	.type	.L.str.22,@object               # @.str.22
.L.str.22:
	.asciz	"new log > "
	.size	.L.str.22, 11

	.type	.L.str.23,@object               # @.str.23
.L.str.23:
	.asciz	"There's no log of %s.\n"
	.size	.L.str.23, 23

	.type	.L.str.24,@object               # @.str.24
.L.str.24:
	.asciz	"Connot read the database.\n"
	.size	.L.str.24, 27

	.type	.L.str.25,@object               # @.str.25
.L.str.25:
	.asciz	"There's nothing.\n"
	.size	.L.str.25, 18

	.type	.L.str.26,@object               # @.str.26
.L.str.26:
	.asciz	"SMS show > "
	.size	.L.str.26, 12

	.type	.L.str.27,@object               # @.str.27
.L.str.27:
	.asciz	"*"
	.size	.L.str.27, 2

	.type	.L.str.28,@object               # @.str.28
.L.str.28:
	.asciz	"%s, %s\n"
	.size	.L.str.28, 8

	.type	.L.str.29,@object               # @.str.29
.L.str.29:
	.asciz	"Found %s,%s.\n"
	.size	.L.str.29, 14

	.type	.L.str.30,@object               # @.str.30
.L.str.30:
	.asciz	"Nothing.\n"
	.size	.L.str.30, 10

	.type	.L.str.31,@object               # @.str.31
.L.str.31:
	.asciz	"a+"
	.size	.L.str.31, 3

	.type	.L.str.32,@object               # @.str.32
.L.str.32:
	.asciz	"%s\n"
	.size	.L.str.32, 4

	.type	.L.str.33,@object               # @.str.33
.L.str.33:
	.asciz	"Please check Input with code.\n"
	.size	.L.str.33, 31

	.type	.L.str.34,@object               # @.str.34
.L.str.34:
	.asciz	"Please check Input with split ',' .\n"
	.size	.L.str.34, 37

	.type	.L.str.35,@object               # @.str.35
.L.str.35:
	.asciz	"Please check Input with name.\n"
	.size	.L.str.35, 31

	.ident	"Ubuntu clang version 14.0.0-1ubuntu1"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym printf
	.addrsig_sym __isoc99_scanf
	.addrsig_sym strcmp
	.addrsig_sym insert
	.addrsig_sym delete
	.addrsig_sym update
	.addrsig_sym createStuNode
	.addrsig_sym malloc
	.addrsig_sym createStuList
	.addrsig_sym save
	.addrsig_sym clearStuList
	.addrsig_sym checkData
	.addrsig_sym searchCode
	.addrsig_sym fopen
	.addrsig_sym fprintf
	.addrsig_sym fclose
	.addrsig_sym free
	.addrsig_sym show
	.addrsig_sym getData
	.addrsig_sym fgetc
	.addrsig_sym fseek
	.addrsig_sym feof
	.addrsig_sym fread
	.addrsig_sym __isoc99_fscanf
