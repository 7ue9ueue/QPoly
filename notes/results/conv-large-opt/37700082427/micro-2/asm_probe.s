	.file	"asm_probe.cpp"
	.text
	.p2align 4
	.globl	_ZN13qp_parse_flat12parse_tokensEPcPjm
	.type	_ZN13qp_parse_flat12parse_tokensEPcPjm, @function
_ZN13qp_parse_flat12parse_tokensEPcPjm:
.LFB8057:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	movq	%rdi, %r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-64, %rsp
	subq	$8392, %rsp
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	$0, -56(%rsp)
	testq	%rdx, %rdx
	je	.L3
	vmovdqa	.LC1(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm7
	movq	%rsi, %rbx
	movq	%rdx, %r12
	vmovdqa	.LC4(%rip), %ymm6
	vmovdqa	.LC5(%rip), %ymm8
	movl	$1, %eax
	movl	$1, %ecx
	vmovdqa	.LC7(%rip), %ymm9
.L2:
	movl	$538976288, %edx
	leaq	2048(%rax), %rdi
	leaq	-56(%rsp), %r9
	vpbroadcastd	%edx, %ymm10
	.p2align 4,,10
	.p2align 3
.L16:
	leaq	-1(%rcx), %rsi
	cmpq	%r12, %rsi
	jnb	.L20
	vpminsb	31(%r14,%rax), %ymm10, %ymm1
	vpminsb	-1(%r14,%rax), %ymm10, %ymm0
	vpbroadcastd	%eax, %ymm4
	leaq	(%r9,%rcx,4), %r10
	vpcmpeqb	31(%r14,%rax), %ymm1, %ymm3
	vpcmpeqb	-1(%r14,%rax), %ymm0, %ymm2
	vpmovmskb	%ymm3, %r13d
	vpmovmskb	%ymm2, %r8d
	salq	$32, %r13
	orq	%r8, %r13
	popcntq	%r13, %rsi
	.p2align 4,,10
	.p2align 3
.L17:
	tzcntq	%r13, %r15
	blsr	%r13, %r11
	blsr	%r11, %rdx
	tzcntq	%rdx, %r8
	tzcntq	%r11, %r13
	addq	$32, %r10
	vmovq	%r15, %xmm11
	vmovq	%r8, %xmm12
	blsr	%rdx, %r15
	blsr	%r15, %rdx
	tzcntq	%rdx, %r8
	tzcntq	%r15, %r11
	vmovq	%r8, %xmm13
	blsr	%rdx, %r15
	blsr	%r15, %rdx
	vpinsrq	$1, %r13, %xmm11, %xmm0
	vpinsrq	$1, %r11, %xmm12, %xmm15
	tzcntq	%r15, %r8
	tzcntq	%rdx, %r15
	blsr	%rdx, %rdx
	vpinsrq	$1, %r8, %xmm13, %xmm1
	vinserti64x2	$0x1, %xmm15, %ymm0, %ymm3
	vmovq	%r15, %xmm14
	tzcntq	%rdx, %r15
	vpinsrq	$1, %r15, %xmm14, %xmm2
	vinserti64x2	$0x1, %xmm2, %ymm1, %ymm11
	vpermt2d	%ymm11, %ymm5, %ymm3
	vpaddd	%ymm4, %ymm3, %ymm12
	vmovdqu	%ymm12, -32(%r10)
	blsr	%rdx, %r13
	jne	.L17
	addq	$64, %rax
	addq	%rsi, %rcx
	cmpq	%rdi, %rax
	jne	.L16
.L20:
	movl	$808464432, %edi
	vmovdqa	.LC9(%rip), %xmm10
	vmovdqa	.LC10(%rip), %xmm4
	xorl	%r8d, %r8d
	vmovdqa	.LC11(%rip), %xmm14
	vpbroadcastd	%edi, %xmm13
	vpbroadcastd	%edi, %ymm15
	.p2align 4,,10
	.p2align 3
.L18:
	cmpq	$3, %r12
	jbe	.L21
.L123:
	leaq	4(%r8), %rdi
	cmpq	%rcx, %rdi
	jnb	.L22
	leaq	1(%r8), %rdx
	movl	-48(%rsp,%r8,4), %r9d
	movl	-56(%rsp,%r8,4), %esi
	movl	-44(%rsp,%r8,4), %r8d
	movl	-56(%rsp,%rdx,4), %r10d
	movq	%rdx, -72(%rsp)
	movl	%r9d, %r13d
	movl	%r8d, %r15d
	movl	%r10d, %r11d
	subl	%r10d, %r13d
	subl	%r9d, %r15d
	subl	%esi, %r11d
	movl	%r15d, -60(%rsp)
	movl	-56(%rsp,%rdi,4), %r15d
	leal	-1(%r11), %edx
	subl	$2, %r11d
	subl	%r8d, %r15d
	movl	%r15d, -64(%rsp)
	leal	-2(%r13), %r15d
	orl	%r11d, %r15d
	movl	-60(%rsp), %r11d
	subl	$2, %r11d
	orl	%r15d, %r11d
	movl	-64(%rsp), %r15d
	subl	$2, %r15d
	orl	%r15d, %r11d
	cmpl	$15, %r11d
	ja	.L28
	salq	$4, %rdx
	vmovdqu	(%r14,%rsi), %xmm0
	vmovdqu	(%r14,%r9), %xmm1
	leal	-1(%r13), %r9d
	vmovdqa	_ZN13qp_parse_flat11right_alignE(%rdx), %xmm12
	movl	-60(%rsp), %edx
	salq	$4, %r9
	subq	$4, %r12
	movl	-64(%rsp), %r11d
	vinserti64x2	$0x1, (%r14,%r10), %ymm0, %ymm3
	addq	$16, %rbx
	leal	-1(%rdx), %r13d
	vinserti64x2	$0x1, _ZN13qp_parse_flat11right_alignE(%r9), %ymm12, %ymm0
	vinserti64x2	$0x1, (%r14,%r8), %ymm1, %ymm11
	movl	$100000000, %r8d
	salq	$4, %r13
	leal	-1(%r11), %r15d
	vpsubusb	%ymm15, %ymm3, %ymm2
	vmovdqa	_ZN13qp_parse_flat11right_alignE(%r13), %xmm12
	salq	$4, %r15
	vpshufb	%ymm0, %ymm2, %ymm2
	vpsubusb	%ymm15, %ymm11, %ymm3
	vpmaddubsw	%ymm7, %ymm2, %ymm1
	vinserti64x2	$0x1, _ZN13qp_parse_flat11right_alignE(%r15), %ymm12, %ymm0
	vpmaddwd	%ymm6, %ymm1, %ymm11
	vpshufb	%ymm0, %ymm3, %ymm3
	vpmaddubsw	%ymm7, %ymm3, %ymm2
	vpbroadcastd	%r8d, %ymm3
	movq	%rdi, %r8
	vpmaddwd	%ymm6, %ymm2, %ymm1
	vpackusdw	%ymm1, %ymm11, %ymm11
	vpmaddwd	%ymm8, %ymm11, %ymm0
	vpmulld	%ymm3, %ymm0, %ymm2
	vpsrlq	$32, %ymm0, %ymm12
	vpaddd	%ymm12, %ymm2, %ymm1
	vxorps	%xmm11, %xmm11, %xmm11
	vpermd	%ymm1, %ymm9, %ymm11
	vmovdqu	%xmm11, -16(%rbx)
	cmpq	$3, %r12
	ja	.L123
.L21:
	testq	%r12, %r12
	je	.L124
.L22:
	leaq	1(%r8), %r9
	cmpq	%rcx, %r9
	jnb	.L25
	movl	-56(%rsp,%r8,4), %esi
	movq	%r9, %r8
	movl	%esi, %edx
	notl	%edx
	addl	-56(%rsp,%r9,4), %edx
.L23:
	testl	%edx, %edx
	je	.L18
	movl	$16, %edi
	vmovdqu	(%r14,%rsi), %xmm12
	cmpl	%edi, %edx
	cmova	%edi, %edx
	vpsubusb	%xmm13, %xmm12, %xmm0
	decq	%r12
	addq	$4, %rbx
	salq	$4, %rdx
	vpshufb	_ZN13qp_parse_flat11right_alignE(%rdx), %xmm0, %xmm3
	vpmaddubsw	%xmm10, %xmm3, %xmm2
	vpmaddwd	%xmm4, %xmm2, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm11
	vpmaddwd	%xmm14, %xmm11, %xmm12
	vmovq	%xmm12, %r10
	imull	$100000000, %r10d, %esi
	shrq	$32, %r10
	addl	%esi, %r10d
	movl	%r10d, -4(%rbx)
	jmp	.L18
.L25:
	testq	%r8, %r8
	je	.L2
	cmpq	%rcx, %r8
	jnb	.L10
	movq	%rcx, %r11
	subq	%r8, %r11
	leaq	-1(%r11), %rsi
	cmpq	$2, %rsi
	jbe	.L6
	cmpq	$-8, %r8
	ja	.L6
	cmpq	$6, %rsi
	jbe	.L27
	movq	%r11, %r10
	leaq	-56(%rsp,%r8,4), %r9
	xorl	%esi, %esi
	shrq	$3, %r10
	salq	$5, %r10
	leaq	-32(%r10), %rdi
	shrq	$5, %rdi
	incq	%rdi
	andl	$7, %edi
	je	.L8
	cmpq	$1, %rdi
	je	.L84
	cmpq	$2, %rdi
	je	.L85
	cmpq	$3, %rdi
	je	.L86
	cmpq	$4, %rdi
	je	.L87
	cmpq	$5, %rdi
	je	.L88
	cmpq	$6, %rdi
	je	.L89
	vmovdqu	(%r9), %ymm0
	movl	$32, %esi
	vmovdqa	%ymm0, -56(%rsp)
.L89:
	vmovdqu	(%r9,%rsi), %ymm3
	vmovdqa	%ymm3, -56(%rsp,%rsi)
	addq	$32, %rsi
.L88:
	vmovdqu	(%r9,%rsi), %ymm2
	vmovdqa	%ymm2, -56(%rsp,%rsi)
	addq	$32, %rsi
.L87:
	vmovdqu	(%r9,%rsi), %ymm1
	vmovdqa	%ymm1, -56(%rsp,%rsi)
	addq	$32, %rsi
.L86:
	vmovdqu	(%r9,%rsi), %ymm11
	vmovdqa	%ymm11, -56(%rsp,%rsi)
	addq	$32, %rsi
.L85:
	vmovdqu	(%r9,%rsi), %ymm12
	vmovdqa	%ymm12, -56(%rsp,%rsi)
	addq	$32, %rsi
.L84:
	vmovdqu	(%r9,%rsi), %ymm13
	vmovdqa	%ymm13, -56(%rsp,%rsi)
	addq	$32, %rsi
	cmpq	%rsi, %r10
	je	.L116
.L8:
	vmovdqu	(%r9,%rsi), %ymm10
	vmovdqa	%ymm10, -56(%rsp,%rsi)
	vmovdqu	32(%r9,%rsi), %ymm4
	vmovdqa	%ymm4, -24(%rsp,%rsi)
	vmovdqu	64(%r9,%rsi), %ymm14
	vmovdqa	%ymm14, 8(%rsp,%rsi)
	vmovdqu	96(%r9,%rsi), %ymm15
	vmovdqa	%ymm15, 40(%rsp,%rsi)
	vmovdqu	128(%r9,%rsi), %ymm0
	vmovdqa	%ymm0, 72(%rsp,%rsi)
	vmovdqu	160(%r9,%rsi), %ymm3
	vmovdqa	%ymm3, 104(%rsp,%rsi)
	vmovdqu	192(%r9,%rsi), %ymm2
	vmovdqa	%ymm2, 136(%rsp,%rsi)
	vmovdqu	224(%r9,%rsi), %ymm1
	vmovdqa	%ymm1, 168(%rsp,%rsi)
	addq	$256, %rsi
	cmpq	%rsi, %r10
	jne	.L8
.L116:
	testb	$7, %r11b
	je	.L10
	movq	%r11, %r15
	andq	$-8, %r15
	subq	%r15, %r11
	leaq	(%r8,%r15), %r13
	leaq	-1(%r11), %r9
	movq	%r13, %rdx
	cmpq	$2, %r9
	jbe	.L12
.L7:
	vmovdqu	-56(%rsp,%r13,4), %xmm11
	vmovdqa	%xmm11, -56(%rsp,%r15,4)
	testb	$3, %r11b
	je	.L10
	andq	$-4, %r11
	addq	%r11, %rdx
.L12:
	movl	-56(%rsp,%rdx,4), %r11d
	movq	%rdx, %r15
	leaq	1(%rdx), %r13
	subq	%r8, %r15
	movl	%r11d, -56(%rsp,%r15,4)
	cmpq	%rcx, %r13
	jnb	.L10
	movl	-56(%rsp,%r13,4), %r10d
	addq	$2, %rdx
	subq	%r8, %r13
	movl	%r10d, -56(%rsp,%r13,4)
	cmpq	%rcx, %rdx
	jnb	.L10
	movl	-56(%rsp,%rdx,4), %edi
	subq	%r8, %rdx
	movl	%edi, -56(%rsp,%rdx,4)
.L10:
	subq	%r8, %rcx
	jmp	.L2
.L124:
	movl	-56(%rsp,%r8,4), %eax
	addq	%rax, %r14
	vzeroupper
.L3:
	leaq	-40(%rbp), %rsp
	movq	%r14, %rax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L28:
	.cfi_restore_state
	movq	-72(%rsp), %r8
	jmp	.L23
.L6:
	leaq	0(,%r8,4), %rsi
	leaq	-56(%rsp,%rcx,4), %r9
	leaq	-56(%rsp,%rsi), %rdx
	movq	%r9, %r11
	negq	%rsi
	subq	%rdx, %r11
	subq	$4, %r11
	shrq	$2, %r11
	incq	%r11
	andl	$7, %r11d
	je	.L14
	cmpq	$1, %r11
	je	.L90
	cmpq	$2, %r11
	je	.L91
	cmpq	$3, %r11
	je	.L92
	cmpq	$4, %r11
	je	.L93
	cmpq	$5, %r11
	je	.L94
	cmpq	$6, %r11
	jne	.L125
.L95:
	movl	(%rdx), %r13d
	addq	$4, %rdx
	movl	%r13d, -4(%rdx,%rsi)
.L94:
	movl	(%rdx), %r10d
	addq	$4, %rdx
	movl	%r10d, -4(%rdx,%rsi)
.L93:
	movl	(%rdx), %edi
	addq	$4, %rdx
	movl	%edi, -4(%rdx,%rsi)
.L92:
	movl	(%rdx), %r11d
	addq	$4, %rdx
	movl	%r11d, -4(%rdx,%rsi)
.L91:
	movl	(%rdx), %r15d
	addq	$4, %rdx
	movl	%r15d, -4(%rdx,%rsi)
.L90:
	movl	(%rdx), %r13d
	addq	$4, %rdx
	movl	%r13d, -4(%rdx,%rsi)
	cmpq	%r9, %rdx
	je	.L10
.L14:
	movl	(%rdx), %r10d
	addq	$32, %rdx
	movl	%r10d, -32(%rdx,%rsi)
	movl	-28(%rdx), %edi
	movl	%edi, -28(%rdx,%rsi)
	movl	-24(%rdx), %r11d
	movl	%r11d, -24(%rdx,%rsi)
	movl	-20(%rdx), %r15d
	movl	%r15d, -20(%rdx,%rsi)
	movl	-16(%rdx), %r13d
	movl	%r13d, -16(%rdx,%rsi)
	movl	-12(%rdx), %r10d
	movl	%r10d, -12(%rdx,%rsi)
	movl	-8(%rdx), %edi
	movl	%edi, -8(%rdx,%rsi)
	movl	-4(%rdx), %r11d
	movl	%r11d, -4(%rdx,%rsi)
	cmpq	%r9, %rdx
	jne	.L14
	jmp	.L10
.L27:
	movq	%r8, %rdx
	xorl	%r15d, %r15d
	movq	%r8, %r13
	jmp	.L7
.L125:
	movl	(%rdx), %r15d
	addq	$4, %rdx
	movl	%r15d, -4(%rdx,%rsi)
	jmp	.L95
	.cfi_endproc
.LFE8057:
	.size	_ZN13qp_parse_flat12parse_tokensEPcPjm, .-_ZN13qp_parse_flat12parse_tokensEPcPjm
	.p2align 4
	.globl	_Z12probe_formatPKjPcm
	.type	_Z12probe_formatPKjPcm, @function
_Z12probe_formatPKjPcm:
.LFB8934:
	.cfi_startproc
	cmpq	$31, %rdx
	jbe	.L132
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$10000, %ecx
	movl	$9999999, %r8d
	movl	$999999, %r9d
	movl	$99999, %r10d
	vpbroadcastd	%r8d, %ymm2
	vpbroadcastd	%r9d, %ymm5
	movl	$9999, %r11d
	vpbroadcastd	%r10d, %ymm0
	vpbroadcastd	%ecx, %ymm16
	movl	$99, %r8d
	movl	$999, %ecx
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	movl	$9, %r9d
	movl	$65280, %r10d
	subq	$264, %rsp
	vpbroadcastd	%r11d, %ymm1
	vpbroadcastd	%ecx, %ymm3
	movl	$343610491, %r11d
	vpbroadcastd	%r8d, %ymm4
	vpbroadcastd	%r9d, %ymm6
	vpbroadcastd	%r10d, %ymm7
	movq	%rsi, %rax
	vmovdqa	%ymm2, -120(%rsp)
	movq	%rdx, %rsi
	vpbroadcastd	%r11d, %ymm15
	movl	$32, %edx
	vmovdqa	%ymm5, 136(%rsp)
	vmovdqa	%ymm0, 104(%rsp)
	vmovdqa	%ymm1, 200(%rsp)
	vmovdqa	%ymm3, 72(%rsp)
	vmovdqa32	.LC15(%rip), %ymm20
	vmovdqa32	.LC16(%rip), %ymm19
	vmovdqa	%ymm4, 40(%rsp)
	vmovdqa64	.LC33(%rip), %ymm29
	vmovdqa64	.LC34(%rip), %ymm18
	vmovdqa	%ymm6, 8(%rsp)
	vmovdqa64	.LC35(%rip), %ymm28
	vmovdqa64	.LC36(%rip), %ymm17
	vmovdqa	%ymm7, -24(%rsp)
	vmovdqa64	.LC37(%rip), %ymm27
	.p2align 4,,10
	.p2align 3
.L128:
	vmovdqu	-128(%rdi,%rdx,4), %ymm13
	vmovdqa32	-120(%rsp), %ymm31
	movl	$572662306, %ecx
	movl	$1145324612, %r8d
	vmovdqa32	104(%rsp), %ymm26
	vmovdqa32	200(%rsp), %ymm23
	kmovd	%ecx, %k3
	kmovd	%r8d, %k2
	movl	$-2004318072, %r9d
	movl	$65436, %r10d
	vpsrlq	$32, %ymm13, %ymm8
	vpmuludq	%ymm20, %ymm13, %ymm11
	vmovdqa32	136(%rsp), %ymm30
	kmovd	%r9d, %k1
	vpbroadcastd	%r10d, %ymm25
	vpmuludq	%ymm20, %ymm8, %ymm9
	vpmuludq	%ymm19, %ymm8, %ymm5
	movl	$429529498, %r11d
	movl	$808464432, %ecx
	vpmuludq	%ymm19, %ymm13, %ymm1
	vpxord	%xmm24, %xmm24, %xmm24
	movl	$538976288, %r8d
	movl	$99999999, %r9d
	vmovdqu	-96(%rdi,%rdx,4), %ymm4
	movl	$48, %r10d
	vmovdqu	-64(%rdi,%rdx,4), %ymm3
	addq	$320, %rax
	vmovdqu	-32(%rdi,%rdx,4), %ymm2
	addq	$32, %rdx
	vpsrlq	$45, %ymm11, %ymm12
	vpsrlq	$13, %ymm9, %ymm10
	vpsrlq	$24, %ymm5, %ymm0
	vpminsd	%ymm30, %ymm13, %ymm5
	vpblendd	$170, %ymm10, %ymm12, %ymm14
	vpsrlq	$56, %ymm1, %ymm6
	vpminsd	%ymm31, %ymm13, %ymm12
	vpmulld	%ymm16, %ymm14, %ymm7
	vpcmpeqd	%ymm5, %ymm13, %ymm1
	vpblendd	$170, %ymm0, %ymm6, %ymm8
	vpmulld	%ymm16, %ymm8, %ymm9
	vpminsd	%ymm26, %ymm13, %ymm0
	vpminsd	40(%rsp), %ymm13, %ymm5
	vpcmpeqd	%ymm0, %ymm13, %ymm6
	vpminsd	8(%rsp), %ymm13, %ymm0
	vpsubd	%ymm7, %ymm13, %ymm11
	vpminsd	%ymm23, %ymm13, %ymm7
	vpsubd	%ymm9, %ymm14, %ymm10
	vpcmpeqd	%ymm12, %ymm13, %ymm14
	vpminsd	72(%rsp), %ymm13, %ymm9
	vpcmpeqd	%ymm7, %ymm13, %ymm12
	vpmulhuw	%ymm15, %ymm10, %ymm7
	vmovdqu8	%ymm6, %ymm12{%k3}
	vpcmpeqd	%ymm0, %ymm13, %ymm6
	vmovdqu8	%ymm1, %ymm12{%k2}
	vpcmpeqd	%ymm5, %ymm13, %ymm1
	vmovdqu8	%ymm14, %ymm12{%k1}
	vpcmpeqd	%ymm9, %ymm13, %ymm14
	vpandq	-24(%rsp), %ymm6, %ymm9
	vpcmpb	$5, %ymm24, %ymm12, %k4
	vmovdqu8	%ymm1, %ymm9{%k2}
	vpbroadcastd	%r11d, %ymm1
	movl	$32, %r11d
	vmovdqu8	%ymm14, %ymm9{%k1}
	vpsrlw	$3, %ymm7, %ymm14
	vpmulld	%ymm25, %ymm14, %ymm5
	vpcmpb	$5, %ymm24, %ymm9, %k5
	vpaddd	%ymm10, %ymm5, %ymm0
	vpmulhuw	%ymm1, %ymm0, %ymm10
	vpsllw	$5, %ymm10, %ymm12
	vpsubw	%ymm10, %ymm12, %ymm6
	vpsllw	$2, %ymm6, %ymm7
	vpmulhuw	%ymm15, %ymm11, %ymm6
	vpsubw	%ymm10, %ymm7, %ymm14
	vpsllw	$1, %ymm14, %ymm5
	vpaddw	%ymm0, %ymm5, %ymm10
	vpbroadcastd	%ecx, %ymm0
	movl	$536870912, %ecx
	vmovdqa	%ymm0, 232(%rsp)
	vpbroadcastd	%r8d, %ymm0
	vpsrlw	$3, %ymm6, %ymm7
	vmovdqa	%ymm0, %ymm12
	vpmulld	%ymm25, %ymm7, %ymm14
	vpaddb	232(%rsp), %ymm10, %ymm12{%k4}
	vpaddd	%ymm11, %ymm14, %ymm5
	vpmulhuw	%ymm1, %ymm5, %ymm11
	vpsllw	$5, %ymm11, %ymm9
	vpsubw	%ymm11, %ymm9, %ymm10
	vmovdqa	%ymm0, %ymm9
	vpsllw	$2, %ymm10, %ymm6
	vpsubw	%ymm11, %ymm6, %ymm7
	vpsrlq	$32, %ymm4, %ymm6
	vpsllw	$1, %ymm7, %ymm14
	vpaddw	%ymm5, %ymm14, %ymm5
	vpaddb	232(%rsp), %ymm5, %ymm9{%k5}
	vpbroadcastd	%r11d, %ymm5
	vmovdqa	%ymm5, %ymm10
	vpunpckldq	%ymm9, %ymm12, %ymm11
	vpunpckhdq	%ymm9, %ymm12, %ymm7
	vpbroadcastd	%r9d, %ymm12
	vpcmpd	$6, %ymm12, %ymm13, %k6
	vpmuludq	%ymm20, %ymm4, %ymm9
	vpbroadcastd	%r10d, %ymm13
	vmovdqa	%ymm13, 168(%rsp)
	vpcmpd	$6, %ymm12, %ymm4, %k5
	vpaddd	168(%rsp), %ymm8, %ymm10{%k6}
	vpmuludq	%ymm20, %ymm6, %ymm8
	vpmuludq	%ymm19, %ymm6, %ymm6
	vpsrlq	$45, %ymm9, %ymm13
	vpsrlq	$13, %ymm8, %ymm14
	vpblendd	$170, %ymm14, %ymm13, %ymm8
	vpmuludq	%ymm19, %ymm4, %ymm14
	vpsrlq	$24, %ymm6, %ymm9
	vpmulld	%ymm16, %ymm8, %ymm6
	vpsrlq	$56, %ymm14, %ymm13
	vpblendd	$170, %ymm9, %ymm13, %ymm14
	vpsubd	%ymm6, %ymm4, %ymm13
	vpminsd	%ymm31, %ymm4, %ymm6
	vpmulld	%ymm16, %ymm14, %ymm9
	vpsubd	%ymm9, %ymm8, %ymm8
	vpcmpeqd	%ymm6, %ymm4, %ymm9
	vpminsd	%ymm30, %ymm4, %ymm6
	vpcmpeqd	%ymm6, %ymm4, %ymm6
	vmovdqa32	%ymm6, %ymm21
	vpminsd	%ymm26, %ymm4, %ymm6
	vpcmpeqd	%ymm6, %ymm4, %ymm6
	vmovdqa32	%ymm6, %ymm22
	vpminsd	%ymm23, %ymm4, %ymm6
	vpcmpeqd	%ymm6, %ymm4, %ymm6
	vmovdqu8	%ymm22, %ymm6{%k3}
	vpmulhuw	%ymm15, %ymm8, %ymm22
	vmovdqu8	%ymm21, %ymm6{%k2}
	vmovdqu8	%ymm9, %ymm6{%k1}
	vpminsd	72(%rsp), %ymm4, %ymm9
	vpcmpb	$5, %ymm24, %ymm6, %k7
	vpcmpeqd	%ymm9, %ymm4, %ymm9
	vmovdqa32	%ymm9, %ymm23
	vpminsd	40(%rsp), %ymm4, %ymm9
	vpcmpeqd	%ymm9, %ymm4, %ymm9
	vmovdqa32	%ymm9, %ymm21
	vpminsd	8(%rsp), %ymm4, %ymm9
	vpcmpeqd	%ymm9, %ymm4, %ymm9
	vmovdqa	%ymm5, %ymm4
	vpaddd	168(%rsp), %ymm14, %ymm4{%k5}
	vpandq	-24(%rsp), %ymm9, %ymm9
	vmovdqa	%ymm4, -56(%rsp)
	vpmuludq	%ymm20, %ymm3, %ymm4
	vmovdqu8	%ymm21, %ymm9{%k2}
	vmovdqu8	%ymm23, %ymm9{%k1}
	vpsrlw	$3, %ymm22, %ymm23
	vpmulld	%ymm25, %ymm23, %ymm21
	vpcmpb	$5, %ymm24, %ymm9, %k4
	vpaddd	%ymm8, %ymm21, %ymm23
	vpmulhuw	%ymm1, %ymm23, %ymm22
	vpsllw	$5, %ymm22, %ymm8
	vpsubw	%ymm22, %ymm8, %ymm6
	vpsllw	$2, %ymm6, %ymm8
	vpsubw	%ymm22, %ymm8, %ymm6
	vpsllw	$1, %ymm6, %ymm8
	vmovdqa	%ymm0, %ymm6
	vpaddw	%ymm23, %ymm8, %ymm8
	vpmuludq	%ymm19, %ymm3, %ymm23
	vpaddb	232(%rsp), %ymm8, %ymm6{%k7}
	vpmulhuw	%ymm15, %ymm13, %ymm8
	vpsrlw	$3, %ymm8, %ymm8
	vpmulld	%ymm25, %ymm8, %ymm8
	vpaddd	%ymm13, %ymm8, %ymm13
	vpmulhuw	%ymm1, %ymm13, %ymm21
	vpsllw	$5, %ymm21, %ymm9
	vpsubw	%ymm21, %ymm9, %ymm8
	vpsllw	$2, %ymm8, %ymm9
	vpsubw	%ymm21, %ymm9, %ymm8
	vpsllw	$1, %ymm8, %ymm9
	vpaddw	%ymm13, %ymm9, %ymm8
	vmovdqa	%ymm0, %ymm9
	vpaddb	232(%rsp), %ymm8, %ymm9{%k4}
	vpsrlq	$32, %ymm3, %ymm8
	vpmuludq	%ymm20, %ymm8, %ymm14
	vpmuludq	%ymm19, %ymm8, %ymm8
	vpunpckldq	%ymm9, %ymm6, %ymm13
	vpcmpd	$6, %ymm12, %ymm3, %k4
	vpunpckhdq	%ymm9, %ymm6, %ymm6
	vpsrlq	$13, %ymm14, %ymm9
	vpsrlq	$45, %ymm4, %ymm14
	vpblendd	$170, %ymm9, %ymm14, %ymm9
	vpsrlq	$24, %ymm8, %ymm4
	vpsrlq	$56, %ymm23, %ymm14
	vpmulld	%ymm16, %ymm9, %ymm22
	vpblendd	$170, %ymm4, %ymm14, %ymm8
	vpminsd	%ymm30, %ymm3, %ymm14
	vpmulld	%ymm16, %ymm8, %ymm4
	vmovdqa32	%ymm8, %ymm21
	vpminsd	%ymm26, %ymm3, %ymm8
	vpsubd	%ymm22, %ymm3, %ymm22
	vpsubd	%ymm4, %ymm9, %ymm23
	vpminsd	%ymm31, %ymm3, %ymm9
	vpcmpeqd	%ymm9, %ymm3, %ymm4
	vpcmpeqd	%ymm14, %ymm3, %ymm9
	vpcmpeqd	%ymm8, %ymm3, %ymm14
	vpminsd	200(%rsp), %ymm3, %ymm8
	vpcmpeqd	%ymm8, %ymm3, %ymm8
	vmovdqu8	%ymm14, %ymm8{%k3}
	vpminsd	40(%rsp), %ymm3, %ymm14
	vmovdqu8	%ymm9, %ymm8{%k2}
	vmovdqu8	%ymm4, %ymm8{%k1}
	vpminsd	72(%rsp), %ymm3, %ymm4
	vpcmpb	$5, %ymm24, %ymm8, %k6
	vpcmpeqd	%ymm4, %ymm3, %ymm9
	vpcmpeqd	%ymm14, %ymm3, %ymm4
	vpminsd	8(%rsp), %ymm3, %ymm14
	vmovdqa32	%ymm4, %ymm26
	vpcmpeqd	%ymm14, %ymm3, %ymm4
	vmovdqa	%ymm5, %ymm3
	vpandq	-24(%rsp), %ymm4, %ymm14
	vmovdqu8	%ymm26, %ymm14{%k2}
	vmovdqa64	%ymm0, %ymm26
	vmovdqu8	%ymm9, %ymm14{%k1}
	vpmulhuw	%ymm15, %ymm23, %ymm9
	vpcmpb	$5, %ymm24, %ymm14, %k7
	vpsrlw	$3, %ymm9, %ymm4
	vpmulld	%ymm25, %ymm4, %ymm9
	vpaddd	%ymm23, %ymm9, %ymm4
	vpmulhuw	%ymm1, %ymm4, %ymm23
	vpsllw	$5, %ymm23, %ymm8
	vpsubw	%ymm23, %ymm8, %ymm9
	vpsllw	$2, %ymm9, %ymm8
	vpsubw	%ymm23, %ymm8, %ymm9
	vpmuludq	%ymm20, %ymm2, %ymm23
	vpsllw	$1, %ymm9, %ymm8
	vpaddw	%ymm4, %ymm8, %ymm9
	vpmulhuw	%ymm15, %ymm22, %ymm8
	vmovdqa	%ymm0, %ymm4
	vpaddb	232(%rsp), %ymm9, %ymm4{%k6}
	vpsrlw	$3, %ymm8, %ymm9
	vpmulld	%ymm25, %ymm9, %ymm8
	vpaddd	%ymm22, %ymm8, %ymm22
	vpmulhuw	%ymm1, %ymm22, %ymm30
	vpsllw	$5, %ymm30, %ymm14
	vpsubw	%ymm30, %ymm14, %ymm9
	vpsllw	$2, %ymm9, %ymm8
	vpsubw	%ymm30, %ymm8, %ymm14
	vpsrlq	$45, %ymm23, %ymm30
	vpsllw	$1, %ymm14, %ymm9
	vpaddw	%ymm22, %ymm9, %ymm8
	vpaddb	232(%rsp), %ymm8, %ymm26{%k7}
	vpaddd	168(%rsp), %ymm21, %ymm3{%k4}
	vmovdqa32	%ymm30, %ymm8
	vmovdqa	%ymm3, -88(%rsp)
	vpsrlq	$32, %ymm2, %ymm3
	vpunpckldq	%ymm26, %ymm4, %ymm14
	vpunpckhdq	%ymm26, %ymm4, %ymm4
	vpmuludq	%ymm20, %ymm3, %ymm21
	vpmuludq	%ymm19, %ymm2, %ymm26
	vpmuludq	%ymm19, %ymm3, %ymm3
	vpsrlq	$13, %ymm21, %ymm22
	vpsrlq	$56, %ymm26, %ymm21
	vmovdqa32	%ymm22, %ymm9
	vpsrlq	$24, %ymm3, %ymm3
	vpblendd	$170, %ymm9, %ymm8, %ymm8
	vmovdqa32	%ymm21, %ymm9
	vpblendd	$170, %ymm3, %ymm9, %ymm3
	vpmulld	%ymm16, %ymm8, %ymm22
	vpmulld	%ymm16, %ymm3, %ymm9
	vmovdqa32	%ymm3, %ymm21
	vpsubd	%ymm22, %ymm2, %ymm30
	vpsubd	%ymm9, %ymm8, %ymm23
	vpminsd	136(%rsp), %ymm2, %ymm9
	vpminsd	%ymm31, %ymm2, %ymm8
	vpcmpeqd	%ymm8, %ymm2, %ymm3
	vpcmpeqd	%ymm9, %ymm2, %ymm8
	vmovdqa32	%ymm3, %ymm22
	vmovdqa32	%ymm8, %ymm26
	vpminsd	104(%rsp), %ymm2, %ymm3
	vpminsd	200(%rsp), %ymm2, %ymm8
	vpcmpeqd	%ymm3, %ymm2, %ymm9
	vpcmpeqd	%ymm8, %ymm2, %ymm3
	vmovdqu8	%ymm9, %ymm3{%k3}
	vpminsd	72(%rsp), %ymm2, %ymm9
	vmovdqu8	%ymm26, %ymm3{%k2}
	vpcmpeqd	%ymm9, %ymm2, %ymm8
	vpminsd	40(%rsp), %ymm2, %ymm9
	vmovdqu8	%ymm22, %ymm3{%k1}
	vpcmpb	$5, %ymm24, %ymm3, %k3
	vmovdqa32	%ymm8, %ymm22
	vpcmpeqd	%ymm9, %ymm2, %ymm8
	vpminsd	8(%rsp), %ymm2, %ymm9
	vmovdqa32	%ymm8, %ymm31
	vpcmpeqd	%ymm9, %ymm2, %ymm8
	vpandq	-24(%rsp), %ymm8, %ymm26
	vmovdqu8	%ymm31, %ymm26{%k2}
	vmovdqu8	%ymm22, %ymm26{%k1}
	vpmulhuw	%ymm15, %ymm23, %ymm22
	vpcmpd	$6, %ymm12, %ymm2, %k1
	vpcmpb	$5, %ymm24, %ymm26, %k2
	vpbroadcastd	%ecx, %ymm2
	vporq	%ymm2, %ymm10, %ymm10
	vpshufb	%ymm18, %ymm11, %ymm12
	vpshufb	%ymm17, %ymm11, %ymm11
	vpshufb	%ymm27, %ymm10, %ymm24
	vpaddd	168(%rsp), %ymm21, %ymm5{%k1}
	vpsrlw	$3, %ymm22, %ymm31
	vpmulld	%ymm25, %ymm31, %ymm22
	vporq	%ymm2, %ymm5, %ymm5
	vpaddd	%ymm23, %ymm22, %ymm31
	vmovdqa64	%ymm0, %ymm22
	vpmulhuw	%ymm1, %ymm31, %ymm23
	vpsllw	$5, %ymm23, %ymm3
	vpsubw	%ymm23, %ymm3, %ymm9
	vpsllw	$2, %ymm9, %ymm8
	vpsubw	%ymm23, %ymm8, %ymm3
	vpsllw	$1, %ymm3, %ymm9
	vpaddw	%ymm31, %ymm9, %ymm8
	vpmulhuw	%ymm15, %ymm30, %ymm31
	vpaddb	232(%rsp), %ymm8, %ymm22{%k3}
	vpsrlw	$3, %ymm31, %ymm23
	vpmulld	%ymm25, %ymm23, %ymm25
	vpaddd	%ymm30, %ymm25, %ymm30
	vpmulhuw	%ymm1, %ymm30, %ymm1
	vpsllw	$5, %ymm1, %ymm3
	vpsubw	%ymm1, %ymm3, %ymm9
	vpsllw	$2, %ymm9, %ymm8
	vpsubw	%ymm1, %ymm8, %ymm1
	vpshufb	%ymm29, %ymm10, %ymm8
	vpsllw	$1, %ymm1, %ymm3
	vpaddw	%ymm30, %ymm3, %ymm9
	vpshufb	%ymm28, %ymm10, %ymm3
	vpshufb	.LC38(%rip), %ymm10, %ymm10
	vpaddb	232(%rsp), %ymm9, %ymm0{%k2}
	vporq	%ymm8, %ymm12, %ymm9
	vpshufb	%ymm18, %ymm7, %ymm12
	vpshufb	%ymm17, %ymm7, %ymm7
	vporq	%ymm3, %ymm11, %ymm8
	vporq	%ymm24, %ymm12, %ymm3
	vmovdqu	%xmm9, -320(%rax)
	vporq	%ymm10, %ymm7, %ymm11
	vmovdqu	%xmm8, -310(%rax)
	vpunpckldq	%ymm0, %ymm22, %ymm1
	vpunpckhdq	%ymm0, %ymm22, %ymm0
	vmovdqu	%xmm3, -300(%rax)
	vmovdqu	%xmm11, -290(%rax)
	vextracti64x2	$0x1, %ymm9, -280(%rax)
	vporq	-56(%rsp), %ymm2, %ymm9
	vextracti64x2	$0x1, %ymm8, -270(%rax)
	vextracti64x2	$0x1, %ymm3, -260(%rax)
	vpshufb	%ymm18, %ymm13, %ymm3
	vextracti64x2	$0x1, %ymm11, -250(%rax)
	vpshufb	%ymm17, %ymm13, %ymm13
	vpshufb	%ymm29, %ymm9, %ymm8
	vpshufb	%ymm28, %ymm9, %ymm10
	vpshufb	%ymm27, %ymm9, %ymm12
	vporq	%ymm8, %ymm3, %ymm11
	vpshufb	.LC38(%rip), %ymm9, %ymm9
	vpshufb	%ymm18, %ymm6, %ymm8
	vpshufb	%ymm17, %ymm6, %ymm6
	vporq	%ymm10, %ymm13, %ymm7
	vporq	%ymm12, %ymm8, %ymm3
	vmovdqu	%xmm11, -240(%rax)
	vporq	%ymm9, %ymm6, %ymm10
	vmovdqu	%xmm7, -230(%rax)
	vpshufb	%ymm18, %ymm4, %ymm8
	vpshufb	%ymm17, %ymm4, %ymm4
	vmovdqu	%xmm3, -220(%rax)
	vmovdqu	%xmm10, -210(%rax)
	vextracti64x2	$0x1, %ymm11, -200(%rax)
	vporq	-88(%rsp), %ymm2, %ymm11
	vextracti64x2	$0x1, %ymm7, -190(%rax)
	vextracti64x2	$0x1, %ymm3, -180(%rax)
	vpshufb	%ymm18, %ymm14, %ymm3
	vextracti64x2	$0x1, %ymm10, -170(%rax)
	vpshufb	%ymm17, %ymm14, %ymm14
	vpshufb	%ymm29, %ymm5, %ymm2
	vpshufb	%ymm29, %ymm11, %ymm7
	vpshufb	%ymm28, %ymm11, %ymm10
	vpshufb	%ymm27, %ymm11, %ymm12
	vpshufb	.LC38(%rip), %ymm11, %ymm11
	vporq	%ymm7, %ymm3, %ymm6
	vporq	%ymm10, %ymm14, %ymm13
	vporq	%ymm11, %ymm4, %ymm3
	vporq	%ymm12, %ymm8, %ymm9
	vmovdqu	%xmm6, -160(%rax)
	vpshufb	%ymm18, %ymm0, %ymm4
	vmovdqu	%xmm13, -150(%rax)
	vpshufb	%ymm28, %ymm5, %ymm8
	vpshufb	%ymm27, %ymm5, %ymm11
	vpshufb	.LC38(%rip), %ymm5, %ymm7
	vmovdqu	%xmm9, -140(%rax)
	vpshufb	%ymm17, %ymm0, %ymm0
	vmovdqu	%xmm3, -130(%rax)
	vextracti64x2	$0x1, %ymm6, -120(%rax)
	vpshufb	%ymm18, %ymm1, %ymm6
	vpshufb	%ymm17, %ymm1, %ymm1
	vextracti64x2	$0x1, %ymm13, -110(%rax)
	vporq	%ymm7, %ymm0, %ymm10
	vextracti64x2	$0x1, %ymm9, -100(%rax)
	vporq	%ymm2, %ymm6, %ymm13
	vextracti64x2	$0x1, %ymm3, -90(%rax)
	vporq	%ymm8, %ymm1, %ymm9
	vporq	%ymm11, %ymm4, %ymm3
	vmovdqu	%xmm13, -80(%rax)
	vmovdqu	%xmm9, -70(%rax)
	vmovdqu	%xmm3, -60(%rax)
	vmovdqu	%xmm10, -50(%rax)
	vextracti64x2	$0x1, %ymm13, -40(%rax)
	vextracti64x2	$0x1, %ymm9, -30(%rax)
	vextracti64x2	$0x1, %ymm3, -20(%rax)
	vextracti64x2	$0x1, %ymm10, -10(%rax)
	cmpq	%rdx, %rsi
	jnb	.L128
	vzeroupper
	leave
	.cfi_def_cfa 7, 8
	ret
.L132:
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE8934:
	.size	_Z12probe_formatPKjPcm, .-_Z12probe_formatPKjPcm
	.section	.text._ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,"axG",@progbits,_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,comdat
	.p2align 4
	.weak	_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.type	_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m, @function
_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m:
.LFB8944:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	.cfi_offset 15, -24
	movq	%rsi, %r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$64, %rsp
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdx, 24(%rsp)
	cmpq	$65600, %rdx
	jbe	.L162
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm3
	movq	%rdi, %r11
	vmovdqa	.LC5(%rip), %ymm7
	.p2align 4,,10
	.p2align 3
.L161:
	movl	$538976288, %eax
	vmovdqa	.LC43(%rip), %ymm15
	vpbroadcastd	%eax, %ymm5
	vpminsb	131072(%r11), %ymm5, %ymm10
	vpminsb	32768(%r11), %ymm5, %ymm0
	vpminsb	98304(%r11), %ymm5, %ymm8
	vpminsb	65536(%r11), %ymm5, %ymm2
	vpcmpeqb	131072(%r11), %ymm10, %ymm11
	vpcmpeqb	32768(%r11), %ymm0, %ymm1
	vpxor	%xmm10, %xmm10, %xmm10
	vpcmpeqb	98304(%r11), %ymm8, %ymm9
	vpcmpeqb	65536(%r11), %ymm2, %ymm6
	vpmovmskb	%ymm1, %edx
	vpmovmskb	%ymm11, %eax
	vpmovmskb	%ymm9, %r12d
	tzcntl	%edx, %ecx
	vpmovmskb	%ymm6, %esi
	tzcntl	%eax, %edx
	tzcntl	%r12d, %r13d
	movl	%ecx, %ebx
	movl	%edx, %ecx
	tzcntl	%esi, %edi
	movl	%r13d, %r14d
	leaq	131073(%r11,%rcx), %r13
	movl	%edi, %r8d
	movl	$808464432, %r12d
	leaq	98305(%r11,%r14), %rsi
	movq	%r13, 32(%rsp)
	leaq	32769(%r11,%rbx), %r9
	movq	%r11, %rcx
	movq	%rsi, 48(%rsp)
	leaq	65537(%r11,%r8), %r10
	xorl	%ebx, %ebx
	movq	%r9, %r8
	movq	%r9, 40(%rsp)
	movq	%r10, %rdi
	vpbroadcastd	%r12d, %ymm6
	movq	%r11, %r9
	.p2align 4,,10
	.p2align 3
.L141:
	movq	48(%rsp), %r11
	movq	%r13, %rax
	movq	40(%rsp), %rdx
	movq	%r10, %r14
	subq	%rsi, %rax
	subq	%rdi, %r11
	cmpq	%r11, %rax
	cmovg	%r11, %rax
	subq	%r8, %r14
	subq	%rcx, %rdx
	cmpq	%rdx, %r14
	cmovg	%rdx, %r14
	cmpq	%r14, %rax
	cmovg	%r14, %rax
	cmpq	$32, %rax
	jbe	.L329
	movabsq	$1117984489315730401, %r12
	movq	%rbx, %r11
	mulq	%r12
	movl	$100000000, %eax
	vpbroadcastd	%eax, %ymm8
	movq	%rdx, %r14
	andq	$-2, %rdx
	shrq	%r14
	leaq	(%rdx,%rbx), %rdx
	movq	%r14, 56(%rsp)
	.p2align 4,,10
	.p2align 3
.L140:
	vmovdqu	(%rcx), %ymm12
	vpminsb	%ymm5, %ymm12, %ymm13
	vpcmpeqb	%ymm13, %ymm12, %ymm14
	vmovdqu	(%r8), %ymm13
	vpmovmskb	%ymm14, %r12d
	vpminsb	%ymm5, %ymm13, %ymm14
	tzcntl	%r12d, %r14d
	blsr	%r12d, %eax
	tzcntl	%eax, %eax
	movl	%r14d, %r12d
	vinserti64x2	$0x1, 1(%rcx,%r12), %ymm12, %ymm0
	incl	%r12d
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm1
	vpsubusb	%ymm6, %ymm0, %ymm9
	vpcmpeqb	%ymm14, %ymm13, %ymm0
	movl	%eax, %r12d
	subl	%r14d, %r12d
	incl	%eax
	salq	$4, %r12
	addq	%rax, %rcx
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%r12), %ymm1, %ymm2
	vpmovmskb	%ymm0, %eax
	vmovdqu	(%rdi), %ymm0
	tzcntl	%eax, %r14d
	blsr	%eax, %r12d
	tzcntl	%r12d, %eax
	vpshufb	%ymm2, %ymm9, %ymm11
	movl	%r14d, %r12d
	vpmaddubsw	%ymm4, %ymm11, %ymm12
	vinserti64x2	$0x1, 1(%r8,%r12), %ymm13, %ymm11
	incl	%r12d
	salq	$4, %r12
	vpmaddwd	%ymm3, %ymm12, %ymm9
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm1
	movl	%eax, %r12d
	incl	%eax
	subl	%r14d, %r12d
	addq	%rax, %r8
	salq	$4, %r12
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%r12), %ymm1, %ymm12
	vpminsb	%ymm5, %ymm0, %ymm1
	vmovdqa	%ymm12, %ymm14
	vpternlogq	$254, %ymm10, %ymm2, %ymm14
	vpsubusb	%ymm6, %ymm11, %ymm10
	vpshufb	%ymm12, %ymm10, %ymm2
	vpcmpeqb	%ymm1, %ymm0, %ymm12
	vpmaddubsw	%ymm4, %ymm2, %ymm13
	vpmaddwd	%ymm3, %ymm13, %ymm11
	vpmovmskb	%ymm12, %eax
	vpackusdw	%ymm11, %ymm9, %ymm9
	tzcntl	%eax, %r14d
	blsr	%eax, %r12d
	tzcntl	%r12d, %eax
	vpmaddwd	%ymm7, %ymm9, %ymm11
	movl	%r14d, %r12d
	vinserti64x2	$0x1, 1(%rdi,%r12), %ymm0, %ymm10
	incl	%r12d
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm2
	movl	%eax, %r12d
	vpsubusb	%ymm6, %ymm10, %ymm0
	incl	%eax
	subl	%r14d, %r12d
	addq	%rax, %rdi
	salq	$4, %r12
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%r12), %ymm2, %ymm13
	vmovdqu	(%rsi), %ymm2
	vpshufb	%ymm13, %ymm0, %ymm1
	vpminsb	%ymm5, %ymm2, %ymm10
	vpmaddubsw	%ymm4, %ymm1, %ymm12
	vpcmpeqb	%ymm10, %ymm2, %ymm1
	vpmaddwd	%ymm3, %ymm12, %ymm0
	vpmovmskb	%ymm1, %eax
	tzcntl	%eax, %r14d
	blsr	%eax, %r12d
	tzcntl	%r12d, %eax
	movl	%r14d, %r12d
	vinserti64x2	$0x1, 1(%rsi,%r12), %ymm2, %ymm2
	incl	%r12d
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm12
	movl	%eax, %r12d
	subl	%r14d, %r12d
	incl	%eax
	salq	$4, %r12
	addq	%rax, %rsi
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%r12), %ymm12, %ymm12
	vmovdqa	%ymm12, %ymm10
	vpternlogq	$254, %ymm14, %ymm13, %ymm10
	vpsubusb	%ymm6, %ymm2, %ymm14
	vpshufb	%ymm12, %ymm14, %ymm13
	vpmaddubsw	%ymm4, %ymm13, %ymm1
	vpmaddwd	%ymm3, %ymm1, %ymm12
	vpackusdw	%ymm12, %ymm0, %ymm0
	vpmaddwd	%ymm7, %ymm0, %ymm2
	vshufps	$136, %ymm2, %ymm11, %ymm14
	vpmulld	%ymm8, %ymm14, %ymm13
	vshufps	$221, %ymm2, %ymm11, %ymm1
	vpaddd	%ymm1, %ymm13, %ymm12
	vxorps	%xmm9, %xmm9, %xmm9
	vpermd	%ymm12, %ymm15, %ymm9
	vextracti64x2	$1, %ymm9, %xmm0
	vextracti64x2	$0x1, %ymm9, %xmm2
	vmovq	%xmm9, (%r15,%r11,4)
	vmovhpd	%xmm9, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region(,%r11,4)
	vmovhpd	%xmm2, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262656(,%r11,4)
	vmovq	%xmm0, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131328(,%r11,4)
	addq	$2, %r11
	cmpq	%rdx, %r11
	jne	.L140
	movq	56(%rsp), %rdx
	leaq	(%rbx,%rdx,2), %rbx
	jmp	.L141
	.p2align 4,,10
	.p2align 3
