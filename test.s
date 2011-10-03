	.file	"test.c"
	.text
.Ltext0:
	.p2align 4,,15
	.globl	suite_rec
	.type	suite_rec, @function
suite_rec:
.LFB11:
	.file 1 "test.c"
	.loc 1 4 0
	.cfi_startproc
.LVL0:
	movq	%rbx, -32(%rsp)
	movq	%rbp, -24(%rsp)
	movl	%edi, %ebx
	.cfi_offset 6, -32
	.cfi_offset 3, -40
	movq	%r12, -16(%rsp)
	movq	%r13, -8(%rsp)
	subq	$72, %rsp
.LCFI0:
	.cfi_def_cfa_offset 80
	.cfi_offset 13, -16
	.cfi_offset 12, -24
	.loc 1 5 0
	testl	%edi, %edi
	.loc 1 6 0
	movl	$75, %eax
	.loc 1 5 0
	jne	.L21
.LVL1:
.L2:
	.loc 1 9 0
	movq	40(%rsp), %rbx
	movq	48(%rsp), %rbp
	movq	56(%rsp), %r12
	movq	64(%rsp), %r13
	addq	$72, %rsp
	.cfi_remember_state
.LCFI1:
	.cfi_def_cfa_offset 8
	ret
.LVL2:
	.p2align 4,,10
	.p2align 3
.L21:
.LCFI2:
	.cfi_restore_state
.LBB18:
.LBB19:
	.loc 1 5 0
	movl	%edi, %ebp
	movl	$84, %edx
	subl	$1, %ebp
	jne	.L22
.L3:
.LBE19:
.LBE18:
	.loc 1 8 0
	movslq	%ebx, %rbx
.LVL3:
	movq	%rbx, %rax
	negq	%rax
.LVL4:
	salq	$4, %rax
	subq	%rbx, %rax
	addq	%rdx, %rax
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L22:
.LVL5:
.LBB47:
.LBB46:
.LBB20:
.LBB21:
	.loc 1 5 0
	movl	%edi, %r12d
	subl	$2, %r12d
	jne	.L23
.L4:
.LBE21:
.LBE20:
	.loc 1 8 0
	movslq	%ebp, %rbp
	movq	%rbp, %rax
	negq	%rax
	salq	$4, %rax
	subq	%rbp, %rax
	leaq	9(%rdx,%rax), %rdx
	jmp	.L3
.L23:
.LVL6:
.LBB45:
.LBB44:
.LBB22:
.LBB23:
	.loc 1 5 0
	movl	%edi, %r13d
	subl	$3, %r13d
	jne	.L24
.L5:
.LBE23:
.LBE22:
	.loc 1 8 0
	movslq	%r12d, %r12
	movq	%r12, %rax
	negq	%rax
	salq	$4, %rax
	subq	%r12, %rax
	leaq	9(%rdx,%rax), %rdx
	jmp	.L4
.L24:
.LVL7:
.LBB43:
.LBB42:
.LBB24:
.LBB25:
	.loc 1 5 0
	movl	%edi, %edx
	subl	$4, %edx
	movl	%edx, 12(%rsp)
	jne	.L25
.L6:
.LBE25:
.LBE24:
	.loc 1 8 0
	movslq	%r13d, %rdx
	imulq	$-17, %rdx, %rdx
.LBB41:
.LBB40:
	leaq	18(%rax,%rdx), %rdx
	jmp	.L5
.L25:
.LVL8:
.LBB26:
.LBB27:
	.loc 1 5 0
	movl	%edi, %edx
	subl	$5, %edx
	movl	%edx, 16(%rsp)
	jne	.L26
.L7:
.LBE27:
.LBE26:
	.loc 1 8 0
	movslq	12(%rsp), %rdx
	imulq	$-17, %rdx, %rdx
	leaq	9(%rax,%rdx), %rax
	jmp	.L6
