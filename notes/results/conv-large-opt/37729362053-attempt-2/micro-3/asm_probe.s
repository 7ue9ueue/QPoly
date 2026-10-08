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
	.type	_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_.isra.0, @function
_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_.isra.0:
.LFB8990:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdx, %r9
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-64, %rsp
	subq	$320, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rsi, 112(%rsp)
	cmpq	$133312, %rdx
	jbe	.L154
	vmovdqa	.LC3(%rip), %ymm6
	vmovdqa	.LC4(%rip), %ymm5
	vmovdqa	.LC5(%rip), %ymm10
	.p2align 4,,10
	.p2align 3
.L153:
	movl	$538976288, %eax
	movq	$0, 96(%rsp)
	vpbroadcastd	%eax, %ymm8
	movq	%rdi, 16(%rsp)
	vpminsb	266496(%rdi), %ymm8, %ymm9
	vpminsb	66624(%rdi), %ymm8, %ymm0
	movq	%r9, 8(%rsp)
	vpminsb	133248(%rdi), %ymm8, %ymm2
	vpminsb	199872(%rdi), %ymm8, %ymm4
	vpcmpeqb	266496(%rdi), %ymm9, %ymm11
	vpcmpeqb	66624(%rdi), %ymm0, %ymm1
	vpcmpeqb	199872(%rdi), %ymm4, %ymm7
	vpcmpeqb	133248(%rdi), %ymm2, %ymm3
	vpmovmskb	%ymm1, %edx
	vpmovmskb	%ymm11, %eax
	vmovdqa	.LC15(%rip), %ymm11
	vpmovmskb	%ymm7, %r11d
	vpmovmskb	%ymm3, %esi
	vpxor	%xmm7, %xmm7, %xmm7
	tzcntl	%edx, %ecx
	tzcntl	%r11d, %r12d
	tzcntl	%esi, %r8d
	tzcntl	%eax, %edx
	movl	%ecx, %ebx
	movl	%r12d, %r15d
	movl	%r8d, %r10d
	movl	%edx, %ecx
	movl	$808464432, %esi
	leaq	66625(%rdi,%rbx), %r14
	leaq	199873(%rdi,%r15), %r12
	vpbroadcastd	%esi, %ymm9
	movq	%rdi, %r15
	leaq	133249(%rdi,%r10), %r13
	leaq	266497(%rdi,%rcx), %rbx
	movq	%r14, 40(%rsp)
	movq	%r13, 32(%rsp)
	leaq	128(%rsp), %r11
	movq	%r12, 24(%rsp)
	movq	%rbx, 48(%rsp)
	.p2align 4,,10
	.p2align 3
.L133:
	movq	32(%rsp), %rax
	movq	40(%rsp), %rdi
	movq	48(%rsp), %r9
	movq	24(%rsp), %r8
	subq	%r14, %rax
	subq	%r15, %rdi
	cmpq	%rdi, %rax
	cmovg	%rdi, %rax
	subq	%r12, %r9
	subq	%r13, %r8
	cmpq	%r8, %r9
	cmovg	%r8, %r9
	cmpq	%r9, %rax
	cmovg	%r9, %rax
	cmpq	$64, %rax
	jbe	.L321
	vpminsb	(%r15), %ymm8, %ymm12
	vpminsb	32(%r15), %ymm8, %ymm14
	movabsq	$1135184250689818561, %r10
	movq	%r15, 128(%rsp)
	mulq	%r10
	movq	%r14, 152(%rsp)
	vpcmpeqb	(%r15), %ymm12, %ymm13
	vpcmpeqb	32(%r15), %ymm14, %ymm15
	vpminsb	(%r14), %ymm8, %ymm12
	movq	%r13, 176(%rsp)
	vpminsb	32(%r14), %ymm8, %ymm14
	movq	%r12, 200(%rsp)
	shrq	$2, %rdx
	vpmovmskb	%ymm13, %ecx
	vpcmpeqb	(%r14), %ymm12, %ymm13
	movq	%rdx, 88(%rsp)
	vpmovmskb	%ymm15, %edx
	vpcmpeqb	32(%r14), %ymm14, %ymm15
	blsr	%ecx, %ebx
	salq	$32, %rdx
	blsr	%ebx, %eax
	tzcntl	%ebx, %r10d
	tzcntl	%eax, %edi
	blsr	%eax, %r9d
	movl	%r9d, %r8d
	tzcntl	%ecx, %esi
	vmovd	%edi, %xmm0
	movl	%edi, 76(%rsp)
	vpmovmskb	%ymm13, %ebx
	vpminsb	0(%r13), %ymm8, %ymm13
	vmovd	%esi, %xmm2
	orq	%rdx, %r8
	blsr	%ebx, %edi
	blsr	%edi, %eax
	tzcntl	%edi, %r9d
	vpmovmskb	%ymm15, %edi
	tzcntq	%r8, %rcx
	tzcntl	%ebx, %esi
	blsr	%eax, %edx
	salq	$32, %rdi
	movl	%edx, %ebx
	tzcntl	%eax, %r8d
	movl	%ecx, 72(%rsp)
	vpcmpeqb	0(%r13), %ymm13, %ymm14
	vpinsrd	$1, %ecx, %xmm0, %xmm3
	orq	%rdi, %rbx
	movl	%r8d, 84(%rsp)
	vpminsb	32(%r13), %ymm8, %ymm15
	vpinsrd	$1, %r10d, %xmm2, %xmm1
	vmovd	%r8d, %xmm0
	tzcntq	%rbx, %rax
	vpunpcklqdq	%xmm3, %xmm1, %xmm4
	movl	%eax, 80(%rsp)
	vmovd	%esi, %xmm3
	leal	1(%rax), %esi
	vmovdqu	%xmm4, 136(%rsp)
	vpinsrd	$1, %eax, %xmm0, %xmm4
	vpcmpeqb	32(%r13), %ymm15, %ymm0
	vpmovmskb	%ymm14, %r8d
	tzcntl	%r8d, %ebx
	vpminsb	(%r12), %ymm8, %ymm14
	blsr	%r8d, %edx
	tzcntl	%edx, %edi
	blsr	%edx, %eax
	tzcntl	%eax, %r8d
	vmovd	%ebx, %xmm22
	blsr	%eax, %edx
	movl	%edx, %eax
	vpinsrd	$1, %r9d, %xmm3, %xmm1
	movl	%edi, 120(%rsp)
	vpmovmskb	%ymm0, %ebx
	vpcmpeqb	(%r12), %ymm14, %ymm15
	vpminsb	32(%r12), %ymm8, %ymm0
	addq	%r14, %rsi
	salq	$32, %rbx
	vpunpcklqdq	%xmm4, %xmm1, %xmm12
	vmovd	%r8d, %xmm4
	movl	%r8d, 68(%rsp)
	orq	%rbx, %rax
	vmovdqa	%xmm12, 160(%rsp)
	vpinsrd	$1, %edi, %xmm22, %xmm1
	leal	1(%rcx), %ecx
	tzcntq	%rax, %rdx
	vpmovmskb	%ymm15, %ebx
	addq	%r15, %rcx
	vpinsrd	$1, %edx, %xmm4, %xmm12
	vpcmpeqb	32(%r12), %ymm0, %ymm4
	leal	1(%rdx), %edi
	movl	%edx, 64(%rsp)
	addq	%r13, %rdi
	blsr	%ebx, %eax
	tzcntl	%ebx, %edx
	blsr	%eax, %r8d
	blsr	%r8d, %ebx
	vpunpcklqdq	%xmm12, %xmm1, %xmm13
	vmovd	%edx, %xmm29
	tzcntl	%r8d, %edx
	movl	%ebx, %r8d
	vmovdqu	%xmm13, 184(%rsp)
	vpmovmskb	%ymm4, %ebx
	movl	%edx, 60(%rsp)
	tzcntl	%eax, %eax
	vmovd	%edx, %xmm12
	salq	$32, %rbx
	vpinsrd	$1, %eax, %xmm29, %xmm1
	orq	%rbx, %r8
	tzcntq	%r8, %r8
	movl	%r8d, 56(%rsp)
	movq	88(%rsp), %rdx
	vpinsrd	$1, %r8d, %xmm12, %xmm13
	incl	%r8d
	vpunpcklqdq	%xmm13, %xmm1, %xmm14
	addq	%r12, %r8
	decq	%rdx
	vmovdqa	%xmm14, 208(%rsp)
	movq	%rdx, 104(%rsp)
	je	.L322
	movq	$0, 120(%rsp)
	movl	$100000000, %r14d
	movq	96(%rsp), %r9
	vmovdqa	%ymm6, %ymm14
	vmovdqa	%ymm5, %ymm13
	vmovdqa64	%ymm10, %ymm28
	vmovdqa32	%ymm11, %ymm16
	vpbroadcastd	%r14d, %ymm12
	.p2align 4,,10
	.p2align 3
.L131:
	vpminsb	(%rcx), %ymm8, %ymm2
	vpminsb	32(%rcx), %ymm8, %ymm15
	movq	120(%rsp), %r15
	vpcmpeqb	(%rcx), %ymm2, %ymm3
	vpcmpeqb	32(%rcx), %ymm15, %ymm0
	movq	%r15, %r13
	xorq	$1, %r15
	leaq	(%r15,%r15,2), %rbx
	movq	%r15, 120(%rsp)
	vpmovmskb	%ymm3, %eax
	salq	$5, %rbx
	blsr	%eax, %r12d
	tzcntl	%eax, %edx
	blsr	%r12d, %r10d
	tzcntl	%r10d, %eax
	tzcntl	%r12d, %r14d
	blsr	%r10d, %r12d
	vmovd	%eax, %xmm4
	vpmovmskb	%ymm0, %eax
	movl	%r12d, %r10d
	movq	%rcx, 128(%rsp,%rbx)
	salq	$32, %rax
	vmovd	%edx, %xmm2
	movq	%r15, %rdx
	orq	%r10, %rax
	vpinsrd	$1, %r14d, %xmm2, %xmm3
	negq	%rdx
	tzcntq	%rax, %r12
	andl	$96, %edx
	vpinsrd	$1, %r12d, %xmm4, %xmm1
	incl	%r12d
	vpunpcklqdq	%xmm1, %xmm3, %xmm15
	addq	%r12, %rcx
	vmovdqu	%xmm15, 8(%r11,%rdx)
	vpminsb	(%rsi), %ymm8, %ymm0
	vpminsb	32(%rsi), %ymm8, %ymm1
	movq	%rsi, 152(%rsp,%rbx)
	vpcmpeqb	(%rsi), %ymm0, %ymm4
	vpcmpeqb	32(%rsi), %ymm1, %ymm2
	vpmovmskb	%ymm4, %r15d
	blsr	%r15d, %eax
	tzcntl	%r15d, %r14d
	blsr	%eax, %r10d
	tzcntl	%r10d, %r15d
	tzcntl	%eax, %r12d
	blsr	%r10d, %eax
	vmovd	%r15d, %xmm3
	vpmovmskb	%ymm2, %r15d
	vmovd	%r14d, %xmm0
	movl	%eax, %r10d
	salq	$32, %r15
	vpinsrd	$1, %r12d, %xmm0, %xmm4
	orq	%r15, %r10
	tzcntq	%r10, %rax
	vpinsrd	$1, %eax, %xmm3, %xmm15
	leal	1(%rax), %r14d
	vpunpcklqdq	%xmm15, %xmm4, %xmm1
	addq	%r14, %rsi
	vmovdqa	%xmm1, 32(%r11,%rdx)
	vpminsb	(%rdi), %ymm8, %ymm2
	vpminsb	32(%rdi), %ymm8, %ymm15
	movq	%rdi, 176(%rsp,%rbx)
	vpcmpeqb	(%rdi), %ymm2, %ymm3
	vpcmpeqb	32(%rdi), %ymm15, %ymm0
	vpmovmskb	%ymm3, %r15d
	blsr	%r15d, %r12d
	blsr	%r12d, %r10d
	tzcntl	%r10d, %eax
	tzcntl	%r15d, %r14d
	tzcntl	%r12d, %r15d
	blsr	%r10d, %r12d
	vmovd	%eax, %xmm4
	vpmovmskb	%ymm0, %eax
	vmovd	%r14d, %xmm2
	movl	%r12d, %r10d
	salq	$32, %rax
	vpinsrd	$1, %r15d, %xmm2, %xmm3
	orq	%rax, %r10
	tzcntq	%r10, %r12
	vpinsrd	$1, %r12d, %xmm4, %xmm1
	leal	1(%r12), %r14d
	vpunpcklqdq	%xmm1, %xmm3, %xmm15
	addq	%r14, %rdi
	vmovdqu	%xmm15, 56(%r11,%rdx)
	vpminsb	(%r8), %ymm8, %ymm0
	vpminsb	32(%r8), %ymm8, %ymm1
	movq	%r8, 200(%rsp,%rbx)
	vpcmpeqb	(%r8), %ymm0, %ymm4
	vpcmpeqb	32(%r8), %ymm1, %ymm2
	vpmovmskb	%ymm4, %r15d
	blsr	%r15d, %r12d
	tzcntl	%r15d, %eax
	blsr	%r12d, %r10d
	tzcntl	%r10d, %ebx
	blsr	%r10d, %r15d
	vpmovmskb	%ymm2, %r10d
	tzcntl	%r12d, %r14d
	salq	$32, %r10
	movl	%r15d, %r12d
	vmovd	%ebx, %xmm3
	orq	%r12, %r10
	vmovd	%eax, %xmm0
	tzcntq	%r10, %rbx
	vpinsrd	$1, %r14d, %xmm0, %xmm4
	vpinsrd	$1, %ebx, %xmm3, %xmm15
	leal	1(%rbx), %eax
	vpunpcklqdq	%xmm15, %xmm4, %xmm1
	addq	%rax, %r8
	vmovdqa	%xmm1, 80(%r11,%rdx)
	leaq	0(%r13,%r13,2), %rax
	salq	$5, %rax
	addq	%r11, %rax
	movq	(%rax), %r10
	movl	12(%rax), %r15d
	movl	16(%rax), %ebx
	movl	8(%rax), %r14d
	vmovdqu	1(%r10,%r15), %xmm15
	vmovdqu	(%r10), %xmm2
	movq	%r15, %r12
	movl	%ebx, %r15d
	movq	%r14, %r13
	vinserti64x2	$0x1, 1(%r10,%r14), %ymm2, %ymm3
	vinserti64x2	$0x1, 1(%r10,%r15), %ymm15, %ymm0
	leal	1(%r14), %r10d
	movl	%r12d, %r14d
	salq	$4, %r10
	subl	%r13d, %r14d
	movl	%ebx, %r13d
	movl	36(%rax), %r15d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm4
	salq	$4, %r14
	subl	%r12d, %r13d
	movl	20(%rax), %r12d
	salq	$4, %r13
	vpsubusb	%ymm9, %ymm3, %ymm2
	movq	24(%rax), %r10
	vpsubusb	%ymm9, %ymm0, %ymm0
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm4, %ymm20
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm1
	subl	%ebx, %r12d
	salq	$4, %r12
	movl	40(%rax), %ebx
	movl	32(%rax), %r14d
	vpshufb	%ymm20, %ymm2, %ymm3
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm1, %ymm24
	movq	%r15, %r12
	vpmaddubsw	%ymm6, %ymm3, %ymm15
	vmovdqu	(%r10), %xmm3
	movq	%r14, %r13
	vpmaddwd	%ymm5, %ymm15, %ymm1
	vmovdqu	1(%r10,%r15), %xmm15
	movl	%ebx, %r15d
	vpshufb	%ymm24, %ymm0, %ymm4
	vinserti64x2	$0x1, 1(%r10,%r14), %ymm3, %ymm18
	vpmaddubsw	%ymm6, %ymm4, %ymm2
	vinserti64x2	$0x1, 1(%r10,%r15), %ymm15, %ymm17
	leal	1(%r14), %r10d
	movl	%r12d, %r14d
	movl	60(%rax), %r15d
	salq	$4, %r10
	vpmaddwd	%ymm5, %ymm2, %ymm0
	vpsubusb	%ymm9, %ymm18, %ymm19
	subl	%r13d, %r14d
	movl	%ebx, %r13d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm4
	movq	48(%rax), %r10
	salq	$4, %r14
	subl	%r12d, %r13d
	movl	44(%rax), %r12d
	vpsubusb	%ymm9, %ymm17, %ymm26
	salq	$4, %r13
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm4, %ymm21
	vmovdqu	(%r10), %xmm3
	movl	56(%rax), %r14d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm2
	subl	%ebx, %r12d
	salq	$4, %r12
	movl	64(%rax), %ebx
	vpshufb	%ymm21, %ymm19, %ymm23
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm2, %ymm22
	vinserti64x2	$0x1, 1(%r10,%r14), %ymm3, %ymm15
	movq	%r15, %r12
	movq	%r14, %r13
	vmovdqu	1(%r10,%r15), %xmm4
	movl	%ebx, %r15d
	vpmaddubsw	%ymm6, %ymm23, %ymm25
	vpsubusb	%ymm9, %ymm15, %ymm15
	vpmaddwd	%ymm5, %ymm25, %ymm29
	vpshufb	%ymm22, %ymm26, %ymm27
	vinserti64x2	$0x1, 1(%r10,%r15), %ymm4, %ymm2
	leal	1(%r14), %r10d
	movl	%r12d, %r14d
	movl	84(%rax), %r15d
	subl	%r13d, %r14d
	movl	%ebx, %r13d
	salq	$4, %r10
	vpackusdw	%ymm29, %ymm1, %ymm1
	subl	%r12d, %r13d
	movl	68(%rax), %r12d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm3
	salq	$4, %r14
	salq	$4, %r13
	movq	72(%rax), %r10
	vpsubusb	%ymm9, %ymm2, %ymm2
	vpmaddubsw	%ymm6, %ymm27, %ymm30
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm4
	subl	%ebx, %r12d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm3, %ymm18
	vpmaddwd	%ymm5, %ymm30, %ymm31
	salq	$4, %r12
	movl	88(%rax), %ebx
	movl	80(%rax), %r14d
	vpackusdw	%ymm31, %ymm0, %ymm0
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm4, %ymm17
	vpshufb	%ymm18, %ymm15, %ymm3
	movq	%r15, %r12
	movl	92(%rax), %eax
	vpmaddubsw	%ymm6, %ymm3, %ymm4
	movq	%r14, %r13
	vpshufb	%ymm17, %ymm2, %ymm15
	vmovdqu	(%r10), %xmm2
	vpmaddwd	%ymm5, %ymm4, %ymm19
	subl	%ebx, %eax
	vpmaddubsw	%ymm6, %ymm15, %ymm3
	vmovdqu	1(%r10,%r15), %xmm15
	movl	%ebx, %r15d
	salq	$4, %rax
	vpmaddwd	%ymm5, %ymm3, %ymm4
	vinserti64x2	$0x1, 1(%r10,%r14), %ymm2, %ymm3
	vpternlogq	$254, %ymm17, %ymm24, %ymm20
	vinserti64x2	$0x1, 1(%r10,%r15), %ymm15, %ymm2
	leal	1(%r14), %r10d
	movl	%r12d, %r14d
	subl	%r13d, %r14d
	salq	$4, %r10
	movl	%ebx, %r13d
	vpsubusb	%ymm9, %ymm3, %ymm3
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm15
	subl	%r12d, %r13d
	salq	$4, %r14
	vpsubusb	%ymm9, %ymm2, %ymm2
	salq	$4, %r13
	movq	112(%rsp), %rbx
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm15, %ymm23
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm15, %ymm25
	vpshufb	%ymm23, %ymm3, %ymm15
	vpternlogq	$254, %ymm7, %ymm23, %ymm20
	vpmaddubsw	%ymm6, %ymm15, %ymm3
	vmovdqa64	%ymm21, %ymm7
	vpmaddwd	%ymm5, %ymm3, %ymm15
	vpternlogq	$254, %ymm18, %ymm22, %ymm7
	vpshufb	%ymm25, %ymm2, %ymm3
	vpackusdw	%ymm15, %ymm19, %ymm15
	vpmaddubsw	%ymm6, %ymm3, %ymm2
	vpternlogq	$254, %ymm20, %ymm25, %ymm7
	vpmaddwd	%ymm10, %ymm15, %ymm3
	vpmaddwd	%ymm10, %ymm1, %ymm20
	vshufps	$136, %ymm3, %ymm20, %ymm1
	vpmulld	%ymm12, %ymm1, %ymm15
	vpmaddwd	%ymm5, %ymm2, %ymm2
	vshufps	$221, %ymm3, %ymm20, %ymm24
	vpackusdw	%ymm2, %ymm4, %ymm4
	vpmaddwd	%ymm10, %ymm4, %ymm2
	vpaddd	%ymm24, %ymm15, %ymm3
	vpmaddwd	%ymm10, %ymm0, %ymm15
	vxorps	%xmm1, %xmm1, %xmm1
	vpermd	%ymm3, %ymm11, %ymm1
	vshufps	$136, %ymm2, %ymm15, %ymm3
	vpmulld	%ymm12, %ymm3, %ymm4
	vshufps	$221, %ymm2, %ymm15, %ymm0
	vpaddd	%ymm0, %ymm4, %ymm15
	vxorps	%xmm3, %xmm3, %xmm3
	vpermd	%ymm15, %ymm11, %ymm3
	vpunpcklqdq	%ymm3, %ymm1, %ymm2
	vpunpckhqdq	%ymm3, %ymm1, %ymm4
	vmovdqu	%xmm2, (%rbx,%r9,4)
	vextracti64x2	$0x1, %ymm2, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266752(,%r9,4)
	vextracti64x2	$0x1, %ymm4, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533504(,%r9,4)
	vmovdqa	%xmm4, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region(,%r9,4)
	addq	$4, %r9
	decq	104(%rsp)
	jne	.L131
	movq	96(%rsp), %r9
	movq	88(%rsp), %r12
	leaq	(%r11,%rdx), %r14
	movl	44(%r14), %r13d
	movl	16(%r14), %eax
	leaq	-4(%r9,%r12,4), %r15
	movl	64(%r14), %r12d
	movl	60(%r14), %edx
	movl	40(%r14), %r10d
	movl	20(%r14), %ebx
	movq	%r15, 96(%rsp)
	movl	68(%r14), %r15d
	vmovd	56(%r14), %xmm22
	movl	%r13d, 80(%rsp)
	movq	24(%r14), %r13
	movl	36(%r14), %r9d
	movl	%eax, 76(%rsp)
	movq	48(%r14), %rax
	vmovd	32(%r14), %xmm3
	movl	%r12d, 68(%rsp)
	movl	88(%r14), %r12d
	vmovd	8(%r14), %xmm2
	movl	%edx, 120(%rsp)
	vmovd	80(%r14), %xmm29
	movq	(%r14), %rdx
	movl	%r10d, 84(%rsp)
	movl	%ebx, 72(%rsp)
	movl	12(%r14), %r10d
	movl	%r15d, 64(%rsp)
	movq	72(%r14), %rbx
	movq	%rcx, %r15
	movq	%r13, 104(%rsp)
	movq	%rdi, %r13
	movq	%rax, 88(%rsp)
	movl	84(%r14), %eax
	movl	%r12d, 60(%rsp)
	movl	92(%r14), %r14d
	movq	%r8, %r12
	movl	%r14d, 56(%rsp)
	movq	%rsi, %r14
.L132:
	vmovdqu	(%rdx), %xmm12
	vmovd	%xmm2, %ecx
	movl	%r10d, %esi
	movl	76(%rsp), %r8d
	vmovdqu	1(%rdx,%rsi), %xmm0
	movq	104(%rsp), %rdi
	vinserti64x2	$0x1, 1(%rdx,%rcx), %ymm12, %ymm15
	incl	%ecx
	movl	%r8d, %esi
	salq	$4, %rcx
	vinserti64x2	$0x1, 1(%rdx,%r8), %ymm0, %ymm4
	movl	%r10d, %edx
	subl	%r10d, %esi
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm1
	vmovd	%xmm2, %ecx
	movl	72(%rsp), %r10d
	salq	$4, %rsi
	subl	%ecx, %edx
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rsi), %xmm2
	vpsubusb	%ymm9, %ymm15, %ymm12
	vpsubusb	%ymm9, %ymm4, %ymm4
	salq	$4, %rdx
	subl	%r8d, %r10d
	movl	84(%rsp), %ecx
	vmovd	%xmm3, %r8d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rdx), %ymm1, %ymm27
	salq	$4, %r10
	movl	%r9d, %edx
	vmovd	%xmm3, %esi
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm2, %ymm30
	movq	88(%rsp), %r10
	vpshufb	%ymm27, %ymm12, %ymm15
	vpmaddubsw	%ymm14, %ymm15, %ymm0
	vmovdqu	(%rdi), %xmm15
	vpshufb	%ymm30, %ymm4, %ymm2
	vmovdqu	1(%rdi,%rdx), %xmm4
	vpmaddubsw	%ymm14, %ymm2, %ymm12
	vpmaddwd	%ymm13, %ymm0, %ymm1
	vmovd	%xmm29, %edx
	vinserti64x2	$0x1, 1(%rdi,%r8), %ymm15, %ymm26
	incl	%r8d
	vpmaddwd	%ymm13, %ymm12, %ymm0
	salq	$4, %r8
	vinserti64x2	$0x1, 1(%rdi,%rcx), %ymm4, %ymm12
	movl	%ecx, %edi
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r8), %xmm2
	subl	%r9d, %edi
	movl	%r9d, %r8d
	movl	80(%rsp), %r9d
	subl	%esi, %r8d
	salq	$4, %rdi
	vpsubusb	%ymm9, %ymm12, %ymm15
	movl	68(%rsp), %esi
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rdi), %xmm3
	salq	$4, %r8
	subl	%ecx, %r9d
	vmovd	%xmm22, %ecx
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r8), %ymm2, %ymm31
	salq	$4, %r9
	vmovdqu	(%r10), %xmm2
	vpsubusb	%ymm9, %ymm26, %ymm18
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r9), %ymm3, %ymm21
	movl	120(%rsp), %r8d
	vinserti64x2	$0x1, 1(%r10,%rcx), %ymm2, %ymm3
	incl	%ecx
	vpshufb	%ymm31, %ymm18, %ymm17
	vpshufb	%ymm21, %ymm15, %ymm4
	salq	$4, %rcx
	vmovdqu	1(%r10,%r8), %xmm15
	movl	%r8d, %r9d
	vpmaddubsw	%ymm14, %ymm4, %ymm12
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm4
	vmovd	%xmm22, %ecx
	vpsubusb	%ymm9, %ymm3, %ymm3
	vinserti64x2	$0x1, 1(%r10,%rsi), %ymm15, %ymm2
	subl	%ecx, %r9d
	vmovd	%xmm29, %ecx
	movl	%esi, %r10d
	salq	$4, %r9
	vpmaddubsw	%ymm14, %ymm17, %ymm19
	vpmaddwd	%ymm13, %ymm12, %ymm12
	subl	%r8d, %r10d
	movl	64(%rsp), %r8d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r9), %ymm4, %ymm20
	salq	$4, %r10
	vpsubusb	%ymm9, %ymm2, %ymm2
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm15
	vpmaddwd	%ymm13, %ymm19, %ymm23
	vpackusdw	%ymm12, %ymm0, %ymm0
	subl	%esi, %r8d
	vpshufb	%ymm20, %ymm3, %ymm4
	vpmaddwd	%ymm28, %ymm0, %ymm12
	movl	%eax, %esi
	salq	$4, %r8
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r8), %ymm15, %ymm25
	vpmaddubsw	%ymm14, %ymm4, %ymm15
	movl	60(%rsp), %r9d
	movl	$100000000, %r8d
	vpmaddwd	%ymm13, %ymm15, %ymm22
	vmovdqu	(%rbx), %xmm15
	vpshufb	%ymm25, %ymm2, %ymm3
	vmovdqu	1(%rbx,%rsi), %xmm2
	movl	%r9d, %r10d
	movq	96(%rsp), %rsi
	vpmaddubsw	%ymm14, %ymm3, %ymm4
	vinserti64x2	$0x1, 1(%rbx,%rdx), %ymm15, %ymm3
	incl	%edx
	subl	%eax, %r10d
	vinserti64x2	$0x1, 1(%rbx,%r9), %ymm2, %ymm2
	salq	$4, %rdx
	movl	%eax, %ebx
	movl	56(%rsp), %eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rdx), %xmm15
	subl	%ecx, %ebx
	salq	$4, %r10
	vpsubusb	%ymm9, %ymm3, %ymm3
	salq	$4, %rbx
	subl	%r9d, %eax
	vpsubusb	%ymm9, %ymm2, %ymm2
	movq	112(%rsp), %rdx
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rbx), %ymm15, %ymm29
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm15
	salq	$4, %rax
	vpmaddwd	%ymm13, %ymm4, %ymm4
	vpternlogq	$254, %ymm25, %ymm30, %ymm27
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm15, %ymm24
	vpshufb	%ymm29, %ymm3, %ymm15
	vpternlogq	$254, %ymm7, %ymm29, %ymm27
	vpmaddubsw	%ymm14, %ymm15, %ymm3
	vmovdqa64	%ymm31, %ymm7
	vpmaddwd	%ymm13, %ymm3, %ymm15
	vpshufb	%ymm24, %ymm2, %ymm3
	vpternlogq	$254, %ymm20, %ymm21, %ymm7
	vpmaddubsw	%ymm14, %ymm3, %ymm14
	vpternlogq	$254, %ymm27, %ymm24, %ymm7
	vpmaddwd	%ymm13, %ymm14, %ymm2
	vpackusdw	%ymm23, %ymm1, %ymm13
	vpackusdw	%ymm15, %ymm22, %ymm1
	vpmaddwd	%ymm28, %ymm1, %ymm15
	vpmaddwd	%ymm28, %ymm13, %ymm13
	vpbroadcastd	%r8d, %ymm14
	vpackusdw	%ymm2, %ymm4, %ymm4
	vshufps	$136, %ymm15, %ymm13, %ymm3
	vpmulld	%ymm14, %ymm3, %ymm1
	vshufps	$221, %ymm15, %ymm13, %ymm13
	vpmaddwd	%ymm28, %ymm4, %ymm2
	vshufps	$136, %ymm2, %ymm12, %ymm3
	vpmulld	%ymm14, %ymm3, %ymm14
	vpaddd	%ymm13, %ymm1, %ymm15
	vshufps	$221, %ymm2, %ymm12, %ymm13
	vxorps	%xmm1, %xmm1, %xmm1
	vpermd	%ymm15, %ymm16, %ymm1
	vpaddd	%ymm13, %ymm14, %ymm15
	vxorps	%xmm0, %xmm0, %xmm0
	vpermd	%ymm15, %ymm16, %ymm0
	vpunpcklqdq	%ymm0, %ymm1, %ymm12
	vpunpckhqdq	%ymm0, %ymm1, %ymm4
	vmovdqu	%xmm12, (%rdx,%rsi,4)
	vextracti64x2	$0x1, %ymm12, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266752(,%rsi,4)
	vextracti64x2	$0x1, %ymm4, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533504(,%rsi,4)
	vmovdqa	%xmm4, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region(,%rsi,4)
	addq	$4, %rsi
	movq	%rsi, 96(%rsp)
	jmp	.L133
	.p2align 4,,10
	.p2align 3