.L329:
	movq	%r9, %r11
	movq	40(%rsp), %r9
	movq	%rbx, %r14
	cmpq	%r9, %rcx
	jnb	.L139
	movl	$538976288, %r13d
	movl	$808464432, %eax
	vmovdqa	.LC9(%rip), %xmm3
	vmovdqa	.LC10(%rip), %xmm4
	vmovdqa	.LC11(%rip), %xmm7
	vpbroadcastd	%r13d, %xmm5
	vpbroadcastd	%eax, %xmm15
	.p2align 4,,10
	.p2align 3
.L138:
	vmovdqu	(%rcx), %xmm6
	incq	%r14
	vpminsb	%xmm5, %xmm6, %xmm8
	vpsubusb	%xmm15, %xmm6, %xmm12
	vpcmpeqb	%xmm8, %xmm6, %xmm14
	vpmovmskb	%xmm14, %r12d
	tzcntl	%r12d, %r13d
	incl	%r13d
	movq	%r13, %rdx
	addq	%r13, %rcx
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm12, %xmm9
	vmovdqa	%xmm13, %xmm1
	vpmaddubsw	%xmm3, %xmm9, %xmm11
	vporq	%ymm1, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm11, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm0
	vpmaddwd	%xmm7, %xmm0, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %r12d
	shrq	$32, %rax
	addl	%r12d, %eax
	movl	%eax, -4(%r15,%r14,4)
	cmpq	%r9, %rcx
	jb	.L138