.L26:
.LVL9:
.LBB39:
.LBB38:
.LBB28:
.LBB29:
	.loc 1 5 0
	movl	%edi, %edx
	subl	$6, %edx
	movl	%edx, 20(%rsp)
	jne	.L27
.L8:
.LBE29:
.LBE28:
	.loc 1 8 0
	movslq	16(%rsp), %rdx
	imulq	$-17, %rdx, %rdx
	leaq	9(%rax,%rdx), %rax
	jmp	.L7
.L27:
.LVL10:
.LBB37:
.LBB36:
.LBB30:
.LBB31:
	.loc 1 5 0
	movl	%edi, %edx
	subl	$7, %edx
	movl	%edx, 24(%rsp)
	jne	.L28
.L9:
.LBE31:
.LBE30:
	.loc 1 8 0
	movslq	20(%rsp), %rdx
	imulq	$-17, %rdx, %rdx
	leaq	9(%rax,%rdx), %rax
	jmp	.L8
.L28:
.LVL11:
.LBB35:
.LBB34:
.LBB32:
.LBB33:
	.loc 1 5 0
	movl	%edi, %edx
	subl	$8, %edx
	movl	%edx, 28(%rsp)
	je	.L10
	.loc 1 8 0
	leal	-9(%rbx), %edi
	call	suite_rec
	movslq	28(%rsp), %rdx
	imulq	$-17, %rdx, %rdx
	leaq	9(%rax,%rdx), %rax
.L10:
.LBE33:
.LBE32:
	movslq	24(%rsp), %rdx
	imulq	$-17, %rdx, %rdx
	leaq	9(%rax,%rdx), %rax
	jmp	.L9
.LBE34:
.LBE35:
.LBE36:
.LBE37:
.LBE38:
.LBE39:
.LBE40:
.LBE41:
.LBE42:
.LBE43:
.LBE44:
.LBE45:
.LBE46:
.LBE47:
	.cfi_endproc
.LFE11:
	.size	suite_rec, .-suite_rec
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%ld"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB12:
	.loc 1 34 0
	.cfi_startproc
	subq	$8, %rsp
.LCFI3:
	.cfi_def_cfa_offset 16
	.loc 1 35 0
	movl	$835194, %edi
	call	suite_rec
	movl	$.LC0, %edi
	movq	%rax, %rsi
	.loc 1 36 0
	addq	$8, %rsp
.LCFI4:
	.cfi_def_cfa_offset 8
	.loc 1 35 0
	xorl	%eax, %eax
	jmp	printf
	.cfi_endproc