.L321:
	movq	%r13, %r11
	movq	16(%rsp), %rdi
	movq	8(%rsp), %r9
	movq	96(%rsp), %r13
	cmpq	40(%rsp), %r15
	jnb	.L130
	movl	$538976288, %ebx
	movl	$808464432, %ecx
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm6
	vmovdqa	.LC11(%rip), %xmm10
	movq	40(%rsp), %r10
	vpbroadcastd	%ebx, %xmm11
	vpbroadcastd	%ecx, %xmm9
	movq	112(%rsp), %r8
	.p2align 4,,10
	.p2align 3
.L129:
	vmovdqu	(%r15), %xmm2
	incq	%r13
	vpminsb	%xmm11, %xmm2, %xmm8
	vpsubusb	%xmm9, %xmm2, %xmm15
	vpcmpeqb	%xmm8, %xmm2, %xmm3
	vpmovmskb	%xmm3, %eax
	tzcntl	%eax, %esi
	incl	%esi
	movq	%rsi, %rdx
	addq	%rsi, %r15
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm15, %xmm0
	vmovdqa	%xmm14, %xmm13
	vpmaddubsw	%xmm5, %xmm0, %xmm12
	vporq	%ymm13, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm12, %xmm4
	vpackusdw	%xmm4, %xmm4, %xmm1
	vpmaddwd	%xmm10, %xmm1, %xmm2
	vmovq	%xmm2, %rbx
	imull	$100000000, %ebx, %ecx
	shrq	$32, %rbx
	addl	%ecx, %ebx
	movl	%ebx, -4(%r8,%r13,4)
	cmpq	%r10, %r15
	jb	.L129
.L130:
	movq	96(%rsp), %r8
	movq	32(%rsp), %rcx
	cmpq	$66687, %r8
	setbe	%bl
	cmpq	%rcx, %r14
	jnb	.L157
	testb	%bl, %bl
	je	.L157
	movl	$538976288, %eax
	movl	$808464432, %esi
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm6
	vmovdqa	.LC11(%rip), %xmm10
	movq	%r8, %r10
	vpbroadcastd	%eax, %xmm8
	vpbroadcastd	%esi, %xmm9
	testb	$1, %r8b
	je	.L135
	vmovdqu	(%r14), %xmm3
	vpminsb	%xmm8, %xmm3, %xmm11
	vpsubusb	%xmm9, %xmm3, %xmm0
	vpcmpeqb	%xmm11, %xmm3, %xmm14
	vpmovmskb	%xmm14, %r10d
	tzcntl	%r10d, %ecx
	leaq	1(%r8), %r10
	incl	%ecx
	movq	%rcx, %rdx
	addq	%rcx, %r14
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm0, %xmm12
	vmovdqa	%xmm13, %xmm15
	vpmaddubsw	%xmm5, %xmm12, %xmm4
	vporq	%ymm15, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm4, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm2
	vpmaddwd	%xmm10, %xmm2, %xmm3
	vmovq	%xmm3, %rax
	imull	$100000000, %eax, %r8d
	shrq	$32, %rax
	addl	%eax, %r8d
	movl	%r8d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region-4(,%r10,4)
	cmpq	32(%rsp), %r14
	jnb	.L134
	movq	32(%rsp), %rcx
	cmpq	$66688, %r10
	jne	.L135
	jmp	.L134
	.p2align 4,,10
	.p2align 3
.L323:
	vmovdqu	(%r14), %xmm13
	incq	%r10
	vpminsb	%xmm8, %xmm13, %xmm11
	vpsubusb	%xmm9, %xmm13, %xmm4
	vpcmpeqb	%xmm11, %xmm13, %xmm15
	vpmovmskb	%xmm15, %edx
	tzcntl	%edx, %eax
	incl	%eax
	movq	%rax, %r8
	addq	%rax, %r14
	salq	$4, %r8
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r8), %xmm12
	vpshufb	%xmm12, %xmm4, %xmm1
	vmovdqa	%xmm12, %xmm0
	vpmaddubsw	%xmm5, %xmm1, %xmm2
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm2, %xmm3
	vpackusdw	%xmm3, %xmm3, %xmm14
	vpmaddwd	%xmm10, %xmm14, %xmm13
	vmovq	%xmm13, %rdx
	imull	$100000000, %edx, %esi
	shrq	$32, %rdx
	addl	%esi, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region-4(,%r10,4)
	cmpq	%rcx, %r14
	jnb	.L134
	cmpq	$66688, %r10
	je	.L134
.L135:
	vmovdqu	(%r14), %xmm14
	incq	%r10
	vpminsb	%xmm8, %xmm14, %xmm11
	vpsubusb	%xmm9, %xmm14, %xmm12
	vpcmpeqb	%xmm11, %xmm14, %xmm13
	vpmovmskb	%xmm13, %esi
	tzcntl	%esi, %edx
	incl	%edx
	movq	%rdx, %rax
	addq	%rdx, %r14
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm15
	vpshufb	%xmm15, %xmm12, %xmm4
	vmovdqa	%xmm15, %xmm0
	vpmaddubsw	%xmm5, %xmm4, %xmm1
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm1, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm3
	vpmaddwd	%xmm10, %xmm3, %xmm14
	vmovq	%xmm14, %r8
	imull	$100000000, %r8d, %esi
	shrq	$32, %r8
	addl	%esi, %r8d
	movl	%r8d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region-4(,%r10,4)
	cmpq	%rcx, %r14
	jb	.L323
.L134:
	movq	24(%rsp), %rdx
	cmpq	%rdx, %r11
	jnb	.L158
	testb	%bl, %bl
	je	.L158
	movq	96(%rsp), %rcx
	movl	$538976288, %eax
	movl	$808464432, %esi
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm6
	vmovdqa	.LC11(%rip), %xmm10
	vpbroadcastd	%eax, %xmm8
	vpbroadcastd	%esi, %xmm9
	movq	%rcx, %r8
	testb	$1, %cl
	je	.L138
	vmovdqu	(%r11), %xmm15
	vpminsb	%xmm8, %xmm15, %xmm11
	vpsubusb	%xmm9, %xmm15, %xmm1
	vpcmpeqb	%xmm11, %xmm15, %xmm12
	vpmovmskb	%xmm12, %r8d
	tzcntl	%r8d, %eax
	leaq	1(%rcx), %r8
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r11
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm4
	vpshufb	%xmm4, %xmm1, %xmm2
	vmovdqa	%xmm4, %xmm0
	vpmaddubsw	%xmm5, %xmm2, %xmm3
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm3, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm13
	vpmaddwd	%xmm10, %xmm13, %xmm15
	vmovq	%xmm15, %rsi
	imull	$100000000, %esi, %ecx
	shrq	$32, %rsi
	addl	%esi, %ecx
	movl	%ecx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266748(,%r8,4)
	cmpq	24(%rsp), %r11
	jnb	.L137
	movq	24(%rsp), %rdx
	cmpq	$66688, %r8
	jne	.L138
	jmp	.L137
	.p2align 4,,10
	.p2align 3
.L324:
	vmovdqu	(%r11), %xmm1
	incq	%r8
	vpminsb	%xmm8, %xmm1, %xmm11
	vpsubusb	%xmm9, %xmm1, %xmm3
	vpcmpeqb	%xmm11, %xmm1, %xmm4
	vpmovmskb	%xmm4, %esi
	tzcntl	%esi, %eax
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %r11
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm2
	vpshufb	%xmm2, %xmm3, %xmm14
	vmovdqa	%xmm2, %xmm0
	vpmaddubsw	%xmm5, %xmm14, %xmm13
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm13, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm12
	vpmaddwd	%xmm10, %xmm12, %xmm1
	vmovq	%xmm1, %rax
	imull	$100000000, %eax, %esi
	shrq	$32, %rax
	addl	%esi, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266748(,%r8,4)
	cmpq	%rdx, %r11
	jnb	.L137
	cmpq	$66688, %r8
	je	.L137
.L138:
	vmovdqu	(%r11), %xmm12
	incq	%r8
	vpminsb	%xmm8, %xmm12, %xmm11
	vpsubusb	%xmm9, %xmm12, %xmm2
	vpcmpeqb	%xmm11, %xmm12, %xmm4
	vpmovmskb	%xmm4, %eax
	tzcntl	%eax, %ecx
	incl	%ecx
	movq	%rcx, %rsi
	addq	%rcx, %r11
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm1
	vpshufb	%xmm1, %xmm2, %xmm3
	vmovdqa	%xmm1, %xmm0
	vpmaddubsw	%xmm5, %xmm3, %xmm14
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm14, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm15
	vpmaddwd	%xmm10, %xmm15, %xmm12
	vmovq	%xmm12, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%ecx, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266748(,%r8,4)
	cmpq	%rdx, %r11
	jb	.L324
.L137:
	movq	48(%rsp), %rdx
	cmpq	%rdx, %r12
	jnb	.L140
	testb	%bl, %bl
	je	.L140
	movq	96(%rsp), %rax
	movl	$538976288, %ebx
	movl	$808464432, %ecx
	vmovdqa	.LC9(%rip), %xmm5
	vpbroadcastd	%ebx, %xmm8
	vmovdqa	.LC10(%rip), %xmm6
	vmovdqa	.LC11(%rip), %xmm10
	vpbroadcastd	%ecx, %xmm9
	movq	%rdx, %rbx
	testb	$1, %al
	je	.L141
	vmovdqu	(%r12), %xmm2
	incq	96(%rsp)
	vpminsb	%xmm8, %xmm2, %xmm11
	vpsubusb	%xmm9, %xmm2, %xmm14
	vpcmpeqb	%xmm11, %xmm2, %xmm4
	vpmovmskb	%xmm4, %eax
	tzcntl	%eax, %esi
	incl	%esi
	movq	%rsi, %rdx
	addq	%rsi, %r12
	movq	96(%rsp), %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm3
	vpshufb	%xmm3, %xmm14, %xmm13
	vmovdqa	%xmm3, %xmm0
	vpmaddubsw	%xmm5, %xmm13, %xmm15
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm15, %xmm12
	vpackusdw	%xmm12, %xmm12, %xmm1
	vpmaddwd	%xmm10, %xmm1, %xmm2
	vmovq	%xmm2, %rbx
	imull	$100000000, %ebx, %ecx
	shrq	$32, %rbx
	addl	%ebx, %ecx
	movl	%ecx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533500(,%rsi,4)
	cmpq	48(%rsp), %r12
	jnb	.L140
	movq	48(%rsp), %rbx
	movq	%rsi, %rax
	cmpq	$66688, %rsi
	jne	.L141
	jmp	.L140
	.p2align 4,,10
	.p2align 3
.L325:
	vmovdqu	(%r12), %xmm14
	incq	%rax
	vpminsb	%xmm8, %xmm14, %xmm11
	vpsubusb	%xmm9, %xmm14, %xmm15
	vpcmpeqb	%xmm11, %xmm14, %xmm4
	vpmovmskb	%xmm4, %esi
	tzcntl	%esi, %edx
	incl	%edx
	movq	%rdx, %rcx
	addq	%rdx, %r12
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm13
	vpshufb	%xmm13, %xmm15, %xmm12
	vmovdqa	%xmm13, %xmm0
	vpmaddubsw	%xmm5, %xmm12, %xmm1
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm1, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm3
	vpmaddwd	%xmm10, %xmm3, %xmm14
	vmovq	%xmm14, %rdx
	imull	$100000000, %edx, %esi
	shrq	$32, %rdx
	addl	%esi, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533500(,%rax,4)
	cmpq	%rbx, %r12
	jnb	.L311
	cmpq	$66688, %rax
	je	.L311
.L141:
	vmovdqu	(%r12), %xmm3
	incq	%rax
	vpminsb	%xmm8, %xmm3, %xmm11
	vpsubusb	%xmm9, %xmm3, %xmm13
	vpcmpeqb	%xmm11, %xmm3, %xmm4
	vpmovmskb	%xmm4, %edx
	tzcntl	%edx, %ecx
	incl	%ecx
	movq	%rcx, %rsi
	addq	%rcx, %r12
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm14
	vpshufb	%xmm14, %xmm13, %xmm15
	vmovdqa	%xmm14, %xmm0
	vpmaddubsw	%xmm5, %xmm15, %xmm12
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm12, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm2
	vpmaddwd	%xmm10, %xmm2, %xmm3
	vmovq	%xmm3, %rdx
	imull	$100000000, %edx, %ecx
	shrq	$32, %rdx
	addl	%ecx, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533500(,%rax,4)
	cmpq	%rbx, %r12
	jb	.L325
.L311:
	movq	%rax, 96(%rsp)