.L139:
	cmpq	$32831, %rbx
	movq	%rbx, %r12
	setbe	56(%rsp)
	cmpq	%r10, %r8
	jnb	.L142
	cmpb	$0, 56(%rsp)
	je	.L142
	movl	$538976288, %r13d
	movl	$808464432, %edx
	vmovdqa	.LC9(%rip), %xmm3
	vmovdqa	.LC10(%rip), %xmm4
	vmovdqa	.LC11(%rip), %xmm7
	vpbroadcastd	%r13d, %xmm5
	vpbroadcastd	%edx, %xmm15
	testb	$1, %bl
	je	.L143
	vmovdqu	(%r8), %xmm8
	vpminsb	%xmm5, %xmm8, %xmm14
	vpsubusb	%xmm15, %xmm8, %xmm9
	vpcmpeqb	%xmm14, %xmm8, %xmm13
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %r12d
	incl	%r12d
	movq	%r12, %r13
	addq	%r12, %r8
	leaq	1(%rbx), %r12
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r13), %xmm1
	vpshufb	%xmm1, %xmm9, %xmm11
	vmovdqa	%xmm1, %xmm12
	vpmaddubsw	%xmm3, %xmm11, %xmm2
	vporq	%ymm12, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm2, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm6
	vpmaddwd	%xmm7, %xmm6, %xmm8
	vmovq	%xmm8, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r10, %r8
	jb	.L308
	jmp	.L142
	.p2align 4,,10
	.p2align 3