.LFE12:
	.size	main, .-main
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-unknown-linux-gnu/4.6.1/include/stddef.h"
	.file 3 "/usr/include/bits/types.h"
	.file 4 "/usr/include/libio.h"
	.file 5 "/usr/include/stdio.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x45e
	.value	0x2
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF48
	.byte	0x1
	.long	.LASF49
	.long	.LASF50
	.quad	0
	.quad	0
	.long	.Ldebug_ranges0+0x150
	.long	.Ldebug_line0
	.uleb128 0x2
	.long	.LASF7
	.byte	0x2
	.byte	0xd4
	.long	0x3c
	.uleb128 0x3
	.byte	0x8
	.byte	0x7
	.long	.LASF0
	.uleb128 0x3
	.byte	0x1
	.byte	0x8
	.long	.LASF1
	.uleb128 0x3
	.byte	0x2
	.byte	0x7
	.long	.LASF2
	.uleb128 0x3
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF4
	.uleb128 0x3
	.byte	0x2
	.byte	0x5
	.long	.LASF5
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF6
	.uleb128 0x2
	.long	.LASF8
	.byte	0x3
	.byte	0x8d
	.long	0x6d
	.uleb128 0x2
	.long	.LASF9
	.byte	0x3
	.byte	0x8e
	.long	0x6d
	.uleb128 0x5
	.byte	0x8
	.uleb128 0x6
	.byte	0x8
	.long	0x92
	.uleb128 0x3
	.byte	0x1
	.byte	0x6
	.long	.LASF10
	.uleb128 0x7
	.long	.LASF40
	.byte	0xd8
	.byte	0x4
	.value	0x111
	.long	0x266
	.uleb128 0x8
	.long	.LASF11
	.byte	0x4
	.value	0x112
	.long	0x66
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0x8
	.long	.LASF12
	.byte	0x4
	.value	0x117
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0x8
	.long	.LASF13
	.byte	0x4
	.value	0x118
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.uleb128 0x8
	.long	.LASF14
	.byte	0x4
	.value	0x119
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x18
	.uleb128 0x8
	.long	.LASF15
	.byte	0x4
	.value	0x11a
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x20
	.uleb128 0x8
	.long	.LASF16
	.byte	0x4
	.value	0x11b
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x28
	.uleb128 0x8
	.long	.LASF17
	.byte	0x4
	.value	0x11c
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x30
	.uleb128 0x8
	.long	.LASF18
	.byte	0x4
	.value	0x11d
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x38
	.uleb128 0x8
	.long	.LASF19
	.byte	0x4
	.value	0x11e
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x40
	.uleb128 0x8
	.long	.LASF20
	.byte	0x4
	.value	0x120
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x48
	.uleb128 0x8
	.long	.LASF21
	.byte	0x4
	.value	0x121
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x50
	.uleb128 0x8
	.long	.LASF22
	.byte	0x4
	.value	0x122
	.long	0x8c
	.byte	0x2
	.byte	0x23
	.uleb128 0x58
	.uleb128 0x8
	.long	.LASF23
	.byte	0x4
	.value	0x124
	.long	0x2a4
	.byte	0x2
	.byte	0x23
	.uleb128 0x60
	.uleb128 0x8
	.long	.LASF24
	.byte	0x4
	.value	0x126
	.long	0x2aa
	.byte	0x2
	.byte	0x23
	.uleb128 0x68
	.uleb128 0x8
	.long	.LASF25
	.byte	0x4
	.value	0x128
	.long	0x66
	.byte	0x2
	.byte	0x23
	.uleb128 0x70
	.uleb128 0x8
	.long	.LASF26
	.byte	0x4
	.value	0x12c
	.long	0x66
	.byte	0x2
	.byte	0x23
	.uleb128 0x74
	.uleb128 0x8
	.long	.LASF27
	.byte	0x4
	.value	0x12e
	.long	0x74
	.byte	0x2
	.byte	0x23
	.uleb128 0x78
	.uleb128 0x8
	.long	.LASF28
	.byte	0x4
	.value	0x132
	.long	0x4a
	.byte	0x3
	.byte	0x23
	.uleb128 0x80
	.uleb128 0x8
	.long	.LASF29
	.byte	0x4
	.value	0x133
	.long	0x58
	.byte	0x3
	.byte	0x23
	.uleb128 0x82
	.uleb128 0x8
	.long	.LASF30
	.byte	0x4
	.value	0x134
	.long	0x2b0
	.byte	0x3
	.byte	0x23
	.uleb128 0x83
	.uleb128 0x8
	.long	.LASF31
	.byte	0x4
	.value	0x138
	.long	0x2c0
	.byte	0x3
	.byte	0x23
	.uleb128 0x88
	.uleb128 0x8
	.long	.LASF32
	.byte	0x4
	.value	0x141
	.long	0x7f
	.byte	0x3
	.byte	0x23
	.uleb128 0x90
	.uleb128 0x8
	.long	.LASF33
	.byte	0x4
	.value	0x14a
	.long	0x8a
	.byte	0x3
	.byte	0x23
	.uleb128 0x98
	.uleb128 0x8
	.long	.LASF34
	.byte	0x4
	.value	0x14b
	.long	0x8a
	.byte	0x3
	.byte	0x23
	.uleb128 0xa0
	.uleb128 0x8
	.long	.LASF35
	.byte	0x4
	.value	0x14c
	.long	0x8a
	.byte	0x3
	.byte	0x23
	.uleb128 0xa8
	.uleb128 0x8
	.long	.LASF36
	.byte	0x4
	.value	0x14d
	.long	0x8a
	.byte	0x3
	.byte	0x23
	.uleb128 0xb0
	.uleb128 0x8
	.long	.LASF37
	.byte	0x4
	.value	0x14e
	.long	0x31
	.byte	0x3
	.byte	0x23
	.uleb128 0xb8
	.uleb128 0x8
	.long	.LASF38
	.byte	0x4
	.value	0x150
	.long	0x66
	.byte	0x3
	.byte	0x23
	.uleb128 0xc0
	.uleb128 0x8
	.long	.LASF39
	.byte	0x4
	.value	0x152
	.long	0x2c6
	.byte	0x3
	.byte	0x23
	.uleb128 0xc4
	.byte	0
	.uleb128 0x9
	.long	.LASF51
	.byte	0x4
	.byte	0xb6
	.uleb128 0xa
	.long	.LASF41
	.byte	0x18
	.byte	0x4
	.byte	0xbc
	.long	0x2a4
	.uleb128 0xb
	.long	.LASF42
	.byte	0x4
	.byte	0xbd
	.long	0x2a4
	.byte	0x2
	.byte	0x23
	.uleb128 0
	.uleb128 0xb
	.long	.LASF43
	.byte	0x4
	.byte	0xbe
	.long	0x2aa
	.byte	0x2
	.byte	0x23
	.uleb128 0x8
	.uleb128 0xb
	.long	.LASF44
	.byte	0x4
	.byte	0xc2
	.long	0x66
	.byte	0x2
	.byte	0x23
	.uleb128 0x10
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x26d
	.uleb128 0x6
	.byte	0x8
	.long	0x99
	.uleb128 0xc
	.long	0x92
	.long	0x2c0
	.uleb128 0xd
	.long	0x3c
	.byte	0
	.byte	0
	.uleb128 0x6
	.byte	0x8
	.long	0x266
	.uleb128 0xc
	.long	0x92
	.long	0x2d6
	.uleb128 0xd
	.long	0x3c
	.byte	0x13
	.byte	0
	.uleb128 0xe
	.byte	0x1
	.long	.LASF52
	.byte	0x1
	.byte	0x3
	.byte	0x1
	.long	0x2f2
	.byte	0x1
	.long	0x2f2
	.uleb128 0xf
	.string	"n"
	.byte	0x1
	.byte	0x3
	.long	0x66
	.byte	0
	.uleb128 0x3
	.byte	0x8
	.byte	0x5
	.long	.LASF45
	.uleb128 0x10
	.long	0x2d6
	.quad	.LFB11
	.quad	.LFE11
	.long	.LLST0
	.long	0x40c
	.uleb128 0x11
	.long	0x2e8
	.long	.LLST1
	.uleb128 0x12
	.long	0x2d6
	.quad	.LBB18
	.long	.Ldebug_ranges0+0
	.byte	0x1
	.byte	0x8
	.uleb128 0x11
	.long	0x2e8
	.long	.LLST2
	.uleb128 0x12
	.long	0x2d6
	.quad	.LBB20
	.long	.Ldebug_ranges0+0x30
	.byte	0x1
	.byte	0x8
	.uleb128 0x13
	.long	0x2e8
	.byte	0x3
	.byte	0x73
	.sleb128 -2
	.byte	0x9f
	.uleb128 0x12
	.long	0x2d6
	.quad	.LBB22
	.long	.Ldebug_ranges0+0x60
	.byte	0x1
	.byte	0x8
	.uleb128 0x13
	.long	0x2e8
	.byte	0x3
	.byte	0x73
	.sleb128 -3
	.byte	0x9f
	.uleb128 0x12
	.long	0x2d6
	.quad	.LBB24
	.long	.Ldebug_ranges0+0x90
	.byte	0x1
	.byte	0x8
	.uleb128 0x13
	.long	0x2e8
	.byte	0x3
	.byte	0x73
	.sleb128 -4
	.byte	0x9f
	.uleb128 0x12
	.long	0x2d6
	.quad	.LBB26
	.long	.Ldebug_ranges0+0xc0
	.byte	0x1
	.byte	0x8
	.uleb128 0x13
	.long	0x2e8
	.byte	0x3
	.byte	0x73
	.sleb128 -5
	.byte	0x9f
	.uleb128 0x12
	.long	0x2d6
	.quad	.LBB28
	.long	.Ldebug_ranges0+0xf0
	.byte	0x1
	.byte	0x8
	.uleb128 0x13
	.long	0x2e8
	.byte	0x3
	.byte	0x73
	.sleb128 -6
	.byte	0x9f
	.uleb128 0x12
	.long	0x2d6
	.quad	.LBB30
	.long	.Ldebug_ranges0+0x120
	.byte	0x1
	.byte	0x8
	.uleb128 0x13
	.long	0x2e8
	.byte	0x3
	.byte	0x73
	.sleb128 -7
	.byte	0x9f
	.uleb128 0x14
	.long	0x2d6
	.quad	.LBB32
	.quad	.LBE32
	.byte	0x1
	.byte	0x8
	.uleb128 0x13
	.long	0x2e8
	.byte	0x3
	.byte	0x73
	.sleb128 -8
	.byte	0x9f
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x15
	.byte	0x1
	.long	.LASF53
	.byte	0x1
	.byte	0x21
	.byte	0x1
	.long	0x66
	.quad	.LFB12
	.quad	.LFE12
	.long	.LLST3
	.uleb128 0x16
	.long	.LASF46
	.byte	0x5
	.byte	0xa5
	.long	0x2aa
	.byte	0x1
	.byte	0x1
	.uleb128 0x16
	.long	.LASF47
	.byte	0x5
	.byte	0xa6
	.long	0x2aa
	.byte	0x1
	.byte	0x1
	.uleb128 0x16
	.long	.LASF46
	.byte	0x5
	.byte	0xa5
	.long	0x2aa
	.byte	0x1
	.byte	0x1
	.uleb128 0x16
	.long	.LASF47
	.byte	0x5
	.byte	0xa6
	.long	0x2aa
	.byte	0x1
	.byte	0x1
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0xa
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x1d
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x58
	.uleb128 0xb
	.uleb128 0x59
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.quad	.LFB11
	.quad	.LCFI0
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI0
	.quad	.LCFI1
	.value	0x3
	.byte	0x77
	.sleb128 80
	.quad	.LCFI1
	.quad	.LCFI2
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI2
	.quad	.LFE11
	.value	0x3
	.byte	0x77
	.sleb128 80
	.quad	0
	.quad	0