.L140:
	cmpq	%r15, 40(%rsp)
	vpmovmskb	%ymm7, %eax
	setne	%r15b
	cmpq	%r14, 32(%rsp)
	setne	%r14b
	orl	%r14d, %r15d
	cmpq	%r11, 24(%rsp)
	setne	%r11b
	andl	$-2147450880, %eax
	xorl	%ecx, %ecx
	orl	%r11d, %r15d
	cmpq	%r12, 48(%rsp)
	setne	%cl
	movzbl	%r15b, %ebx
	orl	%ecx, %eax
	orl	%eax, %ebx
	jne	.L326
	movq	112(%rsp), %r12
	movq	%r8, 104(%rsp)
	leaq	0(,%r10,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region, %esi
	movq	%r9, 88(%rsp)
	movq	%r10, 120(%rsp)
	leaq	(%r12,%r13,4), %rdi
	vzeroupper
	call	memcpy
	movq	120(%rsp), %r9
	movq	104(%rsp), %r10
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266752, %esi
	leaq	0(%r13,%r9), %r13
	leaq	0(,%r10,4), %rdx
	movq	%r10, 120(%rsp)
	leaq	(%r12,%r13,4), %rdi
	call	memcpy
	movq	96(%rsp), %r15
	addq	120(%rsp), %r13
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533504, %esi
	leaq	(%r12,%r13,4), %rdi
	leaq	0(,%r15,4), %rdx
	addq	%r15, %r13
	call	memcpy
	leaq	(%r12,%r13,4), %rdi
	movq	88(%rsp), %r9
	vmovdqa	.LC5(%rip), %ymm10
	vmovdqa	.LC4(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm6
	movq	%rdi, 112(%rsp)
	subq	%r13, %r9
.L152:
	cmpq	$133312, %r9
	jbe	.L313
.L145:
	movq	48(%rsp), %rdi
	jmp	.L153
	.p2align 4,,10
	.p2align 3
.L322:
	movq	%r13, 88(%rsp)
	movq	%r12, %rbx
	movq	%r15, %rdx
	vmovdqa	.LC3(%rip), %ymm14
	movq	%r14, 104(%rsp)
	vmovdqa	.LC4(%rip), %ymm13
	movq	%r8, %r12
	movq	%rdi, %r13
	vmovdqa64	.LC5(%rip), %ymm28
	vmovdqa32	.LC15(%rip), %ymm16
	movq	%rsi, %r14
	movq	%rcx, %r15
	jmp	.L132
.L158:
	movq	96(%rsp), %r8
	jmp	.L137
.L157:
	movq	96(%rsp), %r10
	jmp	.L134
.L313:
	vzeroupper
.L127:
	movq	112(%rsp), %rsi
	movq	48(%rsp), %rdi
	leaq	-40(%rbp), %rsp
	movq	%r9, %rdx
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	_ZN13qp_parse_flat12parse_tokensEPcPjm
.L326:
	.cfi_restore_state
	cmpq	48(%rsp), %rdi
	jnb	.L327
	movq	48(%rsp), %r8
	leaq	1(%rdi), %r11
	leaq	-1(%r8), %rsi
	cmpq	%rsi, %rdi
	cmovbe	%rdi, %rsi
	xorl	%r14d, %r14d
	movq	%rsi, %rax
	subq	%rdi, %rax
	andl	$7, %eax
	cmpb	$32, (%rdi)
	setg	%r14b
	movq	%r14, %rdx
	cmpq	%r11, %rsi
	jnb	.L328
.L306:
	movq	%rsi, %r11
	xorl	%r15d, %r15d
	movq	48(%rsp), %r8
	subq	%rdi, %r11
	cmpq	%rdi, %rsi
	cmovb	%r15, %r11
	leaq	1(%rdi,%r11), %rsi
	cmpq	%r8, %rsi
	jnb	.L151
	movq	%rsi, %r14
	notq	%r14
	addq	%r8, %r14
	andl	$7, %r14d
	cmpb	$32, (%rsi)
	jg	.L329
.L185:
	leaq	1(%rsi), %rax
	cmpq	48(%rsp), %rax
	jnb	.L151
	testq	%r14, %r14
	je	.L150
	cmpq	$1, %r14
	je	.L256
	cmpq	$2, %r14
	je	.L257
	cmpq	$3, %r14
	je	.L258
	cmpq	$4, %r14
	je	.L259
	cmpq	$5, %r14
	je	.L260
	cmpq	$6, %r14
	je	.L261
	cmpb	$32, 1(%rsi)
	jg	.L330
.L187:
	incq	%rax
.L261:
	cmpb	$32, (%rax)
	jle	.L190
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L190:
	incq	%rax
.L260:
	cmpb	$32, (%rax)
	jg	.L331
.L193:
	incq	%rax
.L259:
	cmpb	$32, (%rax)
	jg	.L332
.L196:
	incq	%rax
.L258:
	cmpb	$32, (%rax)
	jg	.L333
.L199:
	incq	%rax
.L257:
	cmpb	$32, (%rax)
	jle	.L202
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rax)
	setle	%r11b
	addq	%r11, %rdx
.L202:
	incq	%rax
.L256:
	cmpb	$32, (%rax)
	jle	.L205
	xorl	%r15d, %r15d
	cmpb	$32, -1(%rax)
	setle	%r15b
	addq	%r15, %rdx
.L205:
	incq	%rax
	cmpq	48(%rsp), %rax
	jnb	.L151
.L150:
	cmpb	$32, (%rax)
	jle	.L149
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L149:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %r8
	jle	.L208
	xorl	%r14d, %r14d
	cmpb	$32, -1(%r8)
	setle	%r14b
	addq	%r14, %rdx
.L208:
	cmpb	$32, 1(%r8)
	jle	.L210
	xorl	%eax, %eax
	cmpb	$32, (%r8)
	setle	%al
	addq	%rax, %rdx
.L210:
	cmpb	$32, 2(%r8)
	jle	.L212
	xorl	%ebx, %ebx
	cmpb	$32, 1(%r8)
	setle	%bl
	addq	%rbx, %rdx
.L212:
	cmpb	$32, 3(%r8)
	jle	.L214
	xorl	%ecx, %ecx
	cmpb	$32, 2(%r8)
	setle	%cl
	addq	%rcx, %rdx
.L214:
	cmpb	$32, 4(%r8)
	jle	.L216
	xorl	%r12d, %r12d
	cmpb	$32, 3(%r8)
	setle	%r12b
	addq	%r12, %rdx
.L216:
	cmpb	$32, 5(%r8)
	jle	.L218
	xorl	%r13d, %r13d
	cmpb	$32, 4(%r8)
	setle	%r13b
	addq	%r13, %rdx
.L218:
	cmpb	$32, 6(%r8)
	jle	.L220
	xorl	%r10d, %r10d
	cmpb	$32, 5(%r8)
	setle	%r10b
	addq	%r10, %rdx
.L220:
	leaq	7(%r8), %rax
	cmpq	48(%rsp), %rax
	jb	.L150
.L151:
	subq	%rdx, %r9
	movq	112(%rsp), %rsi
	movq	%r9, 120(%rsp)
	leaq	(%rsi,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	movq	120(%rsp), %r9
	vmovdqa	.LC3(%rip), %ymm6
	movq	%r15, 112(%rsp)
	vmovdqa	.LC4(%rip), %ymm5
	vmovdqa	.LC5(%rip), %ymm10
	jmp	.L152
.L329:
	xorl	%eax, %eax
	cmpb	$32, -1(%rsi)
	setle	%al
	addq	%rax, %rdx
	jmp	.L185
.L328:
	testq	%rax, %rax
	je	.L147
	cmpq	$1, %rax
	je	.L262
	cmpq	$2, %rax
	je	.L263
	cmpq	$3, %rax
	je	.L264
	cmpq	$4, %rax
	je	.L265
	cmpq	$5, %rax
	je	.L266
	cmpq	$6, %rax
	jne	.L334
.L267:
	xorl	%ebx, %ebx
	cmpb	$32, (%r11)
	setg	%bl
	incq	%r11
	addq	%rbx, %rdx
.L266:
	xorl	%ecx, %ecx
	cmpb	$32, (%r11)
	setg	%cl
	incq	%r11
	addq	%rcx, %rdx
.L265:
	xorl	%r12d, %r12d
	cmpb	$32, (%r11)
	setg	%r12b
	incq	%r11
	addq	%r12, %rdx
.L264:
	xorl	%r13d, %r13d
	cmpb	$32, (%r11)
	setg	%r13b
	incq	%r11
	addq	%r13, %rdx
.L263:
	xorl	%r10d, %r10d
	cmpb	$32, (%r11)
	setg	%r10b
	incq	%r11
	addq	%r10, %rdx
.L262:
	xorl	%r15d, %r15d
	cmpb	$32, (%r11)
	setg	%r15b
	incq	%r11
	addq	%r15, %rdx
	cmpq	%r11, %rsi
	jb	.L306
.L147:
	xorl	%r8d, %r8d
	cmpb	$32, (%r11)
	setg	%r8b
	xorl	%eax, %eax
	addq	%r8, %rdx
	cmpb	$32, 1(%r11)
	setg	%al
	xorl	%r14d, %r14d
	addq	%rax, %rdx
	cmpb	$32, 2(%r11)
	setg	%r14b
	xorl	%ebx, %ebx
	addq	%r14, %rdx
	cmpb	$32, 3(%r11)
	setg	%bl
	xorl	%ecx, %ecx
	addq	%rbx, %rdx
	cmpb	$32, 4(%r11)
	setg	%cl
	xorl	%r12d, %r12d
	addq	%rcx, %rdx
	cmpb	$32, 5(%r11)
	setg	%r12b
	xorl	%r13d, %r13d
	addq	%r12, %rdx
	cmpb	$32, 6(%r11)
	setg	%r13b
	xorl	%r10d, %r10d
	addq	%r13, %rdx
	cmpb	$32, 7(%r11)
	setg	%r10b
	addq	$8, %r11
	addq	%r10, %rdx
	cmpq	%r11, %rsi
	jb	.L306
	jmp	.L147
	.p2align 4,,10
	.p2align 3
.L333:
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
	jmp	.L199
.L332:
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
	jmp	.L196
.L331:
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
	jmp	.L193
.L154:
	movq	%rdi, 48(%rsp)
	jmp	.L127
.L327:
	movq	%r9, 120(%rsp)
	movq	112(%rsp), %rsi
	xorl	%edx, %edx
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm6
	vmovdqa	.LC4(%rip), %ymm5
	vmovdqa	.LC5(%rip), %ymm10
	movq	120(%rsp), %r9
	jmp	.L145
.L330:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L187
.L334:
	xorl	%edx, %edx
	cmpb	$32, 1(%rdi)
	setg	%dl
	incq	%r11
	addq	%r14, %rdx
	jmp	.L267
	.cfi_endproc
.LFE8990:
	.size	_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_.isra.0, .-_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_.isra.0
	.p2align 4
	.type	_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_.isra.0, @function
_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_.isra.0:
.LFB8991:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$256, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rsi, 88(%rsp)
	movq	%rdx, 24(%rsp)
	cmpq	$133312, %rdx
	jbe	.L364
	vmovdqa	.LC3(%rip), %ymm6
	vmovdqa	.LC4(%rip), %ymm5
	vmovdqa	.LC5(%rip), %ymm10
.L363:
	movl	$538976288, %eax
	movq	%rdi, 16(%rsp)
	vpbroadcastd	%eax, %ymm8
	vpminsb	266496(%rdi), %ymm8, %ymm9
	vpminsb	66624(%rdi), %ymm8, %ymm0
	vpminsb	133248(%rdi), %ymm8, %ymm2
	vpminsb	199872(%rdi), %ymm8, %ymm4
	vpcmpeqb	266496(%rdi), %ymm9, %ymm11
	vpcmpeqb	66624(%rdi), %ymm0, %ymm1
	vpcmpeqb	199872(%rdi), %ymm4, %ymm7
	vpcmpeqb	133248(%rdi), %ymm2, %ymm3
	vpmovmskb	%ymm11, %r15d
	vpmovmskb	%ymm1, %edx
	vmovdqa	.LC15(%rip), %ymm11
	vpmovmskb	%ymm3, %esi
	vpmovmskb	%ymm7, %r10d
	tzcntl	%edx, %ecx
	tzcntl	%r15d, %eax
	tzcntl	%esi, %r8d
	tzcntl	%r10d, %r11d
	movl	%ecx, %ebx
	movl	%eax, %edx
	movl	%r8d, %r9d
	movl	%r11d, %r12d
	leaq	66625(%rdi,%rbx), %r14
	movl	$808464432, %esi
	leaq	199873(%rdi,%r12), %r13
	leaq	133249(%rdi,%r9), %r8
	movq	%r14, 40(%rsp)
	vpxor	%xmm7, %xmm7, %xmm7
	leaq	266497(%rdi,%rdx), %rcx
	movq	%r13, 48(%rsp)
	xorl	%ebx, %ebx
	vpbroadcastd	%esi, %ymm9
	movq	%rcx, 72(%rsp)
	movq	%rdi, %r15
	movq	%r13, 232(%rsp)
	movq	%r8, 32(%rsp)
	.p2align 4,,10
	.p2align 3
.L343:
	movq	32(%rsp), %rax
	movq	40(%rsp), %rdi
	movq	72(%rsp), %r9
	movq	48(%rsp), %r10
	subq	%r14, %rax
	subq	%r15, %rdi
	cmpq	%rdi, %rax
	cmovg	%rdi, %rax
	subq	232(%rsp), %r9
	subq	%r8, %r10
	cmpq	%r10, %r9
	cmovg	%r10, %r9
	cmpq	%r9, %rax
	cmovg	%r9, %rax
	cmpq	$64, %rax
	jbe	.L530
	vpminsb	(%r15), %ymm8, %ymm12
	vpminsb	32(%r15), %ymm8, %ymm14
	movabsq	$1135184250689818561, %r11
	vpminsb	(%r14), %ymm8, %ymm0
	vpminsb	(%r8), %ymm8, %ymm4
	vpcmpeqb	(%r15), %ymm12, %ymm13
	mulq	%r11
	vpminsb	32(%r14), %ymm8, %ymm2
	vpcmpeqb	32(%r15), %ymm14, %ymm15
	vpcmpeqb	(%r14), %ymm0, %ymm1
	vpcmpeqb	(%r8), %ymm4, %ymm12
	vpcmpeqb	32(%r14), %ymm2, %ymm3
	vpmovmskb	%ymm13, %r12d
	movq	%rdx, %r13
	vpminsb	32(%r8), %ymm8, %ymm13
	blsr	%r12d, %ecx
	vpmovmskb	%ymm15, %edx
	blsr	%ecx, %esi
	tzcntl	%ecx, %edi
	vpmovmskb	%ymm1, %ecx
	blsr	%esi, %r10d
	salq	$32, %rdx
	movl	%edi, 220(%rsp)
	movl	%r10d, %r11d
	tzcntl	%ecx, %edi
	tzcntl	%r12d, %eax
	orq	%rdx, %r11
	movl	%edi, 208(%rsp)
	vpmovmskb	%ymm12, %edi
	tzcntl	%esi, %r9d
	tzcntq	%r11, %r12
	blsr	%ecx, %esi
	movl	%eax, 224(%rsp)
	blsr	%esi, %eax
	blsr	%eax, %r11d
	movl	%r11d, %ecx
	tzcntl	%edi, %r11d
	vpmovmskb	%ymm3, %edx
	tzcntl	%eax, %r10d
	movl	%r11d, 192(%rsp)
	movq	232(%rsp), %r11
	salq	$32, %rdx
	vpcmpeqb	32(%r8), %ymm13, %ymm14
	orq	%rdx, %rcx
	movl	%r9d, 228(%rsp)
	tzcntl	%esi, %r9d
	shrq	$2, %r13
	vpminsb	(%r11), %ymm8, %ymm15
	tzcntq	%rcx, %rsi
	vpminsb	32(%r11), %ymm8, %ymm1
	movl	%r10d, 200(%rsp)
	blsr	%edi, %r10d
	blsr	%r10d, %eax
	tzcntl	%r10d, %ecx
	movl	%esi, 196(%rsp)
	vpmovmskb	%ymm14, %r10d
	incl	%esi
	vpcmpeqb	(%r11), %ymm15, %ymm0
	salq	$32, %r10
	movl	%r9d, 204(%rsp)
	leaq	(%r14,%rsi), %r9
	blsr	%eax, %esi
	movl	%esi, %edi
	vpcmpeqb	32(%r11), %ymm1, %ymm2
	tzcntl	%eax, %edx
	movl	%ecx, 188(%rsp)
	orq	%r10, %rdi
	movl	%r12d, 216(%rsp)
	incl	%r12d
	tzcntq	%rdi, %rax
	vpmovmskb	%ymm0, %ecx
	movl	%edx, 184(%rsp)
	leaq	(%r15,%r12), %r12
	movl	%eax, 212(%rsp)
	incl	%eax
	blsr	%ecx, %edx
	tzcntl	%ecx, %r10d
	blsr	%edx, %esi
	tzcntl	%esi, %ecx
	movl	%r10d, 180(%rsp)
	vpmovmskb	%ymm2, %r10d
	leaq	(%r8,%rax), %rdi
	tzcntl	%edx, %eax
	blsr	%esi, %edx
	salq	$32, %r10
	movl	%edx, %esi
	movl	%eax, 176(%rsp)
	orq	%r10, %rsi
	movl	%ecx, 172(%rsp)
	tzcntq	%rsi, %rax
	movl	%eax, 168(%rsp)
	incl	%eax
	addq	%rax, %r11
	cmpq	$1, %r13
	je	.L340
	leaq	-4(%rbx,%r13,4), %r10
	movl	$100000000, %eax
	movq	%rbx, 56(%rsp)
	vmovdqa	%ymm6, %ymm14
	movq	%r10, 80(%rsp)
	vmovdqa	%ymm5, %ymm13
	movq	%rbx, %r10
	vmovdqa64	%ymm10, %ymm28
	movq	%r13, 64(%rsp)
	vmovdqa32	%ymm11, %ymm16
	vpbroadcastd	%eax, %ymm12
	movq	%r8, %rsi
	movq	%r11, %rbx
	jmp	.L341
	.p2align 4,,10
	.p2align 3
.L366:
	movq	136(%rsp), %rbx
	movq	144(%rsp), %rdi
	movq	152(%rsp), %r9
	movq	160(%rsp), %r12
.L341:
	vpminsb	(%r12), %ymm8, %ymm3
	vpminsb	32(%r12), %ymm8, %ymm15
	movl	220(%rsp), %edx
	movl	224(%rsp), %ecx
	vpcmpeqb	(%r12), %ymm3, %ymm4
	vpcmpeqb	32(%r12), %ymm15, %ymm0
	vpminsb	(%r9), %ymm8, %ymm1
	movl	%edx, 248(%rsp)
	vpminsb	32(%r9), %ymm8, %ymm3
	movl	%ecx, 240(%rsp)
	vpcmpeqb	(%r9), %ymm1, %ymm2
	vpmovmskb	%ymm4, %r13d
	vpcmpeqb	32(%r9), %ymm3, %ymm4
	vpmovmskb	%ymm0, %edx
	tzcntl	%r13d, %r8d
	blsr	%r13d, %r11d
	salq	$32, %rdx
	blsr	%r11d, %eax
	tzcntl	%eax, %ecx
	blsr	%eax, %eax
	movl	%r8d, 224(%rsp)
	movl	%eax, %r8d
	tzcntl	%r11d, %r13d
	movl	228(%rsp), %r11d
	orq	%rdx, %r8
	movl	%r13d, 220(%rsp)
	tzcntq	%r8, %r13
	movl	%ecx, 228(%rsp)
	movl	216(%rsp), %ecx
	vpmovmskb	%ymm2, %r8d
	movl	%r13d, 216(%rsp)
	incl	%r13d
	blsr	%r8d, %edx
	leaq	(%r12,%r13), %rax
	movl	208(%rsp), %r13d
	movl	%ecx, 132(%rsp)
	tzcntl	%r8d, %ecx
	movq	%rax, 160(%rsp)
	blsr	%edx, %eax
	tzcntl	%edx, %edx
	movl	204(%rsp), %r8d
	movl	%edx, 204(%rsp)
	vpmovmskb	%ymm4, %edx
	salq	$32, %rdx
	movl	%r13d, 112(%rsp)
	tzcntl	%eax, %r13d
	blsr	%eax, %eax
	movl	%ecx, 208(%rsp)
	movl	%eax, %ecx
	movl	196(%rsp), %eax
	orq	%rdx, %rcx
	movl	%r8d, 128(%rsp)
	movl	200(%rsp), %r8d
	movl	%r13d, 200(%rsp)
	tzcntq	%rcx, %r13
	movl	%r13d, 196(%rsp)
	incl	%r13d
	addq	%r9, %r13
	movl	%eax, 96(%rsp)
	movq	%r13, 152(%rsp)
	vpminsb	(%rdi), %ymm8, %ymm15
	vpminsb	32(%rdi), %ymm8, %ymm1
	movl	192(%rsp), %r13d
	vpcmpeqb	(%rdi), %ymm15, %ymm0
	vpminsb	(%rbx), %ymm8, %ymm3
	vpminsb	32(%rbx), %ymm8, %ymm15
	vpcmpeqb	32(%rdi), %ymm1, %ymm2
	movl	%r13d, 100(%rsp)
	movl	188(%rsp), %r13d
	vpcmpeqb	(%rbx), %ymm3, %ymm4
	vpmovmskb	%ymm0, %ecx
	movl	%r13d, 104(%rsp)
	vpcmpeqb	32(%rbx), %ymm15, %ymm0
	blsr	%ecx, %edx
	tzcntl	%ecx, %ecx
	blsr	%edx, %eax
	tzcntl	%edx, %edx
	tzcntl	%eax, %r13d
	blsr	%eax, %eax
	movl	%ecx, 192(%rsp)
	movl	184(%rsp), %ecx
	movl	%edx, 188(%rsp)
	vpmovmskb	%ymm2, %edx
	movl	%ecx, 108(%rsp)
	salq	$32, %rdx
	movl	%eax, %ecx
	movl	212(%rsp), %eax
	orq	%rdx, %rcx
	movl	%r13d, 184(%rsp)
	tzcntq	%rcx, %r13
	vpmovmskb	%ymm4, %ecx
	movl	%eax, 116(%rsp)
	movl	%r13d, 212(%rsp)
	incl	%r13d
	addq	%rdi, %r13
	blsr	%ecx, %edx
	tzcntl	%ecx, %ecx
	blsr	%edx, %eax
	tzcntl	%edx, %edx
	movq	%r13, 144(%rsp)
	movl	180(%rsp), %r13d
	movl	%ecx, 180(%rsp)
	movl	176(%rsp), %ecx
	movl	%r13d, 120(%rsp)
	tzcntl	%eax, %r13d
	blsr	%eax, %eax
	movl	%eax, %eax
	movl	%edx, 176(%rsp)
	movl	172(%rsp), %edx
	movl	%r13d, 172(%rsp)
	vpmovmskb	%ymm0, %r13d
	salq	$32, %r13
	orq	%r13, %rax
	movl	168(%rsp), %r13d
	tzcntq	%rax, %rax
	movl	%eax, 168(%rsp)
	incl	%eax
	addq	%rbx, %rax
	movl	%r13d, 124(%rsp)
	movq	%rax, 136(%rsp)
	movl	240(%rsp), %eax
	movl	248(%rsp), %r13d
	vmovdqu	(%r15), %xmm1
	vmovdqu	1(%r15,%r13), %xmm2
	movl	%r11d, %r13d
	vinserti64x2	$0x1, 1(%r15,%rax), %ymm1, %ymm3
	incl	%eax
	salq	$4, %rax
	vinserti64x2	$0x1, 1(%r15,%r13), %ymm2, %ymm4
	movl	248(%rsp), %r15d
	movl	%r11d, %r13d
	vpsubusb	%ymm9, %ymm3, %ymm1
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm15
	movl	%r15d, %eax
	subl	%r15d, %r13d
	movl	132(%rsp), %r15d
	vpsubusb	%ymm9, %ymm4, %ymm4
	subl	240(%rsp), %eax
	salq	$4, %r13
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm0
	subl	%r11d, %r15d
	movl	128(%rsp), %r11d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm15, %ymm20
	movl	112(%rsp), %eax
	salq	$4, %r15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r15), %ymm0, %ymm24
	movq	%r11, %r15
	vpshufb	%ymm20, %ymm1, %ymm3
	movq	%rax, %r13
	vpmaddubsw	%ymm6, %ymm3, %ymm2
	vmovdqu	(%r14), %xmm3
	vpshufb	%ymm24, %ymm4, %ymm15
	vpmaddwd	%ymm5, %ymm2, %ymm1
	vmovdqu	1(%r14,%r11), %xmm2
	movl	%r8d, %r11d
	vpmaddubsw	%ymm6, %ymm15, %ymm0
	vinserti64x2	$0x1, 1(%r14,%rax), %ymm3, %ymm18
	incl	%eax
	vmovdqu	(%rsi), %xmm3
	vpmaddwd	%ymm5, %ymm0, %ymm0
	salq	$4, %rax
	vinserti64x2	$0x1, 1(%r14,%r11), %ymm2, %ymm17
	movl	%r15d, %r14d
	movl	%ecx, %r11d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm4
	movl	%r8d, %eax
	subl	%r13d, %r14d
	movl	96(%rsp), %r13d
	subl	%r15d, %eax
	salq	$4, %r14
	vpsubusb	%ymm9, %ymm18, %ymm19
	vpsubusb	%ymm9, %ymm17, %ymm26
	salq	$4, %rax
	subl	%r8d, %r13d
	movl	104(%rsp), %r8d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm4, %ymm21
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm15
	salq	$4, %r13
	movl	100(%rsp), %eax
	vmovdqu	1(%rsi,%r8), %xmm2
	vpshufb	%ymm21, %ymm19, %ymm23
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm15, %ymm22
	movl	108(%rsp), %r13d
	movq	%rax, %r15
	vpmaddubsw	%ymm6, %ymm23, %ymm25
	vinserti64x2	$0x1, 1(%rsi,%rax), %ymm3, %ymm15
	incl	%eax
	vpmaddwd	%ymm5, %ymm25, %ymm29
	vinserti64x2	$0x1, 1(%rsi,%r13), %ymm2, %ymm2
	salq	$4, %rax
	movl	%r8d, %esi
	vpackusdw	%ymm29, %ymm1, %ymm1
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm4
	subl	%r15d, %esi
	movl	%r13d, %eax
	vpsubusb	%ymm9, %ymm15, %ymm15
	salq	$4, %rsi
	vpsubusb	%ymm9, %ymm2, %ymm2
	vpshufb	%ymm22, %ymm26, %ymm27
	subl	%r8d, %eax
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rsi), %ymm4, %ymm18
	movl	116(%rsp), %r15d
	salq	$4, %rax
	movl	%edx, %esi
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm3
	movl	120(%rsp), %r14d
	movl	%ecx, %eax
	vpmaddubsw	%ymm6, %ymm27, %ymm30
	subl	%r13d, %r15d
	vpshufb	%ymm18, %ymm15, %ymm4
	movq	232(%rsp), %r13
	vpmaddwd	%ymm5, %ymm30, %ymm31
	salq	$4, %r15
	movq	%r14, %r8
	vpackusdw	%ymm31, %ymm0, %ymm0
	movq	%rbx, 232(%rsp)
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r15), %ymm3, %ymm17
	vpmaddubsw	%ymm6, %ymm4, %ymm3
	movl	%edx, %r15d
	subl	%r8d, %eax
	vpmaddwd	%ymm5, %ymm3, %ymm19
	vmovdqu	0(%r13), %xmm3
	subl	%ecx, %r15d
	movl	124(%rsp), %ecx
	salq	$4, %r15
	vpshufb	%ymm17, %ymm2, %ymm15
	salq	$4, %rax
	vmovdqu	1(%r13,%r11), %xmm2
	vinserti64x2	$0x1, 1(%r13,%r14), %ymm3, %ymm3
	incl	%r14d
	vpmaddubsw	%ymm6, %ymm15, %ymm4
	subl	%edx, %ecx
	salq	$4, %r14
	salq	$4, %rcx
	vinserti64x2	$0x1, 1(%r13,%rsi), %ymm2, %ymm2
	vpternlogq	$254, %ymm17, %ymm24, %ymm20
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm15
	vpsubusb	%ymm9, %ymm3, %ymm3
	vpmaddwd	%ymm5, %ymm4, %ymm4
	movq	88(%rsp), %rdx
	vpsubusb	%ymm9, %ymm2, %ymm2
	movq	%r9, %r14
	movq	%rdi, %rsi
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm15, %ymm23
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r15), %xmm15
	movq	%r12, %r15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rcx), %ymm15, %ymm25
	vpshufb	%ymm23, %ymm3, %ymm15
	vpternlogq	$254, %ymm7, %ymm23, %ymm20
	vpmaddubsw	%ymm6, %ymm15, %ymm3
	vmovdqa64	%ymm21, %ymm7
	vpmaddwd	%ymm5, %ymm3, %ymm15
	vpternlogq	$254, %ymm18, %ymm22, %ymm7
	vpshufb	%ymm25, %ymm2, %ymm3
	vpackusdw	%ymm15, %ymm19, %ymm15
	vpmaddubsw	%ymm6, %ymm3, %ymm2
	vpternlogq	$254, %ymm20, %ymm25, %ymm7
	vpmaddwd	%ymm10, %ymm15, %ymm3
	vpmaddwd	%ymm10, %ymm1, %ymm20
	vshufps	$136, %ymm3, %ymm20, %ymm1
	vpmulld	%ymm12, %ymm1, %ymm15
	vpmaddwd	%ymm5, %ymm2, %ymm2
	vshufps	$221, %ymm3, %ymm20, %ymm24
	vpackusdw	%ymm2, %ymm4, %ymm4
	vpmaddwd	%ymm10, %ymm4, %ymm2
	vpaddd	%ymm24, %ymm15, %ymm3
	vpmaddwd	%ymm10, %ymm0, %ymm15
	vxorps	%xmm1, %xmm1, %xmm1
	vpermd	%ymm3, %ymm11, %ymm1
	vshufps	$136, %ymm2, %ymm15, %ymm3
	vpmulld	%ymm12, %ymm3, %ymm4
	vshufps	$221, %ymm2, %ymm15, %ymm0
	vpaddd	%ymm0, %ymm4, %ymm15
	vxorps	%xmm3, %xmm3, %xmm3
	vpermd	%ymm15, %ymm11, %ymm3
	vpunpcklqdq	%ymm3, %ymm1, %ymm2
	vpunpckhqdq	%ymm3, %ymm1, %ymm4
	vmovdqu	%xmm2, (%rdx,%r10,4)
	vextracti64x2	$0x1, %ymm2, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266752(,%r10,4)
	vextracti64x2	$0x1, %ymm4, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533504(,%r10,4)
	vmovdqa	%xmm4, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region(,%r10,4)
	addq	$4, %r10
	cmpq	80(%rsp), %r10
	jne	.L366
	movq	136(%rsp), %r14
	movq	64(%rsp), %r10
	movq	%rbx, %r11
	movq	56(%rsp), %rbx
	movq	144(%rsp), %r8
	movq	%r14, 232(%rsp)
	movq	160(%rsp), %r15
	movq	152(%rsp), %r14
	leaq	-4(%rbx,%r10,4), %rbx
.L342:
	movl	220(%rsp), %eax
	movl	224(%rsp), %r13d
	vmovdqu	(%r12), %xmm12
	movl	228(%rsp), %edx
	vmovdqu	1(%r12,%rax), %xmm0
	movq	%r13, %r10
	vinserti64x2	$0x1, 1(%r12,%r13), %ymm12, %ymm15
	incl	%r13d
	salq	$4, %r13
	vinserti64x2	$0x1, 1(%r12,%rdx), %ymm0, %ymm3
	movl	%eax, %r12d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm2
	movl	%edx, %r13d
	subl	%r10d, %r12d
	movl	216(%rsp), %r10d
	subl	%eax, %r13d
	movl	208(%rsp), %eax
	salq	$4, %r12
	vpsubusb	%ymm9, %ymm3, %ymm0
	salq	$4, %r13
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm2, %ymm29
	vpsubusb	%ymm9, %ymm15, %ymm1
	subl	%edx, %r10d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm4
	salq	$4, %r10
	movl	200(%rsp), %r13d
	movq	%rax, %r12
	movl	204(%rsp), %edx
	vpshufb	%ymm29, %ymm1, %ymm12
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm4, %ymm27
	vmovdqu	(%r9), %xmm4
	movl	%r13d, %r10d
	vpmaddubsw	%ymm14, %ymm12, %ymm15
	subl	%edx, %r10d
	vmovdqu	1(%r9,%rdx), %xmm12
	vpmaddwd	%ymm13, %ymm15, %ymm1
	vinserti64x2	$0x1, 1(%r9,%rax), %ymm4, %ymm22
	incl	%eax
	vpshufb	%ymm27, %ymm0, %ymm3
	salq	$4, %r10
	salq	$4, %rax
	vpmaddubsw	%ymm14, %ymm3, %ymm2
	vinserti64x2	$0x1, 1(%r9,%r13), %ymm12, %ymm15
	movl	%edx, %r9d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm3
	movl	196(%rsp), %eax
	vpmaddwd	%ymm13, %ymm2, %ymm0
	subl	%r12d, %r9d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm2
	movl	188(%rsp), %edx
	salq	$4, %r9
	vpsubusb	%ymm9, %ymm15, %ymm4
	subl	%r13d, %eax
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r9), %ymm3, %ymm30
	movl	192(%rsp), %r12d
	vpsubusb	%ymm9, %ymm22, %ymm26
	salq	$4, %rax
	vmovdqu	(%rdi), %xmm3
	movl	184(%rsp), %r9d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm2, %ymm21
	vmovdqu	1(%rdi,%rdx), %xmm2
	movq	%r12, %r13
	vpshufb	%ymm30, %ymm26, %ymm31
	movl	%r9d, %r10d
	vpmaddubsw	%ymm14, %ymm31, %ymm18
	vpshufb	%ymm21, %ymm4, %ymm12
	vinserti64x2	$0x1, 1(%rdi,%r9), %ymm2, %ymm2
	vpmaddwd	%ymm13, %ymm18, %ymm17
	subl	%edx, %r10d
	vpmaddubsw	%ymm14, %ymm12, %ymm15
	salq	$4, %r10
	vpmaddwd	%ymm13, %ymm15, %ymm12
	vinserti64x2	$0x1, 1(%rdi,%r12), %ymm3, %ymm15
	incl	%r12d
	movl	%edx, %edi
	salq	$4, %r12
	vpsubusb	%ymm9, %ymm2, %ymm2
	vpackusdw	%ymm12, %ymm0, %ymm0
	subl	%r13d, %edi
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm4
	salq	$4, %rdi
	vpsubusb	%ymm9, %ymm15, %ymm15
	vpmaddwd	%ymm28, %ymm0, %ymm12
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rdi), %ymm4, %ymm19
	movl	212(%rsp), %eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm3
	movl	176(%rsp), %edx
	subl	%r9d, %eax
	vpshufb	%ymm19, %ymm15, %ymm4
	movl	180(%rsp), %r12d
	movl	172(%rsp), %ecx
	salq	$4, %rax
	movl	168(%rsp), %r10d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm3, %ymm23
	vpmaddubsw	%ymm14, %ymm4, %ymm3
	movq	%r12, %r13
	movl	%ecx, %edi
	vpmaddwd	%ymm13, %ymm3, %ymm20
	vmovdqu	(%r11), %xmm3
	subl	%edx, %edi
	subl	%ecx, %r10d
	vpshufb	%ymm23, %ymm2, %ymm15
	vmovdqu	1(%r11,%rdx), %xmm2
	salq	$4, %rdi
	movl	$100000000, %eax
	vinserti64x2	$0x1, 1(%r11,%r12), %ymm3, %ymm3
	incl	%r12d
	vpmaddubsw	%ymm14, %ymm15, %ymm4
	salq	$4, %r10
	vinserti64x2	$0x1, 1(%r11,%rcx), %ymm2, %ymm2
	salq	$4, %r12
	movl	%edx, %r11d
	vpmaddwd	%ymm13, %ymm4, %ymm4
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm15
	subl	%r13d, %r11d
	vpsubusb	%ymm9, %ymm3, %ymm3
	vpternlogq	$254, %ymm23, %ymm27, %ymm29
	salq	$4, %r11
	vpsubusb	%ymm9, %ymm2, %ymm2
	movq	88(%rsp), %r12
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm15, %ymm24
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rdi), %xmm15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm15, %ymm25
	vpshufb	%ymm24, %ymm3, %ymm15
	vpternlogq	$254, %ymm7, %ymm24, %ymm29
	vpmaddubsw	%ymm14, %ymm15, %ymm3
	vmovdqa64	%ymm30, %ymm7
	vpmaddwd	%ymm13, %ymm3, %ymm15
	vpshufb	%ymm25, %ymm2, %ymm3
	vpternlogq	$254, %ymm19, %ymm21, %ymm7
	vpmaddubsw	%ymm14, %ymm3, %ymm14
	vpternlogq	$254, %ymm29, %ymm25, %ymm7
	vpmaddwd	%ymm13, %ymm14, %ymm2
	vpackusdw	%ymm17, %ymm1, %ymm13
	vpackusdw	%ymm15, %ymm20, %ymm1
	vpmaddwd	%ymm28, %ymm1, %ymm15
	vpmaddwd	%ymm28, %ymm13, %ymm13
	vpbroadcastd	%eax, %ymm14
	vpackusdw	%ymm2, %ymm4, %ymm4
	vshufps	$136, %ymm15, %ymm13, %ymm3
	vpmulld	%ymm14, %ymm3, %ymm1
	vshufps	$221, %ymm15, %ymm13, %ymm13
	vpmaddwd	%ymm28, %ymm4, %ymm2
	vshufps	$136, %ymm2, %ymm12, %ymm3
	vpmulld	%ymm14, %ymm3, %ymm14
	vpaddd	%ymm13, %ymm1, %ymm15
	vshufps	$221, %ymm2, %ymm12, %ymm13
	vxorps	%xmm1, %xmm1, %xmm1
	vpermd	%ymm15, %ymm16, %ymm1
	vpaddd	%ymm13, %ymm14, %ymm15
	vxorps	%xmm0, %xmm0, %xmm0
	vpermd	%ymm15, %ymm16, %ymm0
	vpunpcklqdq	%ymm0, %ymm1, %ymm12
	vpunpckhqdq	%ymm0, %ymm1, %ymm4
	vmovdqu	%xmm12, (%r12,%rbx,4)
	vextracti64x2	$0x1, %ymm12, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266752(,%rbx,4)
	vextracti64x2	$0x1, %ymm4, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533504(,%rbx,4)
	vmovdqa	%xmm4, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region(,%rbx,4)
	addq	$4, %rbx
	jmp	.L343