.L143:
	vmovdqu	(%r8), %xmm14
	incq	%r12
	vpminsb	%xmm5, %xmm14, %xmm13
	vpsubusb	%xmm15, %xmm14, %xmm11
	vpcmpeqb	%xmm13, %xmm14, %xmm1
	vpmovmskb	%xmm1, %r13d
	tzcntl	%r13d, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm12
	vpshufb	%xmm12, %xmm11, %xmm2
	vmovdqa	%xmm12, %xmm9
	vpmaddubsw	%xmm3, %xmm2, %xmm0
	vporq	%ymm9, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm0, %xmm6
	vpackusdw	%xmm6, %xmm6, %xmm8
	vpmaddwd	%xmm7, %xmm8, %xmm14
	vmovq	%xmm14, %r13
	imull	$100000000, %r13d, %eax
	shrq	$32, %r13
	addl	%eax, %r13d
	movl	%r13d, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r10, %r8
	jnb	.L142
	vmovdqu	(%r8), %xmm13
	incq	%r12
	vpminsb	%xmm5, %xmm13, %xmm1
	vpsubusb	%xmm15, %xmm13, %xmm2
	vpcmpeqb	%xmm1, %xmm13, %xmm12
	vpmovmskb	%xmm12, %edx
	tzcntl	%edx, %r13d
	incl	%r13d
	movq	%r13, %rax
	addq	%r13, %r8
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm9
	vpshufb	%xmm9, %xmm2, %xmm0
	vmovdqa	%xmm9, %xmm11
	vpmaddubsw	%xmm3, %xmm0, %xmm6
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm6, %xmm8
	vpackusdw	%xmm8, %xmm8, %xmm14
	vpmaddwd	%xmm7, %xmm14, %xmm13
	vmovq	%xmm13, %r13
	imull	$100000000, %r13d, %edx
	shrq	$32, %r13
	addl	%edx, %r13d
	movl	%r13d, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r10, %r8
	jnb	.L142