.LLST1:
	.quad	.LVL0
	.quad	.LVL1
	.value	0x1
	.byte	0x55
	.quad	.LVL2
	.quad	.LFE11
	.value	0x1
	.byte	0x53
	.quad	0
	.quad	0
.LLST2:
	.quad	.LVL2
	.quad	.LVL3
	.value	0x3
	.byte	0x73
	.sleb128 -1
	.byte	0x9f
	.quad	.LVL4
	.quad	.LFE11
	.value	0x3
	.byte	0x73
	.sleb128 -1
	.byte	0x9f
	.quad	0
	.quad	0
.LLST3:
	.quad	.LFB12
	.quad	.LCFI3
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	.LCFI3
	.quad	.LCFI4
	.value	0x2
	.byte	0x77
	.sleb128 16
	.quad	.LCFI4
	.quad	.LFE12
	.value	0x2
	.byte	0x77
	.sleb128 8
	.quad	0
	.quad	0
	.section	.debug_aranges,"",@progbits
	.long	0x3c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.quad	0
	.quad	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.quad	.LBB18
	.quad	.LBE18
	.quad	.LBB47
	.quad	.LBE47
	.quad	0
	.quad	0
	.quad	.LBB20
	.quad	.LBE20
	.quad	.LBB45
	.quad	.LBE45
	.quad	0
	.quad	0
	.quad	.LBB22
	.quad	.LBE22
	.quad	.LBB43
	.quad	.LBE43
	.quad	0
	.quad	0
	.quad	.LBB24
	.quad	.LBE24
	.quad	.LBB41
	.quad	.LBE41
	.quad	0
	.quad	0
	.quad	.LBB26
	.quad	.LBE26
	.quad	.LBB39
	.quad	.LBE39
	.quad	0
	.quad	0
	.quad	.LBB28
	.quad	.LBE28
	.quad	.LBB37
	.quad	.LBE37
	.quad	0
	.quad	0
	.quad	.LBB30
	.quad	.LBE30
	.quad	.LBB35
	.quad	.LBE35
	.quad	0
	.quad	0
	.quad	.Ltext0
	.quad	.Letext0
	.quad	.LFB12
	.quad	.LFE12
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF19:
	.string	"_IO_buf_end"