.L530:
	movq	40(%rsp), %r10
	movq	%r14, %r12
	movq	%r15, %r14
	movq	%r8, %r11
	movq	32(%rsp), %r15
	movq	16(%rsp), %rdi
	movq	%rbx, %r8
	cmpq	%r10, %r14
	jnb	.L339
	movl	$538976288, %r13d
	movl	$808464432, %edx
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm6
	vmovdqa	.LC11(%rip), %xmm10
	movq	88(%rsp), %r9
	vpbroadcastd	%r13d, %xmm2
	vpbroadcastd	%edx, %xmm3
	.p2align 4,,10
	.p2align 3
.L338:
	vmovdqu	(%r14), %xmm14
	incq	%r8
	vpminsb	%xmm2, %xmm14, %xmm13
	vpsubusb	%xmm3, %xmm14, %xmm1
	vpcmpeqb	%xmm13, %xmm14, %xmm15
	vpmovmskb	%xmm15, %ecx
	tzcntl	%ecx, %esi
	incl	%esi
	movq	%rsi, %rax
	addq	%rsi, %r14
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm4
	vpshufb	%xmm4, %xmm1, %xmm8
	vmovdqa	%xmm4, %xmm0
	vpmaddubsw	%xmm5, %xmm8, %xmm9
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm9, %xmm11
	vpackusdw	%xmm11, %xmm11, %xmm12
	vpmaddwd	%xmm10, %xmm12, %xmm14
	vmovq	%xmm14, %r13
	imull	$100000000, %r13d, %edx
	shrq	$32, %r13
	addl	%edx, %r13d
	movl	%r13d, -4(%r9,%r8,4)
	cmpq	%r10, %r14
	jb	.L338
.L339:
	cmpq	$66687, %rbx
	movq	%rbx, %r9
	setbe	%cl
	cmpq	%r15, %r12
	jnb	.L344
	testb	%cl, %cl
	je	.L344
	movl	$538976288, %esi
	movl	$808464432, %eax
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm6
	vmovdqa	.LC11(%rip), %xmm10
	vpbroadcastd	%esi, %xmm2
	vpbroadcastd	%eax, %xmm3
	testb	$1, %bl
	je	.L345
	vmovdqu	(%r12), %xmm13
	vpminsb	%xmm2, %xmm13, %xmm15
	vpsubusb	%xmm3, %xmm13, %xmm8
	vpcmpeqb	%xmm15, %xmm13, %xmm4
	vpmovmskb	%xmm4, %r9d
	tzcntl	%r9d, %r13d
	leaq	1(%rbx), %r9
	incl	%r13d
	movq	%r13, %rdx
	addq	%r13, %r12
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm1
	vpshufb	%xmm1, %xmm8, %xmm9
	vmovdqa	%xmm1, %xmm0
	vpmaddubsw	%xmm5, %xmm9, %xmm11
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm11, %xmm12
	vpackusdw	%xmm12, %xmm12, %xmm14
	vpmaddwd	%xmm10, %xmm14, %xmm13
	vmovq	%xmm13, %rsi
	imull	$100000000, %esi, %eax
	shrq	$32, %rsi
	addl	%esi, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r9,4)
	cmpq	%r15, %r12
	jb	.L510
	jmp	.L344
	.p2align 4,,10
	.p2align 3
.L345:
	vmovdqu	(%r12), %xmm15
	incq	%r9
	vpminsb	%xmm2, %xmm15, %xmm4
	vpsubusb	%xmm3, %xmm15, %xmm9
	vpcmpeqb	%xmm4, %xmm15, %xmm1
	vpmovmskb	%xmm1, %r13d
	tzcntl	%r13d, %esi
	incl	%esi
	movq	%rsi, %rdx
	addq	%rsi, %r12
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm8
	vpshufb	%xmm8, %xmm9, %xmm11
	vmovdqa	%xmm8, %xmm0
	vpmaddubsw	%xmm5, %xmm11, %xmm12
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm12, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm13
	vpmaddwd	%xmm10, %xmm13, %xmm15
	vmovq	%xmm15, %rax
	imull	$100000000, %eax, %r13d
	shrq	$32, %rax
	addl	%r13d, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r9,4)
	cmpq	%r15, %r12
	jnb	.L344
	vmovdqu	(%r12), %xmm1
	incq	%r9
	vpminsb	%xmm2, %xmm1, %xmm4
	vpsubusb	%xmm3, %xmm1, %xmm11
	vpcmpeqb	%xmm4, %xmm1, %xmm8
	vpmovmskb	%xmm8, %esi
	tzcntl	%esi, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r12
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm9
	vpshufb	%xmm9, %xmm11, %xmm12
	vmovdqa	%xmm9, %xmm0
	vpmaddubsw	%xmm5, %xmm12, %xmm14
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm14, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm15
	vpmaddwd	%xmm10, %xmm15, %xmm1
	vmovq	%xmm1, %r13
	imull	$100000000, %r13d, %esi
	shrq	$32, %r13
	addl	%esi, %r13d
	movl	%r13d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r9,4)
	cmpq	%r15, %r12
	jnb	.L344
.L510:
	cmpq	$66688, %r9
	jne	.L345
.L344:
	movq	48(%rsp), %rsi
	movq	%rbx, %r13
	cmpq	%rsi, %r11
	jnb	.L347
	testb	%cl, %cl
	je	.L347
	movl	$538976288, %eax
	movl	$808464432, %edx
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm6
	vmovdqa	.LC11(%rip), %xmm10
	vpbroadcastd	%eax, %xmm2
	vpbroadcastd	%edx, %xmm3
	testb	$1, %bl
	je	.L348
	vmovdqu	(%r11), %xmm8
	vpminsb	%xmm2, %xmm8, %xmm4
	vpsubusb	%xmm3, %xmm8, %xmm11
	vpcmpeqb	%xmm4, %xmm8, %xmm9
	vpmovmskb	%xmm9, %r13d
	tzcntl	%r13d, %eax
	leaq	1(%rbx), %r13
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r11
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm12
	vpshufb	%xmm12, %xmm11, %xmm14
	vmovdqa	%xmm12, %xmm0
	vpmaddubsw	%xmm5, %xmm14, %xmm13
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm13, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm1
	vpmaddwd	%xmm10, %xmm1, %xmm8
	vmovq	%xmm8, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	48(%rsp), %r11
	jb	.L512
	jmp	.L347
	.p2align 4,,10
	.p2align 3
.L348:
	vmovdqu	(%r11), %xmm9
	incq	%r13
	vpminsb	%xmm2, %xmm9, %xmm4
	vpsubusb	%xmm3, %xmm9, %xmm11
	vpcmpeqb	%xmm4, %xmm9, %xmm12
	vpmovmskb	%xmm12, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r11
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm11, %xmm13
	vmovdqa	%xmm14, %xmm0
	vpmaddubsw	%xmm5, %xmm13, %xmm15
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm15, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm8
	vpmaddwd	%xmm10, %xmm8, %xmm9
	vmovq	%xmm9, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	%rsi, %r11
	jnb	.L347
	vmovdqu	(%r11), %xmm12
	incq	%r13
	vpminsb	%xmm2, %xmm12, %xmm4
	vpsubusb	%xmm3, %xmm12, %xmm11
	vpcmpeqb	%xmm4, %xmm12, %xmm14
	vpmovmskb	%xmm14, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r11
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm11, %xmm15
	vmovdqa	%xmm13, %xmm0
	vpmaddubsw	%xmm5, %xmm15, %xmm1
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm1, %xmm8
	vpackusdw	%xmm8, %xmm8, %xmm9
	vpmaddwd	%xmm10, %xmm9, %xmm12
	vmovq	%xmm12, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	%rsi, %r11
	jnb	.L347
.L512:
	cmpq	$66688, %r13
	jne	.L348
.L347:
	movq	232(%rsp), %rdx
	movq	72(%rsp), %rsi
	cmpq	%rsi, %rdx
	jnb	.L350
	testb	%cl, %cl
	je	.L350
	movl	$808464432, %eax
	movl	$538976288, %ecx
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm6
	vpbroadcastd	%eax, %xmm3
	vmovdqa	.LC11(%rip), %xmm10
	vpbroadcastd	%ecx, %xmm2
	movq	%rdx, %rax
	testb	$1, %bl
	je	.L351
	vmovdqu	(%rdx), %xmm14
	movq	%rdx, %rsi
	incq	%rbx
	vpminsb	%xmm2, %xmm14, %xmm4
	vpsubusb	%xmm3, %xmm14, %xmm11
	vpcmpeqb	%xmm4, %xmm14, %xmm13
	vpmovmskb	%xmm13, %edx
	tzcntl	%edx, %ecx
	incl	%ecx
	movq	%rcx, %rax
	addq	%rcx, %rsi
	salq	$4, %rax
	movq	%rsi, 232(%rsp)
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm15
	vpshufb	%xmm15, %xmm11, %xmm1
	vmovdqa	%xmm15, %xmm0
	vpmaddubsw	%xmm5, %xmm1, %xmm8
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm8, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm12
	vpmaddwd	%xmm10, %xmm12, %xmm14
	vmovq	%xmm14, %rcx
	imull	$100000000, %ecx, %edx
	shrq	$32, %rcx
	addl	%ecx, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	72(%rsp), %rsi
	jnb	.L350
	movq	%rsi, %rax
	movq	72(%rsp), %rsi
	cmpq	$66688, %rbx
	jne	.L351
	jmp	.L350
	.p2align 4,,10
	.p2align 3
.L531:
	vmovdqu	(%rax), %xmm15
	incq	%rbx
	vpminsb	%xmm2, %xmm15, %xmm4
	vpsubusb	%xmm3, %xmm15, %xmm11
	vpcmpeqb	%xmm4, %xmm15, %xmm1
	vpmovmskb	%xmm1, %edx
	tzcntl	%edx, %edx
	incl	%edx
	movq	%rdx, %rcx
	addq	%rdx, %rax
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm8
	vpshufb	%xmm8, %xmm11, %xmm9
	vmovdqa	%xmm8, %xmm0
	vpmaddubsw	%xmm5, %xmm9, %xmm12
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm12, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm13
	vpmaddwd	%xmm10, %xmm13, %xmm15
	vmovq	%xmm15, %rdx
	imull	$100000000, %edx, %ecx
	shrq	$32, %rdx
	addl	%edx, %ecx
	movl	%ecx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%rsi, %rax
	jnb	.L520
	cmpq	$66688, %rbx
	je	.L520
.L351:
	vmovdqu	(%rax), %xmm13
	incq	%rbx
	vpminsb	%xmm2, %xmm13, %xmm4
	vpsubusb	%xmm3, %xmm13, %xmm11
	vpcmpeqb	%xmm4, %xmm13, %xmm15
	vpmovmskb	%xmm15, %ecx
	tzcntl	%ecx, %edx
	incl	%edx
	movq	%rdx, %rcx
	addq	%rdx, %rax
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm1
	vpshufb	%xmm1, %xmm11, %xmm8
	vmovdqa	%xmm1, %xmm0
	vpmaddubsw	%xmm5, %xmm8, %xmm9
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm6, %xmm9, %xmm12
	vpackusdw	%xmm12, %xmm12, %xmm14
	vpmaddwd	%xmm10, %xmm14, %xmm13
	vmovq	%xmm13, %rdx
	imull	$100000000, %edx, %ecx
	shrq	$32, %rdx
	addl	%edx, %ecx
	movl	%ecx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%rsi, %rax
	jb	.L531
.L520:
	movq	%rax, 232(%rsp)
.L350:
	cmpq	%r14, %r10
	vpmovmskb	%ymm7, %eax
	setne	%r10b
	cmpq	%r12, %r15
	movq	232(%rsp), %r15
	setne	%r12b
	orl	%r12d, %r10d
	cmpq	%r11, 48(%rsp)
	setne	%r11b
	andl	$-2147450880, %eax
	orl	%r11d, %r10d
	cmpq	%r15, 72(%rsp)
	setne	%sil
	movzbl	%r10b, %r14d
	movzbl	%sil, %edx
	orl	%edx, %eax
	orl	%eax, %r14d
	jne	.L532
	movq	88(%rsp), %r14
	movq	%r9, 248(%rsp)
	leaq	0(,%r9,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region, %esi
	movq	%r8, 240(%rsp)
	leaq	(%r14,%r8,4), %rdi
	vzeroupper
	call	memcpy
	movq	248(%rsp), %rdi
	movq	240(%rsp), %r8
	leaq	0(,%r13,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266752, %esi
	leaq	(%r8,%rdi), %r12
	leaq	(%r14,%r12,4), %rdi
	addq	%r13, %r12
	call	memcpy
	leaq	(%r14,%r12,4), %rdi
	leaq	0(,%rbx,4), %rdx
	addq	%rbx, %r12
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533504, %esi
	leaq	(%r14,%r12,4), %rbx
	call	memcpy
	subq	%r12, 24(%rsp)
	vmovdqa	.LC5(%rip), %ymm10
	vmovdqa	.LC4(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm6
	movq	%rbx, 88(%rsp)
.L362:
	cmpq	$133312, 24(%rsp)
	jbe	.L528
.L355:
	movq	72(%rsp), %rdi
	jmp	.L363
.L340:
	movq	232(%rsp), %r13
	movq	%r8, %rcx
	movq	%r14, %rdx
	movq	%r15, %rsi
	movq	%r11, 232(%rsp)
	movq	%rdi, %r8
	movq	%r9, %r14
	movq	%r12, %r15
	vmovdqa	.LC3(%rip), %ymm14
	vmovdqa	.LC4(%rip), %ymm13
	movq	%r13, %r11
	movq	%rcx, %rdi
	vmovdqa64	.LC5(%rip), %ymm28
	vmovdqa32	.LC15(%rip), %ymm16
	movq	%rdx, %r9
	movq	%rsi, %r12
	jmp	.L342
.L528:
	vzeroupper
.L336:
	movq	24(%rsp), %rdx
	movq	88(%rsp), %rsi
	movq	72(%rsp), %rdi
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	_ZN13qp_parse_flat12parse_tokensEPcPjm
.L532:
	.cfi_restore_state
	cmpq	72(%rsp), %rdi
	jnb	.L533
	movq	72(%rsp), %r9
	leaq	1(%rdi), %rcx
	leaq	-1(%r9), %rsi
	cmpq	%rsi, %rdi
	cmovbe	%rdi, %rsi
	xorl	%eax, %eax
	movq	%rsi, %r13
	subq	%rdi, %r13
	andl	$7, %r13d
	cmpb	$32, (%rdi)
	setg	%al
	movq	%rax, %rdx
	cmpq	%rcx, %rsi
	jnb	.L534
.L515:
	movq	%rsi, %r8
	xorl	%ecx, %ecx
	subq	%rdi, %r8
	cmpq	%rdi, %rsi
	movq	72(%rsp), %rsi
	cmovb	%rcx, %r8
	leaq	1(%rdi,%r8), %r12
	cmpq	%rsi, %r12
	jnb	.L361
	movq	%r12, %rbx
	notq	%rbx
	addq	%rsi, %rbx
	andl	$7, %ebx
	cmpb	$32, (%r12)
	jg	.L535
.L394:
	leaq	1(%r12), %rax
	cmpq	72(%rsp), %rax
	jnb	.L361
	testq	%rbx, %rbx
	je	.L360
	cmpq	$1, %rbx
	je	.L465
	cmpq	$2, %rbx
	je	.L466
	cmpq	$3, %rbx
	je	.L467
	cmpq	$4, %rbx
	je	.L468
	cmpq	$5, %rbx
	je	.L469
	cmpq	$6, %rbx
	je	.L470
	cmpb	$32, 1(%r12)
	jle	.L396
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
.L396:
	incq	%rax
.L470:
	cmpb	$32, (%rax)
	jle	.L399
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
.L399:
	incq	%rax
.L469:
	cmpb	$32, (%rax)
	jle	.L402
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rax)
	setle	%r11b
	addq	%r11, %rdx
.L402:
	incq	%rax
.L468:
	cmpb	$32, (%rax)
	jle	.L405
	xorl	%r15d, %r15d
	cmpb	$32, -1(%rax)
	setle	%r15b
	addq	%r15, %rdx
.L405:
	incq	%rax
.L467:
	cmpb	$32, (%rax)
	jle	.L408
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L408:
	incq	%rax
.L466:
	cmpb	$32, (%rax)
	jle	.L411
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
.L411:
	incq	%rax
.L465:
	cmpb	$32, (%rax)
	jle	.L414
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L414:
	incq	%rax
	cmpq	72(%rsp), %rax
	jnb	.L361
.L360:
	cmpb	$32, (%rax)
	jle	.L359
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
.L359:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %rsi
	jle	.L417
	xorl	%eax, %eax
	cmpb	$32, -1(%rsi)
	setle	%al
	addq	%rax, %rdx
.L417:
	cmpb	$32, 1(%rsi)
	jle	.L419
	xorl	%ebx, %ebx
	cmpb	$32, (%rsi)
	setle	%bl
	addq	%rbx, %rdx
.L419:
	cmpb	$32, 2(%rsi)
	jle	.L421
	xorl	%r9d, %r9d
	cmpb	$32, 1(%rsi)
	setle	%r9b
	addq	%r9, %rdx
.L421:
	cmpb	$32, 3(%rsi)
	jle	.L423
	xorl	%r13d, %r13d
	cmpb	$32, 2(%rsi)
	setle	%r13b
	addq	%r13, %rdx
.L423:
	cmpb	$32, 4(%rsi)
	jle	.L425
	xorl	%r10d, %r10d
	cmpb	$32, 3(%rsi)
	setle	%r10b
	addq	%r10, %rdx
.L425:
	cmpb	$32, 5(%rsi)
	jle	.L427
	xorl	%r11d, %r11d
	cmpb	$32, 4(%rsi)
	setle	%r11b
	addq	%r11, %rdx
.L427:
	cmpb	$32, 6(%rsi)
	jle	.L429
	xorl	%r15d, %r15d
	cmpb	$32, 5(%rsi)
	setle	%r15b
	addq	%r15, %rdx
.L429:
	leaq	7(%rsi), %rax
	cmpq	72(%rsp), %rax
	jb	.L360
.L361:
	subq	%rdx, 24(%rsp)
	movq	88(%rsp), %rsi
	leaq	(%rsi,%rdx,4), %r14
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm6
	vmovdqa	.LC4(%rip), %ymm5
	movq	%r14, 88(%rsp)
	vmovdqa	.LC5(%rip), %ymm10
	jmp	.L362
.L535:
	xorl	%r9d, %r9d
	cmpb	$32, -1(%r12)
	setle	%r9b
	addq	%r9, %rdx
	jmp	.L394
.L534:
	testq	%r13, %r13
	je	.L357
	cmpq	$1, %r13
	je	.L471
	cmpq	$2, %r13
	je	.L472
	cmpq	$3, %r13
	je	.L473
	cmpq	$4, %r13
	je	.L474
	cmpq	$5, %r13
	je	.L475
	cmpq	$6, %r13
	jne	.L536
.L476:
	xorl	%r10d, %r10d
	cmpb	$32, (%rcx)
	setg	%r10b
	incq	%rcx
	addq	%r10, %rdx
.L475:
	xorl	%r11d, %r11d
	cmpb	$32, (%rcx)
	setg	%r11b
	incq	%rcx
	addq	%r11, %rdx
.L474:
	xorl	%r15d, %r15d
	cmpb	$32, (%rcx)
	setg	%r15b
	incq	%rcx
	addq	%r15, %rdx
.L473:
	xorl	%r14d, %r14d
	cmpb	$32, (%rcx)
	setg	%r14b
	incq	%rcx
	addq	%r14, %rdx
.L472:
	xorl	%r8d, %r8d
	cmpb	$32, (%rcx)
	setg	%r8b
	incq	%rcx
	addq	%r8, %rdx
.L471:
	xorl	%r12d, %r12d
	cmpb	$32, (%rcx)
	setg	%r12b
	incq	%rcx
	addq	%r12, %rdx
	cmpq	%rcx, %rsi
	jb	.L515
.L357:
	xorl	%ebx, %ebx
	cmpb	$32, (%rcx)
	setg	%bl
	xorl	%r9d, %r9d
	addq	%rbx, %rdx
	cmpb	$32, 1(%rcx)
	setg	%r9b
	xorl	%r13d, %r13d
	addq	%r9, %rdx
	cmpb	$32, 2(%rcx)
	setg	%r13b
	xorl	%eax, %eax
	addq	%r13, %rdx
	cmpb	$32, 3(%rcx)
	setg	%al
	xorl	%r10d, %r10d
	addq	%rax, %rdx
	cmpb	$32, 4(%rcx)
	setg	%r10b
	xorl	%r11d, %r11d
	addq	%r10, %rdx
	cmpb	$32, 5(%rcx)
	setg	%r11b
	xorl	%r15d, %r15d
	addq	%r11, %rdx
	cmpb	$32, 6(%rcx)
	setg	%r15b
	xorl	%r14d, %r14d
	addq	%r15, %rdx
	cmpb	$32, 7(%rcx)
	setg	%r14b
	addq	$8, %rcx
	addq	%r14, %rdx
	cmpq	%rcx, %rsi
	jb	.L515
	jmp	.L357
.L364:
	movq	%rdi, 72(%rsp)
	jmp	.L336
.L533:
	movq	88(%rsp), %rsi
	xorl	%edx, %edx
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm6
	vmovdqa	.LC4(%rip), %ymm5
	vmovdqa	.LC5(%rip), %ymm10
	jmp	.L355
.L536:
	xorl	%edx, %edx
	cmpb	$32, 1(%rdi)
	setg	%dl
	incq	%rcx
	addq	%rax, %rdx
	jmp	.L476
	.cfi_endproc
.LFE8991:
	.size	_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_.isra.0, .-_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_.isra.0
	.p2align 4
	.type	_ZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_.isra.0, @function
_ZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_.isra.0:
.LFB8992:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %r10
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
	movq	%rdx, 8(%rsp)
	cmpq	$133312, %rdx
	jbe	.L564
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm4
	vmovdqa	.LC5(%rip), %ymm8
	.p2align 4,,10
	.p2align 3
.L563:
	movl	$538976288, %eax
	movq	$0, 56(%rsp)
	vpbroadcastd	%eax, %ymm6
	vpminsb	199872(%r10), %ymm6, %ymm7
	vpminsb	66624(%r10), %ymm6, %ymm0
	vpminsb	133248(%r10), %ymm6, %ymm2
	vpminsb	266496(%r10), %ymm6, %ymm10
	vpcmpeqb	199872(%r10), %ymm7, %ymm9
	vpcmpeqb	66624(%r10), %ymm0, %ymm1
	vpcmpeqb	133248(%r10), %ymm2, %ymm3
	vpcmpeqb	266496(%r10), %ymm10, %ymm11
	vpmovmskb	%ymm1, %edx
	vpmovmskb	%ymm9, %r9d
	vpxor	%xmm9, %xmm9, %xmm9
	vpmovmskb	%ymm3, %esi
	tzcntl	%edx, %ecx
	vpmovmskb	%ymm11, %r14d
	tzcntl	%r9d, %r12d
	tzcntl	%esi, %edi
	movl	%ecx, %ebx
	movl	%r12d, %r13d
	tzcntl	%r14d, %eax
	movl	%edi, %r8d
	leaq	66625(%r10,%rbx), %r11
	movl	%eax, %edx
	movl	$808464432, %ebx
	leaq	133249(%r10,%r8), %rdi
	leaq	199873(%r10,%r13), %r8
	movq	%r11, 16(%rsp)
	vmovdqa	.LC15(%rip), %ymm11
	movq	%rdi, 32(%rsp)
	leaq	266497(%r10,%rdx), %rcx
	vpbroadcastd	%ebx, %ymm7
	movq	%r11, %rsi
	movq	%r8, 24(%rsp)
	movq	%r10, %rbx
	movq	%rcx, 40(%rsp)
	movq	%r10, %rcx
	.p2align 4,,10
	.p2align 3
.L543:
	movq	32(%rsp), %rax
	movq	16(%rsp), %r10
	movq	40(%rsp), %r11
	movq	24(%rsp), %r9
	subq	%rsi, %rax
	subq	%rcx, %r10
	cmpq	%r10, %rax
	cmovg	%r10, %rax
	subq	%r8, %r11
	subq	%rdi, %r9
	cmpq	%r9, %r11
	cmovg	%r9, %r11
	cmpq	%r11, %rax
	cmovg	%r11, %rax
	cmpq	$64, %rax
	jbe	.L731
	movabsq	$1135184250689818561, %r12
	movq	56(%rsp), %r9
	movl	$100000000, %r14d
	mulq	%r12
	vpbroadcastd	%r14d, %ymm10
	movq	%rdx, %r13
	andq	$-4, %rdx
	shrq	$2, %r13
	leaq	(%rdx,%r9), %rdx
	movq	%r13, 48(%rsp)
	.p2align 4,,10
	.p2align 3
.L542:
	vmovdqu	(%rcx), %ymm12
	vpminsb	32(%rcx), %ymm6, %ymm15
	vpminsb	%ymm6, %ymm12, %ymm13
	vpcmpeqb	32(%rcx), %ymm15, %ymm0
	vpcmpeqb	%ymm13, %ymm12, %ymm14
	vpmovmskb	%ymm14, %eax
	blsr	%eax, %r10d
	tzcntl	%r10d, %r11d
	blsr	%r10d, %r13d
	tzcntl	%r13d, %r10d
	blsr	%r13d, %r14d
	vpmovmskb	%ymm0, %r13d
	tzcntl	%eax, %r12d
	salq	$32, %r13
	movl	%r14d, %eax
	movl	%r11d, %r14d
	orq	%r13, %rax
	movl	%r12d, %r13d
	vmovdqu	1(%rcx,%r14), %xmm1
	movl	%r10d, %r14d
	vinserti64x2	$0x1, 1(%rcx,%r13), %ymm12, %ymm2
	incl	%r13d
	tzcntq	%rax, %rax
	salq	$4, %r13
	vinserti64x2	$0x1, 1(%rcx,%r14), %ymm1, %ymm3
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm12
	movl	%r11d, %r13d
	vpsubusb	%ymm7, %ymm2, %ymm0
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	vpsubusb	%ymm7, %ymm3, %ymm3
	salq	$4, %r13
	subl	%r11d, %r12d
	movl	%eax, %r11d
	incl	%eax
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm12, %ymm13
	salq	$4, %r12
	subl	%r10d, %r11d
	addq	%rax, %rcx
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm14
	salq	$4, %r11
	vpshufb	%ymm13, %ymm0, %ymm2
	vmovdqu	(%rsi), %ymm0
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm14, %ymm15
	vpmaddubsw	%ymm5, %ymm2, %ymm1
	vpminsb	%ymm6, %ymm0, %ymm2
	vpmaddwd	%ymm4, %ymm1, %ymm21
	vpshufb	%ymm15, %ymm3, %ymm12
	vpcmpeqb	%ymm2, %ymm0, %ymm3
	vpmaddubsw	%ymm5, %ymm12, %ymm14
	vpminsb	32(%rsi), %ymm6, %ymm12
	vpmaddwd	%ymm4, %ymm14, %ymm1
	vpmovmskb	%ymm3, %r10d
	vpcmpeqb	32(%rsi), %ymm12, %ymm14
	tzcntl	%r10d, %r12d
	blsr	%r10d, %eax
	tzcntl	%eax, %r11d
	blsr	%eax, %r14d
	blsr	%r14d, %r13d
	movl	%r13d, %eax
	movl	%r12d, %r13d
	tzcntl	%r14d, %r10d
	vinserti64x2	$0x1, 1(%rsi,%r13), %ymm0, %ymm0
	incl	%r13d
	vpmovmskb	%ymm14, %r14d
	salq	$4, %r13
	salq	$32, %r14
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm3
	movl	%r11d, %r13d
	orq	%r14, %rax
	movl	%r11d, %r14d
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	tzcntq	%rax, %rax
	vmovdqu	1(%rsi,%r14), %xmm2
	salq	$4, %r13
	subl	%r11d, %r12d
	movl	%eax, %r11d
	movl	%r10d, %r14d
	salq	$4, %r12
	subl	%r10d, %r11d
	vinserti64x2	$0x1, 1(%rsi,%r14), %ymm2, %ymm12
	incl	%eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm14
	salq	$4, %r11
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm3, %ymm16
	vpsubusb	%ymm7, %ymm0, %ymm0
	vpsubusb	%ymm7, %ymm12, %ymm12
	addq	%rax, %rsi
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm14, %ymm19
	vpshufb	%ymm16, %ymm0, %ymm2
	vpmaddubsw	%ymm5, %ymm2, %ymm3
	vpshufb	%ymm19, %ymm12, %ymm0
	vpmaddwd	%ymm4, %ymm3, %ymm14
	vpmaddubsw	%ymm5, %ymm0, %ymm2
	vmovdqu	(%rdi), %ymm0
	vpackusdw	%ymm14, %ymm21, %ymm14
	vpmaddwd	%ymm4, %ymm2, %ymm12
	vpmaddwd	%ymm8, %ymm14, %ymm14
	vpminsb	%ymm6, %ymm0, %ymm3
	vpackusdw	%ymm12, %ymm1, %ymm1
	vpcmpeqb	%ymm3, %ymm0, %ymm2
	vpminsb	32(%rdi), %ymm6, %ymm3
	vpmaddwd	%ymm8, %ymm1, %ymm12
	vpmovmskb	%ymm2, %r10d
	vpcmpeqb	32(%rdi), %ymm3, %ymm2
	tzcntl	%r10d, %r12d
	blsr	%r10d, %eax
	blsr	%eax, %r14d
	tzcntl	%r14d, %r10d
	blsr	%r14d, %r13d
	tzcntl	%eax, %r11d
	movl	%r13d, %eax
	movl	%r12d, %r13d
	vpmovmskb	%ymm2, %r14d
	vinserti64x2	$0x1, 1(%rdi,%r13), %ymm0, %ymm2
	incl	%r13d
	salq	$32, %r14
	salq	$4, %r13
	orq	%r14, %rax
	movl	%r11d, %r14d
	vmovdqu	1(%rdi,%r14), %xmm0
	movl	%r10d, %r14d
	tzcntq	%rax, %rax
	vinserti64x2	$0x1, 1(%rdi,%r14), %ymm0, %ymm3
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm0
	movl	%r11d, %r13d
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	subl	%r11d, %r12d
	salq	$4, %r13
	movl	%eax, %r11d
	vpsubusb	%ymm7, %ymm3, %ymm3
	salq	$4, %r12
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm0, %ymm18
	subl	%r10d, %r11d
	incl	%eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm0
	salq	$4, %r11
	addq	%rax, %rdi
	vpternlogq	$254, %ymm18, %ymm19, %ymm16
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm0, %ymm17
	vpternlogq	$254, %ymm17, %ymm15, %ymm13
	vpshufb	%ymm17, %ymm3, %ymm0
	vmovdqa64	%ymm13, %ymm22
	vpsubusb	%ymm7, %ymm2, %ymm13
	vpshufb	%ymm18, %ymm13, %ymm15
	vpmaddubsw	%ymm5, %ymm0, %ymm13
	vpmaddubsw	%ymm5, %ymm15, %ymm2
	vpmaddwd	%ymm4, %ymm13, %ymm13
	vpmaddwd	%ymm4, %ymm2, %ymm15
	vmovdqu	(%r8), %ymm2
	vpminsb	%ymm6, %ymm2, %ymm3
	vpcmpeqb	%ymm3, %ymm2, %ymm0
	vpminsb	32(%r8), %ymm6, %ymm3
	vpmovmskb	%ymm0, %r10d
	vpcmpeqb	32(%r8), %ymm3, %ymm0
	tzcntl	%r10d, %r12d
	blsr	%r10d, %eax
	blsr	%eax, %r14d
	tzcntl	%r14d, %r10d
	blsr	%r14d, %r13d
	tzcntl	%eax, %r11d
	movl	%r13d, %eax
	movl	%r12d, %r13d
	vpmovmskb	%ymm0, %r14d
	vinserti64x2	$0x1, 1(%r8,%r13), %ymm2, %ymm2
	salq	$32, %r14
	orq	%r14, %rax
	incl	%r13d
	vpsubusb	%ymm7, %ymm2, %ymm2
	movl	%r11d, %r14d
	salq	$4, %r13
	tzcntq	%rax, %rax
	vmovdqu	1(%r8,%r14), %xmm3
	movl	%r10d, %r14d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm0
	movl	%r11d, %r13d
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	vinserti64x2	$0x1, 1(%r8,%r14), %ymm3, %ymm3
	subl	%r11d, %r12d
	salq	$4, %r13
	movl	%eax, %r11d
	incl	%eax
	salq	$4, %r12
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm0, %ymm23
	subl	%r10d, %r11d
	addq	%rax, %r8
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm0
	salq	$4, %r11
	vpsubusb	%ymm7, %ymm3, %ymm3
	vmovdqa64	%ymm23, %ymm20
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm0, %ymm24
	vpshufb	%ymm23, %ymm2, %ymm0
	vpternlogq	$254, %ymm9, %ymm22, %ymm20
	vpmaddubsw	%ymm5, %ymm0, %ymm2
	vpmaddwd	%ymm4, %ymm2, %ymm2
	vpshufb	%ymm24, %ymm3, %ymm0
	vmovdqa64	%ymm24, %ymm9
	vpackusdw	%ymm2, %ymm15, %ymm15
	vpmaddubsw	%ymm5, %ymm0, %ymm3
	vpternlogq	$254, %ymm20, %ymm16, %ymm9
	vpmaddwd	%ymm8, %ymm15, %ymm2
	vpmaddwd	%ymm4, %ymm3, %ymm3
	vshufps	$136, %ymm2, %ymm14, %ymm0
	vpmulld	%ymm10, %ymm0, %ymm15
	vpackusdw	%ymm3, %ymm13, %ymm13
	vshufps	$221, %ymm2, %ymm14, %ymm14
	vpmaddwd	%ymm8, %ymm13, %ymm3
	vpaddd	%ymm14, %ymm15, %ymm2
	vshufps	$136, %ymm3, %ymm12, %ymm15
	vpmulld	%ymm10, %ymm15, %ymm14
	vxorps	%xmm0, %xmm0, %xmm0
	vpermd	%ymm2, %ymm11, %ymm0
	vshufps	$221, %ymm3, %ymm12, %ymm2
	vpaddd	%ymm2, %ymm14, %ymm1
	vxorps	%xmm12, %xmm12, %xmm12
	vpermd	%ymm1, %ymm11, %ymm12
	vpunpcklqdq	%ymm12, %ymm0, %ymm13
	vpunpckhqdq	%ymm12, %ymm0, %ymm0
	vmovdqu	%xmm13, (%r15,%r9,4)
	vextracti64x2	$0x1, %ymm13, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266752(,%r9,4)
	vextracti64x2	$0x1, %ymm0, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533504(,%r9,4)
	vmovdqa	%xmm0, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region(,%r9,4)
	addq	$4, %r9
	cmpq	%rdx, %r9
	jne	.L542
	movq	56(%rsp), %rdx
	movq	48(%rsp), %r9
	leaq	(%rdx,%r9,4), %r10
	movq	%r10, 56(%rsp)
	jmp	.L543
	.p2align 4,,10
	.p2align 3
.L731:
	movq	%rbx, %r10
	movq	16(%rsp), %r11
	movq	56(%rsp), %rbx
	movq	%rbx, %r14
	cmpq	%r11, %rcx
	jnb	.L541
	movl	$538976288, %eax
	movl	$808464432, %r13d
	vmovdqa	.LC9(%rip), %xmm4
	vmovdqa	.LC10(%rip), %xmm5
	vmovdqa	.LC11(%rip), %xmm8
	vpbroadcastd	%eax, %xmm6
	vpbroadcastd	%r13d, %xmm11
	.p2align 4,,10
	.p2align 3
.L540:
	vmovdqu	(%rcx), %xmm10
	incq	%r14
	vpminsb	%xmm6, %xmm10, %xmm7
	vpsubusb	%xmm11, %xmm10, %xmm1
	vpcmpeqb	%xmm7, %xmm10, %xmm15
	vpmovmskb	%xmm15, %r12d
	tzcntl	%r12d, %r9d
	incl	%r9d
	movq	%r9, %rdx
	addq	%r9, %rcx
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm1, %xmm12
	vmovdqa	%xmm14, %xmm2
	vpmaddubsw	%xmm4, %xmm12, %xmm13
	vporq	%ymm2, %ymm9, %ymm9
	vpmaddwd	%xmm5, %xmm13, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm3
	vpmaddwd	%xmm8, %xmm3, %xmm10
	vmovq	%xmm10, %rax
	imull	$100000000, %eax, %r13d
	shrq	$32, %rax
	addl	%r13d, %eax
	movl	%eax, -4(%r15,%r14,4)
	cmpq	%r11, %rcx
	jb	.L540
.L541:
	movq	32(%rsp), %rdx
	cmpq	$66687, %rbx
	movq	%rbx, %r12
	setbe	%r9b
	cmpq	%rdx, %rsi
	jnb	.L544
	testb	%r9b, %r9b
	je	.L544
	movl	$538976288, %eax
	movl	$808464432, %r13d
	vmovdqa	.LC9(%rip), %xmm4
	vmovdqa	.LC10(%rip), %xmm5
	vmovdqa	.LC11(%rip), %xmm8
	vpbroadcastd	%eax, %xmm7
	vpbroadcastd	%r13d, %xmm15
	testb	$1, %bl
	je	.L545
	vmovdqu	(%rsi), %xmm14
	vpminsb	%xmm7, %xmm14, %xmm6
	vpsubusb	%xmm15, %xmm14, %xmm12
	vpcmpeqb	%xmm6, %xmm14, %xmm11
	vpmovmskb	%xmm11, %r12d
	tzcntl	%r12d, %eax
	leaq	1(%rbx), %r12
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm2
	vpshufb	%xmm2, %xmm12, %xmm13
	vmovdqa	%xmm2, %xmm1
	vpmaddubsw	%xmm4, %xmm13, %xmm0
	vporq	%ymm1, %ymm9, %ymm9
	vpmaddwd	%xmm5, %xmm0, %xmm3
	vpackusdw	%xmm3, %xmm3, %xmm10
	vpmaddwd	%xmm8, %xmm10, %xmm14
	vmovq	%xmm14, %r13
	imull	$100000000, %r13d, %eax
	shrq	$32, %r13
	addl	%r13d, %eax
	movl	%eax, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r12,4)
	cmpq	32(%rsp), %rsi
	jnb	.L544
	movq	32(%rsp), %rdx
	cmpq	$66688, %r12
	jne	.L545
	jmp	.L544
	.p2align 4,,10
	.p2align 3
.L732:
	vmovdqu	(%rsi), %xmm1
	incq	%r12
	vpminsb	%xmm7, %xmm1, %xmm6
	vpsubusb	%xmm15, %xmm1, %xmm0
	vpcmpeqb	%xmm6, %xmm1, %xmm11
	vpmovmskb	%xmm11, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %r13
	addq	%rax, %rsi
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r13), %xmm12
	vpshufb	%xmm12, %xmm0, %xmm3
	vmovdqa	%xmm12, %xmm13
	vpmaddubsw	%xmm4, %xmm3, %xmm10
	vporq	%ymm13, %ymm9, %ymm9
	vpmaddwd	%xmm5, %xmm10, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm2
	vpmaddwd	%xmm8, %xmm2, %xmm1
	vmovq	%xmm1, %rax
	imull	$100000000, %eax, %r13d
	shrq	$32, %rax
	addl	%eax, %r13d
	movl	%r13d, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r12,4)
	cmpq	%rdx, %rsi
	jnb	.L544
	cmpq	$66688, %r12
	je	.L544