.L308:
	cmpq	$32832, %r12
	jne	.L143
.L142:
	movq	48(%rsp), %rdx
	movq	%rbx, %r13
	cmpq	%rdx, %rdi
	jnb	.L145
	cmpb	$0, 56(%rsp)
	je	.L145
	movl	$538976288, %eax
	vmovdqa	.LC9(%rip), %xmm1
	vmovdqa	.LC10(%rip), %xmm2
	vpbroadcastd	%eax, %xmm8
	movl	$808464432, %eax
	vmovdqa	.LC11(%rip), %xmm5
	vpbroadcastd	%eax, %xmm9
	testb	$1, %bl
	jne	.L309
	movq	%r12, 40(%rsp)
	movq	%rdx, %r12
	jmp	.L146
	.p2align 4,,10
	.p2align 3
.L330:
	vmovdqu	(%rdi), %xmm7
	incq	%r13
	vpminsb	%xmm8, %xmm7, %xmm15
	vpsubusb	%xmm9, %xmm7, %xmm0
	vpcmpeqb	%xmm15, %xmm7, %xmm12
	vpmovmskb	%xmm12, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm6
	vpshufb	%xmm6, %xmm0, %xmm14
	vmovdqa	%xmm6, %xmm11
	vpmaddubsw	%xmm1, %xmm14, %xmm13
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm13, %xmm3
	vpackusdw	%xmm3, %xmm3, %xmm4
	vpmaddwd	%xmm5, %xmm4, %xmm7
	vmovq	%xmm7, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	%r12, %rdi
	jnb	.L317
	cmpq	$32832, %r13
	je	.L317