.LASF27:
	.string	"_old_offset"
.LASF22:
	.string	"_IO_save_end"
.LASF5:
	.string	"short int"
.LASF7:
	.string	"size_t"
.LASF32:
	.string	"_offset"
.LASF16:
	.string	"_IO_write_ptr"
.LASF11:
	.string	"_flags"
.LASF18:
	.string	"_IO_buf_base"
.LASF50:
	.string	"/home/rapha/Bureau/testsHaskell"
.LASF23:
	.string	"_markers"
.LASF13:
	.string	"_IO_read_end"
.LASF48:
	.string	"GNU C 4.6.1 20110819 (prerelease)"
.LASF45:
	.string	"long long int"
.LASF52:
	.string	"suite_rec"
.LASF31:
	.string	"_lock"
.LASF6:
	.string	"long int"
.LASF28:
	.string	"_cur_column"
.LASF44:
	.string	"_pos"
.LASF43:
	.string	"_sbuf"
.LASF40:
	.string	"_IO_FILE"
.LASF1:
	.string	"unsigned char"
.LASF49:
	.string	"test.c"
.LASF4:
	.string	"signed char"
.LASF3:
	.string	"unsigned int"
.LASF41:
	.string	"_IO_marker"
.LASF30:
	.string	"_shortbuf"