.L545:
	vmovdqu	(%rsi), %xmm2
	incq	%r12
	vpminsb	%xmm7, %xmm2, %xmm6
	vpsubusb	%xmm15, %xmm2, %xmm13
	vpcmpeqb	%xmm6, %xmm2, %xmm11
	vpmovmskb	%xmm11, %r13d
	tzcntl	%r13d, %eax
	incl	%eax
	movq	%rax, %r13
	addq	%rax, %rsi
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r13), %xmm1
	vpshufb	%xmm1, %xmm13, %xmm0
	vmovdqa	%xmm1, %xmm12
	vpmaddubsw	%xmm4, %xmm0, %xmm3
	vporq	%ymm12, %ymm9, %ymm9
	vpmaddwd	%xmm5, %xmm3, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm14
	vpmaddwd	%xmm8, %xmm14, %xmm2
	vmovq	%xmm2, %rax
	imull	$100000000, %eax, %r13d
	shrq	$32, %rax
	addl	%eax, %r13d
	movl	%r13d, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r12,4)
	cmpq	%rdx, %rsi
	jb	.L732
.L544:
	movq	24(%rsp), %rdx
	movq	%rbx, %r13
	cmpq	%rdx, %rdi
	jnb	.L547
	testb	%r9b, %r9b
	je	.L547
	movl	$538976288, %eax
	vmovdqa	.LC9(%rip), %xmm1
	vmovdqa	.LC10(%rip), %xmm2
	vpbroadcastd	%eax, %xmm7
	movl	$808464432, %eax
	vmovdqa	.LC11(%rip), %xmm3
	vpbroadcastd	%eax, %xmm10
	testb	$1, %bl
	jne	.L711
	movq	%r11, 56(%rsp)
	movq	%rdx, %r11
	jmp	.L548
	.p2align 4,,10
	.p2align 3
.L733:
	vmovdqu	(%rdi), %xmm8
	incq	%r13
	vpminsb	%xmm7, %xmm8, %xmm15
	vpsubusb	%xmm10, %xmm8, %xmm13
	vpcmpeqb	%xmm15, %xmm8, %xmm6
	vpmovmskb	%xmm6, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm12
	vpshufb	%xmm12, %xmm13, %xmm0
	vmovdqa	%xmm12, %xmm11
	vpmaddubsw	%xmm1, %xmm0, %xmm14
	vporq	%ymm11, %ymm9, %ymm9
	vpmaddwd	%xmm2, %xmm14, %xmm4
	vpackusdw	%xmm4, %xmm4, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm8
	vmovq	%xmm8, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	%r11, %rdi
	jnb	.L719
	cmpq	$66688, %r13
	je	.L719
.L548:
	vmovdqu	(%rdi), %xmm5
	incq	%r13
	vpminsb	%xmm7, %xmm5, %xmm8
	vpsubusb	%xmm10, %xmm5, %xmm12
	vpcmpeqb	%xmm8, %xmm5, %xmm15
	vpmovmskb	%xmm15, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm6
	vpshufb	%xmm6, %xmm12, %xmm13
	vmovdqa	%xmm6, %xmm11
	vpmaddubsw	%xmm1, %xmm13, %xmm0
	vporq	%ymm11, %ymm9, %ymm9
	vpmaddwd	%xmm2, %xmm0, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm4
	vpmaddwd	%xmm3, %xmm4, %xmm5
	vmovq	%xmm5, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	%r11, %rdi
	jb	.L733
.L719:
	movq	56(%rsp), %r11
.L547:
	movq	40(%rsp), %rdx
	cmpq	%rdx, %r8
	jnb	.L550
	testb	%r9b, %r9b
	je	.L550
	movl	$538976288, %r9d
	movl	$808464432, %eax
	vmovdqa	.LC9(%rip), %xmm1
	vmovdqa	.LC10(%rip), %xmm2
	vmovdqa	.LC11(%rip), %xmm3
	vpbroadcastd	%r9d, %xmm7
	vpbroadcastd	%eax, %xmm10
	testb	$1, %bl
	je	.L551
	vmovdqu	(%r8), %xmm15
	incq	%rbx
	vpminsb	%xmm7, %xmm15, %xmm6
	vpsubusb	%xmm10, %xmm15, %xmm0
	vpcmpeqb	%xmm6, %xmm15, %xmm12
	vpmovmskb	%xmm12, %edx
	tzcntl	%edx, %r9d
	incl	%r9d
	movq	%r9, %rax
	addq	%r9, %r8
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm13
	vpshufb	%xmm13, %xmm0, %xmm14
	vmovdqa	%xmm13, %xmm11
	vpmaddubsw	%xmm1, %xmm14, %xmm4
	vporq	%ymm11, %ymm9, %ymm9
	vpmaddwd	%xmm2, %xmm4, %xmm5
	vpackusdw	%xmm5, %xmm5, %xmm8
	vpmaddwd	%xmm3, %xmm8, %xmm15
	vmovq	%xmm15, %r9
	imull	$100000000, %r9d, %edx
	shrq	$32, %r9
	addl	%r9d, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	40(%rsp), %r8
	jnb	.L550
	movq	40(%rsp), %rdx
	cmpq	$66688, %rbx
	jne	.L551
	jmp	.L550
	.p2align 4,,10
	.p2align 3
.L734:
	vmovdqu	(%r8), %xmm13
	incq	%rbx
	vpminsb	%xmm7, %xmm13, %xmm6
	vpsubusb	%xmm10, %xmm13, %xmm0
	vpcmpeqb	%xmm6, %xmm13, %xmm14
	vpmovmskb	%xmm14, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %r9
	addq	%rax, %r8
	salq	$4, %r9
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r9), %xmm4
	vpshufb	%xmm4, %xmm0, %xmm5
	vmovdqa	%xmm4, %xmm11
	vpmaddubsw	%xmm1, %xmm5, %xmm8
	vporq	%ymm11, %ymm9, %ymm9
	vpmaddwd	%xmm2, %xmm8, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm12
	vpmaddwd	%xmm3, %xmm12, %xmm13
	vmovq	%xmm13, %rax
	imull	$100000000, %eax, %r9d
	shrq	$32, %rax
	addl	%eax, %r9d
	movl	%r9d, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%rdx, %r8
	jnb	.L550
	cmpq	$66688, %rbx
	je	.L550
.L551:
	vmovdqu	(%r8), %xmm12
	incq	%rbx
	vpminsb	%xmm7, %xmm12, %xmm6
	vpsubusb	%xmm10, %xmm12, %xmm0
	vpcmpeqb	%xmm6, %xmm12, %xmm13
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %r9
	addq	%rax, %r8
	salq	$4, %r9
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r9), %xmm14
	vpshufb	%xmm14, %xmm0, %xmm4
	vmovdqa	%xmm14, %xmm11
	vpmaddubsw	%xmm1, %xmm4, %xmm5
	vporq	%ymm11, %ymm9, %ymm9
	vpmaddwd	%xmm2, %xmm5, %xmm8
	vpackusdw	%xmm8, %xmm8, %xmm15
	vpmaddwd	%xmm3, %xmm15, %xmm12
	vmovq	%xmm12, %rax
	imull	$100000000, %eax, %r9d
	shrq	$32, %rax
	addl	%eax, %r9d
	movl	%r9d, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%rdx, %r8
	jb	.L734
.L550:
	cmpq	%rcx, %r11
	vpmovmskb	%ymm9, %eax
	setne	%r11b
	cmpq	%rsi, 32(%rsp)
	setne	%cl
	orl	%ecx, %r11d
	cmpq	%rdi, 24(%rsp)
	setne	%sil
	andl	$-2147450880, %eax
	xorl	%edx, %edx
	orl	%esi, %r11d
	cmpq	%r8, 40(%rsp)
	setne	%dl
	movzbl	%r11b, %edi
	orl	%edx, %eax
	orl	%eax, %edi
	jne	.L735
	vzeroupper
	leaq	(%r15,%r14,4), %rdi
	leaq	0(,%r12,4), %rdx
	movl	$_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region, %esi
	addq	%r14, %r12
	call	memcpy
	leaq	(%r15,%r12,4), %rdi
	leaq	0(,%r13,4), %rdx
	movl	$_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266752, %esi
	call	memcpy
	addq	%r13, %r12
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533504, %esi
	leaq	(%r15,%r12,4), %rdi
	addq	%rbx, %r12
	call	memcpy
	subq	%r12, 8(%rsp)
	vmovdqa	.LC5(%rip), %ymm8
	leaq	(%r15,%r12,4), %r15
	vmovdqa	.LC4(%rip), %ymm4
	vmovdqa	.LC3(%rip), %ymm5
.L562:
	cmpq	$133312, 8(%rsp)
	jbe	.L729
.L555:
	movq	40(%rsp), %r10
	jmp	.L563
.L711:
	vmovdqu	(%rdi), %xmm4
	vpminsb	%xmm7, %xmm4, %xmm5
	vpsubusb	%xmm10, %xmm4, %xmm11
	vpcmpeqb	%xmm5, %xmm4, %xmm8
	vpmovmskb	%xmm8, %r13d
	tzcntl	%r13d, %eax
	leaq	1(%rbx), %r13
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm15
	vpshufb	%xmm15, %xmm11, %xmm12
	vmovdqa	%xmm15, %xmm6
	vpmaddubsw	%xmm1, %xmm12, %xmm13
	vporq	%ymm6, %ymm9, %ymm9
	vpmaddwd	%xmm2, %xmm13, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm14
	vpmaddwd	%xmm3, %xmm14, %xmm4
	vmovq	%xmm4, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	24(%rsp), %rdi
	jnb	.L547
	cmpq	$66688, %r13
	je	.L547
	movq	%r11, 56(%rsp)
	movq	24(%rsp), %r11
	jmp	.L548
.L729:
	vzeroupper
.L538:
	movq	8(%rsp), %rdx
	movq	40(%rsp), %rdi
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
.L735:
	.cfi_restore_state
	cmpq	40(%rsp), %r10
	jnb	.L736
	movq	40(%rsp), %r12
	leaq	1(%r10), %r8
	leaq	-1(%r12), %rsi
	cmpq	%rsi, %r10
	cmovbe	%r10, %rsi
	xorl	%ebx, %ebx
	movq	%rsi, %r13
	subq	%r10, %r13
	andl	$7, %r13d
	cmpb	$32, (%r10)
	setg	%bl
	movq	%rbx, %rdx
	cmpq	%r8, %rsi
	jnb	.L737
.L715:
	movq	%rsi, %r8
	xorl	%edi, %edi
	movq	40(%rsp), %r12
	subq	%r10, %r8
	cmpq	%r10, %rsi
	cmovb	%rdi, %r8
	leaq	1(%r10,%r8), %rsi
	cmpq	%r12, %rsi
	jnb	.L561
	movq	%rsi, %r13
	notq	%r13
	addq	%r12, %r13
	andl	$7, %r13d
	cmpb	$32, (%rsi)
	jg	.L738
.L594:
	leaq	1(%rsi), %rax
	cmpq	40(%rsp), %rax
	jnb	.L561
	testq	%r13, %r13
	je	.L560
	cmpq	$1, %r13
	je	.L665
	cmpq	$2, %r13
	je	.L666
	cmpq	$3, %r13
	je	.L667
	cmpq	$4, %r13
	je	.L668
	cmpq	$5, %r13
	je	.L669
	cmpq	$6, %r13
	je	.L670
	cmpb	$32, 1(%rsi)
	jg	.L739
.L596:
	incq	%rax
.L670:
	cmpb	$32, (%rax)
	jle	.L599
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
.L599:
	incq	%rax
.L669:
	cmpb	$32, (%rax)
	jg	.L740
.L602:
	incq	%rax
.L668:
	cmpb	$32, (%rax)
	jg	.L741
.L605:
	incq	%rax
.L667:
	cmpb	$32, (%rax)
	jg	.L742
.L608:
	incq	%rax
.L666:
	cmpb	$32, (%rax)
	jle	.L611
	xorl	%edi, %edi
	cmpb	$32, -1(%rax)
	setle	%dil
	addq	%rdi, %rdx
.L611:
	incq	%rax
.L665:
	cmpb	$32, (%rax)
	jle	.L614
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L614:
	incq	%rax
	cmpq	40(%rsp), %rax
	jnb	.L561
.L560:
	cmpb	$32, (%rax)
	jle	.L559
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
.L559:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %r13
	jle	.L617
	xorl	%eax, %eax
	cmpb	$32, -1(%r13)
	setle	%al
	addq	%rax, %rdx
.L617:
	cmpb	$32, 1(%r13)
	jle	.L619
	xorl	%ebx, %ebx
	cmpb	$32, 0(%r13)
	setle	%bl
	addq	%rbx, %rdx
.L619:
	cmpb	$32, 2(%r13)
	jle	.L621
	xorl	%r14d, %r14d
	cmpb	$32, 1(%r13)
	setle	%r14b
	addq	%r14, %rdx
.L621:
	cmpb	$32, 3(%r13)
	jle	.L623
	xorl	%r9d, %r9d
	cmpb	$32, 2(%r13)
	setle	%r9b
	addq	%r9, %rdx
.L623:
	cmpb	$32, 4(%r13)
	jle	.L625
	xorl	%r11d, %r11d
	cmpb	$32, 3(%r13)
	setle	%r11b
	addq	%r11, %rdx
.L625:
	cmpb	$32, 5(%r13)
	jle	.L627
	xorl	%ecx, %ecx
	cmpb	$32, 4(%r13)
	setle	%cl
	addq	%rcx, %rdx
.L627:
	cmpb	$32, 6(%r13)
	jle	.L629
	xorl	%r8d, %r8d
	cmpb	$32, 5(%r13)
	setle	%r8b
	addq	%r8, %rdx
.L629:
	leaq	7(%r13), %rax
	cmpq	40(%rsp), %rax
	jb	.L560
.L561:
	subq	%rdx, 8(%rsp)
	movq	%r15, %rsi
	leaq	(%r15,%rdx,4), %r15
	movq	%r10, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm4
	vmovdqa	.LC5(%rip), %ymm8
	jmp	.L562
.L738:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rsi)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L594
.L737:
	testq	%r13, %r13
	je	.L557
	cmpq	$1, %r13
	je	.L671
	cmpq	$2, %r13
	je	.L672
	cmpq	$3, %r13
	je	.L673
	cmpq	$4, %r13
	je	.L674
	cmpq	$5, %r13
	je	.L675
	cmpq	$6, %r13
	jne	.L743
.L676:
	xorl	%r14d, %r14d
	cmpb	$32, (%r8)
	setg	%r14b
	incq	%r8
	addq	%r14, %rdx
.L675:
	xorl	%r9d, %r9d
	cmpb	$32, (%r8)
	setg	%r9b
	incq	%r8
	addq	%r9, %rdx
.L674:
	xorl	%eax, %eax
	cmpb	$32, (%r8)
	setg	%al
	incq	%r8
	addq	%rax, %rdx
.L673:
	xorl	%r11d, %r11d
	cmpb	$32, (%r8)
	setg	%r11b
	incq	%r8
	addq	%r11, %rdx
.L672:
	xorl	%ecx, %ecx
	cmpb	$32, (%r8)
	setg	%cl
	incq	%r8
	addq	%rcx, %rdx