.L146:
	vmovdqu	(%rdi), %xmm4
	incq	%r13
	vpminsb	%xmm8, %xmm4, %xmm7
	vpsubusb	%xmm9, %xmm4, %xmm0
	vpcmpeqb	%xmm7, %xmm4, %xmm15
	vpmovmskb	%xmm15, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm12
	vpshufb	%xmm12, %xmm0, %xmm6
	vmovdqa	%xmm12, %xmm11
	vpmaddubsw	%xmm1, %xmm6, %xmm14
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm14, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm3
	vpmaddwd	%xmm5, %xmm3, %xmm4
	vmovq	%xmm4, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	%r12, %rdi
	jb	.L330
.L317:
	movq	40(%rsp), %r12
.L145:
	movq	32(%rsp), %rdx
	cmpq	%rdx, %rsi
	jnb	.L148
	cmpb	$0, 56(%rsp)
	je	.L148
	movl	$538976288, %eax
	vmovdqa	.LC9(%rip), %xmm1
	vmovdqa	.LC10(%rip), %xmm2
	vpbroadcastd	%eax, %xmm8
	movl	$808464432, %eax
	vmovdqa	.LC11(%rip), %xmm5
	vpbroadcastd	%eax, %xmm9
	testb	$1, %bl
	jne	.L311
	movq	%r12, 56(%rsp)
	movq	%rdx, %r12
	jmp	.L149
	.p2align 4,,10
	.p2align 3