.LASF15:
	.string	"_IO_write_base"
.LASF39:
	.string	"_unused2"
.LASF12:
	.string	"_IO_read_ptr"
.LASF2:
	.string	"short unsigned int"
.LASF10:
	.string	"char"
.LASF53:
	.string	"main"
.LASF42:
	.string	"_next"
.LASF33:
	.string	"__pad1"
.LASF34:
	.string	"__pad2"
.LASF35:
	.string	"__pad3"
.LASF36:
	.string	"__pad4"
.LASF37:
	.string	"__pad5"
.LASF0:
	.string	"long unsigned int"
.LASF17:
	.string	"_IO_write_end"
.LASF9:
	.string	"__off64_t"
.LASF8:
	.string	"__off_t"
.LASF24:
	.string	"_chain"
.LASF21:
	.string	"_IO_backup_base"
.LASF46:
	.string	"stdin"
.LASF26:
	.string	"_flags2"
.LASF38:
	.string	"_mode"
.LASF14:
	.string	"_IO_read_base"
.LASF29:
	.string	"_vtable_offset"
.LASF20:
	.string	"_IO_save_base"
.LASF25:
	.string	"_fileno"
.LASF47:
	.string	"stdout"
.LASF51:
	.string	"_IO_lock_t"
	.ident	"GCC: (GNU) 4.6.1 20110819 (prerelease)"
	.section	.note.GNU-stack,"",@progbits