.L671:
	xorl	%edi, %edi
	cmpb	$32, (%r8)
	setg	%dil
	incq	%r8
	addq	%rdi, %rdx
	cmpq	%r8, %rsi
	jb	.L715
.L557:
	xorl	%r12d, %r12d
	cmpb	$32, (%r8)
	setg	%r12b
	xorl	%r13d, %r13d
	addq	%r12, %rdx
	cmpb	$32, 1(%r8)
	setg	%r13b
	xorl	%ebx, %ebx
	addq	%r13, %rdx
	cmpb	$32, 2(%r8)
	setg	%bl
	xorl	%r14d, %r14d
	addq	%rbx, %rdx
	cmpb	$32, 3(%r8)
	setg	%r14b
	xorl	%r9d, %r9d
	addq	%r14, %rdx
	cmpb	$32, 4(%r8)
	setg	%r9b
	xorl	%eax, %eax
	addq	%r9, %rdx
	cmpb	$32, 5(%r8)
	setg	%al
	xorl	%r11d, %r11d
	addq	%rax, %rdx
	cmpb	$32, 6(%r8)
	setg	%r11b
	xorl	%ecx, %ecx
	addq	%r11, %rdx
	cmpb	$32, 7(%r8)
	setg	%cl
	addq	$8, %r8
	addq	%rcx, %rdx
	cmpq	%r8, %rsi
	jb	.L715
	jmp	.L557
	.p2align 4,,10
	.p2align 3
.L742:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L608
.L741:
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
	jmp	.L605
.L740:
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rax)
	setle	%r11b
	addq	%r11, %rdx
	jmp	.L602
.L564:
	movq	%rdi, 40(%rsp)
	jmp	.L538
.L736:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r10, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm4
	vmovdqa	.LC5(%rip), %ymm8
	jmp	.L555
.L739:
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
	jmp	.L596
.L743:
	xorl	%edx, %edx
	cmpb	$32, 1(%r10)
	setg	%dl
	incq	%r8
	addq	%rbx, %rdx
	jmp	.L676
	.cfi_endproc
.LFE8992:
	.size	_ZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_.isra.0, .-_ZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_.isra.0
	.p2align 4
	.globl	_Z12probe_formatPKjPcm
	.type	_Z12probe_formatPKjPcm, @function
_Z12probe_formatPKjPcm:
.LFB8934:
	.cfi_startproc
	cmpq	$31, %rdx
	jbe	.L750
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
	vmovdqa32	.LC18(%rip), %ymm20
	vmovdqa32	.LC19(%rip), %ymm19
	vmovdqa	%ymm4, 40(%rsp)
	vmovdqa64	.LC36(%rip), %ymm29
	vmovdqa64	.LC37(%rip), %ymm18
	vmovdqa	%ymm6, 8(%rsp)
	vmovdqa64	.LC38(%rip), %ymm28
	vmovdqa64	.LC39(%rip), %ymm17
	vmovdqa	%ymm7, -24(%rsp)
	vmovdqa64	.LC40(%rip), %ymm27
	.p2align 4,,10
	.p2align 3
.L746:
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
	vpshufb	.LC41(%rip), %ymm10, %ymm10
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
	vpshufb	.LC41(%rip), %ymm9, %ymm9
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
	vpshufb	.LC41(%rip), %ymm11, %ymm11
	vporq	%ymm7, %ymm3, %ymm6
	vporq	%ymm10, %ymm14, %ymm13
	vporq	%ymm11, %ymm4, %ymm3
	vporq	%ymm12, %ymm8, %ymm9
	vmovdqu	%xmm6, -160(%rax)
	vpshufb	%ymm18, %ymm0, %ymm4
	vmovdqu	%xmm13, -150(%rax)
	vpshufb	%ymm28, %ymm5, %ymm8
	vpshufb	%ymm27, %ymm5, %ymm11
	vpshufb	.LC41(%rip), %ymm5, %ymm7
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
	jnb	.L746
	vzeroupper
	leave
	.cfi_def_cfa 7, 8
	ret
.L750:
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE8934:
	.size	_Z12probe_formatPKjPcm, .-_Z12probe_formatPKjPcm
	.p2align 4
	.globl	_Z12probe_parse4PcPjm
	.type	_Z12probe_parse4PcPjm, @function
_Z12probe_parse4PcPjm:
.LFB8952:
	.cfi_startproc
	jmp	_ZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_.isra.0
	.cfi_endproc
.LFE8952:
	.size	_Z12probe_parse4PcPjm, .-_Z12probe_parse4PcPjm
	.p2align 4
	.globl	_Z16probe_format_asmPKjPcm
	.type	_Z16probe_format_asmPKjPcm, @function
_Z16probe_format_asmPKjPcm:
.LFB8953:
	.cfi_startproc
	movq	%rdx, %r10
	cmpq	$31, %rdx
	jbe	.L794
	leaq	-32(%rdx), %r9
	movl	$_ZN10qp_fmt_asm6constsE, %ecx
	shrq	$5, %r9
	andl	$7, %r9d
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rdi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rsi)
	vmovdqu %xmm5, (0+10)(%rsi)
	vmovdqu %xmm6, (0+20)(%rsi)
	vmovdqu %xmm7, (0+30)(%rsi)
	vextracti128 $1, %ymm4, (0+40)(%rsi)
	vextracti128 $1, %ymm5, (0+50)(%rsi)
	vextracti128 $1, %ymm6, (0+60)(%rsi)
	vextracti128 $1, %ymm7, (0+70)(%rsi)
	vmovdqu 32(%rdi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rsi)
	vmovdqu %xmm5, (80+10)(%rsi)
	vmovdqu %xmm6, (80+20)(%rsi)
	vmovdqu %xmm7, (80+30)(%rsi)
	vextracti128 $1, %ymm4, (80+40)(%rsi)
	vextracti128 $1, %ymm5, (80+50)(%rsi)
	vextracti128 $1, %ymm6, (80+60)(%rsi)
	vextracti128 $1, %ymm7, (80+70)(%rsi)
	vmovdqu 64(%rdi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rsi)
	vmovdqu %xmm5, (160+10)(%rsi)
	vmovdqu %xmm6, (160+20)(%rsi)
	vmovdqu %xmm7, (160+30)(%rsi)
	vextracti128 $1, %ymm4, (160+40)(%rsi)
	vextracti128 $1, %ymm5, (160+50)(%rsi)
	vextracti128 $1, %ymm6, (160+60)(%rsi)
	vextracti128 $1, %ymm7, (160+70)(%rsi)
	vmovdqu 96(%rdi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rsi)
	vmovdqu %xmm5, (240+10)(%rsi)
	vmovdqu %xmm6, (240+20)(%rsi)
	vmovdqu %xmm7, (240+30)(%rsi)
	vextracti128 $1, %ymm4, (240+40)(%rsi)
	vextracti128 $1, %ymm5, (240+50)(%rsi)
	vextracti128 $1, %ymm6, (240+60)(%rsi)
	vextracti128 $1, %ymm7, (240+70)(%rsi)
	
# 0 "" 2
#NO_APP
	movl	$64, %r8d
	leaq	320(%rsi), %rdx
	leaq	128(%rdi), %rax
	cmpq	$64, %r10
	jb	.L795
	testq	%r9, %r9
	je	.L756
	cmpq	$1, %r9
	je	.L781
	cmpq	$2, %r9
	je	.L782
	cmpq	$3, %r9
	je	.L783
	cmpq	$4, %r9
	je	.L784
	cmpq	$5, %r9
	je	.L785
	cmpq	$6, %r9
	je	.L786
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdx)
	vmovdqu %xmm5, (0+10)(%rdx)
	vmovdqu %xmm6, (0+20)(%rdx)
	vmovdqu %xmm7, (0+30)(%rdx)
	vextracti128 $1, %ymm4, (0+40)(%rdx)
	vextracti128 $1, %ymm5, (0+50)(%rdx)
	vextracti128 $1, %ymm6, (0+60)(%rdx)
	vextracti128 $1, %ymm7, (0+70)(%rdx)
	vmovdqu 32(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdx)
	vmovdqu %xmm5, (80+10)(%rdx)
	vmovdqu %xmm6, (80+20)(%rdx)
	vmovdqu %xmm7, (80+30)(%rdx)
	vextracti128 $1, %ymm4, (80+40)(%rdx)
	vextracti128 $1, %ymm5, (80+50)(%rdx)
	vextracti128 $1, %ymm6, (80+60)(%rdx)
	vextracti128 $1, %ymm7, (80+70)(%rdx)
	vmovdqu 64(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdx)
	vmovdqu %xmm5, (160+10)(%rdx)
	vmovdqu %xmm6, (160+20)(%rdx)
	vmovdqu %xmm7, (160+30)(%rdx)
	vextracti128 $1, %ymm4, (160+40)(%rdx)
	vextracti128 $1, %ymm5, (160+50)(%rdx)
	vextracti128 $1, %ymm6, (160+60)(%rdx)
	vextracti128 $1, %ymm7, (160+70)(%rdx)
	vmovdqu 96(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdx)
	vmovdqu %xmm5, (240+10)(%rdx)
	vmovdqu %xmm6, (240+20)(%rdx)
	vmovdqu %xmm7, (240+30)(%rdx)
	vextracti128 $1, %ymm4, (240+40)(%rdx)
	vextracti128 $1, %ymm5, (240+50)(%rdx)
	vextracti128 $1, %ymm6, (240+60)(%rdx)
	vextracti128 $1, %ymm7, (240+70)(%rdx)
	
# 0 "" 2
#NO_APP
	movl	$96, %r8d
	leaq	640(%rsi), %rdx
	leaq	256(%rdi), %rax
.L786:
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdx)
	vmovdqu %xmm5, (0+10)(%rdx)
	vmovdqu %xmm6, (0+20)(%rdx)
	vmovdqu %xmm7, (0+30)(%rdx)
	vextracti128 $1, %ymm4, (0+40)(%rdx)
	vextracti128 $1, %ymm5, (0+50)(%rdx)
	vextracti128 $1, %ymm6, (0+60)(%rdx)
	vextracti128 $1, %ymm7, (0+70)(%rdx)
	vmovdqu 32(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdx)
	vmovdqu %xmm5, (80+10)(%rdx)
	vmovdqu %xmm6, (80+20)(%rdx)
	vmovdqu %xmm7, (80+30)(%rdx)
	vextracti128 $1, %ymm4, (80+40)(%rdx)
	vextracti128 $1, %ymm5, (80+50)(%rdx)
	vextracti128 $1, %ymm6, (80+60)(%rdx)
	vextracti128 $1, %ymm7, (80+70)(%rdx)
	vmovdqu 64(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdx)
	vmovdqu %xmm5, (160+10)(%rdx)
	vmovdqu %xmm6, (160+20)(%rdx)
	vmovdqu %xmm7, (160+30)(%rdx)
	vextracti128 $1, %ymm4, (160+40)(%rdx)
	vextracti128 $1, %ymm5, (160+50)(%rdx)
	vextracti128 $1, %ymm6, (160+60)(%rdx)
	vextracti128 $1, %ymm7, (160+70)(%rdx)
	vmovdqu 96(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdx)
	vmovdqu %xmm5, (240+10)(%rdx)
	vmovdqu %xmm6, (240+20)(%rdx)
	vmovdqu %xmm7, (240+30)(%rdx)
	vextracti128 $1, %ymm4, (240+40)(%rdx)
	vextracti128 $1, %ymm5, (240+50)(%rdx)
	vextracti128 $1, %ymm6, (240+60)(%rdx)
	vextracti128 $1, %ymm7, (240+70)(%rdx)
	
# 0 "" 2
#NO_APP
	addq	$320, %rdx
	addq	$32, %r8
	subq	$-128, %rax
.L785:
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdx)
	vmovdqu %xmm5, (0+10)(%rdx)
	vmovdqu %xmm6, (0+20)(%rdx)
	vmovdqu %xmm7, (0+30)(%rdx)
	vextracti128 $1, %ymm4, (0+40)(%rdx)
	vextracti128 $1, %ymm5, (0+50)(%rdx)
	vextracti128 $1, %ymm6, (0+60)(%rdx)
	vextracti128 $1, %ymm7, (0+70)(%rdx)
	vmovdqu 32(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdx)
	vmovdqu %xmm5, (80+10)(%rdx)
	vmovdqu %xmm6, (80+20)(%rdx)
	vmovdqu %xmm7, (80+30)(%rdx)
	vextracti128 $1, %ymm4, (80+40)(%rdx)
	vextracti128 $1, %ymm5, (80+50)(%rdx)
	vextracti128 $1, %ymm6, (80+60)(%rdx)
	vextracti128 $1, %ymm7, (80+70)(%rdx)
	vmovdqu 64(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdx)
	vmovdqu %xmm5, (160+10)(%rdx)
	vmovdqu %xmm6, (160+20)(%rdx)
	vmovdqu %xmm7, (160+30)(%rdx)
	vextracti128 $1, %ymm4, (160+40)(%rdx)
	vextracti128 $1, %ymm5, (160+50)(%rdx)
	vextracti128 $1, %ymm6, (160+60)(%rdx)
	vextracti128 $1, %ymm7, (160+70)(%rdx)
	vmovdqu 96(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdx)
	vmovdqu %xmm5, (240+10)(%rdx)
	vmovdqu %xmm6, (240+20)(%rdx)
	vmovdqu %xmm7, (240+30)(%rdx)
	vextracti128 $1, %ymm4, (240+40)(%rdx)
	vextracti128 $1, %ymm5, (240+50)(%rdx)
	vextracti128 $1, %ymm6, (240+60)(%rdx)
	vextracti128 $1, %ymm7, (240+70)(%rdx)
	
# 0 "" 2
#NO_APP
	addq	$320, %rdx
	addq	$32, %r8
	subq	$-128, %rax
.L784:
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdx)
	vmovdqu %xmm5, (0+10)(%rdx)
	vmovdqu %xmm6, (0+20)(%rdx)
	vmovdqu %xmm7, (0+30)(%rdx)
	vextracti128 $1, %ymm4, (0+40)(%rdx)
	vextracti128 $1, %ymm5, (0+50)(%rdx)
	vextracti128 $1, %ymm6, (0+60)(%rdx)
	vextracti128 $1, %ymm7, (0+70)(%rdx)
	vmovdqu 32(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdx)
	vmovdqu %xmm5, (80+10)(%rdx)
	vmovdqu %xmm6, (80+20)(%rdx)
	vmovdqu %xmm7, (80+30)(%rdx)
	vextracti128 $1, %ymm4, (80+40)(%rdx)
	vextracti128 $1, %ymm5, (80+50)(%rdx)
	vextracti128 $1, %ymm6, (80+60)(%rdx)
	vextracti128 $1, %ymm7, (80+70)(%rdx)
	vmovdqu 64(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdx)
	vmovdqu %xmm5, (160+10)(%rdx)
	vmovdqu %xmm6, (160+20)(%rdx)
	vmovdqu %xmm7, (160+30)(%rdx)
	vextracti128 $1, %ymm4, (160+40)(%rdx)
	vextracti128 $1, %ymm5, (160+50)(%rdx)
	vextracti128 $1, %ymm6, (160+60)(%rdx)
	vextracti128 $1, %ymm7, (160+70)(%rdx)
	vmovdqu 96(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdx)
	vmovdqu %xmm5, (240+10)(%rdx)
	vmovdqu %xmm6, (240+20)(%rdx)
	vmovdqu %xmm7, (240+30)(%rdx)
	vextracti128 $1, %ymm4, (240+40)(%rdx)
	vextracti128 $1, %ymm5, (240+50)(%rdx)
	vextracti128 $1, %ymm6, (240+60)(%rdx)
	vextracti128 $1, %ymm7, (240+70)(%rdx)
	
# 0 "" 2
#NO_APP
	addq	$320, %rdx
	addq	$32, %r8
	subq	$-128, %rax
.L783:
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdx)
	vmovdqu %xmm5, (0+10)(%rdx)
	vmovdqu %xmm6, (0+20)(%rdx)
	vmovdqu %xmm7, (0+30)(%rdx)
	vextracti128 $1, %ymm4, (0+40)(%rdx)
	vextracti128 $1, %ymm5, (0+50)(%rdx)
	vextracti128 $1, %ymm6, (0+60)(%rdx)
	vextracti128 $1, %ymm7, (0+70)(%rdx)
	vmovdqu 32(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdx)
	vmovdqu %xmm5, (80+10)(%rdx)
	vmovdqu %xmm6, (80+20)(%rdx)
	vmovdqu %xmm7, (80+30)(%rdx)
	vextracti128 $1, %ymm4, (80+40)(%rdx)
	vextracti128 $1, %ymm5, (80+50)(%rdx)
	vextracti128 $1, %ymm6, (80+60)(%rdx)
	vextracti128 $1, %ymm7, (80+70)(%rdx)
	vmovdqu 64(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdx)
	vmovdqu %xmm5, (160+10)(%rdx)
	vmovdqu %xmm6, (160+20)(%rdx)
	vmovdqu %xmm7, (160+30)(%rdx)
	vextracti128 $1, %ymm4, (160+40)(%rdx)
	vextracti128 $1, %ymm5, (160+50)(%rdx)
	vextracti128 $1, %ymm6, (160+60)(%rdx)
	vextracti128 $1, %ymm7, (160+70)(%rdx)
	vmovdqu 96(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdx)
	vmovdqu %xmm5, (240+10)(%rdx)
	vmovdqu %xmm6, (240+20)(%rdx)
	vmovdqu %xmm7, (240+30)(%rdx)
	vextracti128 $1, %ymm4, (240+40)(%rdx)
	vextracti128 $1, %ymm5, (240+50)(%rdx)
	vextracti128 $1, %ymm6, (240+60)(%rdx)
	vextracti128 $1, %ymm7, (240+70)(%rdx)
	
# 0 "" 2
#NO_APP
	addq	$320, %rdx
	addq	$32, %r8
	subq	$-128, %rax
.L782:
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdx)
	vmovdqu %xmm5, (0+10)(%rdx)
	vmovdqu %xmm6, (0+20)(%rdx)
	vmovdqu %xmm7, (0+30)(%rdx)
	vextracti128 $1, %ymm4, (0+40)(%rdx)
	vextracti128 $1, %ymm5, (0+50)(%rdx)
	vextracti128 $1, %ymm6, (0+60)(%rdx)
	vextracti128 $1, %ymm7, (0+70)(%rdx)
	vmovdqu 32(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdx)
	vmovdqu %xmm5, (80+10)(%rdx)
	vmovdqu %xmm6, (80+20)(%rdx)
	vmovdqu %xmm7, (80+30)(%rdx)
	vextracti128 $1, %ymm4, (80+40)(%rdx)
	vextracti128 $1, %ymm5, (80+50)(%rdx)
	vextracti128 $1, %ymm6, (80+60)(%rdx)
	vextracti128 $1, %ymm7, (80+70)(%rdx)
	vmovdqu 64(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdx)
	vmovdqu %xmm5, (160+10)(%rdx)
	vmovdqu %xmm6, (160+20)(%rdx)
	vmovdqu %xmm7, (160+30)(%rdx)
	vextracti128 $1, %ymm4, (160+40)(%rdx)
	vextracti128 $1, %ymm5, (160+50)(%rdx)
	vextracti128 $1, %ymm6, (160+60)(%rdx)
	vextracti128 $1, %ymm7, (160+70)(%rdx)
	vmovdqu 96(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdx)
	vmovdqu %xmm5, (240+10)(%rdx)
	vmovdqu %xmm6, (240+20)(%rdx)
	vmovdqu %xmm7, (240+30)(%rdx)
	vextracti128 $1, %ymm4, (240+40)(%rdx)
	vextracti128 $1, %ymm5, (240+50)(%rdx)
	vextracti128 $1, %ymm6, (240+60)(%rdx)
	vextracti128 $1, %ymm7, (240+70)(%rdx)
	
# 0 "" 2
#NO_APP
	addq	$320, %rdx
	addq	$32, %r8
	subq	$-128, %rax
.L781:
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdx)
	vmovdqu %xmm5, (0+10)(%rdx)
	vmovdqu %xmm6, (0+20)(%rdx)
	vmovdqu %xmm7, (0+30)(%rdx)
	vextracti128 $1, %ymm4, (0+40)(%rdx)
	vextracti128 $1, %ymm5, (0+50)(%rdx)
	vextracti128 $1, %ymm6, (0+60)(%rdx)
	vextracti128 $1, %ymm7, (0+70)(%rdx)
	vmovdqu 32(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdx)
	vmovdqu %xmm5, (80+10)(%rdx)
	vmovdqu %xmm6, (80+20)(%rdx)
	vmovdqu %xmm7, (80+30)(%rdx)
	vextracti128 $1, %ymm4, (80+40)(%rdx)
	vextracti128 $1, %ymm5, (80+50)(%rdx)
	vextracti128 $1, %ymm6, (80+60)(%rdx)
	vextracti128 $1, %ymm7, (80+70)(%rdx)
	vmovdqu 64(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdx)
	vmovdqu %xmm5, (160+10)(%rdx)
	vmovdqu %xmm6, (160+20)(%rdx)
	vmovdqu %xmm7, (160+30)(%rdx)
	vextracti128 $1, %ymm4, (160+40)(%rdx)
	vextracti128 $1, %ymm5, (160+50)(%rdx)
	vextracti128 $1, %ymm6, (160+60)(%rdx)
	vextracti128 $1, %ymm7, (160+70)(%rdx)
	vmovdqu 96(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdx)
	vmovdqu %xmm5, (240+10)(%rdx)
	vmovdqu %xmm6, (240+20)(%rdx)
	vmovdqu %xmm7, (240+30)(%rdx)
	vextracti128 $1, %ymm4, (240+40)(%rdx)
	vextracti128 $1, %ymm5, (240+50)(%rdx)
	vextracti128 $1, %ymm6, (240+60)(%rdx)
	vextracti128 $1, %ymm7, (240+70)(%rdx)
	
# 0 "" 2
#NO_APP
	addq	$32, %r8
	addq	$320, %rdx
	subq	$-128, %rax
	cmpq	%r8, %r10
	jb	.L795
.L756:
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdx)
	vmovdqu %xmm5, (0+10)(%rdx)
	vmovdqu %xmm6, (0+20)(%rdx)
	vmovdqu %xmm7, (0+30)(%rdx)
	vextracti128 $1, %ymm4, (0+40)(%rdx)
	vextracti128 $1, %ymm5, (0+50)(%rdx)
	vextracti128 $1, %ymm6, (0+60)(%rdx)
	vextracti128 $1, %ymm7, (0+70)(%rdx)
	vmovdqu 32(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdx)
	vmovdqu %xmm5, (80+10)(%rdx)
	vmovdqu %xmm6, (80+20)(%rdx)
	vmovdqu %xmm7, (80+30)(%rdx)
	vextracti128 $1, %ymm4, (80+40)(%rdx)
	vextracti128 $1, %ymm5, (80+50)(%rdx)
	vextracti128 $1, %ymm6, (80+60)(%rdx)
	vextracti128 $1, %ymm7, (80+70)(%rdx)
	vmovdqu 64(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdx)
	vmovdqu %xmm5, (160+10)(%rdx)
	vmovdqu %xmm6, (160+20)(%rdx)
	vmovdqu %xmm7, (160+30)(%rdx)
	vextracti128 $1, %ymm4, (160+40)(%rdx)
	vextracti128 $1, %ymm5, (160+50)(%rdx)
	vextracti128 $1, %ymm6, (160+60)(%rdx)
	vextracti128 $1, %ymm7, (160+70)(%rdx)
	vmovdqu 96(%rax), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdx)
	vmovdqu %xmm5, (240+10)(%rdx)
	vmovdqu %xmm6, (240+20)(%rdx)
	vmovdqu %xmm7, (240+30)(%rdx)
	vextracti128 $1, %ymm4, (240+40)(%rdx)
	vextracti128 $1, %ymm5, (240+50)(%rdx)
	vextracti128 $1, %ymm6, (240+60)(%rdx)
	vextracti128 $1, %ymm7, (240+70)(%rdx)
	
# 0 "" 2
#NO_APP
	leaq	320(%rdx), %rdi
	leaq	128(%rax), %rsi
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdi)
	vmovdqu %xmm5, (0+10)(%rdi)
	vmovdqu %xmm6, (0+20)(%rdi)
	vmovdqu %xmm7, (0+30)(%rdi)
	vextracti128 $1, %ymm4, (0+40)(%rdi)
	vextracti128 $1, %ymm5, (0+50)(%rdi)
	vextracti128 $1, %ymm6, (0+60)(%rdi)
	vextracti128 $1, %ymm7, (0+70)(%rdi)
	vmovdqu 32(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdi)
	vmovdqu %xmm5, (80+10)(%rdi)
	vmovdqu %xmm6, (80+20)(%rdi)
	vmovdqu %xmm7, (80+30)(%rdi)
	vextracti128 $1, %ymm4, (80+40)(%rdi)
	vextracti128 $1, %ymm5, (80+50)(%rdi)
	vextracti128 $1, %ymm6, (80+60)(%rdi)
	vextracti128 $1, %ymm7, (80+70)(%rdi)
	vmovdqu 64(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdi)
	vmovdqu %xmm5, (160+10)(%rdi)
	vmovdqu %xmm6, (160+20)(%rdi)
	vmovdqu %xmm7, (160+30)(%rdi)
	vextracti128 $1, %ymm4, (160+40)(%rdi)
	vextracti128 $1, %ymm5, (160+50)(%rdi)
	vextracti128 $1, %ymm6, (160+60)(%rdi)
	vextracti128 $1, %ymm7, (160+70)(%rdi)
	vmovdqu 96(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdi)
	vmovdqu %xmm5, (240+10)(%rdi)
	vmovdqu %xmm6, (240+20)(%rdi)
	vmovdqu %xmm7, (240+30)(%rdi)
	vextracti128 $1, %ymm4, (240+40)(%rdi)
	vextracti128 $1, %ymm5, (240+50)(%rdi)
	vextracti128 $1, %ymm6, (240+60)(%rdi)
	vextracti128 $1, %ymm7, (240+70)(%rdi)
	
# 0 "" 2
#NO_APP
	leaq	640(%rdx), %r11
	leaq	256(%rax), %r9
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%r11)
	vmovdqu %xmm5, (0+10)(%r11)
	vmovdqu %xmm6, (0+20)(%r11)
	vmovdqu %xmm7, (0+30)(%r11)
	vextracti128 $1, %ymm4, (0+40)(%r11)
	vextracti128 $1, %ymm5, (0+50)(%r11)
	vextracti128 $1, %ymm6, (0+60)(%r11)
	vextracti128 $1, %ymm7, (0+70)(%r11)
	vmovdqu 32(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%r11)
	vmovdqu %xmm5, (80+10)(%r11)
	vmovdqu %xmm6, (80+20)(%r11)
	vmovdqu %xmm7, (80+30)(%r11)
	vextracti128 $1, %ymm4, (80+40)(%r11)
	vextracti128 $1, %ymm5, (80+50)(%r11)
	vextracti128 $1, %ymm6, (80+60)(%r11)
	vextracti128 $1, %ymm7, (80+70)(%r11)
	vmovdqu 64(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%r11)
	vmovdqu %xmm5, (160+10)(%r11)
	vmovdqu %xmm6, (160+20)(%r11)
	vmovdqu %xmm7, (160+30)(%r11)
	vextracti128 $1, %ymm4, (160+40)(%r11)
	vextracti128 $1, %ymm5, (160+50)(%r11)
	vextracti128 $1, %ymm6, (160+60)(%r11)
	vextracti128 $1, %ymm7, (160+70)(%r11)
	vmovdqu 96(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%r11)
	vmovdqu %xmm5, (240+10)(%r11)
	vmovdqu %xmm6, (240+20)(%r11)
	vmovdqu %xmm7, (240+30)(%r11)
	vextracti128 $1, %ymm4, (240+40)(%r11)
	vextracti128 $1, %ymm5, (240+50)(%r11)
	vextracti128 $1, %ymm6, (240+60)(%r11)
	vextracti128 $1, %ymm7, (240+70)(%r11)
	