.L331:
	vmovdqu	(%rsi), %xmm14
	incq	%rbx
	vpminsb	%xmm8, %xmm14, %xmm6
	vpsubusb	%xmm9, %xmm14, %xmm0
	vpcmpeqb	%xmm6, %xmm14, %xmm13
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm3
	vpshufb	%xmm3, %xmm0, %xmm4
	vmovdqa	%xmm3, %xmm11
	vpmaddubsw	%xmm1, %xmm4, %xmm7
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm7, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm12
	vpmaddwd	%xmm5, %xmm12, %xmm14
	vmovq	%xmm14, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	%r12, %rsi
	jnb	.L318
	cmpq	$32832, %rbx
	je	.L318
.L149:
	vmovdqu	(%rsi), %xmm12
	incq	%rbx
	vpminsb	%xmm8, %xmm12, %xmm6
	vpsubusb	%xmm9, %xmm12, %xmm0
	vpcmpeqb	%xmm6, %xmm12, %xmm14
	vpmovmskb	%xmm14, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm0, %xmm3
	vmovdqa	%xmm13, %xmm11
	vpmaddubsw	%xmm1, %xmm3, %xmm4
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm4, %xmm7
	vpackusdw	%xmm7, %xmm7, %xmm15
	vpmaddwd	%xmm5, %xmm15, %xmm12
	vmovq	%xmm12, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	%r12, %rsi
	jb	.L331
.L318:
	movq	56(%rsp), %r12
.L148:
	cmpq	%rcx, %r9
	vpmovmskb	%ymm10, %eax
	setne	%r9b
	cmpq	%r8, %r10
	setne	%cl
	orl	%ecx, %r9d
	cmpq	%rdi, 48(%rsp)
	setne	%dil
	andl	$-2147450880, %eax
	xorl	%r10d, %r10d
	orl	%edi, %r9d
	cmpq	%rsi, 32(%rsp)
	setne	%r10b
	movzbl	%r9b, %r8d
	orl	%r10d, %eax
	orl	%eax, %r8d
	jne	.L332
	vzeroupper
	leaq	(%r15,%r14,4), %rdi
	leaq	0(,%r12,4), %rdx
	movl	$_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, %esi
	addq	%r14, %r12
	call	memcpy
	leaq	(%r15,%r12,4), %rdi
	leaq	0(,%r13,4), %rdx
	movl	$_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131328, %esi
	call	memcpy
	addq	%r13, %r12
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262656, %esi
	leaq	(%r15,%r12,4), %rdi
	addq	%rbx, %r12
	call	memcpy
	subq	%r12, 24(%rsp)
	vmovdqa	.LC5(%rip), %ymm7
	leaq	(%r15,%r12,4), %r15
	vmovdqa	.LC4(%rip), %ymm3
	vmovdqa	.LC3(%rip), %ymm4
.L160:
	cmpq	$65600, 24(%rsp)
	jbe	.L327
.L153:
	movq	32(%rsp), %r11
	jmp	.L161
.L311:
	vmovdqu	(%rsi), %xmm15
	incq	%rbx
	vpminsb	%xmm8, %xmm15, %xmm12
	vpsubusb	%xmm9, %xmm15, %xmm0
	vpcmpeqb	%xmm12, %xmm15, %xmm6
	vpmovmskb	%xmm6, %edx
	tzcntl	%edx, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm0, %xmm13
	vmovdqa	%xmm14, %xmm11
	vpmaddubsw	%xmm1, %xmm13, %xmm3
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm3, %xmm4
	vpackusdw	%xmm4, %xmm4, %xmm7
	vpmaddwd	%xmm5, %xmm7, %xmm15
	vmovq	%xmm15, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	32(%rsp), %rsi
	jnb	.L148
	cmpq	$32832, %rbx
	je	.L148
	movq	%r12, 56(%rsp)
	movq	32(%rsp), %r12
	jmp	.L149
.L309:
	vmovdqu	(%rdi), %xmm3
	vpminsb	%xmm8, %xmm3, %xmm4
	vpsubusb	%xmm9, %xmm3, %xmm11
	vpcmpeqb	%xmm4, %xmm3, %xmm7
	vpmovmskb	%xmm7, %r13d
	tzcntl	%r13d, %eax
	leaq	1(%rbx), %r13
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm15
	vpshufb	%xmm15, %xmm11, %xmm0
	vmovdqa	%xmm15, %xmm12
	vpmaddubsw	%xmm1, %xmm0, %xmm6
	vporq	%ymm12, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm6, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm13
	vpmaddwd	%xmm5, %xmm13, %xmm3
	vmovq	%xmm3, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	48(%rsp), %rdi
	jnb	.L145
	cmpq	$32832, %r13
	je	.L145
	movq	%r12, 40(%rsp)
	movq	48(%rsp), %r12
	jmp	.L146
.L327:
	vzeroupper
.L136:
	movq	24(%rsp), %rdx
	movq	32(%rsp), %rdi
	leaq	-40(%rbp), %rsp
	movq	%r15, %rsi
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	_ZN13qp_parse_flat12parse_tokensEPcPjm
.L332:
	.cfi_restore_state
	cmpq	32(%rsp), %r11
	jnb	.L333
	movq	32(%rsp), %r13
	leaq	1(%r11), %r12
	leaq	-1(%r13), %rsi
	cmpq	%rsi, %r11
	cmovbe	%r11, %rsi
	xorl	%r14d, %r14d
	movq	%rsi, %rbx
	subq	%r11, %rbx
	andl	$7, %ebx
	cmpb	$32, (%r11)
	setg	%r14b
	movq	%r14, %rdx
	cmpq	%r12, %rsi
	jnb	.L334
.L313:
	movq	%rsi, %r12
	xorl	%r10d, %r10d
	movq	32(%rsp), %r13
	subq	%r11, %r12
	cmpq	%r11, %rsi
	cmovb	%r10, %r12
	leaq	1(%r11,%r12), %rsi
	cmpq	%r13, %rsi
	jnb	.L159
	movq	%rsi, %rbx
	notq	%rbx
	addq	%r13, %rbx
	andl	$7, %ebx
	cmpb	$32, (%rsi)
	jg	.L335
.L192:
	leaq	1(%rsi), %rax
	cmpq	32(%rsp), %rax
	jnb	.L159
	testq	%rbx, %rbx
	je	.L158
	cmpq	$1, %rbx
	je	.L263
	cmpq	$2, %rbx
	je	.L264
	cmpq	$3, %rbx
	je	.L265
	cmpq	$4, %rbx
	je	.L266
	cmpq	$5, %rbx
	je	.L267
	cmpq	$6, %rbx
	je	.L268
	cmpb	$32, 1(%rsi)
	jg	.L336