# 0 "" 2
#NO_APP
	leaq	960(%rdx), %rdi
	leaq	384(%rax), %rsi
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdi)
	vmovdqu %xmm5, (0+10)(%rdi)
	vmovdqu %xmm6, (0+20)(%rdi)
	vmovdqu %xmm7, (0+30)(%rdi)
	vextracti128 $1, %ymm4, (0+40)(%rdi)
	vextracti128 $1, %ymm5, (0+50)(%rdi)
	vextracti128 $1, %ymm6, (0+60)(%rdi)
	vextracti128 $1, %ymm7, (0+70)(%rdi)
	vmovdqu 32(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdi)
	vmovdqu %xmm5, (80+10)(%rdi)
	vmovdqu %xmm6, (80+20)(%rdi)
	vmovdqu %xmm7, (80+30)(%rdi)
	vextracti128 $1, %ymm4, (80+40)(%rdi)
	vextracti128 $1, %ymm5, (80+50)(%rdi)
	vextracti128 $1, %ymm6, (80+60)(%rdi)
	vextracti128 $1, %ymm7, (80+70)(%rdi)
	vmovdqu 64(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdi)
	vmovdqu %xmm5, (160+10)(%rdi)
	vmovdqu %xmm6, (160+20)(%rdi)
	vmovdqu %xmm7, (160+30)(%rdi)
	vextracti128 $1, %ymm4, (160+40)(%rdi)
	vextracti128 $1, %ymm5, (160+50)(%rdi)
	vextracti128 $1, %ymm6, (160+60)(%rdi)
	vextracti128 $1, %ymm7, (160+70)(%rdi)
	vmovdqu 96(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdi)
	vmovdqu %xmm5, (240+10)(%rdi)
	vmovdqu %xmm6, (240+20)(%rdi)
	vmovdqu %xmm7, (240+30)(%rdi)
	vextracti128 $1, %ymm4, (240+40)(%rdi)
	vextracti128 $1, %ymm5, (240+50)(%rdi)
	vextracti128 $1, %ymm6, (240+60)(%rdi)
	vextracti128 $1, %ymm7, (240+70)(%rdi)
	
# 0 "" 2
#NO_APP
	leaq	1280(%rdx), %r11
	leaq	512(%rax), %r9
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%r11)
	vmovdqu %xmm5, (0+10)(%r11)
	vmovdqu %xmm6, (0+20)(%r11)
	vmovdqu %xmm7, (0+30)(%r11)
	vextracti128 $1, %ymm4, (0+40)(%r11)
	vextracti128 $1, %ymm5, (0+50)(%r11)
	vextracti128 $1, %ymm6, (0+60)(%r11)
	vextracti128 $1, %ymm7, (0+70)(%r11)
	vmovdqu 32(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%r11)
	vmovdqu %xmm5, (80+10)(%r11)
	vmovdqu %xmm6, (80+20)(%r11)
	vmovdqu %xmm7, (80+30)(%r11)
	vextracti128 $1, %ymm4, (80+40)(%r11)
	vextracti128 $1, %ymm5, (80+50)(%r11)
	vextracti128 $1, %ymm6, (80+60)(%r11)
	vextracti128 $1, %ymm7, (80+70)(%r11)
	vmovdqu 64(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%r11)
	vmovdqu %xmm5, (160+10)(%r11)
	vmovdqu %xmm6, (160+20)(%r11)
	vmovdqu %xmm7, (160+30)(%r11)
	vextracti128 $1, %ymm4, (160+40)(%r11)
	vextracti128 $1, %ymm5, (160+50)(%r11)
	vextracti128 $1, %ymm6, (160+60)(%r11)
	vextracti128 $1, %ymm7, (160+70)(%r11)
	vmovdqu 96(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%r11)
	vmovdqu %xmm5, (240+10)(%r11)
	vmovdqu %xmm6, (240+20)(%r11)
	vmovdqu %xmm7, (240+30)(%r11)
	vextracti128 $1, %ymm4, (240+40)(%r11)
	vextracti128 $1, %ymm5, (240+50)(%r11)
	vextracti128 $1, %ymm6, (240+60)(%r11)
	vextracti128 $1, %ymm7, (240+70)(%r11)
	
# 0 "" 2
#NO_APP
	leaq	1600(%rdx), %rdi
	leaq	640(%rax), %rsi
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdi)
	vmovdqu %xmm5, (0+10)(%rdi)
	vmovdqu %xmm6, (0+20)(%rdi)
	vmovdqu %xmm7, (0+30)(%rdi)
	vextracti128 $1, %ymm4, (0+40)(%rdi)
	vextracti128 $1, %ymm5, (0+50)(%rdi)
	vextracti128 $1, %ymm6, (0+60)(%rdi)
	vextracti128 $1, %ymm7, (0+70)(%rdi)
	vmovdqu 32(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdi)
	vmovdqu %xmm5, (80+10)(%rdi)
	vmovdqu %xmm6, (80+20)(%rdi)
	vmovdqu %xmm7, (80+30)(%rdi)
	vextracti128 $1, %ymm4, (80+40)(%rdi)
	vextracti128 $1, %ymm5, (80+50)(%rdi)
	vextracti128 $1, %ymm6, (80+60)(%rdi)
	vextracti128 $1, %ymm7, (80+70)(%rdi)
	vmovdqu 64(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdi)
	vmovdqu %xmm5, (160+10)(%rdi)
	vmovdqu %xmm6, (160+20)(%rdi)
	vmovdqu %xmm7, (160+30)(%rdi)
	vextracti128 $1, %ymm4, (160+40)(%rdi)
	vextracti128 $1, %ymm5, (160+50)(%rdi)
	vextracti128 $1, %ymm6, (160+60)(%rdi)
	vextracti128 $1, %ymm7, (160+70)(%rdi)
	vmovdqu 96(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdi)
	vmovdqu %xmm5, (240+10)(%rdi)
	vmovdqu %xmm6, (240+20)(%rdi)
	vmovdqu %xmm7, (240+30)(%rdi)
	vextracti128 $1, %ymm4, (240+40)(%rdi)
	vextracti128 $1, %ymm5, (240+50)(%rdi)
	vextracti128 $1, %ymm6, (240+60)(%rdi)
	vextracti128 $1, %ymm7, (240+70)(%rdi)
	
# 0 "" 2
#NO_APP
	leaq	1920(%rdx), %r11
	leaq	768(%rax), %r9
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%r11)
	vmovdqu %xmm5, (0+10)(%r11)
	vmovdqu %xmm6, (0+20)(%r11)
	vmovdqu %xmm7, (0+30)(%r11)
	vextracti128 $1, %ymm4, (0+40)(%r11)
	vextracti128 $1, %ymm5, (0+50)(%r11)
	vextracti128 $1, %ymm6, (0+60)(%r11)
	vextracti128 $1, %ymm7, (0+70)(%r11)
	vmovdqu 32(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%r11)
	vmovdqu %xmm5, (80+10)(%r11)
	vmovdqu %xmm6, (80+20)(%r11)
	vmovdqu %xmm7, (80+30)(%r11)
	vextracti128 $1, %ymm4, (80+40)(%r11)
	vextracti128 $1, %ymm5, (80+50)(%r11)
	vextracti128 $1, %ymm6, (80+60)(%r11)
	vextracti128 $1, %ymm7, (80+70)(%r11)
	vmovdqu 64(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%r11)
	vmovdqu %xmm5, (160+10)(%r11)
	vmovdqu %xmm6, (160+20)(%r11)
	vmovdqu %xmm7, (160+30)(%r11)
	vextracti128 $1, %ymm4, (160+40)(%r11)
	vextracti128 $1, %ymm5, (160+50)(%r11)
	vextracti128 $1, %ymm6, (160+60)(%r11)
	vextracti128 $1, %ymm7, (160+70)(%r11)
	vmovdqu 96(%r9), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%r11)
	vmovdqu %xmm5, (240+10)(%r11)
	vmovdqu %xmm6, (240+20)(%r11)
	vmovdqu %xmm7, (240+30)(%r11)
	vextracti128 $1, %ymm4, (240+40)(%r11)
	vextracti128 $1, %ymm5, (240+50)(%r11)
	vextracti128 $1, %ymm6, (240+60)(%r11)
	vextracti128 $1, %ymm7, (240+70)(%r11)
	
# 0 "" 2
#NO_APP
	leaq	2240(%rdx), %rdi
	leaq	896(%rax), %rsi
#APP
# 215 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
	vmovdqu 0(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 0(%rdi)
	vmovdqu %xmm5, (0+10)(%rdi)
	vmovdqu %xmm6, (0+20)(%rdi)
	vmovdqu %xmm7, (0+30)(%rdi)
	vextracti128 $1, %ymm4, (0+40)(%rdi)
	vextracti128 $1, %ymm5, (0+50)(%rdi)
	vextracti128 $1, %ymm6, (0+60)(%rdi)
	vextracti128 $1, %ymm7, (0+70)(%rdi)
	vmovdqu 32(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 80(%rdi)
	vmovdqu %xmm5, (80+10)(%rdi)
	vmovdqu %xmm6, (80+20)(%rdi)
	vmovdqu %xmm7, (80+30)(%rdi)
	vextracti128 $1, %ymm4, (80+40)(%rdi)
	vextracti128 $1, %ymm5, (80+50)(%rdi)
	vextracti128 $1, %ymm6, (80+60)(%rdi)
	vextracti128 $1, %ymm7, (80+70)(%rdi)
	vmovdqu 64(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 160(%rdi)
	vmovdqu %xmm5, (160+10)(%rdi)
	vmovdqu %xmm6, (160+20)(%rdi)
	vmovdqu %xmm7, (160+30)(%rdi)
	vextracti128 $1, %ymm4, (160+40)(%rdi)
	vextracti128 $1, %ymm5, (160+50)(%rdi)
	vextracti128 $1, %ymm6, (160+60)(%rdi)
	vextracti128 $1, %ymm7, (160+70)(%rdi)
	vmovdqu 96(%rsi), %ymm0
	vpsrlq $32, %ymm0, %ymm1
	vpmuludq 0(%rcx), %ymm0, %ymm2
	vpmuludq 0(%rcx), %ymm1, %ymm3
	vpsrlq $45, %ymm2, %ymm2
	vpsrlq $13, %ymm3, %ymm3
	vpblendd $0xAA, %ymm3, %ymm2, %ymm2
	vpmuludq 32(%rcx), %ymm0, %ymm3
	vpmuludq 32(%rcx), %ymm1, %ymm1
	vpsrlq $56, %ymm3, %ymm3
	vpsrlq $24, %ymm1, %ymm1
	vpblendd $0xAA, %ymm1, %ymm3, %ymm3
	vpmulld 64(%rcx), %ymm2, %ymm1
	vpsubd %ymm1, %ymm0, %ymm4
	vpmulld 64(%rcx), %ymm3, %ymm1
	vpsubd %ymm1, %ymm2, %ymm5
	vmovdqa 384(%rcx), %ymm12
	vmovdqa 416(%rcx), %ymm13
	vmovdqa 448(%rcx), %ymm14
	vmovdqa 640(%rcx), %ymm15
	vpcmpgtd 192(%rcx), %ymm0, %ymm6
	vpcmpgtd 224(%rcx), %ymm0, %ymm1
	vpblendvb %ymm12, %ymm1, %ymm6, %ymm6
	vpcmpgtd 256(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm6, %ymm6
	vpcmpgtd 288(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm6, %ymm6
	vpcmpgtd 96(%rcx), %ymm0, %ymm7
	vpor 352(%rcx), %ymm7, %ymm7
	vpcmpgtd 128(%rcx), %ymm0, %ymm1
	vpblendvb %ymm13, %ymm1, %ymm7, %ymm7
	vpcmpgtd 160(%rcx), %ymm0, %ymm1
	vpblendvb %ymm14, %ymm1, %ymm7, %ymm7
	vpcmpgtd 320(%rcx), %ymm0, %ymm1
	vpaddd 672(%rcx), %ymm3, %ymm3
	vpblendvb %ymm1, %ymm3, %ymm15, %ymm3
	vpmulhuw 480(%rcx), %ymm5, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm5, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm5
	vpaddb 608(%rcx), %ymm5, %ymm5
	vpblendvb %ymm6, %ymm5, %ymm15, %ymm5
	vpmulhuw 480(%rcx), %ymm4, %ymm1
	vpsrlw $3, %ymm1, %ymm1
	vpmulld 512(%rcx), %ymm1, %ymm1
	vpaddd %ymm4, %ymm1, %ymm1
	vpmulhuw 544(%rcx), %ymm1, %ymm2
	vpmullw 576(%rcx), %ymm2, %ymm2
	vpaddw %ymm1, %ymm2, %ymm4
	vpaddb 608(%rcx), %ymm4, %ymm4
	vpblendvb %ymm7, %ymm4, %ymm15, %ymm4
	vpunpckldq %ymm4, %ymm5, %ymm1
	vpunpckhdq %ymm4, %ymm5, %ymm2
	vpshufb 704(%rcx), %ymm1, %ymm4
	vpshufb 768(%rcx), %ymm3, %ymm5
	vpor %ymm5, %ymm4, %ymm4
	vpshufb 736(%rcx), %ymm1, %ymm5
	vpshufb 800(%rcx), %ymm3, %ymm6
	vpor %ymm6, %ymm5, %ymm5
	vpshufb 704(%rcx), %ymm2, %ymm6
	vpshufb 832(%rcx), %ymm3, %ymm7
	vpor %ymm7, %ymm6, %ymm6
	vpshufb 736(%rcx), %ymm2, %ymm7
	vpshufb 864(%rcx), %ymm3, %ymm8
	vpor %ymm8, %ymm7, %ymm7
	vmovdqu %xmm4, 240(%rdi)
	vmovdqu %xmm5, (240+10)(%rdi)
	vmovdqu %xmm6, (240+20)(%rdi)
	vmovdqu %xmm7, (240+30)(%rdi)
	vextracti128 $1, %ymm4, (240+40)(%rdi)
	vextracti128 $1, %ymm5, (240+50)(%rdi)
	vextracti128 $1, %ymm6, (240+60)(%rdi)
	vextracti128 $1, %ymm7, (240+70)(%rdi)
	
# 0 "" 2
#NO_APP
	addq	$256, %r8
	addq	$2560, %rdx
	addq	$1024, %rax
	cmpq	%r8, %r10
	jnb	.L756
.L795:
	vzeroupper
.L794:
	ret
	.cfi_endproc
.LFE8953:
	.size	_Z16probe_format_asmPKjPcm, .-_Z16probe_format_asmPKjPcm
	.p2align 4
	.globl	_Z13probe_parse4pPcPjm
	.type	_Z13probe_parse4pPcPjm, @function
_Z13probe_parse4pPcPjm:
.LFB8959:
	.cfi_startproc
	jmp	_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_.isra.0
	.cfi_endproc
.LFE8959:
	.size	_Z13probe_parse4pPcPjm, .-_Z13probe_parse4pPcPjm
	.p2align 4
	.globl	_Z14probe_parse4pdPcPjm
	.type	_Z14probe_parse4pdPcPjm, @function
_Z14probe_parse4pdPcPjm:
.LFB8960:
	.cfi_startproc
	jmp	_ZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_.isra.0
	.cfi_endproc
.LFE8960:
	.size	_Z14probe_parse4pdPcPjm, .-_Z14probe_parse4pdPcPjm
	.section	.text._ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,"axG",@progbits,_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,comdat
	.p2align 4
	.weak	_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.type	_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m, @function
_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m:
.LFB8971:
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
	jbe	.L825
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm3
	movq	%rdi, %r11
	vmovdqa	.LC5(%rip), %ymm7
	.p2align 4,,10
	.p2align 3
.L824:
	movl	$538976288, %eax
	vmovdqa	.LC15(%rip), %ymm15
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
.L804:
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
	jbe	.L992
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
.L803:
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
	jne	.L803
	movq	56(%rsp), %rdx
	leaq	(%rbx,%rdx,2), %rbx
	jmp	.L804
	.p2align 4,,10
	.p2align 3
.L992:
	movq	%r9, %r11
	movq	40(%rsp), %r9
	movq	%rbx, %r14
	cmpq	%r9, %rcx
	jnb	.L802
	movl	$538976288, %r13d
	movl	$808464432, %eax
	vmovdqa	.LC9(%rip), %xmm3
	vmovdqa	.LC10(%rip), %xmm4
	vmovdqa	.LC11(%rip), %xmm7
	vpbroadcastd	%r13d, %xmm5
	vpbroadcastd	%eax, %xmm15
	.p2align 4,,10
	.p2align 3
.L801:
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
	jb	.L801
.L802:
	cmpq	$32831, %rbx
	movq	%rbx, %r12
	setbe	56(%rsp)
	cmpq	%r10, %r8
	jnb	.L805
	cmpb	$0, 56(%rsp)
	je	.L805
	movl	$538976288, %r13d
	movl	$808464432, %edx
	vmovdqa	.LC9(%rip), %xmm3
	vmovdqa	.LC10(%rip), %xmm4
	vmovdqa	.LC11(%rip), %xmm7
	vpbroadcastd	%r13d, %xmm5
	vpbroadcastd	%edx, %xmm15
	testb	$1, %bl
	je	.L806
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
	jb	.L971
	jmp	.L805
	.p2align 4,,10
	.p2align 3
.L806:
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
	jnb	.L805
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
	jnb	.L805
.L971:
	cmpq	$32832, %r12
	jne	.L806
.L805:
	movq	48(%rsp), %rdx
	movq	%rbx, %r13
	cmpq	%rdx, %rdi
	jnb	.L808
	cmpb	$0, 56(%rsp)
	je	.L808
	movl	$538976288, %eax
	vmovdqa	.LC9(%rip), %xmm1
	vmovdqa	.LC10(%rip), %xmm2
	vpbroadcastd	%eax, %xmm8
	movl	$808464432, %eax
	vmovdqa	.LC11(%rip), %xmm5
	vpbroadcastd	%eax, %xmm9
	testb	$1, %bl
	jne	.L972
	movq	%r12, 40(%rsp)
	movq	%rdx, %r12
	jmp	.L809
	.p2align 4,,10
	.p2align 3
.L993:
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
	jnb	.L980
	cmpq	$32832, %r13
	je	.L980
.L809:
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
	jb	.L993
.L980:
	movq	40(%rsp), %r12
.L808:
	movq	32(%rsp), %rdx
	cmpq	%rdx, %rsi
	jnb	.L811
	cmpb	$0, 56(%rsp)
	je	.L811
	movl	$538976288, %eax
	vmovdqa	.LC9(%rip), %xmm1
	vmovdqa	.LC10(%rip), %xmm2
	vpbroadcastd	%eax, %xmm8
	movl	$808464432, %eax
	vmovdqa	.LC11(%rip), %xmm5
	vpbroadcastd	%eax, %xmm9
	testb	$1, %bl
	jne	.L974
	movq	%r12, 56(%rsp)
	movq	%rdx, %r12
	jmp	.L812
	.p2align 4,,10
	.p2align 3
.L994:
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
	jnb	.L981
	cmpq	$32832, %rbx
	je	.L981
.L812:
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
	jb	.L994
.L981:
	movq	56(%rsp), %r12
.L811:
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
	jne	.L995
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
.L823:
	cmpq	$65600, 24(%rsp)
	jbe	.L990
.L816:
	movq	32(%rsp), %r11
	jmp	.L824
.L974:
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
	jnb	.L811
	cmpq	$32832, %rbx
	je	.L811
	movq	%r12, 56(%rsp)
	movq	32(%rsp), %r12
	jmp	.L812
.L972:
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
	jnb	.L808
	cmpq	$32832, %r13
	je	.L808
	movq	%r12, 40(%rsp)
	movq	48(%rsp), %r12
	jmp	.L809
.L990:
	vzeroupper
.L799:
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
.L995:
	.cfi_restore_state
	cmpq	32(%rsp), %r11
	jnb	.L996
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
	jnb	.L997
.L976:
	movq	%rsi, %r12
	xorl	%r10d, %r10d
	movq	32(%rsp), %r13
	subq	%r11, %r12
	cmpq	%r11, %rsi
	cmovb	%r10, %r12
	leaq	1(%r11,%r12), %rsi
	cmpq	%r13, %rsi
	jnb	.L822
	movq	%rsi, %rbx
	notq	%rbx
	addq	%r13, %rbx
	andl	$7, %ebx
	cmpb	$32, (%rsi)
	jg	.L998
.L855:
	leaq	1(%rsi), %rax
	cmpq	32(%rsp), %rax
	jnb	.L822
	testq	%rbx, %rbx
	je	.L821
	cmpq	$1, %rbx
	je	.L926
	cmpq	$2, %rbx
	je	.L927
	cmpq	$3, %rbx
	je	.L928
	cmpq	$4, %rbx
	je	.L929
	cmpq	$5, %rbx
	je	.L930
	cmpq	$6, %rbx
	je	.L931
	cmpb	$32, 1(%rsi)
	jg	.L999
.L857:
	incq	%rax
.L931:
	cmpb	$32, (%rax)
	jle	.L860
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L860:
	incq	%rax
.L930:
	cmpb	$32, (%rax)
	jg	.L1000
.L863:
	incq	%rax
.L929:
	cmpb	$32, (%rax)
	jg	.L1001
.L866:
	incq	%rax
.L928:
	cmpb	$32, (%rax)
	jg	.L1002
.L869:
	incq	%rax
.L927:
	cmpb	$32, (%rax)
	jle	.L872
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
.L872:
	incq	%rax
.L926:
	cmpb	$32, (%rax)
	jle	.L875
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L875:
	incq	%rax
	cmpq	32(%rsp), %rax
	jnb	.L822
.L821:
	cmpb	$32, (%rax)
	jle	.L820
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
.L820:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %rbx
	jle	.L878
	xorl	%eax, %eax
	cmpb	$32, -1(%rbx)
	setle	%al
	addq	%rax, %rdx
.L878:
	cmpb	$32, 1(%rbx)
	jle	.L880
	xorl	%r14d, %r14d
	cmpb	$32, (%rbx)
	setle	%r14b
	addq	%r14, %rdx
.L880:
	cmpb	$32, 2(%rbx)
	jle	.L882
	xorl	%r9d, %r9d
	cmpb	$32, 1(%rbx)
	setle	%r9b
	addq	%r9, %rdx
.L882:
	cmpb	$32, 3(%rbx)
	jle	.L884
	xorl	%ecx, %ecx
	cmpb	$32, 2(%rbx)
	setle	%cl
	addq	%rcx, %rdx
.L884:
	cmpb	$32, 4(%rbx)
	jle	.L886
	xorl	%edi, %edi
	cmpb	$32, 3(%rbx)
	setle	%dil
	addq	%rdi, %rdx
.L886:
	cmpb	$32, 5(%rbx)
	jle	.L888
	xorl	%r8d, %r8d
	cmpb	$32, 4(%rbx)
	setle	%r8b
	addq	%r8, %rdx
.L888:
	cmpb	$32, 6(%rbx)
	jle	.L890
	xorl	%r12d, %r12d
	cmpb	$32, 5(%rbx)
	setle	%r12b
	addq	%r12, %rdx
.L890:
	leaq	7(%rbx), %rax
	cmpq	32(%rsp), %rax
	jb	.L821
.L822:
	subq	%rdx, 24(%rsp)
	movq	%r15, %rsi
	leaq	(%r15,%rdx,4), %r15
	movq	%r11, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm3
	vmovdqa	.LC5(%rip), %ymm7
	jmp	.L823
.L998:
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rsi)
	setle	%r14b
	addq	%r14, %rdx
	jmp	.L855
.L997:
	testq	%rbx, %rbx
	je	.L818
	cmpq	$1, %rbx
	je	.L932
	cmpq	$2, %rbx
	je	.L933
	cmpq	$3, %rbx
	je	.L934
	cmpq	$4, %rbx
	je	.L935
	cmpq	$5, %rbx
	je	.L936
	cmpq	$6, %rbx
	jne	.L1003
.L937:
	xorl	%eax, %eax
	cmpb	$32, (%r12)
	setg	%al
	incq	%r12
	addq	%rax, %rdx
.L936:
	xorl	%r9d, %r9d
	cmpb	$32, (%r12)
	setg	%r9b
	incq	%r12
	addq	%r9, %rdx
.L935:
	xorl	%ecx, %ecx
	cmpb	$32, (%r12)
	setg	%cl
	incq	%r12
	addq	%rcx, %rdx
.L934:
	xorl	%edi, %edi
	cmpb	$32, (%r12)
	setg	%dil
	incq	%r12
	addq	%rdi, %rdx
.L933:
	xorl	%r8d, %r8d
	cmpb	$32, (%r12)
	setg	%r8b
	incq	%r12
	addq	%r8, %rdx
.L932:
	xorl	%r10d, %r10d
	cmpb	$32, (%r12)
	setg	%r10b
	incq	%r12
	addq	%r10, %rdx
	cmpq	%r12, %rsi
	jb	.L976
.L818:
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
	jb	.L976
	jmp	.L818
	.p2align 4,,10
	.p2align 3
.L1002:
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
	jmp	.L869
.L1001:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L866
.L1000:
	xorl	%edi, %edi
	cmpb	$32, -1(%rax)
	setle	%dil
	addq	%rdi, %rdx
	jmp	.L863
.L825:
	movq	%rdi, 32(%rsp)
	jmp	.L799
.L996:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r11, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm3
	vmovdqa	.LC5(%rip), %ymm7
	jmp	.L816
.L999:
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
	jmp	.L857
.L1003:
	xorl	%edx, %edx
	cmpb	$32, 1(%r11)
	setg	%dl
	incq	%r12
	addq	%r14, %rdx
	jmp	.L937
	.cfi_endproc
.LFE8971:
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
	.section	.text._ZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,"axG",@progbits,_ZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,comdat
	.p2align 4
	.weak	_ZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.type	_ZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m, @function
_ZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m:
.LFB8984:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %r9
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	.cfi_offset 15, -24
	movq	%rsi, %r15
	pushq	%r14
	.cfi_offset 14, -32
	movq	%rdx, %r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$32, %rsp
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	cmpq	$66688, %rdx
	jbe	.L1028
	vmovdqa	.LC3(%rip), %ymm3
	vmovdqa	.LC4(%rip), %ymm2
	vmovdqa	.LC5(%rip), %ymm6
	vmovdqa	.LC15(%rip), %ymm8
	.p2align 4,,10
	.p2align 3
.L1027:
	movl	$538976288, %eax
	vpbroadcastd	%eax, %ymm4
	vpminsb	66624(%r9), %ymm4, %ymm0
	vpminsb	133248(%r9), %ymm4, %ymm5
	vpcmpeqb	66624(%r9), %ymm0, %ymm1
	vpcmpeqb	133248(%r9), %ymm5, %ymm7
	vpmovmskb	%ymm1, %edx
	vpmovmskb	%ymm7, %esi
	tzcntl	%edx, %ecx
	tzcntl	%esi, %edi
	movl	%ecx, %ebx
	movl	%edi, %eax
	addq	$66625, %rbx
	addq	$133249, %rax
	leaq	(%r9,%rax), %r12
	subq	%rbx, %rax
	leaq	(%r9,%rbx), %r8
	cmpq	%rbx, %rax
	cmovg	%rbx, %rax
	cmpq	$64, %rax
	jbe	.L1159
	movabsq	$1135184250689818561, %r10
	movq	%r12, 8(%rsp)
	movl	$808464432, %r11d
	movl	$100000000, %r13d
	mulq	%r10
	movq	%r8, %rsi
	movq	%r9, %rcx
	xorl	%ebx, %ebx
	vpxor	%xmm10, %xmm10, %xmm10
	vpbroadcastd	%r11d, %ymm15
	vpbroadcastd	%r13d, %ymm5
	shrq	$2, %rdx
	.p2align 4,,10
	.p2align 3
.L1009:
	movq	%rdx, 24(%rsp)
	leaq	(%rbx,%rdx,4), %r11
	movq	%rbx, %rdi
	movq	%rbx, 16(%rsp)
	.p2align 4,,10
	.p2align 3
.L1012:
	vmovdqu	(%rcx), %ymm9
	vpminsb	32(%rcx), %ymm4, %ymm13
	vpminsb	%ymm4, %ymm9, %ymm11
	vpcmpeqb	32(%rcx), %ymm13, %ymm14
	vpcmpeqb	%ymm11, %ymm9, %ymm12
	vpmovmskb	%ymm12, %r12d
	tzcntl	%r12d, %ebx
	blsr	%r12d, %eax
	tzcntl	%eax, %r10d
	blsr	%eax, %r13d
	blsr	%r13d, %r12d
	movl	%r12d, %eax
	movl	%ebx, %r12d
	tzcntl	%r13d, %edx
	vpmovmskb	%ymm14, %r13d
	vinserti64x2	$0x1, 1(%rcx,%r12), %ymm9, %ymm0
	incl	%r12d
	salq	$32, %r13
	salq	$4, %r12
	orq	%r13, %rax
	movl	%r10d, %r13d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm9
	movl	%r10d, %r12d
	tzcntq	%rax, %rax
	vmovdqu	1(%rcx,%r13), %xmm1
	subl	%ebx, %r12d
	movl	%edx, %ebx
	movl	%edx, %r13d
	subl	%r10d, %ebx
	movl	%eax, %r10d
	salq	$4, %r12
	vinserti64x2	$0x1, 1(%rcx,%r13), %ymm1, %ymm7
	salq	$4, %rbx
	subl	%edx, %r10d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm9, %ymm12
	incl	%eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rbx), %xmm11
	salq	$4, %r10
	vpsubusb	%ymm15, %ymm7, %ymm7
	addq	%rax, %rcx
	vmovdqa	%ymm12, %ymm14
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm11, %ymm13
	vpternlogq	$254, %ymm10, %ymm13, %ymm14
	vpsubusb	%ymm15, %ymm0, %ymm10
	vpshufb	%ymm12, %ymm10, %ymm0
	vpshufb	%ymm13, %ymm7, %ymm12
	vmovdqu	(%rsi), %ymm13
	vpmaddubsw	%ymm3, %ymm0, %ymm1
	vpmaddubsw	%ymm3, %ymm12, %ymm11
	vpminsb	%ymm4, %ymm13, %ymm10
	vpmaddwd	%ymm2, %ymm1, %ymm9
	vpcmpeqb	%ymm10, %ymm13, %ymm0
	vpminsb	32(%rsi), %ymm4, %ymm1
	vpmaddwd	%ymm2, %ymm11, %ymm7
	vpcmpeqb	32(%rsi), %ymm1, %ymm12
	vpmovmskb	%ymm0, %edx
	tzcntl	%edx, %ebx
	blsr	%edx, %eax
	tzcntl	%eax, %r10d
	blsr	%eax, %r13d
	blsr	%r13d, %r12d
	movl	%r12d, %eax
	movl	%ebx, %r12d
	tzcntl	%r13d, %edx
	vpmovmskb	%ymm12, %r13d
	vinserti64x2	$0x1, 1(%rsi,%r12), %ymm13, %ymm11
	incl	%r12d
	salq	$32, %r13
	salq	$4, %r12
	orq	%r13, %rax
	movl	%r10d, %r13d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm10
	movl	%r10d, %r12d
	tzcntq	%rax, %rax
	vmovdqu	1(%rsi,%r13), %xmm13
	subl	%ebx, %r12d
	movl	%edx, %ebx
	movl	%edx, %r13d
	salq	$4, %r12
	subl	%r10d, %ebx
	vinserti64x2	$0x1, 1(%rsi,%r13), %ymm13, %ymm1
	movl	%eax, %r10d
	salq	$4, %rbx
	subl	%edx, %r10d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm10, %ymm13
	incl	%eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rbx), %xmm0
	salq	$4, %r10
	vpsubusb	%ymm15, %ymm1, %ymm1
	addq	%rax, %rsi
	vmovdqa	%ymm13, %ymm10
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm0, %ymm12
	vpternlogq	$254, %ymm14, %ymm12, %ymm10
	vpsubusb	%ymm15, %ymm11, %ymm14
	vpshufb	%ymm12, %ymm1, %ymm12
	vpshufb	%ymm13, %ymm14, %ymm11
	vpmaddubsw	%ymm3, %ymm12, %ymm14
	vpmaddubsw	%ymm3, %ymm11, %ymm13
	vpmaddwd	%ymm2, %ymm14, %ymm11
	vpmaddwd	%ymm2, %ymm13, %ymm0
	vpackusdw	%ymm11, %ymm7, %ymm7
	vpackusdw	%ymm0, %ymm9, %ymm9
	vpmaddwd	%ymm6, %ymm7, %ymm1
	vpmaddwd	%ymm6, %ymm9, %ymm13
	vshufps	$136, %ymm1, %ymm13, %ymm0
	vpmulld	%ymm5, %ymm0, %ymm12
	vshufps	$221, %ymm1, %ymm13, %ymm14
	vpaddd	%ymm14, %ymm12, %ymm11
	vxorps	%xmm9, %xmm9, %xmm9
	vpermd	%ymm11, %ymm8, %ymm9
	vxorps	%xmm13, %xmm13, %xmm13
	vpermq	$216, %ymm9, %ymm13
	vmovdqu	%xmm13, (%r15,%rdi,4)
	vextracti64x2	$0x1, %ymm13, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region(,%rdi,4)
	addq	$4, %rdi
	cmpq	%r11, %rdi
	jne	.L1012
	movq	8(%rsp), %r13
	movq	%r8, %rdx
	movabsq	$1135184250689818561, %rax
	movq	24(%rsp), %r11
	subq	%rcx, %rdx
	movq	16(%rsp), %rdi
	subq	%rsi, %r13
	cmpq	%rdx, %r13
	leaq	(%rdi,%r11,4), %rbx
	cmovg	%rdx, %r13
	mulq	%r13
	shrq	$2, %rdx
	cmpq	$64, %r13
	ja	.L1009
	cmpq	$66687, %rbx
	movq	8(%rsp), %r12
	setbe	%r10b
.L1007:
	movq	%rbx, %r13
	cmpq	%r8, %rcx
	jnb	.L1011
	movl	$538976288, %r11d
	movl	$808464432, %edi
	vmovdqa	.LC9(%rip), %xmm2
	vmovdqa	.LC10(%rip), %xmm3
	vmovdqa	.LC11(%rip), %xmm6
	vpbroadcastd	%r11d, %xmm8
	vpbroadcastd	%edi, %xmm4
	.p2align 4,,10
	.p2align 3
.L1010:
	vmovdqu	(%rcx), %xmm15
	incq	%r13
	vpminsb	%xmm8, %xmm15, %xmm5
	vpsubusb	%xmm4, %xmm15, %xmm14
	vpcmpeqb	%xmm5, %xmm15, %xmm1
	vpmovmskb	%xmm1, %edx
	tzcntl	%edx, %eax
	incl	%eax
	movq	%rax, %r11
	addq	%rax, %rcx
	salq	$4, %r11
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r11), %xmm12
	vpshufb	%xmm12, %xmm14, %xmm11
	vmovdqa	%xmm12, %xmm0
	vpmaddubsw	%xmm2, %xmm11, %xmm9
	vporq	%ymm0, %ymm10, %ymm10
	vpmaddwd	%xmm3, %xmm9, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm7
	vpmaddwd	%xmm6, %xmm7, %xmm15
	vmovq	%xmm15, %rdx
	imull	$100000000, %edx, %edi
	shrq	$32, %rdx
	addl	%edi, %edx
	movl	%edx, -4(%r15,%r13,4)
	cmpq	%r8, %rcx
	jb	.L1010
.L1011:
	cmpq	%r12, %rsi
	jnb	.L1014
	testb	%r10b, %r10b
	je	.L1014
	movl	$538976288, %r10d
	movl	$808464432, %eax
	vmovdqa	.LC9(%rip), %xmm2
	vmovdqa	.LC10(%rip), %xmm3
	vmovdqa	.LC11(%rip), %xmm6
	vpbroadcastd	%r10d, %xmm8
	vpbroadcastd	%eax, %xmm4
	testb	$1, %bl
	jne	.L1158
	jmp	.L1015
	.p2align 4,,10
	.p2align 3
.L1144:
	cmpq	$66688, %rbx
	je	.L1014
.L1015:
	vmovdqu	(%rsi), %xmm1
	incq	%rbx
	vpminsb	%xmm8, %xmm1, %xmm12
	vpsubusb	%xmm4, %xmm1, %xmm9
	vpcmpeqb	%xmm12, %xmm1, %xmm14
	vpmovmskb	%xmm14, %r11d
	tzcntl	%r11d, %edi
	incl	%edi
	movq	%rdi, %rdx
	addq	%rdi, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm11
	vpshufb	%xmm11, %xmm9, %xmm13
	vmovdqa	%xmm11, %xmm0
	vpmaddubsw	%xmm2, %xmm13, %xmm7
	vporq	%ymm0, %ymm10, %ymm10
	vpmaddwd	%xmm3, %xmm7, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm5
	vpmaddwd	%xmm6, %xmm5, %xmm1
	vmovq	%xmm1, %r10
	imull	$100000000, %r10d, %eax
	shrq	$32, %r10
	addl	%eax, %r10d
	movl	%r10d, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%rbx,4)
	cmpq	%r12, %rsi
	jnb	.L1014
.L1158:
	vmovdqu	(%rsi), %xmm5
	incq	%rbx
	vpminsb	%xmm8, %xmm5, %xmm1
	vpsubusb	%xmm4, %xmm5, %xmm11
	vpcmpeqb	%xmm1, %xmm5, %xmm12
	vpmovmskb	%xmm12, %r11d
	tzcntl	%r11d, %edi
	incl	%edi
	movq	%rdi, %rdx
	addq	%rdi, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm11, %xmm9
	vmovdqa	%xmm14, %xmm0
	vpmaddubsw	%xmm2, %xmm9, %xmm13
	vporq	%ymm0, %ymm10, %ymm10
	vpmaddwd	%xmm3, %xmm13, %xmm7
	vpackusdw	%xmm7, %xmm7, %xmm15
	vpmaddwd	%xmm6, %xmm15, %xmm5
	vmovq	%xmm5, %r10
	imull	$100000000, %r10d, %eax
	shrq	$32, %r10
	addl	%eax, %r10d
	movl	%r10d, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%rbx,4)
	cmpq	%r12, %rsi
	jb	.L1144
.L1014:
	vpmovmskb	%ymm10, %r11d
	xorl	%edi, %edi
	andl	$-2147450880, %r11d
	cmpq	%rsi, %r12
	setne	%dil
	xorl	%esi, %esi
	orl	%edi, %r11d
	cmpq	%rcx, %r8
	setne	%sil
	orl	%esi, %r11d
	jne	.L1160
	leaq	(%r15,%r13,4), %rdi
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, %esi
	vzeroupper
	addq	%rbx, %r13
	call	memcpy
	vmovdqa	.LC15(%rip), %ymm8
	vmovdqa	.LC5(%rip), %ymm6
	leaq	(%r15,%r13,4), %r15
	vmovdqa	.LC4(%rip), %ymm2
	vmovdqa	.LC3(%rip), %ymm3
	subq	%r13, %r14
.L1026:
	cmpq	$66688, %r14
	jbe	.L1156
.L1019:
	movq	%r12, %r9
	jmp	.L1027
.L1159:
	movq	%r8, %rsi
	movq	%r9, %rcx
	movl	$1, %r10d
	xorl	%ebx, %ebx
	vpxor	%xmm10, %xmm10, %xmm10
	jmp	.L1007
.L1156:
	vzeroupper
.L1006:
	leaq	-40(%rbp), %rsp
	movq	%r12, %rdi
	movq	%r14, %rdx
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
.L1160:
	.cfi_restore_state
	cmpq	%r12, %r9
	jnb	.L1161
	leaq	-1(%r12), %rsi
	leaq	1(%r9), %rcx
	cmpq	%rsi, %r9
	cmovbe	%r9, %rsi
	xorl	%ebx, %ebx
	movq	%rsi, %r8
	subq	%r9, %r8
	andl	$7, %r8d
	cmpb	$32, (%r9)
	setg	%bl
	movq	%rbx, %rdx
	cmpq	%rcx, %rsi
	jnb	.L1162
.L1145:
	movq	%rsi, %r13
	xorl	%ecx, %ecx
	subq	%r9, %r13
	cmpq	%r9, %rsi
	cmovb	%rcx, %r13
	leaq	1(%r9,%r13), %rsi
	cmpq	%r12, %rsi
	jnb	.L1025
	movq	%rsi, %r10
	notq	%r10
	addq	%r12, %r10
	andl	$7, %r10d
	cmpb	$32, (%rsi)
	jg	.L1163
.L1044:
	leaq	1(%rsi), %rax
	cmpq	%r12, %rax
	jnb	.L1025
	testq	%r10, %r10
	je	.L1024
	cmpq	$1, %r10
	je	.L1109
	cmpq	$2, %r10
	je	.L1110
	cmpq	$3, %r10
	je	.L1111
	cmpq	$4, %r10
	je	.L1112
	cmpq	$5, %r10
	je	.L1113
	cmpq	$6, %r10
	je	.L1114
	cmpb	$32, 1(%rsi)
	jg	.L1164
.L1046:
	incq	%rax
.L1114:
	cmpb	$32, (%rax)
	jle	.L1049
	xorl	%edi, %edi
	cmpb	$32, -1(%rax)
	setle	%dil
	addq	%rdi, %rdx
.L1049:
	incq	%rax
.L1113:
	cmpb	$32, (%rax)
	jg	.L1165
.L1052:
	incq	%rax
.L1112:
	cmpb	$32, (%rax)
	jg	.L1166
.L1055:
	incq	%rax
.L1111:
	cmpb	$32, (%rax)
	jg	.L1167
.L1058:
	incq	%rax
.L1110:
	cmpb	$32, (%rax)
	jle	.L1061
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L1061:
	incq	%rax
.L1109:
	cmpb	$32, (%rax)
	jle	.L1064
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L1064:
	incq	%rax
	cmpq	%r12, %rax
	jnb	.L1025
.L1024:
	cmpb	$32, (%rax)
	jle	.L1023
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
.L1023:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %r11
	jle	.L1067
	xorl	%eax, %eax
	cmpb	$32, -1(%r11)
	setle	%al
	addq	%rax, %rdx
.L1067:
	cmpb	$32, 1(%r11)
	jle	.L1069
	xorl	%edi, %edi
	cmpb	$32, (%r11)
	setle	%dil
	addq	%rdi, %rdx
.L1069:
	cmpb	$32, 2(%r11)
	jle	.L1071
	xorl	%r8d, %r8d
	cmpb	$32, 1(%r11)
	setle	%r8b
	addq	%r8, %rdx
.L1071:
	cmpb	$32, 3(%r11)
	jle	.L1073
	xorl	%ebx, %ebx
	cmpb	$32, 2(%r11)
	setle	%bl
	addq	%rbx, %rdx
.L1073:
	cmpb	$32, 4(%r11)
	jle	.L1075
	xorl	%r13d, %r13d
	cmpb	$32, 3(%r11)
	setle	%r13b
	addq	%r13, %rdx
.L1075:
	cmpb	$32, 5(%r11)
	jle	.L1077
	xorl	%ecx, %ecx
	cmpb	$32, 4(%r11)
	setle	%cl
	addq	%rcx, %rdx
.L1077:
	cmpb	$32, 6(%r11)
	jle	.L1079
	xorl	%esi, %esi
	cmpb	$32, 5(%r11)
	setle	%sil
	addq	%rsi, %rdx
.L1079:
	leaq	7(%r11), %rax
	cmpq	%r12, %rax
	jb	.L1024
.L1025:
	subq	%rdx, %r14
	movq	%r15, %rsi
	leaq	(%r15,%rdx,4), %r15
	movq	%r9, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm3
	vmovdqa	.LC4(%rip), %ymm2
	vmovdqa	.LC5(%rip), %ymm6
	vmovdqa	.LC15(%rip), %ymm8
	jmp	.L1026
.L1163:
	xorl	%eax, %eax
	cmpb	$32, -1(%rsi)
	setle	%al
	addq	%rax, %rdx
	jmp	.L1044
.L1162:
	testq	%r8, %r8
	je	.L1021
	cmpq	$1, %r8
	je	.L1115
	cmpq	$2, %r8
	je	.L1116
	cmpq	$3, %r8
	je	.L1117
	cmpq	$4, %r8
	je	.L1118
	cmpq	$5, %r8
	je	.L1119
	cmpq	$6, %r8
	jne	.L1168
.L1120:
	xorl	%r13d, %r13d
	cmpb	$32, (%rcx)
	setg	%r13b
	incq	%rcx
	addq	%r13, %rdx
.L1119:
	xorl	%r10d, %r10d
	cmpb	$32, (%rcx)
	setg	%r10b
	incq	%rcx
	addq	%r10, %rdx
.L1118:
	xorl	%eax, %eax
	cmpb	$32, (%rcx)
	setg	%al
	incq	%rcx
	addq	%rax, %rdx
.L1117:
	xorl	%r11d, %r11d
	cmpb	$32, (%rcx)
	setg	%r11b
	incq	%rcx
	addq	%r11, %rdx
.L1116:
	xorl	%edi, %edi
	cmpb	$32, (%rcx)
	setg	%dil
	incq	%rcx
	addq	%rdi, %rdx
.L1115:
	xorl	%r8d, %r8d
	cmpb	$32, (%rcx)
	setg	%r8b
	incq	%rcx
	addq	%r8, %rdx
	cmpq	%rcx, %rsi
	jb	.L1145
.L1021:
	xorl	%ebx, %ebx
	cmpb	$32, (%rcx)
	setg	%bl
	xorl	%r13d, %r13d
	addq	%rbx, %rdx
	cmpb	$32, 1(%rcx)
	setg	%r13b
	xorl	%r10d, %r10d
	addq	%r13, %rdx
	cmpb	$32, 2(%rcx)
	setg	%r10b
	xorl	%eax, %eax
	addq	%r10, %rdx
	cmpb	$32, 3(%rcx)
	setg	%al
	xorl	%r11d, %r11d
	addq	%rax, %rdx
	cmpb	$32, 4(%rcx)
	setg	%r11b
	xorl	%edi, %edi
	addq	%r11, %rdx
	cmpb	$32, 5(%rcx)
	setg	%dil
	xorl	%r8d, %r8d
	addq	%rdi, %rdx
	cmpb	$32, 6(%rcx)
	setg	%r8b
	xorl	%ebx, %ebx
	addq	%r8, %rdx
	cmpb	$32, 7(%rcx)
	setg	%bl
	addq	$8, %rcx
	addq	%rbx, %rdx
	cmpq	%rcx, %rsi
	jb	.L1145
	jmp	.L1021
	.p2align 4,,10
	.p2align 3
.L1167:
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
	jmp	.L1058
.L1166:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L1055
.L1165:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L1052
.L1028:
	movq	%rdi, %r12
	jmp	.L1006
.L1161:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r9, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC3(%rip), %ymm3
	vmovdqa	.LC4(%rip), %ymm2
	vmovdqa	.LC5(%rip), %ymm6
	vmovdqa	.LC15(%rip), %ymm8
	jmp	.L1019
.L1164:
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rax)
	setle	%r11b
	addq	%r11, %rdx
	jmp	.L1046
.L1168:
	xorl	%edx, %edx
	cmpb	$32, 1(%r9)
	setg	%dl
	incq	%rcx
	addq	%rbx, %rdx
	jmp	.L1120
	.cfi_endproc
.LFE8984:
	.size	_ZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m, .-_ZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.text
	.p2align 4
	.globl	_Z13probe_parse4tPcPjm
	.type	_Z13probe_parse4tPcPjm, @function
_Z13probe_parse4tPcPjm:
.LFB8961:
	.cfi_startproc
	jmp	_ZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.cfi_endproc
.LFE8961:
	.size	_Z13probe_parse4tPcPjm, .-_Z13probe_parse4tPcPjm
	.weak	_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region
	.section	.bss._ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region,"awG",@nobits,_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region,comdat
	.align 64
	.type	_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region, @gnu_unique_object
	.size	_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region, 800256
_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region:
	.zero	800256
	.weak	_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region
	.section	.bss._ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region,"awG",@nobits,_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region,comdat
	.align 64
	.type	_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region, @gnu_unique_object
	.size	_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region, 800256
_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region:
	.zero	800256
	.weak	_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region
	.section	.bss._ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region,"awG",@nobits,_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region,comdat
	.align 64
	.type	_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region, @gnu_unique_object
	.size	_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region, 800256
_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region:
	.zero	800256
	.weak	_ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region
	.section	.bss._ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region,"awG",@nobits,_ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region,comdat
	.align 64
	.type	_ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, @gnu_unique_object
	.size	_ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, 266752
_ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region:
	.zero	266752
	.weak	_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region
	.section	.bss._ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region,"awG",@nobits,_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region,comdat
	.align 64
	.type	_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, @gnu_unique_object
	.size	_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, 393984
_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region:
	.zero	393984
	.weak	_ZN10qp_fmt_asm6constsE
	.section	.rodata._ZN10qp_fmt_asm6constsE,"aG",@progbits,_ZN10qp_fmt_asm6constsE,comdat
	.align 32
	.type	_ZN10qp_fmt_asm6constsE, @gnu_unique_object
	.size	_ZN10qp_fmt_asm6constsE, 992
_ZN10qp_fmt_asm6constsE:
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	10000
	.long	10000
	.long	10000
	.long	10000
	.long	10000
	.long	10000
	.long	10000
	.long	10000
	.long	9
	.long	9
	.long	9
	.long	9
	.long	9
	.long	9
	.long	9
	.long	9
	.long	99
	.long	99
	.long	99
	.long	99
	.long	99
	.long	99
	.long	99
	.long	99
	.long	999
	.long	999
	.long	999
	.long	999
	.long	999
	.long	999
	.long	999
	.long	999
	.long	9999
	.long	9999
	.long	9999
	.long	9999
	.long	9999
	.long	9999
	.long	9999
	.long	9999
	.long	99999
	.long	99999
	.long	99999
	.long	99999
	.long	99999
	.long	99999
	.long	99999
	.long	99999
	.long	999999
	.long	999999
	.long	999999
	.long	999999
	.long	999999
	.long	999999
	.long	999999
	.long	999999
	.long	9999999
	.long	9999999
	.long	9999999
	.long	9999999
	.long	9999999
	.long	9999999
	.long	9999999
	.long	9999999
	.long	99999999
	.long	99999999
	.long	99999999
	.long	99999999
	.long	99999999
	.long	99999999
	.long	99999999
	.long	99999999
	.long	255
	.long	255
	.long	255
	.long	255
	.long	255
	.long	255
	.long	255
	.long	255
	.long	65280
	.long	65280
	.long	65280
	.long	65280
	.long	65280
	.long	65280
	.long	65280
	.long	65280
	.long	16711680
	.long	16711680
	.long	16711680
	.long	16711680
	.long	16711680
	.long	16711680
	.long	16711680
	.long	16711680
	.long	-16777216
	.long	-16777216
	.long	-16777216
	.long	-16777216
	.long	-16777216
	.long	-16777216
	.long	-16777216
	.long	-16777216
	.long	343610491
	.long	343610491
	.long	343610491
	.long	343610491
	.long	343610491
	.long	343610491
	.long	343610491
	.long	343610491
	.long	65436
	.long	65436
	.long	65436
	.long	65436
	.long	65436
	.long	65436
	.long	65436
	.long	65436
	.long	429529498
	.long	429529498
	.long	429529498
	.long	429529498
	.long	429529498
	.long	429529498
	.long	429529498
	.long	429529498
	.long	16122102
	.long	16122102
	.long	16122102
	.long	16122102
	.long	16122102
	.long	16122102
	.long	16122102
	.long	16122102
	.long	808464432
	.long	808464432
	.long	808464432
	.long	808464432
	.long	808464432
	.long	808464432
	.long	808464432
	.long	808464432
	.long	538976288
	.long	538976288
	.long	538976288
	.long	538976288
	.long	538976288
	.long	538976288
	.long	538976288
	.long	538976288
	.long	536870960
	.long	536870960
	.long	536870960
	.long	536870960
	.long	536870960
	.long	536870960
	.long	536870960
	.long	536870960
	.long	16909184
	.long	84281088
	.long	-2139062268
	.long	-2139062144
	.long	16909184
	.long	84281088
	.long	-2139062268
	.long	-2139062144
	.long	151653248
	.long	219025160
	.long	-2139062260
	.long	-2139062144
	.long	151653248
	.long	219025160
	.long	-2139062260
	.long	-2139062144
	.long	-2139062272
	.long	-2139062144
	.long	-2139094144
	.long	-2139062144
	.long	-2139062272
	.long	-2139062144
	.long	-2139094144
	.long	-2139062144
	.long	-2139062268
	.long	-2139062144
	.long	-2139093120
	.long	-2139062144
	.long	-2139062268
	.long	-2139062144
	.long	-2139093120
	.long	-2139062144
	.long	-2139062264
	.long	-2139062144
	.long	-2139092096
	.long	-2139062144
	.long	-2139062264
	.long	-2139062144
	.long	-2139092096
	.long	-2139062144
	.long	-2139062260
	.long	-2139062144
	.long	-2139091072
	.long	-2139062144
	.long	-2139062260
	.long	-2139062144
	.long	-2139091072
	.long	-2139062144
	.long	16909184
	.long	84281088
	.long	192970756
	.long	252184842
	.long	-2146693874
	.long	-2139062144
	.long	-2139062144
	.long	-2139062144
	.long	-2139062272
	.long	-2139062144
	.long	-2147220608
	.long	-2139062144
	.long	125862016
	.long	-2139062144
	.long	-2139062144
	.long	-2139062144
	.long	-2139062264
	.long	-2139062144
	.long	-2146694272
	.long	-2139062144
	.long	260079744
	.long	-2139062144
	.long	-2139062144
	.long	-2139062144
	.weak	_ZN12qp_parse_ms44rowsE
	.section	.rodata._ZN12qp_parse_ms44rowsE,"aG",@progbits,_ZN12qp_parse_ms44rowsE,comdat
	.align 32
	.type	_ZN12qp_parse_ms44rowsE, @gnu_unique_object
	.size	_ZN12qp_parse_ms44rowsE, 1056
_ZN12qp_parse_ms44rowsE:
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
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
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
	.byte	-128
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
	.long	0
	.long	4
	.long	1
	.long	5
	.long	2
	.long	6
	.long	3
	.long	7
	.align 32
.LC18:
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.align 32
.LC19:
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.align 32
.LC36:
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
.LC37:
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
.LC38:
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
.LC39:
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
.LC40:
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
.LC41:
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
	.ident	"GCC: (GNU) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