.L194:
	incq	%rax
.L268:
	cmpb	$32, (%rax)
	jle	.L197
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L197:
	incq	%rax
.L267:
	cmpb	$32, (%rax)
	jg	.L337
.L200:
	incq	%rax
.L266:
	cmpb	$32, (%rax)
	jg	.L338
.L203:
	incq	%rax
.L265:
	cmpb	$32, (%rax)
	jg	.L339
.L206:
	incq	%rax
.L264:
	cmpb	$32, (%rax)
	jle	.L209
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
.L209:
	incq	%rax
.L263:
	cmpb	$32, (%rax)
	jle	.L212
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L212:
	incq	%rax
	cmpq	32(%rsp), %rax
	jnb	.L159
.L158:
	cmpb	$32, (%rax)
	jle	.L157
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
.L157:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %rbx
	jle	.L215
	xorl	%eax, %eax
	cmpb	$32, -1(%rbx)
	setle	%al
	addq	%rax, %rdx
.L215:
	cmpb	$32, 1(%rbx)
	jle	.L217
	xorl	%r14d, %r14d
	cmpb	$32, (%rbx)
	setle	%r14b
	addq	%r14, %rdx
.L217:
	cmpb	$32, 2(%rbx)
	jle	.L219
	xorl	%r9d, %r9d
	cmpb	$32, 1(%rbx)
	setle	%r9b
	addq	%r9, %rdx
.L219:
	cmpb	$32, 3(%rbx)
	jle	.L221
	xorl	%ecx, %ecx
	cmpb	$32, 2(%rbx)
	setle	%cl
	addq	%rcx, %rdx
.L221:
	cmpb	$32, 4(%rbx)
	jle	.L223
	xorl	%edi, %edi
	cmpb	$32, 3(%rbx)
	setle	%dil
	addq	%rdi, %rdx
.L223:
	cmpb	$32, 5(%rbx)
	jle	.L225
	xorl	%r8d, %r8d
	cmpb	$32, 4(%rbx)
	setle	%r8b
	addq	%r8, %rdx
.L225:
	cmpb	$32, 6(%rbx)
	jle	.L227
	xorl	%r12d, %r12d
	cmpb	$32, 5(%rbx)
	setle	%r12b
	addq	%r12, %rdx
.L227:
	leaq	7(%rbx), %rax
	cmpq	32(%rsp), %rax
	jb	.L158
.L159:
	subq	%rdx, 24(%rsp)
	movq	%r15, %rsi
	leaq	(%r15,%rdx,4), %r15
	movq	%r11, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm3
	vmovdqa	.LC5(%rip), %ymm7
	jmp	.L160
.L335:
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rsi)
	setle	%r14b
	addq	%r14, %rdx
	jmp	.L192
.L334:
	testq	%rbx, %rbx
	je	.L155
	cmpq	$1, %rbx
	je	.L269
	cmpq	$2, %rbx
	je	.L270
	cmpq	$3, %rbx
	je	.L271
	cmpq	$4, %rbx
	je	.L272
	cmpq	$5, %rbx
	je	.L273
	cmpq	$6, %rbx
	jne	.L340
.L274:
	xorl	%eax, %eax
	cmpb	$32, (%r12)
	setg	%al
	incq	%r12
	addq	%rax, %rdx
.L273:
	xorl	%r9d, %r9d
	cmpb	$32, (%r12)
	setg	%r9b
	incq	%r12
	addq	%r9, %rdx
.L272:
	xorl	%ecx, %ecx
	cmpb	$32, (%r12)
	setg	%cl
	incq	%r12
	addq	%rcx, %rdx
.L271:
	xorl	%edi, %edi
	cmpb	$32, (%r12)
	setg	%dil
	incq	%r12
	addq	%rdi, %rdx
.L270:
	xorl	%r8d, %r8d
	cmpb	$32, (%r12)
	setg	%r8b
	incq	%r12
	addq	%r8, %rdx
.L269:
	xorl	%r10d, %r10d
	cmpb	$32, (%r12)
	setg	%r10b
	incq	%r12
	addq	%r10, %rdx
	cmpq	%r12, %rsi
	jb	.L313
.L155:
	xorl	%r13d, %r13d
	cmpb	$32, (%r12)
	setg	%r13b
	xorl	%ebx, %ebx
	addq	%r13, %rdx
	cmpb	$32, 1(%r12)
	setg	%bl
	xorl	%r14d, %r14d
	addq	%rbx, %rdx
	cmpb	$32, 2(%r12)
	setg	%r14b
	xorl	%eax, %eax
	addq	%r14, %rdx
	cmpb	$32, 3(%r12)
	setg	%al
	xorl	%r9d, %r9d
	addq	%rax, %rdx
	cmpb	$32, 4(%r12)
	setg	%r9b
	xorl	%ecx, %ecx
	addq	%r9, %rdx
	cmpb	$32, 5(%r12)
	setg	%cl
	xorl	%edi, %edi
	addq	%rcx, %rdx
	cmpb	$32, 6(%r12)
	setg	%dil
	xorl	%r8d, %r8d
	addq	%rdi, %rdx
	cmpb	$32, 7(%r12)
	setg	%r8b
	addq	$8, %r12
	addq	%r8, %rdx
	cmpq	%r12, %rsi
	jb	.L313
	jmp	.L155
	.p2align 4,,10
	.p2align 3
.L339:
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
	jmp	.L206
.L338:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L203
.L337:
	xorl	%edi, %edi
	cmpb	$32, -1(%rax)
	setle	%dil
	addq	%rdi, %rdx
	jmp	.L200
.L162:
	movq	%rdi, 32(%rsp)
	jmp	.L136
.L333:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r11, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm3
	vmovdqa	.LC5(%rip), %ymm7
	jmp	.L153
.L336:
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
	jmp	.L194
.L340:
	xorl	%edx, %edx
	cmpb	$32, 1(%r11)
	setg	%dl
	incq	%r12
	addq	%r14, %rdx
	jmp	.L274
	.cfi_endproc
.LFE8944:
	.size	_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m, .-_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.text
	.p2align 4
	.globl	_Z11probe_parsePcPjm
	.type	_Z11probe_parsePcPjm, @function
_Z11probe_parsePcPjm:
.LFB8933:
	.cfi_startproc
	jmp	_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.cfi_endproc
.LFE8933:
	.size	_Z11probe_parsePcPjm, .-_Z11probe_parsePcPjm
	.weak	_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region
	.section	.bss._ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region,"awG",@nobits,_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region,comdat
	.align 64
	.type	_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, @gnu_unique_object
	.size	_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, 393984
_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region:
	.zero	393984
	.weak	_ZN12qp_parse_ms211right_alignE
	.section	.rodata._ZN12qp_parse_ms211right_alignE,"aG",@progbits,_ZN12qp_parse_ms211right_alignE,comdat
	.align 32
	.type	_ZN12qp_parse_ms211right_alignE, @gnu_unique_object
	.size	_ZN12qp_parse_ms211right_alignE, 544
_ZN12qp_parse_ms211right_alignE:
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.weak	_ZN13qp_parse_flat11right_alignE
	.section	.rodata._ZN13qp_parse_flat11right_alignE,"aG",@progbits,_ZN13qp_parse_flat11right_alignE,comdat
	.align 32
	.type	_ZN13qp_parse_flat11right_alignE, @gnu_unique_object
	.size	_ZN13qp_parse_flat11right_alignE, 272
_ZN13qp_parse_flat11right_alignE:
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	-128
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	-128
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC1:
	.long	0
	.long	2
	.long	4
	.long	6
	.long	8
	.long	10
	.long	12
	.long	14
	.align 32
.LC3:
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.byte	10
	.byte	1
	.align 32
.LC4:
	.value	100
	.value	1
	.value	100
	.value	1
	.value	100
	.value	1
	.value	100
	.value	1
	.value	100
	.value	1
	.value	100
	.value	1
	.value	100
	.value	1
	.value	100
	.value	1
	.align 32
.LC5:
	.value	10000
	.value	1
	.value	10000
	.value	1
	.value	10000
	.value	1
	.value	10000
	.value	1
	.value	10000
	.value	1
	.value	10000
	.value	1
	.value	10000
	.value	1
	.value	10000
	.value	1
	.align 32
.LC7:
	.long	0
	.long	4
	.long	2
	.long	6
	.long	0
	.long	4
	.long	2
	.long	6
	.set	.LC9,.LC3
	.set	.LC10,.LC4
	.set	.LC11,.LC5
	.align 32
.LC15:
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.align 32
.LC16:
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.align 32
.LC33:
	.byte	0
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	3
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	0
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	3
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.align 32
.LC34:
	.byte	-128
	.byte	3
	.byte	2
	.byte	1
	.byte	0
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	3
	.byte	2
	.byte	1
	.byte	0
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.align 32
.LC35:
	.byte	4
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	7
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	4
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	7
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.align 32
.LC36:
	.byte	-128
	.byte	11
	.byte	10
	.byte	9
	.byte	8
	.byte	15
	.byte	14
	.byte	13
	.byte	12
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	11
	.byte	10
	.byte	9
	.byte	8
	.byte	15
	.byte	14
	.byte	13
	.byte	12
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.align 32
.LC37:
	.byte	8
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	11
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	8
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	11
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.align 32
.LC38:
	.byte	12
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	15
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	12
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	15
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.align 32
.LC43:
	.long	0
	.long	4
	.long	1
	.long	5
	.long	2
	.long	6
	.long	3
	.long	7
	.ident	"GCC: (GNU) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
