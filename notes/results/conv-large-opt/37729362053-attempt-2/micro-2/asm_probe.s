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
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdx, %r13
	movq	%rdi, %rbx
	andq	$-64, %rsp
	subq	$8392, %rsp
	movl	$0, -56(%rsp)
	testq	%rdx, %rdx
	je	.L3
	vmovdqa	.LC8(%rip), %xmm6
	movq	%rsi, %r12
	movl	$1, %edx
	movl	$1, %r14d
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm7
	vmovdqa	.LC6(%rip), %ymm8
.L2:
	movl	$555819297, %eax
	leaq	2048(%rdx), %rdi
	vmovd	%eax, %xmm3
	vpbroadcastd	%xmm3, %ymm0
	vmovdqa	%ymm0, -88(%rsp)
	.p2align 4
	.p2align 3
.L16:
	leaq	-1(%r14), %rcx
	cmpq	%r13, %rcx
	jnb	.L20
	vmovdqa	-88(%rsp), %ymm1
	vmovd	%edx, %xmm10
	vpbroadcastd	%xmm10, %ymm11
	vpcmpgtb	31(%rbx,%rdx), %ymm1, %ymm9
	vpcmpgtb	-1(%rbx,%rdx), %ymm1, %ymm2
	vpmovmskb	%ymm9, %r9d
	vpmovmskb	%ymm2, %esi
	salq	$32, %r9
	orq	%rsi, %r9
	leaq	-56(%rsp,%r14,4), %rsi
	popcntq	%r9, %rcx
	.p2align 4
	.p2align 3
.L17:
	blsr	%r9, %r8
	tzcntq	%r9, %r15
	addq	$32, %rsi
	blsr	%r8, %r10
	tzcntq	%r8, %r9
	vmovq	%r15, %xmm12
	blsr	%r10, %rax
	tzcntq	%r10, %r11
	vpinsrq	$1, %r9, %xmm12, %xmm0
	blsr	%rax, %r8
	vmovq	%r11, %xmm13
	tzcntq	%rax, %r15
	blsr	%r8, %r11
	tzcntq	%r8, %r10
	vpinsrq	$1, %r15, %xmm13, %xmm3
	blsr	%r11, %rax
	vmovq	%r10, %xmm14
	tzcntq	%r11, %r8
	vinserti128	$0x1, %xmm3, %ymm0, %ymm9
	tzcntq	%rax, %r10
	blsr	%rax, %rax
	vpinsrq	$1, %r8, %xmm14, %xmm2
	vmovq	%r10, %xmm15
	tzcntq	%rax, %r11
	vpinsrq	$1, %r11, %xmm15, %xmm1
	vinserti128	$0x1, %xmm1, %ymm2, %ymm10
	vperm2i128	$32, %ymm10, %ymm9, %ymm12
	vperm2i128	$49, %ymm10, %ymm9, %ymm13
	vpshufd	$216, %ymm12, %ymm14
	vpshufd	$216, %ymm13, %ymm15
	vpunpcklqdq	%ymm15, %ymm14, %ymm3
	vpaddd	%ymm3, %ymm11, %ymm0
	vmovdqu	%ymm0, -32(%rsi)
	blsr	%rax, %r9
	jne	.L17
	addq	$64, %rdx
	addq	%rcx, %r14
	cmpq	%rdi, %rdx
	jne	.L16
.L20:
	vmovdqa	.LC9(%rip), %xmm12
	vmovdqa	.LC10(%rip), %xmm2
	movl	$808464432, %edi
	xorl	%esi, %esi
	vmovd	%edi, %xmm11
	vpbroadcastd	%xmm11, %xmm9
	vpbroadcastd	%xmm11, %ymm1
	.p2align 4
	.p2align 3
.L18:
	cmpq	$3, %r13
	jbe	.L21
.L123:
	leaq	4(%rsi), %rdi
	cmpq	%r14, %rdi
	jnb	.L22
	movl	-48(%rsp,%rsi,4), %r9d
	leaq	1(%rsi), %r10
	movl	-44(%rsp,%rsi,4), %r8d
	movq	%r10, -104(%rsp)
	movl	-56(%rsp,%r10,4), %r10d
	movl	-56(%rsp,%rsi,4), %ecx
	movl	%r9d, %r15d
	movl	%r8d, %r11d
	subl	%r10d, %r15d
	subl	%r9d, %r11d
	movl	%r10d, %esi
	movl	%r15d, -88(%rsp)
	movl	-56(%rsp,%rdi,4), %r15d
	movl	%r11d, -92(%rsp)
	subl	$2, %r11d
	subl	%ecx, %esi
	leal	-1(%rsi), %eax
	subl	$2, %esi
	subl	%r8d, %r15d
	movl	%r15d, -96(%rsp)
	subl	$2, %r15d
	orl	%r15d, %r11d
	movl	-88(%rsp), %r15d
	subl	$2, %r15d
	orl	%r15d, %esi
	orl	%esi, %r11d
	cmpl	$15, %r11d
	ja	.L28
	salq	$4, %rax
	vmovdqu	(%rbx,%r9), %xmm10
	movl	-96(%rsp), %r15d
	subq	$4, %r13
	vmovdqa	_ZN13qp_parse_flat11right_alignE(%rax), %xmm3
	movl	-92(%rsp), %eax
	addq	$16, %r12
	movl	-88(%rsp), %r9d
	vinserti128	$0x1, (%rbx,%r8), %ymm10, %ymm14
	vmovdqu	(%rbx,%rcx), %xmm0
	leal	-1(%r15), %esi
	vinserti128	$0x1, (%rbx,%r10), %ymm0, %ymm11
	movl	$100000000, %r10d
	leal	-1(%rax), %r11d
	salq	$4, %rsi
	leal	-1(%r9), %r8d
	salq	$4, %r11
	vmovdqa	_ZN13qp_parse_flat11right_alignE(%r11), %xmm10
	salq	$4, %r8
	vinserti128	$0x1, _ZN13qp_parse_flat11right_alignE(%r8), %ymm3, %ymm0
	vinserti128	$0x1, _ZN13qp_parse_flat11right_alignE(%rsi), %ymm10, %ymm3
	vmovd	%r10d, %xmm10
	movq	%rdi, %rsi
	vpsubusb	%ymm1, %ymm14, %ymm15
	vpsubusb	%ymm1, %ymm11, %ymm13
	vpshufb	%ymm0, %ymm13, %ymm11
	vpshufb	%ymm3, %ymm15, %ymm15
	vpmaddubsw	%ymm5, %ymm11, %ymm13
	vpmaddubsw	%ymm5, %ymm15, %ymm0
	vpbroadcastd	%xmm10, %ymm15
	vpmaddwd	%ymm4, %ymm0, %ymm11
	vpmaddwd	%ymm4, %ymm13, %ymm14
	vpackusdw	%ymm11, %ymm14, %ymm13
	vpmaddwd	%ymm7, %ymm13, %ymm14
	vpmulld	%ymm15, %ymm14, %ymm0
	vpsrlq	$32, %ymm14, %ymm3
	vpaddd	%ymm3, %ymm0, %ymm11
	vpermd	%ymm11, %ymm8, %ymm13
	vmovdqu	%xmm13, -16(%r12)
	cmpq	$3, %r13
	ja	.L123
.L21:
	testq	%r13, %r13
	je	.L124
.L22:
	leaq	1(%rsi), %r15
	cmpq	%r14, %r15
	jnb	.L25
	movl	-56(%rsp,%rsi,4), %ecx
	movq	%r15, %rsi
	movl	%ecx, %eax
	notl	%eax
	addl	-56(%rsp,%r15,4), %eax
.L23:
	testl	%eax, %eax
	je	.L18
	vmovdqu	(%rbx,%rcx), %xmm0
	movl	$16, %edi
	cmpl	%edi, %eax
	cmova	%edi, %eax
	decq	%r13
	addq	$4, %r12
	salq	$4, %rax
	vpsubusb	%xmm9, %xmm0, %xmm11
	vpshufb	_ZN13qp_parse_flat11right_alignE(%rax), %xmm11, %xmm10
	vpmaddubsw	%xmm6, %xmm10, %xmm13
	vpmaddwd	%xmm12, %xmm13, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm15
	vpmaddwd	%xmm2, %xmm15, %xmm3
	vmovq	%xmm3, %r10
	imull	$100000000, %r10d, %ecx
	shrq	$32, %r10
	addl	%ecx, %r10d
	movl	%r10d, -4(%r12)
	jmp	.L18
.L25:
	testq	%rsi, %rsi
	je	.L2
	cmpq	%r14, %rsi
	jnb	.L10
	movq	%r14, %r8
	subq	%rsi, %r8
	leaq	-1(%r8), %rcx
	cmpq	$2, %rcx
	jbe	.L6
	cmpq	$-8, %rsi
	ja	.L6
	cmpq	$6, %rcx
	jbe	.L27
	movq	%r8, %r9
	leaq	-56(%rsp,%rsi,4), %r15
	xorl	%ecx, %ecx
	shrq	$3, %r9
	salq	$5, %r9
	leaq	-32(%r9), %rdi
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
	vmovdqu	(%r15), %ymm10
	movl	$32, %ecx
	vmovdqa	%ymm10, -56(%rsp)
.L89:
	vmovdqu	(%r15,%rcx), %ymm13
	vmovdqa	%ymm13, -56(%rsp,%rcx)
	addq	$32, %rcx
.L88:
	vmovdqu	(%r15,%rcx), %ymm14
	vmovdqa	%ymm14, -56(%rsp,%rcx)
	addq	$32, %rcx
.L87:
	vmovdqu	(%r15,%rcx), %ymm15
	vmovdqa	%ymm15, -56(%rsp,%rcx)
	addq	$32, %rcx
.L86:
	vmovdqu	(%r15,%rcx), %ymm3
	vmovdqa	%ymm3, -56(%rsp,%rcx)
	addq	$32, %rcx
.L85:
	vmovdqu	(%r15,%rcx), %ymm0
	vmovdqa	%ymm0, -56(%rsp,%rcx)
	addq	$32, %rcx
.L84:
	vmovdqu	(%r15,%rcx), %ymm11
	vmovdqa	%ymm11, -56(%rsp,%rcx)
	addq	$32, %rcx
	cmpq	%rcx, %r9
	je	.L116
.L8:
	vmovdqu	(%r15,%rcx), %ymm9
	vmovdqa	%ymm9, -56(%rsp,%rcx)
	vmovdqu	32(%r15,%rcx), %ymm12
	vmovdqa	%ymm12, -24(%rsp,%rcx)
	vmovdqu	64(%r15,%rcx), %ymm2
	vmovdqa	%ymm2, 8(%rsp,%rcx)
	vmovdqu	96(%r15,%rcx), %ymm1
	vmovdqa	%ymm1, 40(%rsp,%rcx)
	vmovdqu	128(%r15,%rcx), %ymm10
	vmovdqa	%ymm10, 72(%rsp,%rcx)
	vmovdqu	160(%r15,%rcx), %ymm13
	vmovdqa	%ymm13, 104(%rsp,%rcx)
	vmovdqu	192(%r15,%rcx), %ymm14
	vmovdqa	%ymm14, 136(%rsp,%rcx)
	vmovdqu	224(%r15,%rcx), %ymm15
	vmovdqa	%ymm15, 168(%rsp,%rcx)
	addq	$256, %rcx
	cmpq	%rcx, %r9
	jne	.L8
.L116:
	testb	$7, %r8b
	je	.L10
	movq	%r8, %rax
	andq	$-8, %rax
	subq	%rax, %r8
	leaq	(%rsi,%rax), %r11
	leaq	-1(%r8), %r15
	movq	%r11, %r10
	cmpq	$2, %r15
	jbe	.L12
.L7:
	vmovdqu	-56(%rsp,%r11,4), %xmm3
	vmovdqa	%xmm3, -56(%rsp,%rax,4)
	testb	$3, %r8b
	je	.L10
	andq	$-4, %r8
	addq	%r8, %r10
.L12:
	movl	-56(%rsp,%r10,4), %r8d
	movq	%r10, %rax
	leaq	1(%r10), %r11
	subq	%rsi, %rax
	movl	%r8d, -56(%rsp,%rax,4)
	cmpq	%r14, %r11
	jnb	.L10
	movl	-56(%rsp,%r11,4), %r9d
	addq	$2, %r10
	subq	%rsi, %r11
	movl	%r9d, -56(%rsp,%r11,4)
	cmpq	%r14, %r10
	jnb	.L10
	movl	-56(%rsp,%r10,4), %edi
	subq	%rsi, %r10
	movl	%edi, -56(%rsp,%r10,4)
.L10:
	subq	%rsi, %r14
	jmp	.L2
.L124:
	movl	-56(%rsp,%rsi,4), %edx
	leaq	(%rbx,%rdx), %rbx
	vzeroupper
.L3:
	leaq	-40(%rbp), %rsp
	movq	%rbx, %rax
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
	movq	-104(%rsp), %rsi
	jmp	.L23
.L6:
	leaq	0(,%rsi,4), %r10
	leaq	-56(%rsp,%r14,4), %r15
	leaq	-56(%rsp,%r10), %rcx
	movq	%r15, %r8
	negq	%r10
	subq	%rcx, %r8
	subq	$4, %r8
	shrq	$2, %r8
	incq	%r8
	andl	$7, %r8d
	je	.L14
	cmpq	$1, %r8
	je	.L90
	cmpq	$2, %r8
	je	.L91
	cmpq	$3, %r8
	je	.L92
	cmpq	$4, %r8
	je	.L93
	cmpq	$5, %r8
	je	.L94
	cmpq	$6, %r8
	jne	.L125
.L95:
	movl	(%rcx), %r11d
	addq	$4, %rcx
	movl	%r11d, -4(%rcx,%r10)
.L94:
	movl	(%rcx), %r9d
	addq	$4, %rcx
	movl	%r9d, -4(%rcx,%r10)
.L93:
	movl	(%rcx), %edi
	addq	$4, %rcx
	movl	%edi, -4(%rcx,%r10)
.L92:
	movl	(%rcx), %r8d
	addq	$4, %rcx
	movl	%r8d, -4(%rcx,%r10)
.L91:
	movl	(%rcx), %eax
	addq	$4, %rcx
	movl	%eax, -4(%rcx,%r10)
.L90:
	movl	(%rcx), %r11d
	addq	$4, %rcx
	movl	%r11d, -4(%rcx,%r10)
	cmpq	%rcx, %r15
	je	.L10
.L14:
	movl	(%rcx), %r9d
	addq	$32, %rcx
	movl	%r9d, -32(%rcx,%r10)
	movl	-28(%rcx), %edi
	movl	%edi, -28(%rcx,%r10)
	movl	-24(%rcx), %r8d
	movl	%r8d, -24(%rcx,%r10)
	movl	-20(%rcx), %eax
	movl	%eax, -20(%rcx,%r10)
	movl	-16(%rcx), %r11d
	movl	%r11d, -16(%rcx,%r10)
	movl	-12(%rcx), %r9d
	movl	%r9d, -12(%rcx,%r10)
	movl	-8(%rcx), %edi
	movl	%edi, -8(%rcx,%r10)
	movl	-4(%rcx), %r8d
	movl	%r8d, -4(%rcx,%r10)
	cmpq	%rcx, %r15
	jne	.L14
	jmp	.L10
.L27:
	movq	%rsi, %r10
	xorl	%eax, %eax
	movq	%rsi, %r11
	jmp	.L7
.L125:
	movl	(%rcx), %eax
	addq	$4, %rcx
	movl	%eax, -4(%rcx,%r10)
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
	movq	%rdi, %r8
	movq	%rdx, %r11
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-64, %rsp
	subq	$704, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rsi, 344(%rsp)
	cmpq	$133312, %rdx
	jbe	.L172
	vmovdqa	.LC2(%rip), %ymm12
	movq	%rdx, 56(%rsp)
	vmovdqa	.LC3(%rip), %ymm11
	.p2align 4
	.p2align 3
.L171:
	movl	$555819297, %eax
	vpxor	%xmm7, %xmm7, %xmm7
	movq	$0, 336(%rsp)
	movq	%r8, 48(%rsp)
	vmovd	%eax, %xmm6
	vmovdqa	%ymm7, 448(%rsp)
	vpbroadcastd	%xmm6, %ymm0
	vmovdqa	%ymm0, 480(%rsp)
	vmovdqa	480(%rsp), %ymm1
	vpcmpgtb	66624(%r8), %ymm1, %ymm2
	vpcmpgtb	133248(%r8), %ymm1, %ymm3
	vpcmpgtb	199872(%r8), %ymm1, %ymm4
	vpcmpgtb	266496(%r8), %ymm1, %ymm5
	vpmovmskb	%ymm2, %edx
	vpmovmskb	%ymm3, %esi
	tzcntl	%edx, %ecx
	vpmovmskb	%ymm4, %r10d
	tzcntl	%esi, %edi
	movl	%ecx, %ebx
	movl	$808464432, %ecx
	vpmovmskb	%ymm5, %r13d
	tzcntl	%r10d, %r11d
	movl	%edi, %r9d
	leaq	66625(%r8,%rbx), %rbx
	tzcntl	%r13d, %r15d
	movl	%r11d, %r12d
	leaq	133249(%r8,%r9), %r14
	vmovd	%ecx, %xmm10
	movl	%r15d, %eax
	leaq	199873(%r8,%r12), %rsi
	movq	%rbx, 80(%rsp)
	movq	%r14, 72(%rsp)
	leaq	266497(%r8,%rax), %rdx
	movq	%rsi, 64(%rsp)
	vpbroadcastd	%xmm10, %ymm10
	movq	%r8, %r15
	movq	%rdx, 88(%rsp)
	movq	%r14, %r12
	.p2align 4
	.p2align 3
.L133:
	movq	72(%rsp), %r8
	movq	80(%rsp), %rdi
	movq	88(%rsp), %r9
	movq	64(%rsp), %r14
	subq	%rbx, %r8
	subq	%r15, %rdi
	cmpq	%rdi, %r8
	cmovg	%rdi, %r8
	subq	%rsi, %r9
	subq	%r12, %r14
	cmpq	%r14, %r9
	cmovg	%r14, %r9
	cmpq	%r9, %r8
	cmovg	%r9, %r8
	cmpq	$64, %r8
	jbe	.L304
	vmovdqa	480(%rsp), %ymm8
	vmovdqa	480(%rsp), %ymm3
	movabsq	$1135184250689818561, %rax
	movq	%r15, 512(%rsp)
	mulq	%r8
	movq	%rbx, 536(%rsp)
	movq	%r12, 560(%rsp)
	movq	%rsi, 584(%rsp)
	shrq	$2, %rdx
	movq	%rdx, %r14
	vpcmpgtb	(%r15), %ymm8, %ymm9
	vpcmpgtb	32(%r15), %ymm8, %ymm13
	vpmovmskb	%ymm9, %r10d
	vpcmpgtb	(%rbx), %ymm3, %ymm2
	vpcmpgtb	32(%rbx), %ymm3, %ymm4
	vpmovmskb	%ymm13, %edx
	blsr	%r10d, %r11d
	tzcntl	%r10d, %r8d
	blsr	%r11d, %r13d
	tzcntl	%r11d, %ecx
	salq	$32, %rdx
	vmovd	%r8d, %xmm6
	blsr	%r13d, %r9d
	tzcntl	%r13d, %edi
	movl	%r8d, 224(%rsp)
	vpinsrd	$1, %ecx, %xmm6, %xmm0
	vpmovmskb	%ymm2, %r11d
	movl	%r9d, %eax
	vmovd	%edi, %xmm14
	movl	%edi, 192(%rsp)
	blsr	%r11d, %r13d
	orq	%rdx, %rax
	tzcntl	%r11d, %r9d
	vpcmpgtb	32(%r12), %ymm3, %ymm6
	tzcntq	%rax, %r10
	blsr	%r13d, %r8d
	tzcntl	%r13d, %edx
	vmovd	%r9d, %xmm8
	vpinsrd	$1, %r10d, %xmm14, %xmm15
	leal	1(%r10), %edi
	vpcmpgtb	(%r12), %ymm3, %ymm14
	movl	%r10d, 324(%rsp)
	tzcntl	%r8d, %r10d
	blsr	%r8d, %eax
	movl	%r9d, 328(%rsp)
	vpunpcklqdq	%xmm15, %xmm0, %xmm1
	vmovd	%r10d, %xmm5
	vpmovmskb	%ymm4, %r13d
	movl	%r10d, 288(%rsp)
	movl	%eax, %r11d
	vpmovmskb	%ymm14, %r10d
	salq	$32, %r13
	vmovdqa	%ymm3, %ymm15
	addq	%r15, %rdi
	blsr	%r10d, %r9d
	orq	%r13, %r11
	tzcntl	%r10d, %r10d
	vmovdqu	%xmm1, 520(%rsp)
	blsr	%r9d, %eax
	tzcntq	%r11, %r8
	tzcntl	%r9d, %r11d
	vmovd	%r10d, %xmm2
	blsr	%eax, %r9d
	tzcntl	%eax, %r13d
	vpinsrd	$1, %r8d, %xmm5, %xmm7
	vpcmpgtb	(%rsi), %ymm15, %ymm5
	movl	%r9d, %eax
	vpinsrd	$1, %r11d, %xmm2, %xmm3
	movl	%r8d, 256(%rsp)
	movl	%r11d, 352(%rsp)
	vpmovmskb	%ymm6, %r9d
	leal	1(%r8), %r8d
	vmovd	%r13d, %xmm0
	movl	%r10d, 384(%rsp)
	salq	$32, %r9
	addq	%rbx, %r8
	movl	%r13d, 320(%rsp)
	vpinsrd	$1, %edx, %xmm8, %xmm9
	vpmovmskb	%ymm5, %r11d
	orq	%r9, %rax
	vpunpcklqdq	%xmm7, %xmm9, %xmm13
	vpcmpgtb	32(%rsi), %ymm15, %ymm7
	tzcntq	%rax, %rax
	vmovdqa	%xmm13, 544(%rsp)
	leal	1(%rax), %r9d
	vpinsrd	$1, %eax, %xmm0, %xmm1
	movl	%eax, 188(%rsp)
	addq	%r12, %r9
	blsr	%r11d, %r10d
	tzcntl	%r11d, %r11d
	vpunpcklqdq	%xmm1, %xmm3, %xmm4
	blsr	%r10d, %eax
	tzcntl	%r10d, %r13d
	vmovd	%r11d, %xmm13
	movl	%r11d, 184(%rsp)
	tzcntl	%eax, %r10d
	blsr	%eax, %eax
	vpinsrd	$1, %r13d, %xmm13, %xmm14
	movq	%r14, %r11
	movl	%r10d, 416(%rsp)
	vmovd	416(%rsp), %xmm8
	movl	%eax, %eax
	vmovdqu	%xmm4, 568(%rsp)
	vpmovmskb	%ymm7, %r10d
	salq	$32, %r10
	orq	%r10, %rax
	tzcntq	%rax, %rax
	leal	1(%rax), %r10d
	movl	%eax, 180(%rsp)
	addq	%rsi, %r10
	vpinsrd	$1, %eax, %xmm8, %xmm9
	vpunpcklqdq	%xmm9, %xmm14, %xmm15
	vmovdqa	%xmm15, 592(%rsp)
	decq	%r11
	je	.L305
	vmovdqa	.LC4(%rip), %ymm6
	movl	$100000000, %ebx
	xorl	%ecx, %ecx
	movq	%r14, 328(%rsp)
	vmovdqa	.LC14(%rip), %ymm2
	vmovd	%ebx, %xmm3
	movq	%r11, 256(%rsp)
	vmovdqa	%ymm12, 224(%rsp)
	vpbroadcastd	%xmm3, %ymm4
	vmovdqa	%ymm11, 192(%rsp)
	movq	336(%rsp), %rsi
	vmovdqa	%ymm4, 288(%rsp)
	vmovdqa	%ymm6, 96(%rsp)
	vmovdqa	%ymm2, 128(%rsp)
	.p2align 4
	.p2align 3
.L131:
	vmovdqa	480(%rsp), %ymm5
	movq	%rcx, %r15
	xorq	$1, %rcx
	leaq	(%rcx,%rcx,2), %r11
	salq	$5, %r11
	movq	%rdi, 512(%rsp,%r11)
	vpcmpgtb	(%rdi), %ymm5, %ymm7
	vpcmpgtb	32(%rdi), %ymm5, %ymm8
	vpmovmskb	%ymm7, %r12d
	blsr	%r12d, %r14d
	tzcntl	%r12d, %r13d
	blsr	%r14d, %edx
	tzcntl	%r14d, %ebx
	vmovd	%r13d, %xmm9
	tzcntl	%edx, %eax
	blsr	%edx, %r12d
	vpinsrd	$1, %ebx, %xmm9, %xmm15
	vpmovmskb	%ymm8, %edx
	movl	%r12d, %r14d
	vmovd	%eax, %xmm13
	salq	$32, %rdx
	orq	%r14, %rdx
	tzcntq	%rdx, %r13
	movq	%rcx, %rdx
	vpinsrd	$1, %r13d, %xmm13, %xmm14
	negq	%rdx
	leal	1(%r13), %ebx
	andl	$96, %edx
	vpunpcklqdq	%xmm14, %xmm15, %xmm0
	addq	%rbx, %rdi
	vmovdqu	%xmm0, 520(%rsp,%rdx)
	movq	%r8, 536(%rsp,%r11)
	vpcmpgtb	(%r8), %ymm5, %ymm1
	vpcmpgtb	32(%r8), %ymm5, %ymm6
	vpmovmskb	%ymm1, %eax
	blsr	%eax, %r12d
	tzcntl	%eax, %r14d
	blsr	%r12d, %r13d
	tzcntl	%r12d, %ebx
	vmovd	%r14d, %xmm2
	vpmovmskb	%ymm6, %r14d
	blsr	%r13d, %r12d
	tzcntl	%r13d, %eax
	vpinsrd	$1, %ebx, %xmm2, %xmm7
	movl	%r12d, %r13d
	salq	$32, %r14
	vmovd	%eax, %xmm3
	orq	%r13, %r14
	tzcntq	%r14, %rax
	vpinsrd	$1, %eax, %xmm3, %xmm4
	leal	1(%rax), %ebx
	vpunpcklqdq	%xmm4, %xmm7, %xmm8
	addq	%rbx, %r8
	vmovdqa	%xmm8, 544(%rsp,%rdx)
	movq	%r9, 560(%rsp,%r11)
	vpcmpgtb	(%r9), %ymm5, %ymm9
	vpcmpgtb	32(%r9), %ymm5, %ymm13
	vpmovmskb	%ymm9, %r12d
	blsr	%r12d, %r14d
	tzcntl	%r12d, %eax
	blsr	%r14d, %r13d
	tzcntl	%r14d, %ebx
	vmovd	%eax, %xmm14
	vpmovmskb	%ymm13, %eax
	blsr	%r13d, %r14d
	tzcntl	%r13d, %r12d
	vpinsrd	$1, %ebx, %xmm14, %xmm0
	movl	%r14d, %r13d
	salq	$32, %rax
	vmovd	%r12d, %xmm15
	orq	%r13, %rax
	tzcntq	%rax, %r12
	vpinsrd	$1, %r12d, %xmm15, %xmm1
	leal	1(%r12), %ebx
	vpunpcklqdq	%xmm1, %xmm0, %xmm6
	addq	%rbx, %r9
	vmovdqu	%xmm6, 568(%rsp,%rdx)
	movq	%r10, 584(%rsp,%r11)
	vpcmpgtb	(%r10), %ymm5, %ymm2
	vpcmpgtb	32(%r10), %ymm5, %ymm5
	vpmovmskb	%ymm2, %r14d
	blsr	%r14d, %r13d
	tzcntl	%r14d, %r11d
	blsr	%r13d, %r12d
	tzcntl	%r13d, %ebx
	vmovd	%r11d, %xmm3
	tzcntl	%r12d, %eax
	blsr	%r12d, %r14d
	vpinsrd	$1, %ebx, %xmm3, %xmm8
	vpmovmskb	%ymm5, %r12d
	movl	%r14d, %r13d
	vmovd	%eax, %xmm4
	salq	$32, %r12
	orq	%r13, %r12
	tzcntq	%r12, %r11
	vpinsrd	$1, %r11d, %xmm4, %xmm7
	leal	1(%r11), %ebx
	vpunpcklqdq	%xmm7, %xmm8, %xmm9
	addq	%rbx, %r10
	vmovdqa	%xmm9, 592(%rsp,%rdx)
	leaq	(%r15,%r15,2), %r15
	salq	$5, %r15
	leaq	512(%rsp,%r15), %rax
	movq	(%rax), %r11
	movl	16(%rax), %ebx
	movl	12(%rax), %r15d
	movl	8(%rax), %r14d
	vmovdqu	(%r11), %xmm13
	vmovdqu	1(%r11,%r15), %xmm15
	movq	%r15, %r12
	movl	%ebx, %r15d
	vinserti128	$0x1, 1(%r11,%r14), %ymm13, %ymm14
	vinserti128	$0x1, 1(%r11,%r15), %ymm15, %ymm0
	movq	%r14, %r13
	leal	1(%r14), %r11d
	movl	%r12d, %r14d
	salq	$4, %r11
	subl	%r13d, %r14d
	movl	%ebx, %r13d
	movl	36(%rax), %r15d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r11), %xmm1
	salq	$4, %r14
	subl	%r12d, %r13d
	movl	20(%rax), %r12d
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm1, %ymm2
	movq	24(%rax), %r11
	salq	$4, %r13
	movl	32(%rax), %r14d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm6
	subl	%ebx, %r12d
	movl	40(%rax), %ebx
	salq	$4, %r12
	vpsubusb	%ymm10, %ymm14, %ymm5
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm6, %ymm15
	vpsubusb	%ymm10, %ymm0, %ymm8
	vmovdqu	1(%r11,%r15), %xmm6
	movq	%r15, %r12
	vmovdqu	(%r11), %xmm0
	movq	%r14, %r13
	movl	%ebx, %r15d
	vinserti128	$0x1, 1(%r11,%r14), %ymm0, %ymm1
	vpshufb	%ymm2, %ymm5, %ymm3
	vpmaddubsw	%ymm12, %ymm3, %ymm4
	vinserti128	$0x1, 1(%r11,%r15), %ymm6, %ymm3
	leal	1(%r14), %r11d
	movl	%r12d, %r14d
	subl	%r13d, %r14d
	movl	%ebx, %r13d
	vpmaddwd	%ymm11, %ymm4, %ymm7
	salq	$4, %r11
	subl	%r12d, %r13d
	movl	44(%rax), %r12d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r11), %xmm5
	salq	$4, %r14
	salq	$4, %r13
	movq	48(%rax), %r11
	vmovdqa	%ymm7, 416(%rsp)
	vpshufb	%ymm15, %ymm8, %ymm9
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm4
	vpor	%ymm15, %ymm2, %ymm2
	vpmaddubsw	%ymm12, %ymm9, %ymm13
	subl	%ebx, %r12d
	vpmaddwd	%ymm11, %ymm13, %ymm14
	vpsubusb	%ymm10, %ymm1, %ymm7
	salq	$4, %r12
	vmovdqa	%ymm14, 384(%rsp)
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm5, %ymm14
	movl	56(%rax), %r14d
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm4, %ymm13
	vpsubusb	%ymm10, %ymm3, %ymm0
	vmovdqu	(%r11), %xmm4
	movq	%r14, %r13
	vpshufb	%ymm14, %ymm7, %ymm8
	vpshufb	%ymm13, %ymm0, %ymm1
	vpmaddubsw	%ymm12, %ymm8, %ymm9
	vpmaddubsw	%ymm12, %ymm1, %ymm6
	vpmaddwd	%ymm11, %ymm9, %ymm5
	vpmaddwd	%ymm11, %ymm6, %ymm3
	vmovdqa	%ymm3, 352(%rsp)
	vinserti128	$0x1, 1(%r11,%r14), %ymm4, %ymm7
	movl	64(%rax), %ebx
	movl	60(%rax), %r15d
	vpor	448(%rsp), %ymm2, %ymm15
	vmovdqu	1(%r11,%r15), %xmm8
	movq	%r15, %r12
	movl	%ebx, %r15d
	vinserti128	$0x1, 1(%r11,%r15), %ymm8, %ymm0
	leal	1(%r14), %r11d
	movl	%r12d, %r14d
	movl	84(%rax), %r15d
	subl	%r13d, %r14d
	movl	%ebx, %r13d
	salq	$4, %r11
	subl	%r12d, %r13d
	movl	68(%rax), %r12d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r11), %xmm9
	salq	$4, %r14
	salq	$4, %r13
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm9, %ymm9
	movq	72(%rax), %r11
	vpsubusb	%ymm10, %ymm7, %ymm6
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm1
	movl	80(%rax), %r14d
	vpor	%ymm14, %ymm15, %ymm14
	vpor	%ymm13, %ymm14, %ymm13
	subl	%ebx, %r12d
	movl	88(%rax), %ebx
	movl	92(%rax), %eax
	salq	$4, %r12
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm1, %ymm8
	vpsubusb	%ymm10, %ymm0, %ymm7
	movq	%r15, %r12
	movq	%r14, %r13
	subl	%ebx, %eax
	vpshufb	%ymm9, %ymm6, %ymm3
	salq	$4, %rax
	vpor	%ymm9, %ymm13, %ymm9
	vpmaddubsw	%ymm12, %ymm3, %ymm4
	vmovdqu	(%r11), %xmm3
	vpmaddwd	%ymm11, %ymm4, %ymm1
	vinserti128	$0x1, 1(%r11,%r14), %ymm3, %ymm4
	vpshufb	%ymm8, %ymm7, %ymm0
	vmovdqu	1(%r11,%r15), %xmm7
	movl	%ebx, %r15d
	vpor	%ymm8, %ymm9, %ymm8
	vinserti128	$0x1, 1(%r11,%r15), %ymm7, %ymm3
	leal	1(%r14), %r11d
	movl	%r12d, %r14d
	vpmaddubsw	%ymm12, %ymm0, %ymm6
	subl	%r13d, %r14d
	movl	%ebx, %r13d
	salq	$4, %r11
	vpmaddwd	%ymm11, %ymm6, %ymm0
	subl	%r12d, %r13d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r11), %xmm6
	salq	$4, %r14
	salq	$4, %r13
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm6, %ymm7
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm6
	vpsubusb	%ymm10, %ymm4, %ymm4
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm6, %ymm6
	vpsubusb	%ymm10, %ymm3, %ymm3
	vpor	%ymm7, %ymm8, %ymm2
	vpshufb	%ymm7, %ymm4, %ymm7
	vpmaddubsw	%ymm12, %ymm7, %ymm14
	vpor	%ymm6, %ymm2, %ymm15
	vmovdqa	416(%rsp), %ymm2
	vpmaddwd	%ymm11, %ymm14, %ymm13
	vpshufb	%ymm6, %ymm3, %ymm6
	vpackusdw	%ymm13, %ymm1, %ymm1
	vmovdqa	%ymm15, 448(%rsp)
	vpmaddwd	.LC4(%rip), %ymm1, %ymm4
	vpmaddubsw	%ymm12, %ymm6, %ymm9
	vmovdqa	288(%rsp), %ymm14
	vpmaddwd	%ymm11, %ymm9, %ymm8
	vmovdqa	.LC14(%rip), %ymm9
	vpackusdw	%ymm8, %ymm0, %ymm0
	vpackusdw	%ymm5, %ymm2, %ymm5
	vpmaddwd	.LC4(%rip), %ymm5, %ymm15
	vmovdqa	384(%rsp), %ymm2
	vpmaddwd	.LC4(%rip), %ymm0, %ymm8
	movq	344(%rsp), %rbx
	vshufps	$136, %ymm4, %ymm15, %ymm7
	vshufps	$221, %ymm4, %ymm15, %ymm3
	vpackusdw	352(%rsp), %ymm2, %ymm15
	vpmaddwd	.LC4(%rip), %ymm15, %ymm1
	vpmulld	%ymm14, %ymm7, %ymm13
	vpaddd	%ymm3, %ymm13, %ymm6
	vpermd	%ymm6, %ymm9, %ymm5
	vshufps	$136, %ymm8, %ymm1, %ymm4
	vpmulld	%ymm14, %ymm4, %ymm7
	vshufps	$221, %ymm8, %ymm1, %ymm14
	vpaddd	%ymm14, %ymm7, %ymm13
	vpermd	%ymm13, %ymm9, %ymm3
	vpunpcklqdq	%ymm3, %ymm5, %ymm6
	vpunpckhqdq	%ymm3, %ymm5, %ymm9
	vmovdqu	%xmm6, (%rbx,%rsi,4)
	vextracti128	$0x1, %ymm6, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266752(,%rsi,4)
	vextracti128	$0x1, %ymm9, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533504(,%rsi,4)
	vmovdqa	%xmm9, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region(,%rsi,4)
	addq	$4, %rsi
	decq	256(%rsp)
	jne	.L131
	leaq	512(%rsp,%rdx), %r15
	movq	328(%rsp), %rsi
	movq	336(%rsp), %rcx
	movl	60(%r15), %r11d
	movl	40(%r15), %r14d
	movl	44(%r15), %r13d
	movl	32(%r15), %eax
	movl	56(%r15), %edx
	movl	8(%r15), %ebx
	leaq	-4(%rcx,%rsi,4), %r12
	movl	16(%r15), %esi
	vmovdqa	224(%rsp), %ymm6
	movq	%r12, 336(%rsp)
	movl	%r11d, 352(%rsp)
	movl	20(%r15), %r12d
	movl	64(%r15), %r11d
	movl	%r14d, 288(%rsp)
	movl	%r13d, 256(%rsp)
	movl	%eax, 328(%rsp)
	movl	%edx, 384(%rsp)
	movl	%ebx, 224(%rsp)
	movl	68(%r15), %r14d
	movq	(%r15), %r13
	movl	%r12d, 324(%rsp)
	movl	%r11d, 320(%rsp)
	movq	%r9, %r12
	movq	72(%r15), %rax
	vmovdqa	192(%rsp), %ymm7
	movl	%esi, 192(%rsp)
	movl	36(%r15), %edx
	movl	12(%r15), %ecx
	movq	48(%r15), %r11
	movl	%r14d, 188(%rsp)
	movq	%r13, 168(%rsp)
	movq	24(%r15), %r14
	movq	%rax, 160(%rsp)
	movl	80(%r15), %ebx
	movl	88(%r15), %esi
	movl	84(%r15), %r13d
	movl	92(%r15), %r15d
	movl	%ebx, 184(%rsp)
	movq	%r8, %rbx
	movl	%esi, 416(%rsp)
	movq	%r10, %rsi
	movl	%r15d, 180(%rsp)
	movq	%rdi, %r15
.L132:
	movq	168(%rsp), %r8
	movl	%ecx, %edi
	movl	224(%rsp), %eax
	movl	328(%rsp), %r10d
	vmovdqu	1(%r8,%rdi), %xmm1
	vmovdqu	(%r8), %xmm2
	movl	192(%rsp), %edi
	vinserti128	$0x1, 1(%r8,%rax), %ymm2, %ymm15
	movq	%rax, %r9
	incl	%eax
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm0
	movl	%ecx, %eax
	subl	%r9d, %eax
	movl	%edi, %r9d
	vinserti128	$0x1, 1(%r8,%rdi), %ymm1, %ymm8
	salq	$4, %rax
	movq	%r10, %r8
	subl	%ecx, %r9d
	movl	324(%rsp), %ecx
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm0, %ymm0
	salq	$4, %r9
	movl	288(%rsp), %eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r9), %xmm4
	movl	%r13d, %r9d
	vpsubusb	%ymm10, %ymm15, %ymm13
	subl	%edi, %ecx
	movl	%edx, %edi
	salq	$4, %rcx
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rcx), %ymm4, %ymm14
	vmovdqu	(%r14), %xmm4
	movl	%eax, %ecx
	vpsubusb	%ymm10, %ymm8, %ymm2
	subl	%edx, %ecx
	vpshufb	%ymm0, %ymm13, %ymm3
	vmovdqu	1(%r14,%rdi), %xmm13
	salq	$4, %rcx
	movl	352(%rsp), %edi
	vpmaddubsw	%ymm6, %ymm3, %ymm9
	vinserti128	$0x1, 1(%r14,%r10), %ymm4, %ymm3
	incl	%r10d
	vpmaddwd	%ymm7, %ymm9, %ymm5
	salq	$4, %r10
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm9
	vmovdqa	%ymm5, 224(%rsp)
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm5
	movl	384(%rsp), %r10d
	vpshufb	%ymm14, %ymm2, %ymm15
	vpor	%ymm14, %ymm0, %ymm0
	vpmaddubsw	%ymm6, %ymm15, %ymm1
	vinserti128	$0x1, 1(%r14,%rax), %ymm13, %ymm15
	movl	%edx, %r14d
	movl	256(%rsp), %edx
	subl	%r8d, %r14d
	vpmaddwd	%ymm7, %ymm1, %ymm8
	movq	%r10, %r8
	salq	$4, %r14
	vpsubusb	%ymm10, %ymm3, %ymm2
	vmovdqa	%ymm8, 192(%rsp)
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm9, %ymm13
	subl	%eax, %edx
	salq	$4, %rdx
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rdx), %ymm5, %ymm9
	vpsubusb	%ymm10, %ymm15, %ymm3
	vpshufb	%ymm13, %ymm2, %ymm1
	vpmaddubsw	%ymm6, %ymm1, %ymm8
	vmovdqu	(%r11), %xmm1
	vpmaddwd	%ymm7, %ymm8, %ymm4
	vmovdqu	1(%r11,%rdi), %xmm8
	vpshufb	%ymm9, %ymm3, %ymm15
	vmovdqa	%ymm4, 288(%rsp)
	vinserti128	$0x1, 1(%r11,%r10), %ymm1, %ymm4
	incl	%r10d
	vpmaddubsw	%ymm6, %ymm15, %ymm5
	salq	$4, %r10
	vpmaddwd	%ymm7, %ymm5, %ymm2
	vmovdqa	%ymm2, 256(%rsp)
	movl	320(%rsp), %eax
	movl	188(%rsp), %edx
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm15
	vpor	448(%rsp), %ymm0, %ymm14
	movl	%eax, %ecx
	vinserti128	$0x1, 1(%r11,%rax), %ymm8, %ymm3
	movl	%edi, %r11d
	subl	%eax, %edx
	subl	%edi, %ecx
	subl	%r8d, %r11d
	salq	$4, %rdx
	movl	416(%rsp), %eax
	salq	$4, %rcx
	salq	$4, %r11
	movq	160(%rsp), %rdi
	movl	184(%rsp), %r8d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm5
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm15, %ymm8
	vpsubusb	%ymm10, %ymm4, %ymm2
	movl	%r13d, %r11d
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rdx), %ymm5, %ymm5
	movl	$100000000, %edx
	movl	%eax, %ecx
	subl	%r13d, %ecx
	movl	180(%rsp), %r13d
	movq	%r8, %r10
	vpor	%ymm13, %ymm14, %ymm13
	subl	%r10d, %r11d
	salq	$4, %rcx
	vpor	%ymm9, %ymm13, %ymm9
	vpsubusb	%ymm10, %ymm3, %ymm3
	salq	$4, %r11
	subl	%eax, %r13d
	vpshufb	%ymm8, %ymm2, %ymm1
	salq	$4, %r13
	vpor	%ymm8, %ymm9, %ymm8
	vpshufb	%ymm5, %ymm3, %ymm2
	vmovdqu	(%rdi), %xmm3
	vpmaddubsw	%ymm6, %ymm1, %ymm4
	vpor	%ymm5, %ymm8, %ymm5
	vpmaddubsw	%ymm6, %ymm2, %ymm1
	vinserti128	$0x1, 1(%rdi,%r8), %ymm3, %ymm2
	incl	%r8d
	vpmaddwd	%ymm7, %ymm4, %ymm15
	salq	$4, %r8
	vpmaddwd	%ymm7, %ymm1, %ymm4
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm3
	vmovdqu	1(%rdi,%r9), %xmm1
	vmovdqa	%ymm4, 384(%rsp)
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r8), %xmm4
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm3, %ymm3
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm4, %ymm4
	vmovdqa	224(%rsp), %ymm8
	vinserti128	$0x1, 1(%rdi,%rax), %ymm1, %ymm1
	vpsubusb	%ymm10, %ymm2, %ymm2
	vpor	%ymm4, %ymm5, %ymm0
	vpshufb	%ymm4, %ymm2, %ymm4
	vpackusdw	288(%rsp), %ymm8, %ymm5
	vpmaddubsw	%ymm6, %ymm4, %ymm13
	vpor	%ymm3, %ymm0, %ymm14
	vpsubusb	%ymm10, %ymm1, %ymm1
	vpmaddwd	%ymm7, %ymm13, %ymm9
	vmovdqa	%ymm14, 448(%rsp)
	vpmaddwd	96(%rsp), %ymm5, %ymm14
	vpshufb	%ymm3, %ymm1, %ymm3
	vpackusdw	%ymm9, %ymm15, %ymm15
	vpmaddwd	96(%rsp), %ymm15, %ymm2
	vpmaddubsw	%ymm6, %ymm3, %ymm6
	vmovd	%edx, %xmm4
	vmovdqa	192(%rsp), %ymm5
	vpmaddwd	%ymm7, %ymm6, %ymm7
	vmovdqa	128(%rsp), %ymm6
	vpbroadcastd	%xmm4, %ymm13
	vshufps	$136, %ymm2, %ymm14, %ymm0
	vshufps	$221, %ymm2, %ymm14, %ymm1
	vpackusdw	256(%rsp), %ymm5, %ymm14
	vpmaddwd	96(%rsp), %ymm14, %ymm15
	vmovdqa	384(%rsp), %ymm2
	movq	336(%rsp), %r10
	movq	344(%rsp), %r8
	vpmulld	%ymm13, %ymm0, %ymm9
	vpaddd	%ymm1, %ymm9, %ymm3
	vpermd	%ymm3, %ymm6, %ymm8
	vpackusdw	%ymm7, %ymm2, %ymm7
	vpmaddwd	96(%rsp), %ymm7, %ymm0
	vshufps	$136, %ymm0, %ymm15, %ymm4
	vshufps	$221, %ymm0, %ymm15, %ymm9
	vpmulld	%ymm13, %ymm4, %ymm13
	vpaddd	%ymm9, %ymm13, %ymm1
	vpermd	%ymm1, %ymm6, %ymm3
	vpunpcklqdq	%ymm3, %ymm8, %ymm6
	vpunpckhqdq	%ymm3, %ymm8, %ymm8
	vmovdqu	%xmm6, (%r8,%r10,4)
	vextracti128	$0x1, %ymm6, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266752(,%r10,4)
	vextracti128	$0x1, %ymm8, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533504(,%r10,4)
	vmovdqa	%xmm8, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region(,%r10,4)
	addq	$4, %r10
	movq	%r10, 336(%rsp)
	jmp	.L133
	.p2align 4
	.p2align 3
.L304:
	movq	%r15, %r11
	movq	%r12, %r14
	movq	48(%rsp), %r8
	movq	336(%rsp), %r13
	movq	%rbx, %r15
	movq	%rsi, %r12
	cmpq	80(%rsp), %r11
	jnb	.L130
	vmovdqa	.LC8(%rip), %xmm11
	vmovdqa	.LC9(%rip), %xmm12
	movl	$555819297, %esi
	movl	$808464432, %ebx
	vmovdqa	.LC10(%rip), %xmm10
	vmovdqa	448(%rsp), %ymm7
	vmovd	%esi, %xmm14
	vmovd	%ebx, %xmm2
	movq	80(%rsp), %rdi
	movq	344(%rsp), %r9
	vpbroadcastd	%xmm14, %xmm15
	vpbroadcastd	%xmm2, %xmm4
	.p2align 4
	.p2align 3
.L129:
	vmovdqu	(%r11), %xmm0
	incq	%r13
	vpcmpgtb	%xmm0, %xmm15, %xmm13
	vpsubusb	%xmm4, %xmm0, %xmm3
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %ecx
	incl	%ecx
	movq	%rcx, %rdx
	addq	%rcx, %r11
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm9
	vpshufb	%xmm9, %xmm3, %xmm6
	vmovdqa	%xmm9, %xmm1
	vpmaddubsw	%xmm11, %xmm6, %xmm8
	vpor	%ymm1, %ymm7, %ymm7
	vpmaddwd	%xmm12, %xmm8, %xmm5
	vpackusdw	%xmm5, %xmm5, %xmm14
	vpmaddwd	%xmm10, %xmm14, %xmm2
	vmovq	%xmm2, %r10
	imull	$100000000, %r10d, %esi
	shrq	$32, %r10
	addl	%esi, %r10d
	movl	%r10d, -4(%r9,%r13,4)
	cmpq	%rdi, %r11
	jb	.L129
	vmovdqa	%ymm7, 448(%rsp)
.L130:
	movq	336(%rsp), %r9
	movq	72(%rsp), %rdx
	cmpq	$66687, %r9
	setbe	%cl
	cmpq	%rdx, %r15
	jnb	.L175
	testb	%cl, %cl
	je	.L175
	movl	$555819297, %edi
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm11
	vmovdqa	.LC9(%rip), %xmm12
	vmovd	%edi, %xmm15
	vmovd	%eax, %xmm0
	vmovdqa	.LC10(%rip), %xmm10
	movq	%r9, %rbx
	vpbroadcastd	%xmm15, %xmm4
	vpbroadcastd	%xmm0, %xmm13
	testb	$1, %r9b
	jne	.L286
	vmovdqa	448(%rsp), %ymm6
	jmp	.L135
	.p2align 4
	.p2align 3
.L306:
	vmovdqu	(%r15), %xmm9
	incq	%rbx
	vpcmpgtb	%xmm9, %xmm4, %xmm1
	vpsubusb	%xmm13, %xmm9, %xmm8
	vpmovmskb	%xmm1, %eax
	tzcntl	%eax, %r10d
	incl	%r10d
	movq	%r10, %rsi
	addq	%r10, %r15
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm3
	vpshufb	%xmm3, %xmm8, %xmm5
	vmovdqa	%xmm3, %xmm7
	vpmaddubsw	%xmm11, %xmm5, %xmm14
	vpor	%ymm7, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm14, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm15
	vpmaddwd	%xmm10, %xmm15, %xmm0
	vmovq	%xmm0, %r9
	imull	$100000000, %r9d, %edi
	shrq	$32, %r9
	addl	%edi, %r9d
	movl	%r9d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region-4(,%rbx,4)
	cmpq	%rdx, %r15
	jnb	.L294
	cmpq	$66688, %rbx
	je	.L294
.L135:
	vmovdqu	(%r15), %xmm9
	incq	%rbx
	vpcmpgtb	%xmm9, %xmm4, %xmm1
	vpsubusb	%xmm13, %xmm9, %xmm8
	vpmovmskb	%xmm1, %eax
	tzcntl	%eax, %r10d
	incl	%r10d
	movq	%r10, %rsi
	addq	%r10, %r15
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm3
	vpshufb	%xmm3, %xmm8, %xmm5
	vmovdqa	%xmm3, %xmm7
	vpmaddubsw	%xmm11, %xmm5, %xmm14
	vpor	%ymm7, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm14, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm15
	vpmaddwd	%xmm10, %xmm15, %xmm0
	vmovq	%xmm0, %r9
	imull	$100000000, %r9d, %edi
	shrq	$32, %r9
	addl	%edi, %r9d
	movl	%r9d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region-4(,%rbx,4)
	cmpq	%rdx, %r15
	jb	.L306
.L294:
	vmovdqa	%ymm6, 448(%rsp)
.L134:
	movq	64(%rsp), %rdx
	cmpq	%rdx, %r14
	jnb	.L176
.L310:
	testb	%cl, %cl
	je	.L176
	movq	336(%rsp), %rax
	movl	$555819297, %r10d
	movl	$808464432, %esi
	vmovdqa	.LC8(%rip), %xmm11
	vmovd	%r10d, %xmm4
	vmovd	%esi, %xmm9
	vmovdqa	.LC9(%rip), %xmm12
	vmovdqa	.LC10(%rip), %xmm10
	vpbroadcastd	%xmm4, %xmm13
	vpbroadcastd	%xmm9, %xmm1
	movq	%rax, %r9
	testb	$1, %al
	jne	.L288
	vmovdqa	448(%rsp), %ymm6
	jmp	.L138
	.p2align 4
	.p2align 3
.L307:
	vmovdqu	(%r14), %xmm3
	incq	%r9
	vpcmpgtb	%xmm3, %xmm13, %xmm7
	vpsubusb	%xmm1, %xmm3, %xmm14
	vpmovmskb	%xmm7, %eax
	tzcntl	%eax, %r10d
	incl	%r10d
	movq	%r10, %rdi
	addq	%r10, %r14
	salq	$4, %rdi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdi), %xmm5
	vpshufb	%xmm5, %xmm14, %xmm2
	vmovdqa	%xmm5, %xmm8
	vpmaddubsw	%xmm11, %xmm2, %xmm15
	vpor	%ymm8, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm15, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm4
	vpmaddwd	%xmm10, %xmm4, %xmm9
	vmovq	%xmm9, %rax
	imull	$100000000, %eax, %esi
	shrq	$32, %rax
	addl	%esi, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266748(,%r9,4)
	cmpq	%rdx, %r14
	jnb	.L295
	cmpq	$66688, %r9
	je	.L295
.L138:
	vmovdqu	(%r14), %xmm3
	incq	%r9
	vpcmpgtb	%xmm3, %xmm13, %xmm7
	vpsubusb	%xmm1, %xmm3, %xmm14
	vpmovmskb	%xmm7, %edi
	tzcntl	%edi, %eax
	incl	%eax
	movq	%rax, %r10
	addq	%rax, %r14
	salq	$4, %r10
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r10), %xmm5
	vpshufb	%xmm5, %xmm14, %xmm2
	vmovdqa	%xmm5, %xmm8
	vpmaddubsw	%xmm11, %xmm2, %xmm15
	vpor	%ymm8, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm15, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm4
	vpmaddwd	%xmm10, %xmm4, %xmm9
	vmovq	%xmm9, %rdi
	imull	$100000000, %edi, %esi
	shrq	$32, %rdi
	addl	%esi, %edi
	movl	%edi, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266748(,%r9,4)
	cmpq	%rdx, %r14
	jb	.L307
.L295:
	vmovdqa	%ymm6, 448(%rsp)
.L137:
	movq	88(%rsp), %r10
	cmpq	%r10, %r12
	jnb	.L140
	testb	%cl, %cl
	je	.L140
	movq	336(%rsp), %rdi
	movl	$555819297, %ecx
	movl	$808464432, %edx
	vmovdqa	.LC8(%rip), %xmm1
	vmovd	%ecx, %xmm11
	vmovd	%edx, %xmm12
	vmovdqa	.LC9(%rip), %xmm2
	vmovdqa	.LC10(%rip), %xmm3
	vpbroadcastd	%xmm11, %xmm4
	vpbroadcastd	%xmm12, %xmm5
	testb	$1, %dil
	jne	.L290
	vmovdqa	448(%rsp), %ymm6
	jmp	.L141
	.p2align 4
	.p2align 3
.L308:
	vmovdqu	(%r12), %xmm10
	incq	%rdi
	vpcmpgtb	%xmm10, %xmm4, %xmm13
	vpsubusb	%xmm5, %xmm10, %xmm14
	vpmovmskb	%xmm13, %ecx
	tzcntl	%ecx, %edx
	incl	%edx
	movq	%rdx, %rsi
	addq	%rdx, %r12
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm7
	vpshufb	%xmm7, %xmm14, %xmm15
	vmovdqa	%xmm7, %xmm8
	vpmaddubsw	%xmm1, %xmm15, %xmm0
	vpor	%ymm8, %ymm6, %ymm6
	vpmaddwd	%xmm2, %xmm0, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm11
	vpmaddwd	%xmm3, %xmm11, %xmm12
	vmovq	%xmm12, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%ecx, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533500(,%rdi,4)
	cmpq	%r10, %r12
	jnb	.L296
	cmpq	$66688, %rdi
	je	.L296
.L141:
	vmovdqu	(%r12), %xmm10
	incq	%rdi
	vpcmpgtb	%xmm10, %xmm4, %xmm13
	vpsubusb	%xmm5, %xmm10, %xmm14
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %ecx
	incl	%ecx
	movq	%rcx, %rsi
	addq	%rcx, %r12
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm7
	vpshufb	%xmm7, %xmm14, %xmm15
	vmovdqa	%xmm7, %xmm8
	vpmaddubsw	%xmm1, %xmm15, %xmm0
	vpor	%ymm8, %ymm6, %ymm6
	vpmaddwd	%xmm2, %xmm0, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm11
	vpmaddwd	%xmm3, %xmm11, %xmm12
	vmovq	%xmm12, %rdx
	imull	$100000000, %edx, %eax
	shrq	$32, %rdx
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533500(,%rdi,4)
	cmpq	%r10, %r12
	jb	.L308
.L296:
	vmovdqa	%ymm6, 448(%rsp)
	movq	%rdi, 336(%rsp)
.L140:
	cmpq	%r11, 80(%rsp)
	vmovdqa	448(%rsp), %ymm1
	setne	%r11b
	cmpq	%r15, 72(%rsp)
	vpmovmskb	%ymm1, %edi
	setne	%r15b
	orl	%r15d, %r11d
	cmpq	%r14, 64(%rsp)
	setne	%r14b
	andl	$-2147450880, %edi
	xorl	%edx, %edx
	orl	%r14d, %r11d
	cmpq	%r12, 88(%rsp)
	movzbl	%r11b, %r10d
	setne	%dl
	orl	%edx, %edi
	orl	%edi, %r10d
	jne	.L309
	movq	344(%rsp), %r12
	movq	%r9, 480(%rsp)
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region, %esi
	vzeroupper
	addq	%r13, %rbx
	leaq	(%r12,%r13,4), %rdi
	call	memcpy
	movq	480(%rsp), %r9
	leaq	(%r12,%rbx,4), %rdi
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266752, %esi
	leaq	0(,%r9,4), %rdx
	call	memcpy
	addq	480(%rsp), %rbx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533504, %esi
	movq	336(%rsp), %r13
	leaq	(%r12,%rbx,4), %rdi
	leaq	0(,%r13,4), %rdx
	addq	%r13, %rbx
	call	memcpy
	vmovdqa	.LC3(%rip), %ymm11
	leaq	(%r12,%rbx,4), %r8
	vmovdqa	.LC2(%rip), %ymm12
	subq	%rbx, 56(%rsp)
	movq	%r8, 344(%rsp)
.L170:
	cmpq	$133312, 56(%rsp)
	jbe	.L297
.L145:
	movq	88(%rsp), %r8
	jmp	.L171
	.p2align 4
	.p2align 3
.L305:
	vmovdqa	.LC4(%rip), %ymm0
	vmovdqa	.LC14(%rip), %ymm1
	movq	%rsi, 160(%rsp)
	movq	%r12, %r11
	movq	%rbx, %r14
	movq	%r15, 168(%rsp)
	vmovdqa	.LC2(%rip), %ymm6
	movq	%r10, %rsi
	vmovdqa	.LC3(%rip), %ymm7
	movq	%r9, %r12
	movq	%r8, %rbx
	movq	%rdi, %r15
	vmovdqa	%ymm0, 96(%rsp)
	vmovdqa	%ymm1, 128(%rsp)
	jmp	.L132
.L290:
	vmovdqu	(%r12), %xmm10
	incq	336(%rsp)
	movq	336(%rsp), %rcx
	vpcmpgtb	%xmm10, %xmm4, %xmm13
	vpsubusb	%xmm5, %xmm10, %xmm14
	vpmovmskb	%xmm13, %edi
	tzcntl	%edi, %eax
	incl	%eax
	movq	%rax, %rsi
	addq	%rax, %r12
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm8
	vpshufb	%xmm8, %xmm14, %xmm15
	vmovdqa	%xmm8, %xmm7
	vpor	448(%rsp), %ymm7, %ymm6
	vpmaddubsw	%xmm1, %xmm15, %xmm0
	vpmaddwd	%xmm2, %xmm0, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm11
	vpmaddwd	%xmm3, %xmm11, %xmm12
	vmovq	%xmm12, %r10
	imull	$100000000, %r10d, %edx
	shrq	$32, %r10
	vmovdqa	%ymm6, 448(%rsp)
	addl	%r10d, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533500(,%rcx,4)
	cmpq	88(%rsp), %r12
	jnb	.L140
	cmpq	$66688, %rcx
	je	.L140
	movq	88(%rsp), %r10
	movq	%rcx, %rdi
	jmp	.L141
.L288:
	vmovdqu	(%r14), %xmm3
	leaq	1(%r9), %r9
	vpcmpgtb	%xmm3, %xmm13, %xmm7
	vpsubusb	%xmm1, %xmm3, %xmm14
	vpmovmskb	%xmm7, %edx
	tzcntl	%edx, %edi
	incl	%edi
	movq	%rdi, %rax
	addq	%rdi, %r14
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm6
	vpshufb	%xmm6, %xmm14, %xmm2
	vmovdqa	%xmm6, %xmm8
	vpor	448(%rsp), %ymm8, %ymm5
	vpmaddubsw	%xmm11, %xmm2, %xmm15
	vpmaddwd	%xmm12, %xmm15, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm4
	vpmaddwd	%xmm10, %xmm4, %xmm9
	vmovq	%xmm9, %r10
	imull	$100000000, %r10d, %esi
	shrq	$32, %r10
	vmovdqa	%ymm5, 448(%rsp)
	addl	%r10d, %esi
	movl	%esi, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266748(,%r9,4)
	cmpq	64(%rsp), %r14
	jnb	.L137
	movq	64(%rsp), %rdx
	vmovdqa	%ymm5, %ymm6
	cmpq	$66688, %r9
	jne	.L138
	jmp	.L137
	.p2align 4
	.p2align 3
.L286:
	vmovdqu	(%r15), %xmm9
	leaq	1(%rbx), %rbx
	vpcmpgtb	%xmm9, %xmm4, %xmm1
	vpsubusb	%xmm13, %xmm9, %xmm8
	vpmovmskb	%xmm1, %edx
	tzcntl	%edx, %r10d
	incl	%r10d
	movq	%r10, %rsi
	addq	%r10, %r15
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm3
	vpshufb	%xmm3, %xmm8, %xmm5
	vmovdqa	%xmm3, %xmm7
	vpor	448(%rsp), %ymm7, %ymm6
	vpmaddubsw	%xmm11, %xmm5, %xmm14
	vpmaddwd	%xmm12, %xmm14, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm15
	vpmaddwd	%xmm10, %xmm15, %xmm0
	vmovq	%xmm0, %r9
	imull	$100000000, %r9d, %edi
	shrq	$32, %r9
	vmovdqa	%ymm6, 448(%rsp)
	addl	%r9d, %edi
	movl	%edi, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region-4(,%rbx,4)
	cmpq	72(%rsp), %r15
	jnb	.L134
	movq	72(%rsp), %rdx
	cmpq	$66688, %rbx
	jne	.L135
	movq	64(%rsp), %rdx
	cmpq	%rdx, %r14
	jb	.L310
.L176:
	movq	336(%rsp), %r9
	jmp	.L137
.L175:
	movq	336(%rsp), %rbx
	jmp	.L134
.L297:
	movq	56(%rsp), %r11
	vzeroupper
.L127:
	movq	344(%rsp), %rsi
	movq	88(%rsp), %rdi
	leaq	-40(%rbp), %rsp
	movq	%r11, %rdx
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	_ZN13qp_parse_flat12parse_tokensEPcPjm
.L309:
	.cfi_restore_state
	cmpq	88(%rsp), %r8
	jnb	.L311
	movq	88(%rsp), %rbx
	movl	$1, %r10d
	leaq	-1(%rbx), %rdi
	cmpq	%rdi, %r8
	cmovbe	%r8, %rdi
	cmpq	%r8, %rdi
	movq	%rdi, %r14
	setnb	%r15b
	subq	%r8, %r14
	cmpq	%r8, %rdi
	leaq	1(%r14), %rcx
	cmovb	%r10, %rcx
	cmpq	$30, %r14
	jbe	.L177
	cmpq	%r8, %rdi
	jb	.L177
	movq	%rcx, %rsi
	movl	$538976288, %r11d
	vmovq	%r10, %xmm5
	movq	%r8, %rax
	andq	$-32, %rsi
	vmovd	%r11d, %xmm3
	vpxor	%xmm2, %xmm2, %xmm2
	vpbroadcastq	%xmm5, %ymm10
	leaq	(%rsi,%r8), %rdx
	vpbroadcastd	%xmm3, %ymm4
.L147:
	vmovdqu	(%rax), %ymm13
	addq	$32, %rax
	vpcmpgtb	%ymm4, %ymm13, %ymm7
	vpmovsxbw	%xmm7, %ymm8
	vextracti128	$0x1, %ymm7, %xmm6
	vpmovsxwd	%xmm8, %ymm15
	vextracti128	$0x1, %ymm8, %xmm0
	vpmovsxbw	%xmm6, %ymm14
	vpmovsxdq	%xmm15, %ymm3
	vextracti128	$0x1, %ymm15, %xmm13
	vpmovsxwd	%xmm0, %ymm9
	vpmovsxwd	%xmm14, %ymm11
	vpand	%ymm10, %ymm3, %ymm5
	vpmovsxdq	%xmm13, %ymm7
	vextracti128	$0x1, %ymm9, %xmm15
	vpmovsxdq	%xmm9, %ymm6
	vpsubq	%ymm7, %ymm5, %ymm8
	vextracti128	$0x1, %ymm14, %xmm1
	vpmovsxdq	%xmm15, %ymm0
	vpsubq	%ymm6, %ymm8, %ymm14
	vpmovsxwd	%xmm1, %ymm12
	vpmovsxdq	%xmm11, %ymm1
	vpsubq	%ymm0, %ymm14, %ymm9
	vextracti128	$0x1, %ymm11, %xmm11
	vpmovsxdq	%xmm12, %ymm7
	vpsubq	%ymm1, %ymm9, %ymm3
	vpmovsxdq	%xmm11, %ymm5
	vextracti128	$0x1, %ymm12, %xmm12
	vpsubq	%ymm5, %ymm3, %ymm13
	vpmovsxdq	%xmm12, %ymm6
	vpsubq	%ymm7, %ymm13, %ymm8
	vpsubq	%ymm6, %ymm8, %ymm14
	vpaddq	%ymm14, %ymm2, %ymm2
	cmpq	%rdx, %rax
	jne	.L147
	vextracti128	$0x1, %ymm2, %xmm4
	vpaddq	%xmm2, %xmm4, %xmm10
	vpsrldq	$8, %xmm10, %xmm15
	vpaddq	%xmm15, %xmm10, %xmm0
	vmovq	%xmm0, %rdx
	cmpq	%rcx, %rsi
	je	.L148
	vmovdqa	%xmm10, %xmm9
.L146:
	subq	%rsi, %rcx
	leaq	-1(%rcx), %r12
	cmpq	$14, %r12
	jbe	.L149
	vmovdqu	(%r8,%rsi), %xmm3
	movl	$538976288, %r9d
	movl	$1, %r13d
	vmovd	%r9d, %xmm1
	vpbroadcastd	%xmm1, %xmm11
	vpcmpgtb	%xmm11, %xmm3, %xmm5
	vmovq	%r13, %xmm3
	vpmovsxbw	%xmm5, %xmm13
	vpunpcklqdq	%xmm3, %xmm3, %xmm1
	vpsrldq	$8, %xmm5, %xmm7
	vpmovsxbw	%xmm7, %xmm8
	vpmovsxwd	%xmm13, %xmm12
	vpsrldq	$8, %xmm13, %xmm6
	vpmovsxwd	%xmm6, %xmm14
	vpmovsxwd	%xmm8, %xmm2
	vpsrldq	$8, %xmm12, %xmm15
	vpmovsxdq	%xmm15, %xmm0
	vpmovsxdq	%xmm14, %xmm5
	vpsrldq	$8, %xmm8, %xmm4
	vpand	%xmm1, %xmm0, %xmm11
	vpsrldq	$8, %xmm14, %xmm7
	vpmovsxdq	%xmm7, %xmm8
	vpmovsxdq	%xmm2, %xmm14
	vpsubq	%xmm5, %xmm11, %xmm13
	vpmovsxwd	%xmm4, %xmm10
	vpsrldq	$8, %xmm2, %xmm2
	vpmovsxdq	%xmm2, %xmm15
	vpaddq	%xmm9, %xmm13, %xmm9
	vpmovsxdq	%xmm10, %xmm3
	vpsrldq	$8, %xmm10, %xmm10
	vpmovsxdq	%xmm10, %xmm1
	vpsubq	%xmm8, %xmm9, %xmm6
	vpmovsxdq	%xmm12, %xmm12
	vpsubq	%xmm14, %xmm6, %xmm4
	vpsubq	%xmm15, %xmm4, %xmm0
	vpsubq	%xmm3, %xmm0, %xmm11
	vpsubq	%xmm1, %xmm11, %xmm5
	vpsubq	%xmm12, %xmm5, %xmm13
	vpsrldq	$8, %xmm13, %xmm9
	vpaddq	%xmm9, %xmm13, %xmm7
	vmovq	%xmm7, %rdx
	testb	$15, %cl
	je	.L148
	andq	$-16, %rcx
	addq	%rcx, %rax
.L149:
	xorl	%ebx, %ebx
	cmpb	$32, (%rax)
	leaq	1(%rax), %rcx
	setg	%bl
	addq	%rbx, %rdx
	cmpq	%rcx, %rdi
	jnb	.L312
.L148:
	xorl	%edi, %edi
	testb	%r15b, %r15b
	cmovne	%r14, %rdi
	movq	88(%rsp), %r14
	leaq	1(%r8,%rdi), %r15
	cmpq	%r14, %r15
	jnb	.L169
	movq	%r15, %r9
	notq	%r9
	addq	%r14, %r9
	andl	$7, %r9d
	cmpb	$32, (%r15)
	jg	.L313
.L206:
	leaq	1(%r15), %r14
	cmpq	88(%rsp), %r14
	jnb	.L169
	testq	%r9, %r9
	je	.L168
	cmpq	$1, %r9
	je	.L254
	cmpq	$2, %r9
	je	.L255
	cmpq	$3, %r9
	je	.L256
	cmpq	$4, %r9
	je	.L257
	cmpq	$5, %r9
	je	.L258
	cmpq	$6, %r9
	je	.L259
	cmpb	$32, 1(%r15)
	jg	.L314
.L208:
	incq	%r14
.L259:
	cmpb	$32, (%r14)
	jle	.L211
	xorl	%ebx, %ebx
	cmpb	$32, -1(%r14)
	setle	%bl
	addq	%rbx, %rdx
.L211:
	incq	%r14
.L258:
	cmpb	$32, (%r14)
	jg	.L315
.L214:
	incq	%r14
.L257:
	cmpb	$32, (%r14)
	jg	.L316
.L217:
	incq	%r14
.L256:
	cmpb	$32, (%r14)
	jg	.L317
.L220:
	incq	%r14
.L255:
	cmpb	$32, (%r14)
	jle	.L223
	xorl	%esi, %esi
	cmpb	$32, -1(%r14)
	setle	%sil
	addq	%rsi, %rdx
.L223:
	incq	%r14
.L254:
	cmpb	$32, (%r14)
	jle	.L226
	xorl	%r12d, %r12d
	cmpb	$32, -1(%r14)
	setle	%r12b
	addq	%r12, %rdx
.L226:
	incq	%r14
	cmpq	88(%rsp), %r14
	jnb	.L169
.L168:
	cmpb	$32, (%r14)
	jle	.L167
	xorl	%edi, %edi
	cmpb	$32, -1(%r14)
	setle	%dil
	addq	%rdi, %rdx
.L167:
	cmpb	$32, 1(%r14)
	leaq	1(%r14), %r15
	jle	.L229
	xorl	%r14d, %r14d
	cmpb	$32, -1(%r15)
	setle	%r14b
	addq	%r14, %rdx
.L229:
	cmpb	$32, 1(%r15)
	jle	.L231
	xorl	%r9d, %r9d
	cmpb	$32, (%r15)
	setle	%r9b
	addq	%r9, %rdx
.L231:
	cmpb	$32, 2(%r15)
	jle	.L233
	xorl	%eax, %eax
	cmpb	$32, 1(%r15)
	setle	%al
	addq	%rax, %rdx
.L233:
	cmpb	$32, 3(%r15)
	jle	.L235
	xorl	%r13d, %r13d
	cmpb	$32, 2(%r15)
	setle	%r13b
	addq	%r13, %rdx
.L235:
	cmpb	$32, 4(%r15)
	jle	.L237
	xorl	%ebx, %ebx
	cmpb	$32, 3(%r15)
	setle	%bl
	addq	%rbx, %rdx
.L237:
	cmpb	$32, 5(%r15)
	jle	.L239
	xorl	%ecx, %ecx
	cmpb	$32, 4(%r15)
	setle	%cl
	addq	%rcx, %rdx
.L239:
	cmpb	$32, 6(%r15)
	jle	.L241
	xorl	%r10d, %r10d
	cmpb	$32, 5(%r15)
	setle	%r10b
	addq	%r10, %rdx
.L241:
	leaq	7(%r15), %r14
	cmpq	88(%rsp), %r14
	jb	.L168
.L169:
	movq	344(%rsp), %rsi
	subq	%rdx, 56(%rsp)
	movq	%r8, %rdi
	leaq	(%rsi,%rdx,4), %r12
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm12
	movq	%r12, 344(%rsp)
	vmovdqa	.LC3(%rip), %ymm11
	jmp	.L170
.L313:
	xorl	%eax, %eax
	cmpb	$32, -1(%r15)
	setle	%al
	addq	%rax, %rdx
	jmp	.L206
.L312:
	xorl	%r10d, %r10d
	cmpb	$32, 1(%rax)
	leaq	2(%rax), %r11
	setg	%r10b
	addq	%r10, %rdx
	cmpq	%r11, %rdi
	jb	.L148
	xorl	%esi, %esi
	cmpb	$32, 2(%rax)
	leaq	3(%rax), %r12
	setg	%sil
	addq	%rsi, %rdx
	cmpq	%r12, %rdi
	jb	.L148
	xorl	%r9d, %r9d
	cmpb	$32, 3(%rax)
	leaq	4(%rax), %r13
	setg	%r9b
	addq	%r9, %rdx
	cmpq	%r13, %rdi
	jb	.L148
	xorl	%ebx, %ebx
	cmpb	$32, 4(%rax)
	leaq	5(%rax), %rcx
	setg	%bl
	addq	%rbx, %rdx
	cmpq	%rcx, %rdi
	jb	.L148
	xorl	%r10d, %r10d
	cmpb	$32, 5(%rax)
	leaq	6(%rax), %r11
	setg	%r10b
	addq	%r10, %rdx
	cmpq	%r11, %rdi
	jb	.L148
	xorl	%esi, %esi
	cmpb	$32, 6(%rax)
	leaq	7(%rax), %r12
	setg	%sil
	addq	%rsi, %rdx
	cmpq	%r12, %rdi
	jb	.L148
	xorl	%r9d, %r9d
	cmpb	$32, 7(%rax)
	leaq	8(%rax), %r13
	setg	%r9b
	addq	%r9, %rdx
	cmpq	%r13, %rdi
	jb	.L148
	cmpb	$32, 8(%rax)
	jle	.L159
	incq	%rdx
.L159:
	leaq	9(%rax), %rbx
	cmpq	%rbx, %rdi
	jb	.L148
	cmpb	$32, 9(%rax)
	jle	.L160
	incq	%rdx
.L160:
	leaq	10(%rax), %rcx
	cmpq	%rcx, %rdi
	jb	.L148
	cmpb	$32, 10(%rax)
	jle	.L161
	incq	%rdx
.L161:
	leaq	11(%rax), %r10
	cmpq	%r10, %rdi
	jb	.L148
	cmpb	$32, 11(%rax)
	jle	.L162
	incq	%rdx
.L162:
	leaq	12(%rax), %r11
	cmpq	%r11, %rdi
	jb	.L148
	cmpb	$32, 12(%rax)
	jle	.L163
	incq	%rdx
.L163:
	leaq	13(%rax), %rsi
	cmpq	%rsi, %rdi
	jb	.L148
	cmpb	$32, 13(%rax)
	jle	.L164
	incq	%rdx
.L164:
	leaq	14(%rax), %r12
	cmpq	%r12, %rdi
	jb	.L148
	cmpb	$32, 14(%rax)
	jle	.L148
	incq	%rdx
	jmp	.L148
	.p2align 4
	.p2align 3
.L317:
	xorl	%r11d, %r11d
	cmpb	$32, -1(%r14)
	setle	%r11b
	addq	%r11, %rdx
	jmp	.L220
.L316:
	xorl	%r10d, %r10d
	cmpb	$32, -1(%r14)
	setle	%r10b
	addq	%r10, %rdx
	jmp	.L217
.L315:
	xorl	%ecx, %ecx
	cmpb	$32, -1(%r14)
	setle	%cl
	addq	%rcx, %rdx
	jmp	.L214
.L172:
	movq	%rdi, 88(%rsp)
	jmp	.L127
.L311:
	movq	344(%rsp), %rsi
	xorl	%edx, %edx
	movq	%r8, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm12
	vmovdqa	.LC3(%rip), %ymm11
	jmp	.L145
.L177:
	movq	%r8, %rax
	vpxor	%xmm9, %xmm9, %xmm9
	xorl	%esi, %esi
	xorl	%edx, %edx
	jmp	.L146
.L314:
	xorl	%r13d, %r13d
	cmpb	$32, -1(%r14)
	setle	%r13b
	addq	%r13, %rdx
	jmp	.L208
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
	subq	$640, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rsi, 216(%rsp)
	movq	%rdx, 24(%rsp)
	cmpq	$133312, %rdx
	jbe	.L365
	vmovdqa	.LC2(%rip), %ymm12
	vmovdqa	.LC3(%rip), %ymm11
.L364:
	movl	$555819297, %eax
	vpxor	%xmm6, %xmm6, %xmm6
	movq	%rdi, 16(%rsp)
	vmovd	%eax, %xmm7
	vmovdqa	%ymm6, 480(%rsp)
	vpbroadcastd	%xmm7, %ymm0
	vmovdqa	%ymm0, 608(%rsp)
	vmovdqa	608(%rsp), %ymm1
	vpcmpgtb	66624(%rdi), %ymm1, %ymm2
	vpcmpgtb	133248(%rdi), %ymm1, %ymm3
	vpcmpgtb	199872(%rdi), %ymm1, %ymm4
	vpcmpgtb	266496(%rdi), %ymm1, %ymm5
	vpmovmskb	%ymm2, %edx
	vpmovmskb	%ymm3, %esi
	tzcntl	%edx, %ecx
	vpmovmskb	%ymm4, %r10d
	tzcntl	%esi, %r8d
	movl	%ecx, %ebx
	movl	$808464432, %esi
	vpmovmskb	%ymm5, %eax
	tzcntl	%r10d, %r11d
	movl	%r8d, %r9d
	leaq	66625(%rdi,%rbx), %r14
	tzcntl	%eax, %edx
	movl	%r11d, %r12d
	leaq	133249(%rdi,%r9), %r15
	vmovd	%esi, %xmm10
	movl	%edx, %ecx
	leaq	199873(%rdi,%r12), %r13
	movq	%r15, 96(%rsp)
	movq	%r15, 536(%rsp)
	leaq	266497(%rdi,%rcx), %rbx
	movq	%r13, 112(%rsp)
	movq	%r13, 576(%rsp)
	vpbroadcastd	%xmm10, %ymm10
	movq	%rbx, 200(%rsp)
	movq	%r14, 104(%rsp)
	xorl	%ebx, %ebx
	movq	%rdi, %r15
	.p2align 4
	.p2align 3
.L326:
	movq	200(%rsp), %rax
	movq	112(%rsp), %rdi
	subq	576(%rsp), %rax
	subq	536(%rsp), %rdi
	movq	96(%rsp), %r8
	movq	104(%rsp), %r9
	cmpq	%rdi, %rax
	cmovg	%rdi, %rax
	subq	%r14, %r8
	subq	%r15, %r9
	cmpq	%r9, %r8
	cmovg	%r9, %r8
	cmpq	%r8, %rax
	cmovg	%r8, %rax
	cmpq	$64, %rax
	jbe	.L496
	vmovdqa	608(%rsp), %ymm4
	movabsq	$1135184250689818561, %r10
	mulq	%r10
	movq	%rdx, %r13
	shrq	$2, %r13
	vpcmpgtb	(%r15), %ymm4, %ymm8
	vpcmpgtb	(%r14), %ymm4, %ymm13
	vpmovmskb	%ymm8, %r11d
	vpcmpgtb	32(%r15), %ymm4, %ymm9
	vpcmpgtb	32(%r14), %ymm4, %ymm14
	vpmovmskb	%ymm9, %r10d
	blsr	%r11d, %r12d
	tzcntl	%r11d, %ecx
	blsr	%r12d, %esi
	tzcntl	%r12d, %eax
	salq	$32, %r10
	movl	%ecx, 416(%rsp)
	vpmovmskb	%ymm13, %r11d
	tzcntl	%esi, %edi
	blsr	%esi, %r8d
	movl	%eax, 384(%rsp)
	blsr	%r11d, %esi
	movl	%edi, 448(%rsp)
	movl	%r8d, %r9d
	tzcntl	%r11d, %ecx
	tzcntl	%esi, %edi
	blsr	%esi, %eax
	orq	%r10, %r9
	movl	%ecx, 528(%rsp)
	movl	%edi, 524(%rsp)
	movq	536(%rsp), %rdi
	tzcntq	%r9, %rdx
	blsr	%eax, %r9d
	movl	%r9d, %r10d
	movl	%edx, 352(%rsp)
	incl	%edx
	tzcntl	%eax, %r8d
	leaq	(%r15,%rdx), %r12
	movl	%r8d, 520(%rsp)
	vpmovmskb	%ymm14, %edx
	vmovdqu	(%rdi), %ymm15
	vmovdqu	32(%rdi), %ymm0
	salq	$32, %rdx
	orq	%rdx, %r10
	tzcntq	%r10, %r11
	movl	%r11d, 516(%rsp)
	incl	%r11d
	leaq	(%r14,%r11), %rsi
	vmovdqa	%ymm15, 544(%rsp)
	vpcmpgtb	544(%rsp), %ymm4, %ymm7
	vmovdqa	%ymm0, 544(%rsp)
	vpmovmskb	%ymm7, %ecx
	vpcmpgtb	544(%rsp), %ymm4, %ymm1
	tzcntl	%ecx, %r9d
	blsr	%ecx, %r8d
	movl	%r9d, 512(%rsp)
	movq	576(%rsp), %r9
	blsr	%r8d, %eax
	tzcntl	%r8d, %r10d
	vpmovmskb	%ymm1, %r8d
	blsr	%eax, %r11d
	tzcntl	%eax, %edx
	movl	%r10d, 348(%rsp)
	salq	$32, %r8
	movl	%r11d, %ecx
	movl	%edx, 344(%rsp)
	orq	%r8, %rcx
	vmovdqu	(%r9), %ymm2
	vmovdqu	32(%r9), %ymm5
	tzcntq	%rcx, %rax
	movl	%eax, 532(%rsp)
	incl	%eax
	addq	%rax, %rdi
	vmovdqa	%ymm2, 544(%rsp)
	vpcmpgtb	544(%rsp), %ymm4, %ymm3
	vmovdqa	%ymm5, 544(%rsp)
	vpmovmskb	%ymm3, %r10d
	vpcmpgtb	544(%rsp), %ymm4, %ymm6
	blsr	%r10d, %edx
	tzcntl	%r10d, %ecx
	blsr	%edx, %r11d
	tzcntl	%edx, %r8d
	movl	%ecx, 340(%rsp)
	vpmovmskb	%ymm6, %edx
	blsr	%r11d, %r10d
	tzcntl	%r11d, %eax
	movl	%r8d, 336(%rsp)
	movl	%r10d, %r11d
	salq	$32, %rdx
	movl	%eax, 332(%rsp)
	orq	%rdx, %r11
	tzcntq	%r11, %rcx
	movl	%ecx, 328(%rsp)
	incl	%ecx
	leaq	(%r9,%rcx), %r11
	cmpq	$1, %r13
	je	.L323
	vmovdqa	.LC4(%rip), %ymm13
	vmovdqa	.LC14(%rip), %ymm14
	leaq	-4(%rbx,%r13,4), %r8
	movq	%r13, 192(%rsp)
	movq	%r8, 208(%rsp)
	movq	%r12, %r13
	movq	%rbx, %r8
	movq	%r9, %r12
	movq	%rbx, 120(%rsp)
	movq	%rsi, %r10
	movq	%rdi, %r9
	movq	%r11, %rcx
	vmovdqa	%ymm12, 64(%rsp)
	vmovdqa	%ymm11, 32(%rsp)
	vmovdqa	%ymm13, 128(%rsp)
	vmovdqa	%ymm14, 160(%rsp)
	jmp	.L324
	.p2align 4
	.p2align 3
.L367:
	movq	296(%rsp), %rcx
	movq	304(%rsp), %r9
	movq	312(%rsp), %r10
	movq	320(%rsp), %r13
.L324:
	vmovdqa	608(%rsp), %ymm15
	movl	416(%rsp), %ebx
	movl	384(%rsp), %esi
	movl	%ebx, 576(%rsp)
	movl	%esi, 544(%rsp)
	vpcmpgtb	0(%r13), %ymm15, %ymm0
	vpcmpgtb	32(%r13), %ymm15, %ymm1
	vpmovmskb	%ymm0, %r11d
	vpcmpgtb	(%r10), %ymm15, %ymm4
	vpcmpgtb	32(%r10), %ymm15, %ymm2
	blsr	%r11d, %edx
	tzcntl	%r11d, %edi
	vpcmpgtb	(%r9), %ymm15, %ymm3
	vpcmpgtb	32(%r9), %ymm15, %ymm5
	vpmovmskb	%ymm1, %esi
	blsr	%edx, %eax
	tzcntl	%edx, %r11d
	movl	448(%rsp), %edx
	tzcntl	%eax, %ebx
	blsr	%eax, %eax
	salq	$32, %rsi
	movl	%edi, 416(%rsp)
	movl	%eax, %edi
	movl	%r11d, 384(%rsp)
	movl	%ebx, 448(%rsp)
	orq	%rsi, %rdi
	tzcntq	%rdi, %r11
	movl	%edx, 256(%rsp)
	movl	352(%rsp), %edx
	vpmovmskb	%ymm4, %edi
	movl	%r11d, 352(%rsp)
	incl	%r11d
	leaq	0(%r13,%r11), %rbx
	movl	528(%rsp), %r11d
	blsr	%edi, %esi
	blsr	%esi, %eax
	movq	%rbx, 320(%rsp)
	movl	524(%rsp), %ebx
	movl	%edx, 228(%rsp)
	tzcntl	%edi, %edx
	tzcntl	%esi, %edi
	tzcntl	%eax, %esi
	movl	%edx, 528(%rsp)
	blsr	%eax, %eax
	movl	%edi, 524(%rsp)
	movl	520(%rsp), %edi
	vpmovmskb	%ymm2, %edx
	movl	%r11d, 232(%rsp)
	movl	%eax, %r11d
	movl	%esi, 520(%rsp)
	salq	$32, %rdx
	movl	%ebx, 236(%rsp)
	movl	516(%rsp), %esi
	orq	%rdx, %r11
	vpmovmskb	%ymm3, %edx
	tzcntq	%r11, %rbx
	movl	%ebx, 516(%rsp)
	incl	%ebx
	blsr	%edx, %r11d
	leaq	(%r10,%rbx), %rax
	movl	%esi, 240(%rsp)
	movq	%rax, 312(%rsp)
	tzcntl	%edx, %esi
	movl	512(%rsp), %ebx
	blsr	%r11d, %eax
	tzcntl	%r11d, %edx
	movl	%esi, 512(%rsp)
	vpcmpgtb	(%rcx), %ymm15, %ymm6
	movl	344(%rsp), %r11d
	vpcmpgtb	32(%rcx), %ymm15, %ymm7
	movl	348(%rsp), %esi
	movl	%edx, 348(%rsp)
	vmovdqu	(%r15), %xmm8
	movl	%ebx, 244(%rsp)
	tzcntl	%eax, %ebx
	blsr	%eax, %eax
	movl	%eax, %edx
	movl	%ebx, 344(%rsp)
	movl	532(%rsp), %eax
	movl	%r11d, 248(%rsp)
	vpmovmskb	%ymm5, %r11d
	salq	$32, %r11
	orq	%r11, %rdx
	movl	%eax, 252(%rsp)
	tzcntq	%rdx, %rbx
	movl	340(%rsp), %edx
	movl	%ebx, 532(%rsp)
	incl	%ebx
	addq	%r9, %rbx
	movq	%rbx, 304(%rsp)
	vpmovmskb	%ymm6, %ebx
	movl	%edx, 288(%rsp)
	movl	332(%rsp), %edx
	blsr	%ebx, %r11d
	blsr	%r11d, %eax
	tzcntl	%ebx, %ebx
	tzcntl	%r11d, %r11d
	movl	%ebx, 340(%rsp)
	movl	336(%rsp), %ebx
	movl	%r11d, 336(%rsp)
	tzcntl	%eax, %r11d
	movl	%r11d, 332(%rsp)
	blsr	%eax, %eax
	movl	%edx, 292(%rsp)
	vpmovmskb	%ymm7, %r11d
	movl	%eax, %edx
	salq	$32, %r11
	orq	%r11, %rdx
	movl	544(%rsp), %r11d
	tzcntq	%rdx, %rax
	movl	328(%rsp), %edx
	movl	%eax, 328(%rsp)
	incl	%eax
	addq	%rcx, %rax
	movq	%rax, 296(%rsp)
	movl	576(%rsp), %eax
	vmovdqu	1(%r15,%r11), %xmm13
	movl	%edx, 224(%rsp)
	movl	256(%rsp), %edx
	vinserti128	$0x1, 1(%r15,%rax), %ymm8, %ymm9
	incl	%eax
	vinserti128	$0x1, 1(%r15,%rdx), %ymm13, %ymm14
	movl	544(%rsp), %r15d
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm15
	movl	256(%rsp), %r11d
	movl	228(%rsp), %edx
	subl	256(%rsp), %edx
	vmovdqu	(%r14), %xmm13
	movl	%r15d, %eax
	subl	576(%rsp), %eax
	subl	%r15d, %r11d
	salq	$4, %r11
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r11), %xmm0
	movl	236(%rsp), %r11d
	vpsubusb	%ymm10, %ymm9, %ymm1
	salq	$4, %rdx
	vpsubusb	%ymm10, %ymm14, %ymm6
	salq	$4, %rax
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm15, %ymm2
	movl	232(%rsp), %eax
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rdx), %ymm0, %ymm15
	vmovdqu	1(%r14,%r11), %xmm14
	movl	%edi, %edx
	vinserti128	$0x1, 1(%r14,%rdx), %ymm14, %ymm0
	movl	%esi, %edx
	vpshufb	%ymm2, %ymm1, %ymm4
	vinserti128	$0x1, 1(%r14,%rax), %ymm13, %ymm1
	incl	%eax
	movl	%r11d, %r14d
	salq	$4, %rax
	vpmaddubsw	%ymm12, %ymm4, %ymm3
	subl	232(%rsp), %r14d
	vpshufb	%ymm15, %ymm6, %ymm7
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm4
	movl	%edi, %eax
	vpmaddwd	%ymm11, %ymm3, %ymm5
	vpmaddubsw	%ymm12, %ymm7, %ymm8
	subl	%r11d, %eax
	movl	240(%rsp), %r11d
	vpmaddwd	%ymm11, %ymm8, %ymm9
	vpsubusb	%ymm10, %ymm0, %ymm8
	salq	$4, %rax
	vmovdqa	%ymm5, 576(%rsp)
	vmovdqa	%ymm9, 544(%rsp)
	vpor	%ymm15, %ymm2, %ymm2
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm3
	salq	$4, %r14
	movl	244(%rsp), %eax
	subl	%edi, %r11d
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm4, %ymm14
	movq	536(%rsp), %rdi
	salq	$4, %r11
	vpsubusb	%ymm10, %ymm1, %ymm5
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm3, %ymm13
	movl	248(%rsp), %r11d
	movq	%rax, %r15
	vmovdqu	(%rdi), %xmm4
	vinserti128	$0x1, 1(%rdi,%rax), %ymm4, %ymm3
	incl	%eax
	salq	$4, %rax
	vpshufb	%ymm14, %ymm5, %ymm6
	vpmaddubsw	%ymm12, %ymm6, %ymm7
	vmovdqu	1(%rdi,%rdx), %xmm6
	movl	%ebx, %edx
	vpshufb	%ymm13, %ymm8, %ymm9
	vpmaddwd	%ymm11, %ymm7, %ymm5
	vinserti128	$0x1, 1(%rdi,%r11), %ymm6, %ymm7
	vpmaddubsw	%ymm12, %ymm9, %ymm1
	vpmaddwd	%ymm11, %ymm1, %ymm0
	vmovdqa	%ymm0, 256(%rsp)
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm8
	movl	%esi, %eax
	movl	292(%rsp), %r14d
	subl	%r15d, %eax
	movl	%r11d, %r15d
	vpsubusb	%ymm10, %ymm3, %ymm0
	vpor	480(%rsp), %ymm2, %ymm15
	salq	$4, %rax
	subl	%esi, %r15d
	movl	252(%rsp), %esi
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm8, %ymm9
	salq	$4, %r15
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r15), %xmm1
	movl	%r14d, %eax
	movq	%r13, %r15
	vpsubusb	%ymm10, %ymm7, %ymm6
	subl	%r11d, %esi
	movl	288(%rsp), %r11d
	subl	%ebx, %eax
	salq	$4, %rsi
	salq	$4, %rax
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rsi), %ymm1, %ymm8
	vpor	%ymm14, %ymm15, %ymm14
	movq	%r11, %rdi
	vpor	%ymm13, %ymm14, %ymm13
	vpshufb	%ymm9, %ymm0, %ymm4
	vpor	%ymm9, %ymm13, %ymm9
	vpmaddubsw	%ymm12, %ymm4, %ymm3
	vmovdqu	(%r12), %xmm4
	vpmaddwd	%ymm11, %ymm3, %ymm1
	vmovdqu	1(%r12,%rdx), %xmm3
	vinserti128	$0x1, 1(%r12,%r11), %ymm4, %ymm4
	incl	%r11d
	vinserti128	$0x1, 1(%r12,%r14), %ymm3, %ymm3
	movl	%ebx, %r12d
	movl	224(%rsp), %ebx
	salq	$4, %r11
	subl	%edi, %r12d
	vpshufb	%ymm8, %ymm6, %ymm7
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r11), %xmm6
	vpor	%ymm8, %ymm9, %ymm8
	vpmaddubsw	%ymm12, %ymm7, %ymm0
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm6, %ymm7
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm6
	movq	%rcx, %r12
	subl	%r14d, %ebx
	vpmaddwd	%ymm11, %ymm0, %ymm0
	movq	%r10, %r14
	salq	$4, %rbx
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rbx), %ymm6, %ymm6
	vpsubusb	%ymm10, %ymm4, %ymm4
	vpsubusb	%ymm10, %ymm3, %ymm3
	vpor	%ymm7, %ymm8, %ymm2
	vpshufb	%ymm7, %ymm4, %ymm7
	vpmaddubsw	%ymm12, %ymm7, %ymm14
	vpmaddwd	%ymm11, %ymm14, %ymm13
	vpor	%ymm6, %ymm2, %ymm15
	vmovdqa	576(%rsp), %ymm2
	vpackusdw	%ymm13, %ymm1, %ymm1
	vpmaddwd	.LC4(%rip), %ymm1, %ymm4
	vpshufb	%ymm6, %ymm3, %ymm6
	vmovdqa	%ymm15, 480(%rsp)
	vpmaddubsw	%ymm12, %ymm6, %ymm9
	vmovdqa	544(%rsp), %ymm6
	vpmaddwd	%ymm11, %ymm9, %ymm8
	vmovdqa	.LC14(%rip), %ymm9
	vpackusdw	%ymm8, %ymm0, %ymm0
	vpmaddwd	.LC4(%rip), %ymm0, %ymm8
	vpackusdw	%ymm5, %ymm2, %ymm5
	vpmaddwd	.LC4(%rip), %ymm5, %ymm15
	vpackusdw	256(%rsp), %ymm6, %ymm2
	vshufps	$136, %ymm4, %ymm15, %ymm7
	vshufps	$221, %ymm4, %ymm15, %ymm13
	vpmulld	.LC5(%rip), %ymm7, %ymm14
	vpmaddwd	.LC4(%rip), %ymm2, %ymm15
	vshufps	$136, %ymm8, %ymm15, %ymm1
	vpmulld	.LC5(%rip), %ymm1, %ymm4
	vshufps	$221, %ymm8, %ymm15, %ymm7
	movq	216(%rsp), %rsi
	movq	%r9, 536(%rsp)
	vpaddd	%ymm13, %ymm14, %ymm3
	vpermd	%ymm3, %ymm9, %ymm5
	vpaddd	%ymm7, %ymm4, %ymm14
	vpermd	%ymm14, %ymm9, %ymm13
	vpunpcklqdq	%ymm13, %ymm5, %ymm3
	vpunpckhqdq	%ymm13, %ymm5, %ymm9
	vmovdqu	%xmm3, (%rsi,%r8,4)
	vextracti128	$0x1, %ymm3, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266752(,%r8,4)
	vextracti128	$0x1, %ymm9, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533504(,%r8,4)
	vmovdqa	%xmm9, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region(,%r8,4)
	addq	$4, %r8
	cmpq	208(%rsp), %r8
	jne	.L367
	vmovdqa	64(%rsp), %ymm6
	vmovdqa	32(%rsp), %ymm7
	movq	%r13, %r12
	movq	%r9, %rdi
	movq	192(%rsp), %r13
	movq	120(%rsp), %r8
	movq	%r10, %r9
	movq	%rcx, %r11
	movq	296(%rsp), %r10
	movq	304(%rsp), %rcx
	movq	312(%rsp), %r14
	movq	320(%rsp), %r15
	leaq	-4(%r8,%r13,4), %rbx
	movq	%r10, 576(%rsp)
	movq	%rcx, 536(%rsp)
.L325:
	movl	384(%rsp), %edx
	movl	416(%rsp), %eax
	movl	448(%rsp), %r10d
	vmovdqu	(%r12), %xmm2
	vmovdqu	1(%r12,%rdx), %xmm0
	vinserti128	$0x1, 1(%r12,%rax), %ymm2, %ymm15
	movq	%rax, %r13
	incl	%eax
	vinserti128	$0x1, 1(%r12,%r10), %ymm0, %ymm8
	movl	%edx, %r12d
	salq	$4, %rax
	movl	%r10d, %ecx
	subl	%r13d, %r12d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm1
	movl	352(%rsp), %eax
	subl	%edx, %ecx
	salq	$4, %r12
	salq	$4, %rcx
	movl	524(%rsp), %edx
	movl	528(%rsp), %r13d
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm1, %ymm1
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm4
	movl	520(%rsp), %r12d
	subl	%r10d, %eax
	salq	$4, %rax
	movq	%r13, %r8
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm4, %ymm14
	vpsubusb	%ymm10, %ymm15, %ymm13
	movl	516(%rsp), %eax
	vmovdqu	(%r9), %xmm4
	movl	%r12d, %ecx
	vpsubusb	%ymm10, %ymm8, %ymm2
	subl	%edx, %ecx
	salq	$4, %rcx
	vpshufb	%ymm1, %ymm13, %ymm3
	vmovdqu	1(%r9,%rdx), %xmm13
	subl	%r12d, %eax
	vpmaddubsw	%ymm6, %ymm3, %ymm9
	salq	$4, %rax
	vpmaddwd	%ymm7, %ymm9, %ymm5
	vinserti128	$0x1, 1(%r9,%r13), %ymm4, %ymm9
	incl	%r13d
	vmovdqa	%ymm5, 544(%rsp)
	vinserti128	$0x1, 1(%r9,%r12), %ymm13, %ymm5
	movl	%edx, %r9d
	salq	$4, %r13
	subl	%r8d, %r9d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm3
	vpshufb	%ymm14, %ymm2, %ymm15
	vpor	%ymm14, %ymm1, %ymm1
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm2
	salq	$4, %r9
	vpmaddubsw	%ymm6, %ymm15, %ymm0
	movl	512(%rsp), %r13d
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r9), %ymm3, %ymm15
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm2, %ymm13
	vpmaddwd	%ymm7, %ymm0, %ymm8
	movl	348(%rsp), %edx
	vmovdqa	%ymm8, 448(%rsp)
	movq	%r13, %r8
	vpsubusb	%ymm10, %ymm9, %ymm0
	vpsubusb	%ymm10, %ymm5, %ymm5
	vpshufb	%ymm15, %ymm0, %ymm8
	vpshufb	%ymm13, %ymm5, %ymm3
	vpmaddubsw	%ymm6, %ymm8, %ymm4
	vpmaddubsw	%ymm6, %ymm3, %ymm2
	vmovdqu	(%rdi), %xmm8
	vpmaddwd	%ymm7, %ymm4, %ymm9
	vpmaddwd	%ymm7, %ymm2, %ymm0
	vinserti128	$0x1, 1(%rdi,%r13), %ymm8, %ymm4
	incl	%r13d
	vmovdqa	%ymm0, 384(%rsp)
	vmovdqa	%ymm9, 416(%rsp)
	vmovdqu	1(%rdi,%rdx), %xmm9
	movl	344(%rsp), %r12d
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm3
	movl	532(%rsp), %ecx
	movl	340(%rsp), %eax
	vpor	480(%rsp), %ymm1, %ymm14
	vinserti128	$0x1, 1(%rdi,%r12), %ymm9, %ymm5
	movl	%edx, %edi
	movl	%r12d, %r9d
	subl	%r8d, %edi
	subl	%edx, %r9d
	movl	336(%rsp), %r8d
	movl	332(%rsp), %edx
	salq	$4, %rdi
	salq	$4, %r9
	subl	%r12d, %ecx
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rdi), %ymm3, %ymm9
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r9), %xmm2
	salq	$4, %rcx
	vpsubusb	%ymm10, %ymm4, %ymm0
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rcx), %ymm2, %ymm8
	movl	328(%rsp), %edi
	movq	%rax, %r13
	movl	%edx, %esi
	subl	%r8d, %esi
	salq	$4, %rsi
	vpor	%ymm15, %ymm14, %ymm15
	vpsubusb	%ymm10, %ymm5, %ymm5
	subl	%edx, %edi
	vpor	%ymm13, %ymm15, %ymm13
	salq	$4, %rdi
	vpshufb	%ymm9, %ymm0, %ymm4
	vpor	%ymm9, %ymm13, %ymm9
	vpmaddubsw	%ymm6, %ymm4, %ymm3
	vpshufb	%ymm8, %ymm5, %ymm0
	vpor	%ymm8, %ymm9, %ymm8
	vpmaddwd	%ymm7, %ymm3, %ymm2
	vmovdqu	(%r11), %xmm3
	vpmaddubsw	%ymm6, %ymm0, %ymm4
	vmovdqa	%ymm2, 352(%rsp)
	vmovdqu	1(%r11,%r8), %xmm2
	vinserti128	$0x1, 1(%r11,%rax), %ymm3, %ymm3
	incl	%eax
	vinserti128	$0x1, 1(%r11,%rdx), %ymm2, %ymm2
	movl	%r8d, %r11d
	salq	$4, %rax
	vpmaddwd	%ymm7, %ymm4, %ymm0
	subl	%r13d, %r11d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm5
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rsi), %xmm4
	salq	$4, %r11
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%rdi), %ymm4, %ymm4
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm5, %ymm5
	vpsubusb	%ymm10, %ymm3, %ymm3
	vpsubusb	%ymm10, %ymm2, %ymm2
	vpor	%ymm5, %ymm8, %ymm1
	vpshufb	%ymm5, %ymm3, %ymm5
	vpor	%ymm4, %ymm1, %ymm14
	vmovdqa	352(%rsp), %ymm1
	vpshufb	%ymm4, %ymm2, %ymm4
	vpmaddubsw	%ymm6, %ymm5, %ymm15
	vpmaddubsw	%ymm6, %ymm4, %ymm6
	vpmaddwd	%ymm7, %ymm15, %ymm13
	vmovdqa	%ymm14, 480(%rsp)
	vpmaddwd	%ymm7, %ymm6, %ymm9
	vmovdqa	544(%rsp), %ymm7
	vpackusdw	416(%rsp), %ymm7, %ymm8
	vmovdqa	160(%rsp), %ymm6
	vpackusdw	%ymm9, %ymm0, %ymm0
	vpmaddwd	128(%rsp), %ymm8, %ymm14
	vpackusdw	%ymm13, %ymm1, %ymm3
	vpmaddwd	128(%rsp), %ymm3, %ymm5
	vpbroadcastd	.LC23(%rip), %ymm13
	vshufps	$136, %ymm5, %ymm14, %ymm15
	vshufps	$221, %ymm5, %ymm14, %ymm2
	vmovdqa	448(%rsp), %ymm14
	vpmaddwd	128(%rsp), %ymm0, %ymm9
	vpackusdw	384(%rsp), %ymm14, %ymm1
	movq	216(%rsp), %r9
	vpmaddwd	128(%rsp), %ymm1, %ymm5
	vpmulld	%ymm13, %ymm15, %ymm4
	vpaddd	%ymm2, %ymm4, %ymm7
	vpermd	%ymm7, %ymm6, %ymm8
	vshufps	$136, %ymm9, %ymm5, %ymm3
	vpmulld	%ymm13, %ymm3, %ymm15
	vshufps	$221, %ymm9, %ymm5, %ymm13
	vpaddd	%ymm13, %ymm15, %ymm4
	vpermd	%ymm4, %ymm6, %ymm7
	vpunpcklqdq	%ymm7, %ymm8, %ymm2
	vpunpckhqdq	%ymm7, %ymm8, %ymm6
	vmovdqu	%xmm2, (%r9,%rbx,4)
	vextracti128	$0x1, %ymm2, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266752(,%rbx,4)
	vextracti128	$0x1, %ymm6, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533504(,%rbx,4)
	vmovdqa	%xmm6, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region(,%rbx,4)
	addq	$4, %rbx
	jmp	.L326
.L496:
	movq	104(%rsp), %r10
	movq	%r14, %r12
	movq	%r15, %r14
	movq	536(%rsp), %r11
	movq	96(%rsp), %r15
	movq	16(%rsp), %rdi
	movq	%rbx, %r8
	cmpq	%r10, %r14
	jnb	.L322
	vmovdqa	.LC8(%rip), %xmm11
	vmovdqa	.LC9(%rip), %xmm12
	movl	$555819297, %eax
	movl	$808464432, %edx
	vmovdqa	.LC10(%rip), %xmm14
	vmovdqa	480(%rsp), %ymm7
	vmovd	%eax, %xmm1
	vmovd	%edx, %xmm5
	movq	216(%rsp), %rsi
	vpbroadcastd	%xmm1, %xmm9
	vpbroadcastd	%xmm5, %xmm3
	.p2align 4
	.p2align 3
.L321:
	vmovdqu	(%r14), %xmm0
	incq	%r8
	vpcmpgtb	%xmm0, %xmm9, %xmm15
	vpsubusb	%xmm3, %xmm0, %xmm2
	vpmovmskb	%xmm15, %ecx
	tzcntl	%ecx, %r9d
	incl	%r9d
	movq	%r9, %r13
	addq	%r9, %r14
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r13), %xmm13
	vpshufb	%xmm13, %xmm2, %xmm6
	vmovdqa	%xmm13, %xmm4
	vpmaddubsw	%xmm11, %xmm6, %xmm8
	vpor	%ymm4, %ymm7, %ymm7
	vpmaddwd	%xmm12, %xmm8, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm1
	vpmaddwd	%xmm14, %xmm1, %xmm5
	vmovq	%xmm5, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%edx, %eax
	movl	%eax, -4(%rsi,%r8,4)
	cmpq	%r10, %r14
	jb	.L321
	vmovdqa	%ymm7, 480(%rsp)
.L322:
	cmpq	$66687, %rbx
	movq	%rbx, %r9
	setbe	%cl
	cmpq	%r15, %r12
	jnb	.L327
	testb	%cl, %cl
	je	.L327
	movl	$555819297, %esi
	movl	$808464432, %r13d
	vmovdqa	.LC8(%rip), %xmm11
	vmovdqa	.LC9(%rip), %xmm12
	vmovd	%esi, %xmm9
	vmovd	%r13d, %xmm0
	vmovdqa	.LC10(%rip), %xmm14
	vpbroadcastd	%xmm9, %xmm3
	vpbroadcastd	%xmm0, %xmm15
	testb	$1, %bl
	jne	.L478
	vmovdqa	480(%rsp), %ymm6
	jmp	.L328
	.p2align 4
	.p2align 3
.L497:
	vmovdqu	(%r12), %xmm13
	incq	%r9
	vpcmpgtb	%xmm13, %xmm3, %xmm4
	vpsubusb	%xmm15, %xmm13, %xmm8
	vpmovmskb	%xmm4, %esi
	tzcntl	%esi, %r13d
	incl	%r13d
	movq	%r13, %rdx
	addq	%r13, %r12
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm2
	vpshufb	%xmm2, %xmm8, %xmm10
	vmovdqa	%xmm2, %xmm7
	vpmaddubsw	%xmm11, %xmm10, %xmm1
	vpor	%ymm7, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm1, %xmm5
	vpackusdw	%xmm5, %xmm5, %xmm9
	vpmaddwd	%xmm14, %xmm9, %xmm0
	vmovq	%xmm0, %rax
	imull	$100000000, %eax, %esi
	shrq	$32, %rax
	addl	%esi, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r9,4)
	cmpq	%r15, %r12
	jnb	.L486
	cmpq	$66688, %r9
	je	.L486
.L328:
	vmovdqu	(%r12), %xmm13
	incq	%r9
	vpcmpgtb	%xmm13, %xmm3, %xmm4
	vpsubusb	%xmm15, %xmm13, %xmm8
	vpmovmskb	%xmm4, %eax
	tzcntl	%eax, %esi
	incl	%esi
	movq	%rsi, %rdx
	addq	%rsi, %r12
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm2
	vpshufb	%xmm2, %xmm8, %xmm10
	vmovdqa	%xmm2, %xmm7
	vpmaddubsw	%xmm11, %xmm10, %xmm1
	vpor	%ymm7, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm1, %xmm5
	vpackusdw	%xmm5, %xmm5, %xmm9
	vpmaddwd	%xmm14, %xmm9, %xmm0
	vmovq	%xmm0, %r13
	imull	$100000000, %r13d, %eax
	shrq	$32, %r13
	addl	%eax, %r13d
	movl	%r13d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r9,4)
	cmpq	%r15, %r12
	jb	.L497
.L486:
	vmovdqa	%ymm6, 480(%rsp)
.L327:
	movq	112(%rsp), %rsi
	movq	%rbx, %r13
	cmpq	%rsi, %r11
	jnb	.L330
	testb	%cl, %cl
	je	.L330
	movl	$555819297, %edx
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm11
	vmovdqa	.LC9(%rip), %xmm12
	vmovd	%edx, %xmm3
	vmovd	%eax, %xmm13
	vmovdqa	.LC10(%rip), %xmm14
	vpbroadcastd	%xmm3, %xmm15
	vpbroadcastd	%xmm13, %xmm4
	testb	$1, %bl
	jne	.L480
	vmovdqa	480(%rsp), %ymm6
	jmp	.L331
	.p2align 4
	.p2align 3
.L498:
	vmovdqu	(%r11), %xmm2
	incq	%r13
	vpcmpgtb	%xmm2, %xmm15, %xmm7
	vpsubusb	%xmm4, %xmm2, %xmm1
	vpmovmskb	%xmm7, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r11
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm10
	vpshufb	%xmm10, %xmm1, %xmm5
	vmovdqa	%xmm10, %xmm8
	vpmaddubsw	%xmm11, %xmm5, %xmm9
	vpor	%ymm8, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm9, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm3
	vpmaddwd	%xmm14, %xmm3, %xmm13
	vmovq	%xmm13, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	%rsi, %r11
	jnb	.L487
	cmpq	$66688, %r13
	je	.L487
.L331:
	vmovdqu	(%r11), %xmm2
	incq	%r13
	vpcmpgtb	%xmm2, %xmm15, %xmm7
	vpsubusb	%xmm4, %xmm2, %xmm1
	vpmovmskb	%xmm7, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r11
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm10
	vpshufb	%xmm10, %xmm1, %xmm5
	vmovdqa	%xmm10, %xmm8
	vpmaddubsw	%xmm11, %xmm5, %xmm9
	vpor	%ymm8, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm9, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm3
	vpmaddwd	%xmm14, %xmm3, %xmm13
	vmovq	%xmm13, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	%rsi, %r11
	jb	.L498
.L487:
	vmovdqa	%ymm6, 480(%rsp)
.L330:
	movq	576(%rsp), %rdx
	movq	200(%rsp), %rsi
	cmpq	%rsi, %rdx
	jnb	.L333
	testb	%cl, %cl
	je	.L333
	movl	$555819297, %ecx
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm11
	vmovdqa	.LC9(%rip), %xmm12
	vmovd	%ecx, %xmm15
	vmovd	%eax, %xmm2
	vmovdqa	.LC10(%rip), %xmm14
	vpbroadcastd	%xmm15, %xmm4
	vpbroadcastd	%xmm2, %xmm10
	testb	$1, %bl
	jne	.L482
	vmovdqa	480(%rsp), %ymm6
	jmp	.L334
	.p2align 4
	.p2align 3
.L499:
	vmovdqu	(%rdx), %xmm1
	incq	%rbx
	vpcmpgtb	%xmm1, %xmm4, %xmm8
	vpsubusb	%xmm10, %xmm1, %xmm9
	vpmovmskb	%xmm8, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %rdx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm7
	vpshufb	%xmm7, %xmm9, %xmm0
	vmovdqa	%xmm7, %xmm5
	vpmaddubsw	%xmm11, %xmm0, %xmm3
	vpor	%ymm5, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm3, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm15
	vpmaddwd	%xmm14, %xmm15, %xmm2
	vmovq	%xmm2, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%rsi, %rdx
	jnb	.L488
	cmpq	$66688, %rbx
	je	.L488
.L334:
	vmovdqu	(%rdx), %xmm1
	incq	%rbx
	vpcmpgtb	%xmm1, %xmm4, %xmm8
	vpsubusb	%xmm10, %xmm1, %xmm9
	vpmovmskb	%xmm8, %ecx
	tzcntl	%ecx, %eax
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %rdx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm7
	vpshufb	%xmm7, %xmm9, %xmm0
	vmovdqa	%xmm7, %xmm5
	vpmaddubsw	%xmm11, %xmm0, %xmm3
	vpor	%ymm5, %ymm6, %ymm6
	vpmaddwd	%xmm12, %xmm3, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm15
	vpmaddwd	%xmm14, %xmm15, %xmm2
	vmovq	%xmm2, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%rsi, %rdx
	jb	.L499
.L488:
	movq	%rdx, 576(%rsp)
	vmovdqa	%ymm6, 480(%rsp)
.L333:
	cmpq	%r14, %r10
	vmovdqa	480(%rsp), %ymm11
	setne	%r10b
	cmpq	%r12, %r15
	movq	576(%rsp), %r15
	setne	%r12b
	orl	%r12d, %r10d
	cmpq	%r11, 112(%rsp)
	setne	%r11b
	xorl	%esi, %esi
	vpmovmskb	%ymm11, %eax
	orl	%r11d, %r10d
	andl	$-2147450880, %eax
	cmpq	%r15, 200(%rsp)
	movzbl	%r10b, %r14d
	setne	%sil
	orl	%esi, %eax
	orl	%eax, %r14d
	jne	.L500
	movq	216(%rsp), %r14
	leaq	0(,%r9,4), %rdx
	movq	%r9, 608(%rsp)
	movq	%r8, 576(%rsp)
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region, %esi
	vzeroupper
	leaq	(%r14,%r8,4), %rdi
	call	memcpy
	movq	608(%rsp), %rdi
	leaq	0(,%r13,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266752, %esi
	movq	576(%rsp), %r8
	leaq	(%r8,%rdi), %r12
	leaq	(%r14,%r12,4), %rdi
	addq	%r13, %r12
	call	memcpy
	leaq	(%r14,%r12,4), %rdi
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533504, %esi
	call	memcpy
	vmovdqa	.LC3(%rip), %ymm11
	addq	%rbx, %r12
	vmovdqa	.LC2(%rip), %ymm12
	subq	%r12, 24(%rsp)
	leaq	(%r14,%r12,4), %rbx
	movq	%rbx, 216(%rsp)
.L363:
	cmpq	$133312, 24(%rsp)
	jbe	.L494
.L338:
	movq	200(%rsp), %rdi
	jmp	.L364
.L323:
	vmovdqa	.LC4(%rip), %ymm8
	vmovdqa	.LC14(%rip), %ymm9
	movq	%r11, 576(%rsp)
	movq	%r9, %r11
	movq	536(%rsp), %r9
	movq	%rdi, 536(%rsp)
	vmovdqa	.LC2(%rip), %ymm6
	vmovdqa	.LC3(%rip), %ymm7
	movq	%r9, %rdi
	movq	%r14, %r9
	movq	%rsi, %r14
	movq	%r15, %rsi
	movq	%r12, %r15
	movq	%rsi, %r12
	vmovdqa	%ymm8, 128(%rsp)
	vmovdqa	%ymm9, 160(%rsp)
	jmp	.L325
.L478:
	vmovdqu	(%r12), %xmm13
	vpcmpgtb	%xmm13, %xmm3, %xmm4
	vpsubusb	%xmm15, %xmm13, %xmm8
	vpmovmskb	%xmm4, %r9d
	tzcntl	%r9d, %eax
	leaq	1(%rbx), %r9
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r12
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm2
	vpshufb	%xmm2, %xmm8, %xmm10
	vmovdqa	%xmm2, %xmm7
	vpor	480(%rsp), %ymm7, %ymm6
	vpmaddubsw	%xmm11, %xmm10, %xmm1
	vpmaddwd	%xmm12, %xmm1, %xmm5
	vpackusdw	%xmm5, %xmm5, %xmm9
	vpmaddwd	%xmm14, %xmm9, %xmm0
	vmovq	%xmm0, %rsi
	imull	$100000000, %esi, %r13d
	shrq	$32, %rsi
	vmovdqa	%ymm6, 480(%rsp)
	addl	%esi, %r13d
	movl	%r13d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r9,4)
	cmpq	%r15, %r12
	jnb	.L327
	cmpq	$66688, %r9
	jne	.L328
	jmp	.L327
	.p2align 4
	.p2align 3
.L482:
	vmovdqu	(%rdx), %xmm8
	movq	%rdx, %rcx
	incq	%rbx
	vpcmpgtb	%xmm8, %xmm4, %xmm7
	vpsubusb	%xmm10, %xmm8, %xmm9
	vpmovmskb	%xmm7, %edx
	tzcntl	%edx, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rcx
	salq	$4, %rdx
	movq	%rcx, 576(%rsp)
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm6
	vpshufb	%xmm6, %xmm9, %xmm0
	vmovdqa	%xmm6, %xmm1
	vpor	480(%rsp), %ymm1, %ymm5
	vpmaddubsw	%xmm11, %xmm0, %xmm3
	vpmaddwd	%xmm12, %xmm3, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm15
	vpmaddwd	%xmm14, %xmm15, %xmm2
	vmovq	%xmm2, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	vmovdqa	%ymm5, 480(%rsp)
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	200(%rsp), %rcx
	jnb	.L333
	movq	%rcx, %rdx
	vmovdqa	%ymm5, %ymm6
	cmpq	$66688, %rbx
	jne	.L334
	jmp	.L333
	.p2align 4
	.p2align 3
.L480:
	vmovdqu	(%r11), %xmm2
	vpcmpgtb	%xmm2, %xmm15, %xmm7
	vpsubusb	%xmm4, %xmm2, %xmm1
	vpmovmskb	%xmm7, %r13d
	tzcntl	%r13d, %eax
	leaq	1(%rbx), %r13
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r11
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm6
	vpshufb	%xmm6, %xmm1, %xmm5
	vmovdqa	%xmm6, %xmm8
	vpor	480(%rsp), %ymm8, %ymm10
	vpmaddubsw	%xmm11, %xmm5, %xmm9
	vpmaddwd	%xmm12, %xmm9, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm3
	vpmaddwd	%xmm14, %xmm3, %xmm13
	vmovq	%xmm13, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	vmovdqa	%ymm10, 480(%rsp)
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	112(%rsp), %r11
	jnb	.L330
	vmovdqa	%ymm10, %ymm6
	cmpq	$66688, %r13
	jne	.L331
	jmp	.L330
.L494:
	vzeroupper
.L319:
	movq	24(%rsp), %rdx
	movq	216(%rsp), %rsi
	movq	200(%rsp), %rdi
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
.L500:
	.cfi_restore_state
	cmpq	200(%rsp), %rdi
	jnb	.L501
	movq	200(%rsp), %r9
	movl	$1, %edx
	leaq	-1(%r9), %r13
	cmpq	%r13, %rdi
	cmovbe	%rdi, %r13
	cmpq	%rdi, %r13
	movq	%r13, %r15
	setnb	%r10b
	subq	%rdi, %r15
	cmpq	%rdi, %r13
	leaq	1(%r15), %rcx
	cmovb	%rdx, %rcx
	cmpq	$30, %r15
	jbe	.L370
	cmpq	%rdi, %r13
	jb	.L370
	movq	%rcx, %rsi
	movl	$538976288, %r11d
	vmovq	%rdx, %xmm10
	movq	%rdi, %rax
	andq	$-32, %rsi
	vmovd	%r11d, %xmm14
	vpxor	%xmm2, %xmm2, %xmm2
	vpbroadcastq	%xmm10, %ymm8
	leaq	(%rsi,%rdi), %r14
	vpbroadcastd	%xmm14, %ymm4
.L340:
	vmovdqu	(%rax), %ymm1
	addq	$32, %rax
	vpcmpgtb	%ymm4, %ymm1, %ymm7
	vpmovsxbw	%xmm7, %ymm5
	vextracti128	$0x1, %ymm7, %xmm6
	vpmovsxwd	%xmm5, %ymm3
	vextracti128	$0x1, %ymm5, %xmm0
	vpmovsxbw	%xmm6, %ymm9
	vpmovsxdq	%xmm3, %ymm14
	vextracti128	$0x1, %ymm3, %xmm1
	vpmovsxwd	%xmm0, %ymm13
	vpmovsxwd	%xmm9, %ymm15
	vpand	%ymm8, %ymm14, %ymm10
	vpmovsxdq	%xmm1, %ymm7
	vextracti128	$0x1, %ymm13, %xmm3
	vpmovsxdq	%xmm13, %ymm6
	vpsubq	%ymm7, %ymm10, %ymm5
	vextracti128	$0x1, %ymm9, %xmm11
	vpmovsxdq	%xmm3, %ymm0
	vpsubq	%ymm6, %ymm5, %ymm9
	vpmovsxwd	%xmm11, %ymm12
	vpmovsxdq	%xmm15, %ymm11
	vpsubq	%ymm0, %ymm9, %ymm13
	vextracti128	$0x1, %ymm15, %xmm15
	vpmovsxdq	%xmm12, %ymm7
	vpsubq	%ymm11, %ymm13, %ymm14
	vpmovsxdq	%xmm15, %ymm10
	vextracti128	$0x1, %ymm12, %xmm12
	vpsubq	%ymm10, %ymm14, %ymm1
	vpmovsxdq	%xmm12, %ymm6
	vpsubq	%ymm7, %ymm1, %ymm5
	vpsubq	%ymm6, %ymm5, %ymm9
	vpaddq	%ymm9, %ymm2, %ymm2
	cmpq	%r14, %rax
	jne	.L340
	vextracti128	$0x1, %ymm2, %xmm4
	vpaddq	%xmm2, %xmm4, %xmm8
	vpsrldq	$8, %xmm8, %xmm3
	vpaddq	%xmm3, %xmm8, %xmm0
	vmovq	%xmm0, %rdx
	cmpq	%rcx, %rsi
	je	.L341
	vmovdqa	%xmm8, %xmm13
.L339:
	subq	%rsi, %rcx
	leaq	-1(%rcx), %r8
	cmpq	$14, %r8
	jbe	.L342
	vmovdqu	(%rdi,%rsi), %xmm11
	movl	$538976288, %r12d
	movl	$1, %ebx
	vmovd	%r12d, %xmm14
	vmovq	%rbx, %xmm0
	vpbroadcastd	%xmm14, %xmm15
	vpunpcklqdq	%xmm0, %xmm0, %xmm14
	vpcmpgtb	%xmm15, %xmm11, %xmm10
	vpmovsxbw	%xmm10, %xmm1
	vpsrldq	$8, %xmm10, %xmm7
	vpmovsxbw	%xmm7, %xmm12
	vpmovsxwd	%xmm1, %xmm9
	vpsrldq	$8, %xmm1, %xmm5
	vpmovsxwd	%xmm5, %xmm2
	vpmovsxwd	%xmm12, %xmm8
	vpsrldq	$8, %xmm9, %xmm4
	vpmovsxdq	%xmm4, %xmm3
	vpmovsxdq	%xmm2, %xmm10
	vpsrldq	$8, %xmm12, %xmm6
	vpand	%xmm14, %xmm3, %xmm15
	vpsrldq	$8, %xmm2, %xmm7
	vpmovsxdq	%xmm7, %xmm12
	vpmovsxdq	%xmm8, %xmm2
	vpsubq	%xmm10, %xmm15, %xmm1
	vpmovsxwd	%xmm6, %xmm11
	vpsrldq	$8, %xmm8, %xmm8
	vpmovsxdq	%xmm8, %xmm4
	vpaddq	%xmm13, %xmm1, %xmm13
	vpmovsxdq	%xmm11, %xmm3
	vpsrldq	$8, %xmm11, %xmm11
	vpmovsxdq	%xmm11, %xmm15
	vpsubq	%xmm12, %xmm13, %xmm5
	vpmovsxdq	%xmm9, %xmm9
	vpsubq	%xmm2, %xmm5, %xmm6
	vpsubq	%xmm4, %xmm6, %xmm0
	vpsubq	%xmm3, %xmm0, %xmm14
	vpsubq	%xmm15, %xmm14, %xmm10
	vpsubq	%xmm9, %xmm10, %xmm13
	vpsrldq	$8, %xmm13, %xmm1
	vpaddq	%xmm1, %xmm13, %xmm7
	vmovq	%xmm7, %rdx
	testb	$15, %cl
	je	.L341
	andq	$-16, %rcx
	addq	%rcx, %rax
.L342:
	xorl	%r9d, %r9d
	cmpb	$32, (%rax)
	leaq	1(%rax), %rcx
	setg	%r9b
	addq	%r9, %rdx
	cmpq	%rcx, %r13
	jnb	.L502
.L341:
	xorl	%r13d, %r13d
	testb	%r10b, %r10b
	cmovne	%r15, %r13
	movq	200(%rsp), %r15
	leaq	1(%rdi,%r13), %r10
	cmpq	%r15, %r10
	jnb	.L362
	movq	%r10, %r12
	notq	%r12
	addq	%r15, %r12
	andl	$7, %r12d
	cmpb	$32, (%r10)
	jg	.L503
.L398:
	leaq	1(%r10), %r15
	cmpq	200(%rsp), %r15
	jnb	.L362
	testq	%r12, %r12
	je	.L361
	cmpq	$1, %r12
	je	.L446
	cmpq	$2, %r12
	je	.L447
	cmpq	$3, %r12
	je	.L448
	cmpq	$4, %r12
	je	.L449
	cmpq	$5, %r12
	je	.L450
	cmpq	$6, %r12
	je	.L451
	cmpb	$32, 1(%r10)
	jle	.L400
	xorl	%ebx, %ebx
	cmpb	$32, -1(%r15)
	setle	%bl
	addq	%rbx, %rdx
.L400:
	incq	%r15
.L451:
	cmpb	$32, (%r15)
	jle	.L403
	xorl	%r9d, %r9d
	cmpb	$32, -1(%r15)
	setle	%r9b
	addq	%r9, %rdx
.L403:
	incq	%r15
.L450:
	cmpb	$32, (%r15)
	jle	.L406
	xorl	%ecx, %ecx
	cmpb	$32, -1(%r15)
	setle	%cl
	addq	%rcx, %rdx
.L406:
	incq	%r15
.L449:
	cmpb	$32, (%r15)
	jle	.L409
	xorl	%r14d, %r14d
	cmpb	$32, -1(%r15)
	setle	%r14b
	addq	%r14, %rdx
.L409:
	incq	%r15
.L448:
	cmpb	$32, (%r15)
	jle	.L412
	xorl	%r11d, %r11d
	cmpb	$32, -1(%r15)
	setle	%r11b
	addq	%r11, %rdx
.L412:
	incq	%r15
.L447:
	cmpb	$32, (%r15)
	jle	.L415
	xorl	%esi, %esi
	cmpb	$32, -1(%r15)
	setle	%sil
	addq	%rsi, %rdx
.L415:
	incq	%r15
.L446:
	cmpb	$32, (%r15)
	jle	.L418
	xorl	%r8d, %r8d
	cmpb	$32, -1(%r15)
	setle	%r8b
	addq	%r8, %rdx
.L418:
	incq	%r15
	cmpq	200(%rsp), %r15
	jnb	.L362
.L361:
	cmpb	$32, (%r15)
	jle	.L360
	xorl	%r13d, %r13d
	cmpb	$32, -1(%r15)
	setle	%r13b
	addq	%r13, %rdx
.L360:
	cmpb	$32, 1(%r15)
	leaq	1(%r15), %r10
	jle	.L421
	xorl	%r15d, %r15d
	cmpb	$32, -1(%r10)
	setle	%r15b
	addq	%r15, %rdx
.L421:
	cmpb	$32, 1(%r10)
	jle	.L423
	xorl	%r12d, %r12d
	cmpb	$32, (%r10)
	setle	%r12b
	addq	%r12, %rdx
.L423:
	cmpb	$32, 2(%r10)
	jle	.L425
	xorl	%eax, %eax
	cmpb	$32, 1(%r10)
	setle	%al
	addq	%rax, %rdx
.L425:
	cmpb	$32, 3(%r10)
	jle	.L427
	xorl	%ebx, %ebx
	cmpb	$32, 2(%r10)
	setle	%bl
	addq	%rbx, %rdx
.L427:
	cmpb	$32, 4(%r10)
	jle	.L429
	xorl	%r9d, %r9d
	cmpb	$32, 3(%r10)
	setle	%r9b
	addq	%r9, %rdx
.L429:
	cmpb	$32, 5(%r10)
	jle	.L431
	xorl	%ecx, %ecx
	cmpb	$32, 4(%r10)
	setle	%cl
	addq	%rcx, %rdx
.L431:
	cmpb	$32, 6(%r10)
	jle	.L433
	xorl	%r14d, %r14d
	cmpb	$32, 5(%r10)
	setle	%r14b
	addq	%r14, %rdx
.L433:
	leaq	7(%r10), %r15
	cmpq	200(%rsp), %r15
	jb	.L361
.L362:
	movq	216(%rsp), %rsi
	subq	%rdx, 24(%rsp)
	leaq	(%rsi,%rdx,4), %r13
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm12
	movq	%r13, 216(%rsp)
	vmovdqa	.LC3(%rip), %ymm11
	jmp	.L363
.L503:
	xorl	%eax, %eax
	cmpb	$32, -1(%r10)
	setle	%al
	addq	%rax, %rdx
	jmp	.L398
.L502:
	xorl	%r14d, %r14d
	cmpb	$32, 1(%rax)
	leaq	2(%rax), %r11
	setg	%r14b
	addq	%r14, %rdx
	cmpq	%r11, %r13
	jb	.L341
	xorl	%esi, %esi
	cmpb	$32, 2(%rax)
	leaq	3(%rax), %r8
	setg	%sil
	addq	%rsi, %rdx
	cmpq	%r8, %r13
	jb	.L341
	xorl	%r12d, %r12d
	cmpb	$32, 3(%rax)
	leaq	4(%rax), %rbx
	setg	%r12b
	addq	%r12, %rdx
	cmpq	%rbx, %r13
	jb	.L341
	xorl	%r9d, %r9d
	cmpb	$32, 4(%rax)
	leaq	5(%rax), %rcx
	setg	%r9b
	addq	%r9, %rdx
	cmpq	%rcx, %r13
	jb	.L341
	xorl	%r14d, %r14d
	cmpb	$32, 5(%rax)
	leaq	6(%rax), %r11
	setg	%r14b
	addq	%r14, %rdx
	cmpq	%r11, %r13
	jb	.L341
	xorl	%esi, %esi
	cmpb	$32, 6(%rax)
	leaq	7(%rax), %r8
	setg	%sil
	addq	%rsi, %rdx
	cmpq	%r8, %r13
	jb	.L341
	xorl	%r12d, %r12d
	cmpb	$32, 7(%rax)
	leaq	8(%rax), %rbx
	setg	%r12b
	addq	%r12, %rdx
	cmpq	%rbx, %r13
	jb	.L341
	cmpb	$32, 8(%rax)
	jle	.L352
	incq	%rdx
.L352:
	leaq	9(%rax), %r9
	cmpq	%r9, %r13
	jb	.L341
	cmpb	$32, 9(%rax)
	jle	.L353
	incq	%rdx
.L353:
	leaq	10(%rax), %rcx
	cmpq	%rcx, %r13
	jb	.L341
	cmpb	$32, 10(%rax)
	jle	.L354
	incq	%rdx
.L354:
	leaq	11(%rax), %r14
	cmpq	%r14, %r13
	jb	.L341
	cmpb	$32, 11(%rax)
	jle	.L355
	incq	%rdx
.L355:
	leaq	12(%rax), %r11
	cmpq	%r11, %r13
	jb	.L341
	cmpb	$32, 12(%rax)
	jle	.L356
	incq	%rdx
.L356:
	leaq	13(%rax), %rsi
	cmpq	%rsi, %r13
	jb	.L341
	cmpb	$32, 13(%rax)
	jle	.L357
	incq	%rdx
.L357:
	leaq	14(%rax), %r8
	cmpq	%r8, %r13
	jb	.L341
	cmpb	$32, 14(%rax)
	jle	.L341
	incq	%rdx
	jmp	.L341
	.p2align 4
	.p2align 3
.L501:
	movq	216(%rsp), %rsi
	xorl	%edx, %edx
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm12
	vmovdqa	.LC3(%rip), %ymm11
	jmp	.L338
.L370:
	movq	%rdi, %rax
	vpxor	%xmm13, %xmm13, %xmm13
	xorl	%esi, %esi
	xorl	%edx, %edx
	jmp	.L339
.L365:
	movq	%rdi, 200(%rsp)
	jmp	.L319
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
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rsi, %r15
	andq	$-32, %rsp
	subq	$224, %rsp
	movq	%rdx, 8(%rsp)
	cmpq	$133312, %rdx
	jbe	.L549
	vmovdqa	.LC2(%rip), %ymm9
	movq	%rdi, %r10
	vmovdqa	.LC3(%rip), %ymm5
	.p2align 4
	.p2align 3
.L548:
	movl	$555819297, %eax
	vpxor	%xmm8, %xmm8, %xmm8
	movq	$0, 56(%rsp)
	vmovd	%eax, %xmm7
	vmovdqa	%ymm8, 160(%rsp)
	vpbroadcastd	%xmm7, %ymm0
	vmovdqa	%ymm0, 192(%rsp)
	vmovdqa	192(%rsp), %ymm1
	vpcmpgtb	66624(%r10), %ymm1, %ymm2
	vpcmpgtb	133248(%r10), %ymm1, %ymm3
	vpmovmskb	%ymm2, %edx
	vpcmpgtb	199872(%r10), %ymm1, %ymm4
	vpcmpgtb	266496(%r10), %ymm1, %ymm6
	vpmovmskb	%ymm3, %esi
	tzcntl	%edx, %ecx
	vpmovmskb	%ymm4, %r9d
	movl	%ecx, %ebx
	tzcntl	%esi, %edi
	vpmovmskb	%ymm6, %r14d
	tzcntl	%r9d, %r12d
	leaq	66625(%r10,%rbx), %r11
	movl	%edi, %r8d
	tzcntl	%r14d, %eax
	movl	$808464432, %ebx
	movl	%r12d, %r13d
	leaq	133249(%r10,%r8), %rdi
	movl	%eax, %edx
	vmovd	%ebx, %xmm10
	leaq	199873(%r10,%r13), %r8
	movq	%rdi, 32(%rsp)
	leaq	266497(%r10,%rdx), %rcx
	movq	%r8, 24(%rsp)
	movq	%r11, %rsi
	vpbroadcastd	%xmm10, %ymm8
	movq	%rcx, 40(%rsp)
	movq	%r11, 16(%rsp)
	movq	%r10, %rcx
	movq	%r10, %rbx
	.p2align 4
	.p2align 3
.L510:
	movq	40(%rsp), %rax
	movq	24(%rsp), %r10
	movq	32(%rsp), %r11
	movq	16(%rsp), %r9
	subq	%r8, %rax
	subq	%rdi, %r10
	cmpq	%r10, %rax
	cmovg	%r10, %rax
	subq	%rsi, %r11
	subq	%rcx, %r9
	cmpq	%r9, %r11
	cmovg	%r9, %r11
	cmpq	%r11, %rax
	cmovg	%r11, %rax
	cmpq	$64, %rax
	jbe	.L681
	movabsq	$1135184250689818561, %r12
	movq	56(%rsp), %r9
	mulq	%r12
	movq	%rdx, %r13
	andq	$-4, %rdx
	shrq	$2, %r13
	leaq	(%rdx,%r9), %rdx
	movq	%r13, 48(%rsp)
	.p2align 4
	.p2align 3
.L509:
	vmovdqu	(%rcx), %ymm11
	vmovdqa	192(%rsp), %ymm12
	vpcmpgtb	%ymm11, %ymm12, %ymm13
	vpcmpgtb	32(%rcx), %ymm12, %ymm14
	vpmovmskb	%ymm13, %r14d
	blsr	%r14d, %eax
	tzcntl	%r14d, %r12d
	blsr	%eax, %r13d
	tzcntl	%eax, %r11d
	tzcntl	%r13d, %r10d
	blsr	%r13d, %r14d
	vpmovmskb	%ymm14, %r13d
	movl	%r14d, %eax
	movl	%r11d, %r14d
	salq	$32, %r13
	vmovdqu	1(%rcx,%r14), %xmm15
	movl	%r10d, %r14d
	orq	%r13, %rax
	movl	%r12d, %r13d
	vinserti128	$0x1, 1(%rcx,%r14), %ymm15, %ymm1
	vinserti128	$0x1, 1(%rcx,%r13), %ymm11, %ymm7
	incl	%r13d
	tzcntq	%rax, %rax
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm0
	movl	%r11d, %r13d
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	salq	$4, %r13
	subl	%r11d, %r12d
	movl	%eax, %r11d
	incl	%eax
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm0, %ymm3
	salq	$4, %r12
	subl	%r10d, %r11d
	addq	%rax, %rcx
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm2
	salq	$4, %r11
	vpsubusb	%ymm8, %ymm1, %ymm11
	vmovdqa	192(%rsp), %ymm1
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm2, %ymm15
	vpsubusb	%ymm8, %ymm7, %ymm4
	vmovdqu	(%rsi), %ymm7
	vpshufb	%ymm3, %ymm4, %ymm6
	vpmaddubsw	%ymm9, %ymm6, %ymm10
	vpshufb	%ymm15, %ymm11, %ymm12
	vpcmpgtb	32(%rsi), %ymm1, %ymm4
	vpmaddwd	%ymm5, %ymm10, %ymm0
	vpor	%ymm15, %ymm3, %ymm3
	vpcmpgtb	%ymm7, %ymm1, %ymm2
	vpmaddubsw	%ymm9, %ymm12, %ymm13
	vpmovmskb	%ymm2, %r10d
	vpmaddwd	%ymm5, %ymm13, %ymm14
	blsr	%r10d, %eax
	tzcntl	%r10d, %r12d
	vmovdqa	%ymm14, 128(%rsp)
	blsr	%eax, %r14d
	tzcntl	%eax, %r11d
	blsr	%r14d, %r13d
	tzcntl	%r14d, %r10d
	vpmovmskb	%ymm4, %r14d
	movl	%r13d, %eax
	movl	%r12d, %r13d
	vinserti128	$0x1, 1(%rsi,%r13), %ymm7, %ymm6
	incl	%r13d
	salq	$32, %r14
	salq	$4, %r13
	orq	%r14, %rax
	movl	%r11d, %r14d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm12
	movl	%r11d, %r13d
	tzcntq	%rax, %rax
	vmovdqu	1(%rsi,%r14), %xmm10
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	movl	%r10d, %r14d
	salq	$4, %r13
	subl	%r11d, %r12d
	movl	%eax, %r11d
	vinserti128	$0x1, 1(%rsi,%r14), %ymm10, %ymm11
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm12, %ymm14
	salq	$4, %r12
	subl	%r10d, %r11d
	incl	%eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm13
	salq	$4, %r11
	addq	%rax, %rsi
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm13, %ymm13
	vpsubusb	%ymm8, %ymm6, %ymm7
	vpsubusb	%ymm8, %ymm11, %ymm6
	vpshufb	%ymm14, %ymm7, %ymm1
	vmovdqu	(%rdi), %ymm7
	vpmaddubsw	%ymm9, %ymm1, %ymm2
	vmovdqa	192(%rsp), %ymm1
	vpmaddwd	%ymm5, %ymm2, %ymm4
	vpshufb	%ymm13, %ymm6, %ymm10
	vmovdqa	%ymm4, 96(%rsp)
	vmovdqa	192(%rsp), %ymm4
	vpmaddubsw	%ymm9, %ymm10, %ymm11
	vpmaddwd	%ymm5, %ymm11, %ymm12
	vmovdqa	%ymm12, 64(%rsp)
	vpcmpgtb	%ymm7, %ymm1, %ymm2
	vpmovmskb	%ymm2, %r10d
	blsr	%r10d, %eax
	tzcntl	%r10d, %r12d
	vpcmpgtb	32(%rdi), %ymm4, %ymm6
	blsr	%eax, %r14d
	tzcntl	%eax, %r11d
	blsr	%r14d, %r13d
	tzcntl	%r14d, %r10d
	vpmovmskb	%ymm6, %r14d
	movl	%r13d, %eax
	movl	%r12d, %r13d
	vinserti128	$0x1, 1(%rdi,%r13), %ymm7, %ymm10
	incl	%r13d
	salq	$32, %r14
	salq	$4, %r13
	orq	%r14, %rax
	movl	%r11d, %r14d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm12
	movl	%r11d, %r13d
	tzcntq	%rax, %rax
	vmovdqu	1(%rdi,%r14), %xmm11
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	movl	%r10d, %r14d
	subl	%r11d, %r12d
	movl	%eax, %r11d
	salq	$4, %r13
	vinserti128	$0x1, 1(%rdi,%r14), %ymm11, %ymm7
	salq	$4, %r12
	subl	%r10d, %r11d
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm12, %ymm12
	incl	%eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm1
	salq	$4, %r11
	addq	%rax, %rdi
	vpor	160(%rsp), %ymm3, %ymm15
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm1, %ymm11
	vpackusdw	96(%rsp), %ymm0, %ymm0
	vpsubusb	%ymm8, %ymm10, %ymm2
	vpsubusb	%ymm8, %ymm7, %ymm10
	vpshufb	%ymm12, %ymm2, %ymm4
	vpmaddubsw	%ymm9, %ymm4, %ymm6
	vmovdqu	(%r8), %ymm4
	vpor	%ymm14, %ymm15, %ymm14
	vpshufb	%ymm11, %ymm10, %ymm7
	vmovdqa	192(%rsp), %ymm10
	vpmaddwd	%ymm5, %ymm6, %ymm1
	vpor	%ymm13, %ymm14, %ymm13
	vpmaddubsw	%ymm9, %ymm7, %ymm2
	vpor	%ymm12, %ymm13, %ymm12
	vpor	%ymm11, %ymm12, %ymm11
	vpmaddwd	%ymm5, %ymm2, %ymm2
	vpcmpgtb	%ymm4, %ymm10, %ymm6
	vpcmpgtb	32(%r8), %ymm10, %ymm7
	vpmovmskb	%ymm6, %r10d
	blsr	%r10d, %eax
	tzcntl	%r10d, %r12d
	blsr	%eax, %r14d
	tzcntl	%eax, %r11d
	tzcntl	%r14d, %r10d
	blsr	%r14d, %r13d
	vpmovmskb	%ymm7, %r14d
	movl	%r13d, %eax
	movl	%r12d, %r13d
	salq	$32, %r14
	vinserti128	$0x1, 1(%r8,%r13), %ymm4, %ymm4
	orq	%r14, %rax
	incl	%r13d
	movl	%r11d, %r14d
	salq	$4, %r13
	tzcntq	%rax, %rax
	vmovdqu	1(%r8,%r14), %xmm10
	movl	%r10d, %r14d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm7
	movl	%r11d, %r13d
	vinserti128	$0x1, 1(%r8,%r14), %ymm10, %ymm6
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	subl	%r11d, %r12d
	salq	$4, %r13
	movl	%eax, %r11d
	incl	%eax
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm7, %ymm10
	salq	$4, %r12
	subl	%r10d, %r11d
	addq	%rax, %r8
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm7
	salq	$4, %r11
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm7, %ymm7
	vpsubusb	%ymm8, %ymm4, %ymm4
	vpsubusb	%ymm8, %ymm6, %ymm6
	vpor	%ymm10, %ymm11, %ymm3
	vpshufb	%ymm10, %ymm4, %ymm10
	vpmaddubsw	%ymm9, %ymm10, %ymm14
	vpor	%ymm7, %ymm3, %ymm15
	vpmaddwd	%ymm5, %ymm14, %ymm13
	vpshufb	%ymm7, %ymm6, %ymm7
	vmovdqa	.LC14(%rip), %ymm6
	vpackusdw	%ymm13, %ymm1, %ymm1
	vmovdqa	%ymm15, 160(%rsp)
	vpmaddwd	.LC4(%rip), %ymm1, %ymm3
	vpmaddwd	.LC4(%rip), %ymm0, %ymm15
	vpmaddubsw	%ymm9, %ymm7, %ymm12
	vmovdqa	128(%rsp), %ymm7
	vpmaddwd	%ymm5, %ymm12, %ymm11
	vpackusdw	64(%rsp), %ymm7, %ymm0
	vpackusdw	%ymm11, %ymm2, %ymm2
	vpmaddwd	.LC4(%rip), %ymm2, %ymm11
	vshufps	$136, %ymm3, %ymm15, %ymm4
	vshufps	$221, %ymm3, %ymm15, %ymm14
	vpmulld	.LC5(%rip), %ymm4, %ymm10
	vpmaddwd	.LC4(%rip), %ymm0, %ymm15
	vshufps	$136, %ymm11, %ymm15, %ymm1
	vpmulld	.LC5(%rip), %ymm1, %ymm3
	vshufps	$221, %ymm11, %ymm15, %ymm4
	vpaddd	%ymm14, %ymm10, %ymm13
	vmovdqa	.LC14(%rip), %ymm14
	vpermd	%ymm13, %ymm6, %ymm12
	vpaddd	%ymm4, %ymm3, %ymm10
	vpermd	%ymm10, %ymm14, %ymm13
	vpunpcklqdq	%ymm13, %ymm12, %ymm6
	vpunpckhqdq	%ymm13, %ymm12, %ymm12
	vmovdqu	%xmm6, (%r15,%r9,4)
	vextracti128	$0x1, %ymm6, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266752(,%r9,4)
	vmovdqa	%xmm12, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region(,%r9,4)
	vextracti128	$0x1, %ymm12, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533504(,%r9,4)
	addq	$4, %r9
	cmpq	%rdx, %r9
	jne	.L509
	movq	56(%rsp), %rdx
	movq	48(%rsp), %r9
	leaq	(%rdx,%r9,4), %r10
	movq	%r10, 56(%rsp)
	jmp	.L510
	.p2align 4
	.p2align 3
.L681:
	movq	%rbx, %r10
	movq	16(%rsp), %r11
	movq	56(%rsp), %rbx
	movq	%rbx, %r14
	cmpq	%r11, %rcx
	jnb	.L508
	vmovdqa	.LC8(%rip), %xmm5
	vmovdqa	.LC9(%rip), %xmm9
	movl	$555819297, %eax
	movl	$808464432, %r13d
	vmovdqa	.LC10(%rip), %xmm15
	vmovdqa	160(%rsp), %ymm14
	vmovd	%eax, %xmm8
	vmovd	%r13d, %xmm0
	vpbroadcastd	%xmm8, %xmm2
	vpbroadcastd	%xmm0, %xmm11
	.p2align 4
	.p2align 3
.L507:
	vmovdqu	(%rcx), %xmm3
	incq	%r14
	vpcmpgtb	%xmm3, %xmm2, %xmm1
	vpsubusb	%xmm11, %xmm3, %xmm13
	vpmovmskb	%xmm1, %r12d
	tzcntl	%r12d, %r9d
	incl	%r9d
	movq	%r9, %rdx
	addq	%r9, %rcx
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm4
	vpshufb	%xmm4, %xmm13, %xmm6
	vmovdqa	%xmm4, %xmm10
	vpmaddubsw	%xmm5, %xmm6, %xmm12
	vpor	%ymm10, %ymm14, %ymm14
	vpmaddwd	%xmm9, %xmm12, %xmm7
	vpackusdw	%xmm7, %xmm7, %xmm8
	vpmaddwd	%xmm15, %xmm8, %xmm0
	vmovq	%xmm0, %rax
	imull	$100000000, %eax, %r13d
	shrq	$32, %rax
	addl	%r13d, %eax
	movl	%eax, -4(%r15,%r14,4)
	cmpq	%r11, %rcx
	jb	.L507
	vmovdqa	%ymm14, 160(%rsp)
.L508:
	movq	32(%rsp), %r13
	cmpq	$66687, %rbx
	movq	%rbx, %r12
	setbe	%r9b
	cmpq	%r13, %rsi
	jnb	.L511
	testb	%r9b, %r9b
	je	.L511
	movl	$555819297, %edx
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm5
	vmovdqa	.LC9(%rip), %xmm9
	vmovd	%edx, %xmm2
	vmovd	%eax, %xmm3
	vmovdqa	.LC10(%rip), %xmm15
	vpbroadcastd	%xmm2, %xmm11
	vpbroadcastd	%xmm3, %xmm1
	testb	$1, %bl
	jne	.L662
	vmovdqa	160(%rsp), %ymm7
	jmp	.L512
	.p2align 4
	.p2align 3
.L682:
	vmovdqu	(%rsi), %xmm4
	incq	%r12
	vpcmpgtb	%xmm4, %xmm11, %xmm10
	vpsubusb	%xmm1, %xmm4, %xmm6
	vpmovmskb	%xmm10, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm6, %xmm12
	vmovdqa	%xmm14, %xmm13
	vpmaddubsw	%xmm5, %xmm12, %xmm8
	vpor	%ymm13, %ymm7, %ymm7
	vpmaddwd	%xmm9, %xmm8, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm2
	vpmaddwd	%xmm15, %xmm2, %xmm3
	vmovq	%xmm3, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r12,4)
	cmpq	%r13, %rsi
	jnb	.L670
	cmpq	$66688, %r12
	je	.L670
.L512:
	vmovdqu	(%rsi), %xmm4
	incq	%r12
	vpcmpgtb	%xmm4, %xmm11, %xmm10
	vpsubusb	%xmm1, %xmm4, %xmm6
	vpmovmskb	%xmm10, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm6, %xmm12
	vmovdqa	%xmm14, %xmm13
	vpmaddubsw	%xmm5, %xmm12, %xmm8
	vpor	%ymm13, %ymm7, %ymm7
	vpmaddwd	%xmm9, %xmm8, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm2
	vpmaddwd	%xmm15, %xmm2, %xmm3
	vmovq	%xmm3, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r12,4)
	cmpq	%r13, %rsi
	jb	.L682
.L670:
	vmovdqa	%ymm7, 160(%rsp)
.L511:
	movq	24(%rsp), %rax
	movq	%rbx, %r13
	cmpq	%rax, %rdi
	jnb	.L514
	testb	%r9b, %r9b
	je	.L514
	movl	$555819297, %edx
	vmovdqa	.LC8(%rip), %xmm1
	vmovdqa	.LC9(%rip), %xmm2
	vmovd	%edx, %xmm5
	movl	$808464432, %edx
	vmovdqa	.LC10(%rip), %xmm3
	vmovd	%edx, %xmm9
	vpbroadcastd	%xmm5, %xmm4
	vpbroadcastd	%xmm9, %xmm6
	testb	$1, %bl
	jne	.L664
	movq	%r11, 192(%rsp)
	vmovdqa	160(%rsp), %ymm7
	movq	%rax, %r11
	jmp	.L515
	.p2align 4
	.p2align 3
.L683:
	vmovdqu	(%rdi), %xmm15
	incq	%r13
	vpcmpgtb	%xmm15, %xmm4, %xmm11
	vpsubusb	%xmm6, %xmm15, %xmm13
	vpmovmskb	%xmm11, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm13, %xmm12
	vmovdqa	%xmm14, %xmm10
	vpmaddubsw	%xmm1, %xmm12, %xmm8
	vpor	%ymm10, %ymm7, %ymm7
	vpmaddwd	%xmm2, %xmm8, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm9
	vmovq	%xmm9, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	%r11, %rdi
	jnb	.L671
	cmpq	$66688, %r13
	je	.L671
.L515:
	vmovdqu	(%rdi), %xmm15
	incq	%r13
	vpcmpgtb	%xmm15, %xmm4, %xmm11
	vpsubusb	%xmm6, %xmm15, %xmm13
	vpmovmskb	%xmm11, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm13, %xmm12
	vmovdqa	%xmm14, %xmm10
	vpmaddubsw	%xmm1, %xmm12, %xmm8
	vpor	%ymm10, %ymm7, %ymm7
	vpmaddwd	%xmm2, %xmm8, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm9
	vmovq	%xmm9, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	%r11, %rdi
	jb	.L683
.L671:
	movq	192(%rsp), %r11
	vmovdqa	%ymm7, 160(%rsp)
.L514:
	movq	40(%rsp), %rax
	cmpq	%rax, %r8
	jnb	.L517
	testb	%r9b, %r9b
	je	.L517
	movl	$555819297, %r9d
	movl	$808464432, %edx
	vmovdqa	.LC8(%rip), %xmm1
	vmovdqa	.LC9(%rip), %xmm2
	vmovd	%r9d, %xmm4
	vmovd	%edx, %xmm6
	vmovdqa	.LC10(%rip), %xmm3
	vpbroadcastd	%xmm4, %xmm15
	vpbroadcastd	%xmm6, %xmm11
	testb	$1, %bl
	jne	.L666
	vmovdqa	160(%rsp), %ymm7
	movq	%rax, %r9
	jmp	.L518
	.p2align 4
	.p2align 3
.L684:
	vmovdqu	(%r8), %xmm14
	incq	%rbx
	vpcmpgtb	%xmm14, %xmm15, %xmm10
	vpsubusb	%xmm11, %xmm14, %xmm8
	vpmovmskb	%xmm10, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm8, %xmm0
	vmovdqa	%xmm13, %xmm12
	vpmaddubsw	%xmm1, %xmm0, %xmm5
	vpor	%ymm12, %ymm7, %ymm7
	vpmaddwd	%xmm2, %xmm5, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm4
	vpmaddwd	%xmm3, %xmm4, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%r9, %r8
	jnb	.L672
	cmpq	$66688, %rbx
	je	.L672
.L518:
	vmovdqu	(%r8), %xmm14
	incq	%rbx
	vpcmpgtb	%xmm14, %xmm15, %xmm10
	vpsubusb	%xmm11, %xmm14, %xmm8
	vpmovmskb	%xmm10, %edx
	tzcntl	%edx, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm8, %xmm0
	vmovdqa	%xmm13, %xmm12
	vpmaddubsw	%xmm1, %xmm0, %xmm5
	vpor	%ymm12, %ymm7, %ymm7
	vpmaddwd	%xmm2, %xmm5, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm4
	vpmaddwd	%xmm3, %xmm4, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%r9, %r8
	jb	.L684
.L672:
	vmovdqa	%ymm7, 160(%rsp)
.L517:
	cmpq	%rcx, %r11
	vmovdqa	160(%rsp), %ymm1
	setne	%r11b
	cmpq	%rsi, 32(%rsp)
	setne	%cl
	orl	%ecx, %r11d
	cmpq	%rdi, 24(%rsp)
	vpmovmskb	%ymm1, %r9d
	setne	%sil
	andl	$-2147450880, %r9d
	xorl	%eax, %eax
	orl	%esi, %r11d
	cmpq	%r8, 40(%rsp)
	movzbl	%r11b, %edi
	setne	%al
	orl	%eax, %r9d
	orl	%r9d, %edi
	jne	.L685
	vzeroupper
	leaq	(%r15,%r14,4), %rdi
	leaq	0(,%r12,4), %rdx
	movl	$_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region, %esi
	addq	%r14, %r12
	call	memcpy
	leaq	0(,%r13,4), %rdx
	movl	$_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266752, %esi
	leaq	(%r15,%r12,4), %rdi
	addq	%r13, %r12
	call	memcpy
	leaq	(%r15,%r12,4), %rdi
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533504, %esi
	call	memcpy
	vmovdqa	.LC3(%rip), %ymm5
	addq	%rbx, %r12
	vmovdqa	.LC2(%rip), %ymm9
	subq	%r12, 8(%rsp)
	leaq	(%r15,%r12,4), %r15
.L547:
	cmpq	$133312, 8(%rsp)
	jbe	.L679
.L522:
	movq	40(%rsp), %r10
	jmp	.L548
.L666:
	vmovdqu	(%r8), %xmm14
	incq	%rbx
	vpcmpgtb	%xmm14, %xmm15, %xmm10
	vpsubusb	%xmm11, %xmm14, %xmm8
	vpmovmskb	%xmm10, %eax
	tzcntl	%eax, %r9d
	incl	%r9d
	movq	%r9, %rdx
	addq	%r9, %r8
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm7
	vpshufb	%xmm7, %xmm8, %xmm0
	vmovdqa	%xmm7, %xmm13
	vpor	160(%rsp), %ymm13, %ymm12
	vpmaddubsw	%xmm1, %xmm0, %xmm5
	vpmaddwd	%xmm2, %xmm5, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm4
	vpmaddwd	%xmm3, %xmm4, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %r9d
	shrq	$32, %rax
	vmovdqa	%ymm12, 160(%rsp)
	addl	%eax, %r9d
	movl	%r9d, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	40(%rsp), %r8
	jnb	.L517
	movq	40(%rsp), %r9
	vmovdqa	%ymm12, %ymm7
	cmpq	$66688, %rbx
	jne	.L518
	jmp	.L517
	.p2align 4
	.p2align 3
.L664:
	vmovdqu	(%rdi), %xmm15
	vpcmpgtb	%xmm15, %xmm4, %xmm11
	vpsubusb	%xmm6, %xmm15, %xmm7
	vpmovmskb	%xmm11, %r13d
	tzcntl	%r13d, %eax
	leaq	1(%rbx), %r13
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm10
	vpshufb	%xmm10, %xmm7, %xmm12
	vmovdqa	%xmm10, %xmm14
	vpor	160(%rsp), %ymm14, %ymm13
	vpmaddubsw	%xmm1, %xmm12, %xmm8
	vpmaddwd	%xmm2, %xmm8, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm9
	vmovq	%xmm9, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	vmovdqa	%ymm13, 160(%rsp)
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r13,4)
	cmpq	24(%rsp), %rdi
	jnb	.L514
	cmpq	$66688, %r13
	je	.L514
	movq	%r11, 192(%rsp)
	vmovdqa	%ymm13, %ymm7
	movq	24(%rsp), %r11
	jmp	.L515
.L662:
	vmovdqu	(%rsi), %xmm4
	vpcmpgtb	%xmm4, %xmm11, %xmm10
	vpsubusb	%xmm1, %xmm4, %xmm12
	vpmovmskb	%xmm10, %r12d
	tzcntl	%r12d, %eax
	leaq	1(%rbx), %r12
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm12, %xmm7
	vmovdqa	%xmm14, %xmm13
	vpor	160(%rsp), %ymm13, %ymm6
	vpmaddubsw	%xmm5, %xmm7, %xmm8
	vpmaddwd	%xmm9, %xmm8, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm2
	vpmaddwd	%xmm15, %xmm2, %xmm3
	vmovq	%xmm3, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	vmovdqa	%ymm6, 160(%rsp)
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r12,4)
	cmpq	32(%rsp), %rsi
	jnb	.L511
	vmovdqa	%ymm6, %ymm7
	cmpq	$66688, %r12
	jne	.L512
	jmp	.L511
.L679:
	vzeroupper
.L505:
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
.L685:
	.cfi_restore_state
	cmpq	40(%rsp), %r10
	jnb	.L686
	movq	40(%rsp), %r12
	movl	$1, %edx
	leaq	-1(%r12), %r13
	cmpq	%r13, %r10
	cmovbe	%r10, %r13
	cmpq	%r10, %r13
	movq	%r13, %r8
	setnb	%r14b
	subq	%r10, %r8
	cmpq	%r10, %r13
	leaq	1(%r8), %r9
	cmovb	%rdx, %r9
	cmpq	$30, %r8
	jbe	.L553
	cmpq	%r10, %r13
	jb	.L553
	movq	%r9, %rcx
	movl	$538976288, %r11d
	vmovq	%rdx, %xmm11
	movq	%r10, %rdi
	andq	$-32, %rcx
	vmovd	%r11d, %xmm3
	vpxor	%xmm2, %xmm2, %xmm2
	vpbroadcastq	%xmm11, %ymm14
	leaq	(%rcx,%r10), %rbx
	vpbroadcastd	%xmm3, %ymm15
.L524:
	vmovdqu	(%rdi), %ymm10
	addq	$32, %rdi
	vpcmpgtb	%ymm15, %ymm10, %ymm13
	vpmovsxbw	%xmm13, %ymm12
	vextracti128	$0x1, %ymm13, %xmm7
	vpmovsxwd	%xmm12, %ymm8
	vextracti128	$0x1, %ymm12, %xmm4
	vpmovsxbw	%xmm7, %ymm0
	vpmovsxdq	%xmm8, %ymm3
	vextracti128	$0x1, %ymm8, %xmm10
	vpmovsxwd	%xmm4, %ymm6
	vpmovsxwd	%xmm0, %ymm5
	vpand	%ymm14, %ymm3, %ymm11
	vpmovsxdq	%xmm10, %ymm13
	vextracti128	$0x1, %ymm6, %xmm8
	vpmovsxdq	%xmm6, %ymm7
	vpsubq	%ymm13, %ymm11, %ymm12
	vextracti128	$0x1, %ymm0, %xmm1
	vpmovsxdq	%xmm8, %ymm4
	vpmovsxdq	%xmm5, %ymm6
	vpsubq	%ymm7, %ymm12, %ymm0
	vpmovsxwd	%xmm1, %ymm9
	vextracti128	$0x1, %ymm5, %xmm5
	vpsubq	%ymm4, %ymm0, %ymm1
	vpmovsxdq	%xmm5, %ymm11
	vpmovsxdq	%xmm9, %ymm13
	vpsubq	%ymm6, %ymm1, %ymm3
	vextracti128	$0x1, %ymm9, %xmm9
	vpsubq	%ymm11, %ymm3, %ymm10
	vpmovsxdq	%xmm9, %ymm7
	vpsubq	%ymm13, %ymm10, %ymm12
	vpsubq	%ymm7, %ymm12, %ymm0
	vpaddq	%ymm0, %ymm2, %ymm2
	cmpq	%rbx, %rdi
	jne	.L524
	vextracti128	$0x1, %ymm2, %xmm15
	vpaddq	%xmm2, %xmm15, %xmm14
	vpsrldq	$8, %xmm14, %xmm8
	vpaddq	%xmm8, %xmm14, %xmm4
	vmovq	%xmm4, %rdx
	cmpq	%r9, %rcx
	je	.L525
	vmovdqa	%xmm14, %xmm5
.L523:
	subq	%rcx, %r9
	leaq	-1(%r9), %rsi
	cmpq	$14, %rsi
	jbe	.L526
	vmovdqu	(%r10,%rcx), %xmm6
	movl	$538976288, %eax
	movl	$1, %r12d
	vmovd	%eax, %xmm1
	vpbroadcastd	%xmm1, %xmm3
	vpcmpgtb	%xmm3, %xmm6, %xmm11
	vmovq	%r12, %xmm6
	vpmovsxbw	%xmm11, %xmm10
	vpunpcklqdq	%xmm6, %xmm6, %xmm1
	vpsrldq	$8, %xmm11, %xmm13
	vpmovsxbw	%xmm13, %xmm12
	vpmovsxwd	%xmm10, %xmm9
	vpsrldq	$8, %xmm10, %xmm7
	vpmovsxwd	%xmm7, %xmm2
	vpmovsxwd	%xmm12, %xmm15
	vpsrldq	$8, %xmm9, %xmm8
	vpmovsxdq	%xmm8, %xmm4
	vpmovsxdq	%xmm2, %xmm11
	vpsrldq	$8, %xmm12, %xmm0
	vpand	%xmm1, %xmm4, %xmm3
	vpsrldq	$8, %xmm2, %xmm13
	vpmovsxdq	%xmm13, %xmm12
	vpmovsxdq	%xmm15, %xmm2
	vpsubq	%xmm11, %xmm3, %xmm10
	vpmovsxwd	%xmm0, %xmm14
	vpsrldq	$8, %xmm15, %xmm15
	vpmovsxdq	%xmm15, %xmm8
	vpaddq	%xmm5, %xmm10, %xmm5
	vpmovsxdq	%xmm14, %xmm6
	vpsrldq	$8, %xmm14, %xmm14
	vpmovsxdq	%xmm14, %xmm1
	vpsubq	%xmm12, %xmm5, %xmm7
	vpmovsxdq	%xmm9, %xmm9
	vpsubq	%xmm2, %xmm7, %xmm0
	vpsubq	%xmm8, %xmm0, %xmm4
	vpsubq	%xmm6, %xmm4, %xmm3
	vpsubq	%xmm1, %xmm3, %xmm11
	vpsubq	%xmm9, %xmm11, %xmm10
	vpsrldq	$8, %xmm10, %xmm5
	vpaddq	%xmm5, %xmm10, %xmm13
	vmovq	%xmm13, %rdx
	testb	$15, %r9b
	je	.L525
	andq	$-16, %r9
	addq	%r9, %rdi
.L526:
	xorl	%r9d, %r9d
	cmpb	$32, (%rdi)
	leaq	1(%rdi), %rbx
	setg	%r9b
	addq	%r9, %rdx
	cmpq	%rbx, %r13
	jnb	.L687
.L525:
	xorl	%r13d, %r13d
	testb	%r14b, %r14b
	cmovne	%r8, %r13
	movq	40(%rsp), %r8
	leaq	1(%r10,%r13), %r14
	cmpq	%r8, %r14
	jnb	.L546
	movq	%r14, %rdi
	notq	%rdi
	addq	%r8, %rdi
	andl	$7, %edi
	cmpb	$32, (%r14)
	jg	.L688
.L582:
	leaq	1(%r14), %rax
	cmpq	40(%rsp), %rax
	jnb	.L546
	testq	%rdi, %rdi
	je	.L545
	cmpq	$1, %rdi
	je	.L630
	cmpq	$2, %rdi
	je	.L631
	cmpq	$3, %rdi
	je	.L632
	cmpq	$4, %rdi
	je	.L633
	cmpq	$5, %rdi
	je	.L634
	cmpq	$6, %rdi
	je	.L635
	cmpb	$32, 1(%r14)
	jg	.L689
.L584:
	incq	%rax
.L635:
	cmpb	$32, (%rax)
	jle	.L587
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L587:
	incq	%rax
.L634:
	cmpb	$32, (%rax)
	jg	.L690
.L590:
	incq	%rax
.L633:
	cmpb	$32, (%rax)
	jg	.L691
.L593:
	incq	%rax
.L632:
	cmpb	$32, (%rax)
	jg	.L692
.L596:
	incq	%rax
.L631:
	cmpb	$32, (%rax)
	jle	.L599
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
.L599:
	incq	%rax
.L630:
	cmpb	$32, (%rax)
	jle	.L602
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L602:
	incq	%rax
	cmpq	40(%rsp), %rax
	jnb	.L546
.L545:
	cmpb	$32, (%rax)
	jle	.L544
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
.L544:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %rdi
	jle	.L605
	xorl	%eax, %eax
	cmpb	$32, -1(%rdi)
	setle	%al
	addq	%rax, %rdx
.L605:
	cmpb	$32, 1(%rdi)
	jle	.L607
	xorl	%ebx, %ebx
	cmpb	$32, (%rdi)
	setle	%bl
	addq	%rbx, %rdx
.L607:
	cmpb	$32, 2(%rdi)
	jle	.L609
	xorl	%r11d, %r11d
	cmpb	$32, 1(%rdi)
	setle	%r11b
	addq	%r11, %rdx
.L609:
	cmpb	$32, 3(%rdi)
	jle	.L611
	xorl	%ecx, %ecx
	cmpb	$32, 2(%rdi)
	setle	%cl
	addq	%rcx, %rdx
.L611:
	cmpb	$32, 4(%rdi)
	jle	.L613
	xorl	%esi, %esi
	cmpb	$32, 3(%rdi)
	setle	%sil
	addq	%rsi, %rdx
.L613:
	cmpb	$32, 5(%rdi)
	jle	.L615
	xorl	%r12d, %r12d
	cmpb	$32, 4(%rdi)
	setle	%r12b
	addq	%r12, %rdx
.L615:
	cmpb	$32, 6(%rdi)
	jle	.L617
	xorl	%r9d, %r9d
	cmpb	$32, 5(%rdi)
	setle	%r9b
	addq	%r9, %rdx
.L617:
	leaq	7(%rdi), %rax
	cmpq	40(%rsp), %rax
	jb	.L545
.L546:
	subq	%rdx, 8(%rsp)
	movq	%r15, %rsi
	movq	%r10, %rdi
	leaq	(%r15,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm9
	vmovdqa	.LC3(%rip), %ymm5
	jmp	.L547
.L688:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%r14)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L582
.L687:
	xorl	%r11d, %r11d
	cmpb	$32, 1(%rdi)
	leaq	2(%rdi), %rcx
	setg	%r11b
	addq	%r11, %rdx
	cmpq	%rcx, %r13
	jb	.L525
	xorl	%esi, %esi
	cmpb	$32, 2(%rdi)
	leaq	3(%rdi), %rax
	setg	%sil
	addq	%rsi, %rdx
	cmpq	%rax, %r13
	jb	.L525
	xorl	%r12d, %r12d
	cmpb	$32, 3(%rdi)
	leaq	4(%rdi), %r9
	setg	%r12b
	addq	%r12, %rdx
	cmpq	%r9, %r13
	jb	.L525
	xorl	%ebx, %ebx
	cmpb	$32, 4(%rdi)
	leaq	5(%rdi), %r11
	setg	%bl
	addq	%rbx, %rdx
	cmpq	%r11, %r13
	jb	.L525
	xorl	%ecx, %ecx
	cmpb	$32, 5(%rdi)
	leaq	6(%rdi), %rsi
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rsi, %r13
	jb	.L525
	xorl	%eax, %eax
	cmpb	$32, 6(%rdi)
	leaq	7(%rdi), %r12
	setg	%al
	addq	%rax, %rdx
	cmpq	%r12, %r13
	jb	.L525
	xorl	%r9d, %r9d
	cmpb	$32, 7(%rdi)
	leaq	8(%rdi), %rbx
	setg	%r9b
	addq	%r9, %rdx
	cmpq	%rbx, %r13
	jb	.L525
	cmpb	$32, 8(%rdi)
	jle	.L536
	incq	%rdx
.L536:
	leaq	9(%rdi), %r11
	cmpq	%r11, %r13
	jb	.L525
	cmpb	$32, 9(%rdi)
	jle	.L537
	incq	%rdx
.L537:
	leaq	10(%rdi), %rcx
	cmpq	%rcx, %r13
	jb	.L525
	cmpb	$32, 10(%rdi)
	jle	.L538
	incq	%rdx
.L538:
	leaq	11(%rdi), %rsi
	cmpq	%rsi, %r13
	jb	.L525
	cmpb	$32, 11(%rdi)
	jle	.L539
	incq	%rdx
.L539:
	leaq	12(%rdi), %rax
	cmpq	%rax, %r13
	jb	.L525
	cmpb	$32, 12(%rdi)
	jle	.L540
	incq	%rdx
.L540:
	leaq	13(%rdi), %r12
	cmpq	%r12, %r13
	jb	.L525
	cmpb	$32, 13(%rdi)
	jle	.L541
	incq	%rdx
.L541:
	leaq	14(%rdi), %r9
	cmpq	%r9, %r13
	jb	.L525
	cmpb	$32, 14(%rdi)
	jle	.L525
	incq	%rdx
	jmp	.L525
	.p2align 4
	.p2align 3
.L692:
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
	jmp	.L596
.L691:
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
	jmp	.L593
.L690:
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
	jmp	.L590
.L549:
	movq	%rdi, 40(%rsp)
	jmp	.L505
.L686:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r10, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm9
	vmovdqa	.LC3(%rip), %ymm5
	jmp	.L522
.L553:
	movq	%r10, %rdi
	vpxor	%xmm5, %xmm5, %xmm5
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	jmp	.L523
.L689:
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rax)
	setle	%r11b
	addq	%r11, %rdx
	jmp	.L584
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
	jbe	.L699
	shrq	$5, %rdx
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %rax
	movl	$1000000, %r8d
	leaq	(%rdx,%rdx,4), %rsi
	movl	$100000, %r9d
	movl	$10000, %edx
	movq	%rdi, %rcx
	movl	$10000000, %edi
	vmovd	%edx, %xmm5
	vmovd	%r8d, %xmm3
	vmovd	%r9d, %xmm6
	vmovd	%edi, %xmm1
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$1000, %r10d
	andq	$-32, %rsp
	movl	$100, %r11d
	movl	$10, %edx
	movl	$65280, %edi
	movl	$343610491, %r8d
	movl	$65436, %r9d
	subq	$488, %rsp
	vpbroadcastd	%xmm5, %ymm0
	vpbroadcastd	%xmm1, %ymm2
	vmovd	%r10d, %xmm8
	vmovd	%r11d, %xmm10
	vmovd	%edx, %xmm12
	vmovd	%edi, %xmm14
	vmovd	%r8d, %xmm5
	vmovd	%r9d, %xmm1
	salq	$6, %rsi
	vpbroadcastd	%xmm3, %ymm4
	vpbroadcastd	%xmm6, %ymm7
	vmovdqa	%ymm0, -120(%rsp)
	vmovdqa	%ymm2, 360(%rsp)
	vpbroadcastd	%xmm8, %ymm9
	vpbroadcastd	%xmm10, %ymm11
	vpbroadcastd	%xmm12, %ymm13
	vpbroadcastd	%xmm14, %ymm15
	vpbroadcastd	%xmm5, %ymm0
	vpbroadcastd	%xmm1, %ymm2
	addq	%rax, %rsi
	vmovdqa	%ymm4, 328(%rsp)
	vmovdqa	%ymm7, 392(%rsp)
	vmovdqa	%ymm9, 296(%rsp)
	vmovdqa	%ymm11, 264(%rsp)
	vmovdqa	%ymm13, 232(%rsp)
	vmovdqa	%ymm15, 200(%rsp)
	vmovdqa	%ymm0, 456(%rsp)
	vmovdqa	%ymm2, 168(%rsp)
	.p2align 4
	.p2align 3
.L695:
	movl	$429529498, %r10d
	movl	$16122102, %r11d
	movl	$808464432, %edx
	movl	$538976288, %edi
	vmovdqu	(%rcx), %ymm4
	vmovdqu	64(%rcx), %ymm6
	movl	$48, %r9d
	movl	$100000000, %r8d
	vpmuludq	.LC25(%rip), %ymm4, %ymm15
	vmovdqu	32(%rcx), %ymm3
	addq	$320, %rax
	subq	$-128, %rcx
	vpmuludq	.LC24(%rip), %ymm4, %ymm10
	vmovdqu	-32(%rcx), %ymm5
	vpsrlq	$32, %ymm4, %ymm7
	vpmuludq	.LC24(%rip), %ymm7, %ymm8
	vmovdqa	%ymm6, 424(%rsp)
	vpmuludq	.LC25(%rip), %ymm7, %ymm12
	vmovdqa	360(%rsp), %ymm7
	vpsrlq	$56, %ymm15, %ymm0
	vmovdqa	-120(%rsp), %ymm15
	vpsrlq	$45, %ymm10, %ymm11
	vmovdqa	328(%rsp), %ymm10
	vpsrlq	$13, %ymm8, %ymm9
	vpblendd	$170, %ymm9, %ymm11, %ymm13
	vpcmpgtd	%ymm4, %ymm7, %ymm9
	vpmulld	%ymm15, %ymm13, %ymm2
	vpsrlq	$24, %ymm12, %ymm14
	vpblendd	$170, %ymm14, %ymm0, %ymm1
	vpcmpgtd	%ymm4, %ymm15, %ymm0
	vpmulld	%ymm1, %ymm15, %ymm6
	vpcmpgtd	%ymm4, %ymm10, %ymm11
	vmovdqa	%ymm1, 136(%rsp)
	vmovdqa	.LC32(%rip), %ymm10
	vpsubd	%ymm2, %ymm4, %ymm12
	vmovdqa	392(%rsp), %ymm2
	vpsubd	%ymm6, %ymm13, %ymm8
	vmovdqa	.LC30(%rip), %ymm13
	vmovdqa	.LC31(%rip), %ymm6
	vpcmpgtd	%ymm4, %ymm2, %ymm14
	vpblendvb	%ymm13, %ymm14, %ymm0, %ymm1
	vmovdqa	232(%rsp), %ymm14
	vpblendvb	%ymm6, %ymm11, %ymm1, %ymm7
	vmovdqa	264(%rsp), %ymm11
	vpblendvb	%ymm10, %ymm9, %ymm7, %ymm10
	vmovdqa	296(%rsp), %ymm9
	vmovdqa	.LC31(%rip), %ymm7
	vpcmpgtd	%ymm4, %ymm14, %ymm1
	vpand	200(%rsp), %ymm1, %ymm6
	vmovdqa	168(%rsp), %ymm14
	vpcmpgtd	%ymm4, %ymm11, %ymm13
	vmovdqa	.LC32(%rip), %ymm11
	vpcmpgtd	%ymm4, %ymm9, %ymm0
	vpblendvb	%ymm7, %ymm13, %ymm6, %ymm9
	vpblendvb	%ymm11, %ymm0, %ymm9, %ymm13
	vpmulhuw	456(%rsp), %ymm8, %ymm0
	vmovd	%r11d, %xmm11
	movl	$536870912, %r11d
	vpsrlw	$3, %ymm0, %ymm1
	vpmulld	%ymm14, %ymm1, %ymm6
	vpaddd	%ymm8, %ymm6, %ymm7
	vmovd	%r10d, %xmm8
	movl	$32, %r10d
	vpbroadcastd	%xmm8, %ymm0
	vpbroadcastd	%xmm11, %ymm8
	vmovd	%edi, %xmm11
	vpmulhuw	%ymm0, %ymm7, %ymm9
	vpmullw	%ymm8, %ymm9, %ymm1
	vpaddw	%ymm7, %ymm1, %ymm6
	vmovd	%edx, %xmm7
	vpbroadcastd	%xmm7, %ymm7
	vpaddb	%ymm7, %ymm6, %ymm9
	vpbroadcastd	%xmm11, %ymm6
	vpblendvb	%ymm10, %ymm6, %ymm9, %ymm9
	vpmulhuw	456(%rsp), %ymm12, %ymm10
	vpsrlw	$3, %ymm10, %ymm1
	vpmulld	%ymm14, %ymm1, %ymm11
	vpaddd	%ymm12, %ymm11, %ymm12
	vpmulhuw	%ymm0, %ymm12, %ymm10
	vpmullw	%ymm8, %ymm10, %ymm1
	vpaddw	%ymm12, %ymm1, %ymm11
	vpaddb	%ymm7, %ymm11, %ymm12
	vpsrlq	$32, %ymm3, %ymm11
	vpmuludq	.LC24(%rip), %ymm11, %ymm1
	vpblendvb	%ymm13, %ymm6, %ymm12, %ymm13
	vpunpckldq	%ymm13, %ymm9, %ymm10
	vpunpckhdq	%ymm13, %ymm9, %ymm9
	vpmuludq	.LC24(%rip), %ymm3, %ymm13
	vmovdqa	%ymm10, -24(%rsp)
	vmovdqa	%ymm9, 104(%rsp)
	vpmuludq	.LC25(%rip), %ymm11, %ymm9
	vpsrlq	$13, %ymm1, %ymm12
	vpsrlq	$45, %ymm13, %ymm10
	vpblendd	$170, %ymm12, %ymm10, %ymm1
	vpmuludq	.LC25(%rip), %ymm3, %ymm12
	vpsrlq	$24, %ymm9, %ymm11
	vpmulld	%ymm15, %ymm1, %ymm9
	vpsrlq	$56, %ymm12, %ymm13
	vpblendd	$170, %ymm11, %ymm13, %ymm10
	vpsubd	%ymm9, %ymm3, %ymm11
	vpmulld	%ymm10, %ymm15, %ymm12
	vmovdqa	%ymm10, 72(%rsp)
	vmovdqa	360(%rsp), %ymm13
	vmovdqa	328(%rsp), %ymm10
	vpsubd	%ymm12, %ymm1, %ymm1
	vpcmpgtd	%ymm3, %ymm13, %ymm9
	vpcmpgtd	%ymm3, %ymm2, %ymm13
	vmovdqa	.LC30(%rip), %ymm2
	vpcmpgtd	%ymm3, %ymm10, %ymm12
	vpcmpgtd	%ymm3, %ymm15, %ymm10
	vpblendvb	%ymm2, %ymm13, %ymm10, %ymm13
	vmovdqa	.LC31(%rip), %ymm10
	vmovdqa	.LC32(%rip), %ymm2
	vpblendvb	%ymm10, %ymm12, %ymm13, %ymm12
	vmovdqa	264(%rsp), %ymm13
	vpblendvb	%ymm2, %ymm9, %ymm12, %ymm10
	vmovdqa	296(%rsp), %ymm9
	vmovdqa	232(%rsp), %ymm2
	vpcmpgtd	%ymm3, %ymm13, %ymm13
	vpcmpgtd	%ymm3, %ymm9, %ymm12
	vpcmpgtd	%ymm3, %ymm2, %ymm9
	vmovdqa	.LC31(%rip), %ymm2
	vpand	200(%rsp), %ymm9, %ymm9
	vpblendvb	%ymm2, %ymm13, %ymm9, %ymm13
	vmovdqa	.LC32(%rip), %ymm9
	vpblendvb	%ymm9, %ymm12, %ymm13, %ymm2
	vpmulhuw	456(%rsp), %ymm1, %ymm12
	vpsrlw	$3, %ymm12, %ymm13
	vpmulld	%ymm14, %ymm13, %ymm9
	vpaddd	%ymm1, %ymm9, %ymm12
	vpmulhuw	%ymm0, %ymm12, %ymm1
	vpmullw	%ymm8, %ymm1, %ymm13
	vpaddw	%ymm12, %ymm13, %ymm9
	vpaddb	%ymm7, %ymm9, %ymm12
	vpblendvb	%ymm10, %ymm6, %ymm12, %ymm1
	vpmulhuw	456(%rsp), %ymm11, %ymm10
	vpsrlw	$3, %ymm10, %ymm13
	vpmulld	%ymm14, %ymm13, %ymm9
	vpaddd	%ymm11, %ymm9, %ymm11
	vpmulhuw	%ymm0, %ymm11, %ymm12
	vpmullw	%ymm8, %ymm12, %ymm10
	vpaddw	%ymm11, %ymm10, %ymm13
	vpaddb	%ymm7, %ymm13, %ymm9
	vmovdqa	424(%rsp), %ymm13
	vpblendvb	%ymm2, %ymm6, %ymm9, %ymm2
	vpunpckldq	%ymm2, %ymm1, %ymm11
	vpunpckhdq	%ymm2, %ymm1, %ymm1
	vpmuludq	.LC24(%rip), %ymm13, %ymm2
	vmovdqa	%ymm11, -56(%rsp)
	vmovdqa	%ymm1, -88(%rsp)
	vpsrlq	$32, %ymm13, %ymm12
	vpmuludq	.LC24(%rip), %ymm12, %ymm10
	vpmuludq	.LC25(%rip), %ymm12, %ymm12
	vpsrlq	$45, %ymm2, %ymm11
	vpsrlq	$13, %ymm10, %ymm9
	vpmuludq	.LC25(%rip), %ymm13, %ymm10
	vpblendd	$170, %ymm9, %ymm11, %ymm1
	vpsrlq	$24, %ymm12, %ymm9
	vpmulld	%ymm15, %ymm1, %ymm11
	vpsubd	%ymm11, %ymm13, %ymm11
	vpsrlq	$56, %ymm10, %ymm2
	vmovdqa	360(%rsp), %ymm10
	vpblendd	$170, %ymm9, %ymm2, %ymm12
	vmovdqa	328(%rsp), %ymm2
	vmovdqa	%ymm12, 40(%rsp)
	vpmulld	%ymm12, %ymm15, %ymm9
	vpsubd	%ymm9, %ymm1, %ymm1
	vpcmpgtd	%ymm13, %ymm10, %ymm9
	vmovdqa	392(%rsp), %ymm10
	vpcmpgtd	%ymm13, %ymm2, %ymm12
	vmovdqa	.LC30(%rip), %ymm2
	vpcmpgtd	%ymm13, %ymm10, %ymm13
	vpcmpgtd	424(%rsp), %ymm15, %ymm10
	vpblendvb	%ymm2, %ymm13, %ymm10, %ymm13
	vmovdqa	.LC31(%rip), %ymm10
	vmovdqa	.LC32(%rip), %ymm2
	vpblendvb	%ymm10, %ymm12, %ymm13, %ymm12
	vmovdqa	424(%rsp), %ymm13
	vpblendvb	%ymm2, %ymm9, %ymm12, %ymm10
	vmovdqa	296(%rsp), %ymm9
	vmovdqa	264(%rsp), %ymm2
	vpcmpgtd	%ymm13, %ymm9, %ymm12
	vmovdqa	232(%rsp), %ymm9
	vpcmpgtd	%ymm13, %ymm2, %ymm13
	vpcmpgtd	424(%rsp), %ymm9, %ymm2
	vpand	200(%rsp), %ymm2, %ymm9
	vmovdqa	.LC31(%rip), %ymm2
	vpblendvb	%ymm2, %ymm13, %ymm9, %ymm13
	vmovdqa	.LC32(%rip), %ymm9
	vpblendvb	%ymm9, %ymm12, %ymm13, %ymm2
	vpmulhuw	456(%rsp), %ymm1, %ymm12
	vpsrlw	$3, %ymm12, %ymm13
	vpmulld	%ymm14, %ymm13, %ymm9
	vpaddd	%ymm1, %ymm9, %ymm12
	vpmulhuw	%ymm0, %ymm12, %ymm1
	vpmullw	%ymm8, %ymm1, %ymm13
	vpaddw	%ymm12, %ymm13, %ymm9
	vpaddb	%ymm7, %ymm9, %ymm12
	vpblendvb	%ymm10, %ymm6, %ymm12, %ymm1
	vpmulhuw	456(%rsp), %ymm11, %ymm10
	vpsrlw	$3, %ymm10, %ymm13
	vpmulld	%ymm14, %ymm13, %ymm14
	vpaddd	%ymm11, %ymm14, %ymm11
	vpsrlq	$32, %ymm5, %ymm14
	vpmulhuw	%ymm0, %ymm11, %ymm9
	vpmullw	%ymm8, %ymm9, %ymm12
	vpmuludq	.LC24(%rip), %ymm5, %ymm9
	vpaddw	%ymm11, %ymm12, %ymm10
	vpmuludq	.LC24(%rip), %ymm14, %ymm11
	vpaddb	%ymm7, %ymm10, %ymm13
	vpmuludq	.LC25(%rip), %ymm14, %ymm14
	vpblendvb	%ymm2, %ymm6, %ymm13, %ymm2
	vpunpckldq	%ymm2, %ymm1, %ymm10
	vpunpckhdq	%ymm2, %ymm1, %ymm1
	vpsrlq	$45, %ymm9, %ymm13
	vpsrlq	$13, %ymm11, %ymm12
	vpblendd	$170, %ymm12, %ymm13, %ymm2
	vpmuludq	.LC25(%rip), %ymm5, %ymm12
	vpsrlq	$24, %ymm14, %ymm11
	vpmulld	%ymm15, %ymm2, %ymm13
	vpsubd	%ymm13, %ymm5, %ymm13
	vpsrlq	$56, %ymm12, %ymm9
	vpblendd	$170, %ymm11, %ymm9, %ymm14
	vpcmpgtd	%ymm5, %ymm15, %ymm12
	vpmulld	%ymm14, %ymm15, %ymm11
	vmovdqa	328(%rsp), %ymm15
	vmovdqa	%ymm14, 8(%rsp)
	vpsubd	%ymm11, %ymm2, %ymm9
	vmovdqa	360(%rsp), %ymm2
	vpcmpgtd	%ymm5, %ymm15, %ymm14
	vpcmpgtd	%ymm5, %ymm2, %ymm11
	vmovdqa	392(%rsp), %ymm2
	vpcmpgtd	%ymm5, %ymm2, %ymm15
	vmovdqa	.LC30(%rip), %ymm2
	vpblendvb	%ymm2, %ymm15, %ymm12, %ymm12
	vmovdqa	.LC31(%rip), %ymm15
	vmovdqa	.LC32(%rip), %ymm2
	vpblendvb	%ymm15, %ymm14, %ymm12, %ymm14
	vmovdqa	264(%rsp), %ymm15
	vpblendvb	%ymm2, %ymm11, %ymm14, %ymm12
	vmovdqa	296(%rsp), %ymm11
	vmovdqa	232(%rsp), %ymm2
	vpcmpgtd	%ymm5, %ymm15, %ymm15
	vpcmpgtd	%ymm5, %ymm11, %ymm14
	vpcmpgtd	%ymm5, %ymm2, %ymm11
	vmovdqa	.LC31(%rip), %ymm2
	vpand	200(%rsp), %ymm11, %ymm11
	vpblendvb	%ymm2, %ymm15, %ymm11, %ymm15
	vmovdqa	.LC32(%rip), %ymm11
	vmovdqa	456(%rsp), %ymm2
	vpblendvb	%ymm11, %ymm14, %ymm15, %ymm11
	vmovdqa	168(%rsp), %ymm15
	vpmulhuw	%ymm2, %ymm9, %ymm14
	vpsrlw	$3, %ymm14, %ymm14
	vpmulld	%ymm15, %ymm14, %ymm14
	vpaddd	%ymm9, %ymm14, %ymm14
	vpmulhuw	%ymm0, %ymm14, %ymm9
	vpmullw	%ymm8, %ymm9, %ymm9
	vpaddw	%ymm14, %ymm9, %ymm14
	vpaddb	%ymm7, %ymm14, %ymm9
	vpblendvb	%ymm12, %ymm6, %ymm9, %ymm14
	vpmulhuw	%ymm2, %ymm13, %ymm12
	vpsrlw	$3, %ymm12, %ymm2
	vpmulld	%ymm15, %ymm2, %ymm15
	vpaddd	%ymm13, %ymm15, %ymm13
	vmovd	%r10d, %xmm15
	vpmulhuw	%ymm0, %ymm13, %ymm0
	vpmullw	%ymm8, %ymm0, %ymm8
	vpaddw	%ymm13, %ymm8, %ymm9
	vmovd	%r11d, %xmm8
	vpaddb	%ymm7, %ymm9, %ymm7
	vpbroadcastd	%xmm8, %ymm9
	vpblendvb	%ymm11, %ymm6, %ymm7, %ymm6
	vmovd	%r8d, %xmm11
	vpunpckldq	%ymm6, %ymm14, %ymm7
	vpunpckhdq	%ymm6, %ymm14, %ymm0
	vmovd	%r9d, %xmm14
	vpbroadcastd	%xmm11, %ymm6
	vpcmpgtd	%ymm4, %ymm6, %ymm4
	vpbroadcastd	%xmm14, %ymm12
	vpaddd	136(%rsp), %ymm12, %ymm2
	vpbroadcastd	%xmm15, %ymm11
	vpcmpgtd	%ymm5, %ymm6, %ymm5
	vpblendvb	%ymm4, %ymm11, %ymm2, %ymm13
	vmovdqa	-24(%rsp), %ymm2
	vpor	%ymm13, %ymm9, %ymm4
	vpshufb	.LC44(%rip), %ymm4, %ymm15
	vpshufb	.LC46(%rip), %ymm4, %ymm13
	vpshufb	.LC45(%rip), %ymm2, %ymm14
	vpshufb	.LC47(%rip), %ymm2, %ymm8
	vpor	%ymm15, %ymm14, %ymm14
	vpshufb	.LC48(%rip), %ymm4, %ymm15
	vmovdqa	104(%rsp), %ymm2
	vpor	%ymm13, %ymm8, %ymm8
	vpshufb	.LC49(%rip), %ymm4, %ymm4
	vmovdqu	%xmm14, -320(%rax)
	vmovdqu	%xmm8, -310(%rax)
	vpshufb	.LC45(%rip), %ymm2, %ymm13
	vpor	%ymm15, %ymm13, %ymm13
	vpshufb	.LC47(%rip), %ymm2, %ymm15
	vpor	%ymm4, %ymm15, %ymm2
	vmovdqu	%xmm13, -300(%rax)
	vmovdqa	-56(%rsp), %ymm4
	vmovdqu	%xmm2, -290(%rax)
	vextracti128	$0x1, %ymm14, -280(%rax)
	vpcmpgtd	%ymm3, %ymm6, %ymm14
	vpaddd	72(%rsp), %ymm12, %ymm3
	vextracti128	$0x1, %ymm8, -270(%rax)
	vextracti128	$0x1, %ymm13, -260(%rax)
	vextracti128	$0x1, %ymm2, -250(%rax)
	vpshufb	.LC45(%rip), %ymm4, %ymm13
	vpblendvb	%ymm14, %ymm11, %ymm3, %ymm8
	vpshufb	.LC47(%rip), %ymm4, %ymm3
	vpor	%ymm9, %ymm8, %ymm15
	vpshufb	.LC44(%rip), %ymm15, %ymm2
	vpshufb	.LC46(%rip), %ymm15, %ymm14
	vpor	%ymm2, %ymm13, %ymm13
	vmovdqa	-88(%rsp), %ymm2
	vpor	%ymm14, %ymm3, %ymm4
	vpshufb	.LC48(%rip), %ymm15, %ymm8
	vpshufb	.LC49(%rip), %ymm15, %ymm15
	vmovdqu	%xmm13, -240(%rax)
	vmovdqu	%xmm4, -230(%rax)
	vpshufb	.LC45(%rip), %ymm2, %ymm14
	vpshufb	.LC47(%rip), %ymm2, %ymm3
	vpor	%ymm15, %ymm3, %ymm2
	vpor	%ymm8, %ymm14, %ymm8
	vmovdqu	%xmm8, -220(%rax)
	vmovdqu	%xmm2, -210(%rax)
	vextracti128	$0x1, %ymm13, -200(%rax)
	vpcmpgtd	424(%rsp), %ymm6, %ymm13
	vextracti128	$0x1, %ymm4, -190(%rax)
	vextracti128	$0x1, %ymm8, -180(%rax)
	vextracti128	$0x1, %ymm2, -170(%rax)
	vpaddd	40(%rsp), %ymm12, %ymm4
	vpaddd	8(%rsp), %ymm12, %ymm6
	vpshufb	.LC45(%rip), %ymm10, %ymm3
	vpshufb	.LC47(%rip), %ymm10, %ymm10
	vpblendvb	%ymm13, %ymm11, %ymm4, %ymm8
	vpshufb	.LC45(%rip), %ymm1, %ymm4
	vpshufb	.LC47(%rip), %ymm1, %ymm1
	vpor	%ymm9, %ymm8, %ymm2
	vpblendvb	%ymm5, %ymm11, %ymm6, %ymm12
	vpshufb	.LC44(%rip), %ymm2, %ymm15
	vpshufb	.LC46(%rip), %ymm2, %ymm13
	vpor	%ymm9, %ymm12, %ymm11
	vpshufb	.LC48(%rip), %ymm2, %ymm8
	vpshufb	.LC49(%rip), %ymm2, %ymm2
	vpor	%ymm15, %ymm3, %ymm14
	vpor	%ymm13, %ymm10, %ymm15
	vpor	%ymm8, %ymm4, %ymm3
	vpor	%ymm2, %ymm1, %ymm13
	vpshufb	.LC45(%rip), %ymm0, %ymm10
	vmovdqu	%xmm14, -160(%rax)
	vpshufb	.LC44(%rip), %ymm11, %ymm9
	vmovdqu	%xmm15, -150(%rax)
	vpshufb	.LC48(%rip), %ymm11, %ymm1
	vmovdqu	%xmm3, -140(%rax)
	vpshufb	.LC49(%rip), %ymm11, %ymm4
	vmovdqu	%xmm13, -130(%rax)
	vpshufb	.LC47(%rip), %ymm0, %ymm0
	vpor	%ymm1, %ymm10, %ymm8
	vextracti128	$0x1, %ymm14, -120(%rax)
	vpshufb	.LC45(%rip), %ymm7, %ymm14
	vpshufb	.LC47(%rip), %ymm7, %ymm7
	vpor	%ymm4, %ymm0, %ymm2
	vextracti128	$0x1, %ymm15, -110(%rax)
	vextracti128	$0x1, %ymm3, -100(%rax)
	vpshufb	.LC46(%rip), %ymm11, %ymm3
	vpor	%ymm9, %ymm14, %ymm15
	vextracti128	$0x1, %ymm13, -90(%rax)
	vpor	%ymm3, %ymm7, %ymm13
	vmovdqu	%xmm15, -80(%rax)
	vmovdqu	%xmm13, -70(%rax)
	vmovdqu	%xmm8, -60(%rax)
	vmovdqu	%xmm2, -50(%rax)
	vextracti128	$0x1, %ymm15, -40(%rax)
	vextracti128	$0x1, %ymm13, -30(%rax)
	vextracti128	$0x1, %ymm8, -20(%rax)
	vextracti128	$0x1, %ymm2, -10(%rax)
	cmpq	%rsi, %rax
	jne	.L695
	vzeroupper
	leave
	.cfi_def_cfa 7, 8
	ret
.L699:
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
	jbe	.L743
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
	jb	.L744
	testq	%r9, %r9
	je	.L705
	cmpq	$1, %r9
	je	.L730
	cmpq	$2, %r9
	je	.L731
	cmpq	$3, %r9
	je	.L732
	cmpq	$4, %r9
	je	.L733
	cmpq	$5, %r9
	je	.L734
	cmpq	$6, %r9
	je	.L735
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
.L735:
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
.L734:
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
.L733:
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
.L732:
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
.L731:
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
.L730:
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
	jb	.L744
.L705:
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
	jnb	.L705
.L744:
	vzeroupper
.L743:
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
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rsi, %r15
	andq	$-32, %rsp
	subq	$96, %rsp
	movq	%rdx, 24(%rsp)
	cmpq	$65600, %rdx
	jbe	.L792
	vmovdqa	.LC2(%rip), %ymm6
	movq	%rdi, %r11
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm9
	.p2align 4
	.p2align 3
.L791:
	movl	$555819297, %eax
	vmovdqa	.LC14(%rip), %ymm11
	vmovd	%eax, %xmm4
	vpbroadcastd	%xmm4, %ymm0
	vpxor	%xmm4, %xmm4, %xmm4
	vmovdqa	%ymm0, 64(%rsp)
	vmovdqa	64(%rsp), %ymm1
	vpcmpgtb	131072(%r11), %ymm1, %ymm8
	vpcmpgtb	32768(%r11), %ymm1, %ymm2
	vpcmpgtb	65536(%r11), %ymm1, %ymm3
	vpcmpgtb	98304(%r11), %ymm1, %ymm7
	vpmovmskb	%ymm2, %edx
	vpmovmskb	%ymm3, %esi
	tzcntl	%edx, %ecx
	vpmovmskb	%ymm7, %r12d
	tzcntl	%esi, %edi
	movl	%ecx, %ebx
	vpmovmskb	%ymm8, %eax
	tzcntl	%r12d, %r13d
	movl	%edi, %r8d
	movl	$808464432, %r12d
	tzcntl	%eax, %edx
	movl	%r13d, %r14d
	leaq	32769(%r11,%rbx), %r9
	leaq	65537(%r11,%r8), %r10
	movl	%edx, %ecx
	leaq	98305(%r11,%r14), %rsi
	vmovd	%r12d, %xmm10
	movq	%r9, %r8
	leaq	131073(%r11,%rcx), %r13
	movq	%r9, 40(%rsp)
	movq	%rsi, 48(%rsp)
	movq	%r10, %rdi
	movq	%r13, 32(%rsp)
	movq	%r11, %rcx
	xorl	%ebx, %ebx
	vpbroadcastd	%xmm10, %ymm8
	movq	%r11, %r9
	.p2align 4
	.p2align 3
.L753:
	movq	40(%rsp), %r11
	movq	48(%rsp), %rdx
	movq	%r10, %rax
	movq	%r13, %r14
	subq	%r8, %rax
	subq	%rcx, %r11
	cmpq	%r11, %rax
	cmovg	%r11, %rax
	subq	%rsi, %r14
	subq	%rdi, %rdx
	cmpq	%rdx, %r14
	cmovg	%rdx, %r14
	cmpq	%r14, %rax
	cmovg	%r14, %rax
	cmpq	$32, %rax
	jbe	.L924
	vpbroadcastd	.LC23(%rip), %ymm10
	movabsq	$1117984489315730401, %r12
	movq	%rbx, %r11
	mulq	%r12
	movq	%rdx, %r14
	andq	$-2, %rdx
	shrq	%r14
	leaq	(%rdx,%rbx), %rdx
	movq	%r14, 56(%rsp)
	.p2align 4
	.p2align 3
.L752:
	vmovdqu	(%rcx), %ymm12
	vmovdqa	64(%rsp), %ymm13
	vpcmpgtb	%ymm12, %ymm13, %ymm14
	vmovdqa	64(%rsp), %ymm13
	vpmovmskb	%ymm14, %eax
	tzcntl	%eax, %r14d
	blsr	%eax, %r12d
	tzcntl	%r12d, %eax
	movl	%r14d, %r12d
	vinserti128	$0x1, 1(%rcx,%r12), %ymm12, %ymm15
	vmovdqu	(%r8), %ymm12
	incl	%r12d
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm0
	movl	%eax, %r12d
	incl	%eax
	subl	%r14d, %r12d
	addq	%rax, %rcx
	salq	$4, %r12
	vinserti128	$0x1, _ZN12qp_parse_ms211right_alignE(%r12), %ymm0, %ymm7
	vpcmpgtb	%ymm12, %ymm13, %ymm14
	vpsubusb	%ymm8, %ymm15, %ymm1
	vpmovmskb	%ymm14, %eax
	vmovdqu	(%rdi), %ymm14
	tzcntl	%eax, %r14d
	blsr	%eax, %r12d
	tzcntl	%r12d, %eax
	movl	%r14d, %r12d
	vinserti128	$0x1, 1(%r8,%r12), %ymm12, %ymm15
	incl	%r12d
	salq	$4, %r12
	vpshufb	%ymm7, %ymm1, %ymm2
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm1
	movl	%eax, %r12d
	vpmaddubsw	%ymm6, %ymm2, %ymm3
	incl	%eax
	subl	%r14d, %r12d
	vpmaddwd	%ymm5, %ymm3, %ymm0
	addq	%rax, %r8
	salq	$4, %r12
	vinserti128	$0x1, _ZN12qp_parse_ms211right_alignE(%r12), %ymm1, %ymm3
	vpsubusb	%ymm8, %ymm15, %ymm2
	vmovdqa	64(%rsp), %ymm15
	vpshufb	%ymm3, %ymm2, %ymm12
	vpor	%ymm7, %ymm3, %ymm7
	vpmaddubsw	%ymm6, %ymm12, %ymm13
	vpor	%ymm4, %ymm7, %ymm4
	vpmaddwd	%ymm5, %ymm13, %ymm2
	vpcmpgtb	%ymm14, %ymm15, %ymm1
	vpackusdw	%ymm2, %ymm0, %ymm0
	vpmovmskb	%ymm1, %eax
	vpmaddwd	%ymm9, %ymm0, %ymm2
	tzcntl	%eax, %r14d
	blsr	%eax, %r12d
	tzcntl	%r12d, %eax
	movl	%r14d, %r12d
	vinserti128	$0x1, 1(%rdi,%r12), %ymm14, %ymm13
	incl	%r12d
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm12
	movl	%eax, %r12d
	incl	%eax
	subl	%r14d, %r12d
	addq	%rax, %rdi
	salq	$4, %r12
	vinserti128	$0x1, _ZN12qp_parse_ms211right_alignE(%r12), %ymm12, %ymm12
	vpsubusb	%ymm8, %ymm13, %ymm14
	vpshufb	%ymm12, %ymm14, %ymm1
	vpor	%ymm12, %ymm4, %ymm3
	vpmaddubsw	%ymm6, %ymm1, %ymm13
	vpmaddwd	%ymm5, %ymm13, %ymm1
	vmovdqu	(%rsi), %ymm13
	vpcmpgtb	%ymm13, %ymm15, %ymm15
	vpmovmskb	%ymm15, %eax
	tzcntl	%eax, %r14d
	blsr	%eax, %r12d
	tzcntl	%r12d, %eax
	movl	%r14d, %r12d
	vinserti128	$0x1, 1(%rsi,%r12), %ymm13, %ymm13
	incl	%r12d
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm14
	movl	%eax, %r12d
	subl	%r14d, %r12d
	incl	%eax
	salq	$4, %r12
	addq	%rax, %rsi
	vinserti128	$0x1, _ZN12qp_parse_ms211right_alignE(%r12), %ymm14, %ymm15
	vpsubusb	%ymm8, %ymm13, %ymm12
	vpshufb	%ymm15, %ymm12, %ymm13
	vpor	%ymm15, %ymm3, %ymm4
	vpmaddubsw	%ymm6, %ymm13, %ymm14
	vpmaddwd	%ymm5, %ymm14, %ymm15
	vpackusdw	%ymm15, %ymm1, %ymm1
	vpmaddwd	%ymm9, %ymm1, %ymm7
	vshufps	$136, %ymm7, %ymm2, %ymm3
	vshufps	$221, %ymm7, %ymm2, %ymm13
	vpmulld	%ymm10, %ymm3, %ymm12
	vpaddd	%ymm13, %ymm12, %ymm14
	vpermd	%ymm14, %ymm11, %ymm15
	vextracti128	$0x1, %ymm15, %xmm0
	vmovq	%xmm15, (%r15,%r11,4)
	vmovhpd	%xmm15, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region(,%r11,4)
	vmovq	%xmm0, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131328(,%r11,4)
	vmovhpd	%xmm0, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262656(,%r11,4)
	addq	$2, %r11
	cmpq	%rdx, %r11
	jne	.L752
	movq	56(%rsp), %rdx
	leaq	(%rbx,%rdx,2), %rbx
	jmp	.L753
	.p2align 4
	.p2align 3
.L924:
	movq	%r9, %r11
	movq	40(%rsp), %r9
	movq	%rbx, %r14
	cmpq	%r9, %rcx
	jnb	.L751
	vmovdqa	.LC8(%rip), %xmm5
	vmovdqa	.LC9(%rip), %xmm6
	movl	$555819297, %r13d
	movl	$808464432, %eax
	vmovdqa	.LC10(%rip), %xmm9
	vmovd	%r13d, %xmm11
	vmovd	%eax, %xmm10
	vpbroadcastd	%xmm11, %xmm8
	vpbroadcastd	%xmm10, %xmm1
	.p2align 4
	.p2align 3
.L750:
	vmovdqu	(%rcx), %xmm7
	incq	%r14
	vpcmpgtb	%xmm7, %xmm8, %xmm3
	vpsubusb	%xmm1, %xmm7, %xmm14
	vpmovmskb	%xmm3, %r12d
	tzcntl	%r12d, %r13d
	incl	%r13d
	movq	%r13, %rdx
	addq	%r13, %rcx
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm12
	vpshufb	%xmm12, %xmm14, %xmm15
	vmovdqa	%xmm12, %xmm13
	vpmaddubsw	%xmm5, %xmm15, %xmm2
	vpor	%ymm13, %ymm4, %ymm4
	vpmaddwd	%xmm6, %xmm2, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm11
	vpmaddwd	%xmm9, %xmm11, %xmm10
	vmovq	%xmm10, %rax
	imull	$100000000, %eax, %r12d
	shrq	$32, %rax
	addl	%r12d, %eax
	movl	%eax, -4(%r15,%r14,4)
	cmpq	%r9, %rcx
	jb	.L750
.L751:
	cmpq	$32831, %rbx
	movq	%rbx, %r12
	setbe	64(%rsp)
	cmpq	%r10, %r8
	jnb	.L754
	cmpb	$0, 64(%rsp)
	je	.L754
	movl	$555819297, %r13d
	movl	$808464432, %edx
	vmovdqa	.LC8(%rip), %xmm5
	vmovdqa	.LC9(%rip), %xmm6
	vmovd	%r13d, %xmm8
	vmovd	%edx, %xmm7
	vmovdqa	.LC10(%rip), %xmm9
	vpbroadcastd	%xmm8, %xmm1
	vpbroadcastd	%xmm7, %xmm3
	testb	$1, %bl
	je	.L755
	vmovdqu	(%r8), %xmm12
	vpcmpgtb	%xmm12, %xmm1, %xmm13
	vpsubusb	%xmm3, %xmm12, %xmm2
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %r12d
	incl	%r12d
	movq	%r12, %r13
	addq	%r12, %r8
	leaq	1(%rbx), %r12
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r13), %xmm14
	vpshufb	%xmm14, %xmm2, %xmm0
	vmovdqa	%xmm14, %xmm15
	vpmaddubsw	%xmm5, %xmm0, %xmm11
	vpor	%ymm15, %ymm4, %ymm4
	vpmaddwd	%xmm6, %xmm11, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm8
	vpmaddwd	%xmm9, %xmm8, %xmm7
	vmovq	%xmm7, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r10, %r8
	jb	.L906
	jmp	.L754
	.p2align 4
	.p2align 3
.L755:
	vmovdqu	(%r8), %xmm12
	incq	%r12
	vpcmpgtb	%xmm12, %xmm1, %xmm13
	vpsubusb	%xmm3, %xmm12, %xmm2
	vpmovmskb	%xmm13, %r13d
	tzcntl	%r13d, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm2, %xmm0
	vmovdqa	%xmm14, %xmm15
	vpmaddubsw	%xmm5, %xmm0, %xmm11
	vpor	%ymm15, %ymm4, %ymm4
	vpmaddwd	%xmm6, %xmm11, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm8
	vpmaddwd	%xmm9, %xmm8, %xmm7
	vmovq	%xmm7, %r13
	imull	$100000000, %r13d, %eax
	shrq	$32, %r13
	addl	%eax, %r13d
	movl	%r13d, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r10, %r8
	jnb	.L754
	vmovdqu	(%r8), %xmm12
	incq	%r12
	vpcmpgtb	%xmm12, %xmm1, %xmm13
	vpsubusb	%xmm3, %xmm12, %xmm2
	vpmovmskb	%xmm13, %edx
	tzcntl	%edx, %r13d
	incl	%r13d
	movq	%r13, %rax
	addq	%r13, %r8
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm14
	vpshufb	%xmm14, %xmm2, %xmm0
	vmovdqa	%xmm14, %xmm15
	vpmaddubsw	%xmm5, %xmm0, %xmm11
	vpor	%ymm15, %ymm4, %ymm4
	vpmaddwd	%xmm6, %xmm11, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm8
	vpmaddwd	%xmm9, %xmm8, %xmm7
	vmovq	%xmm7, %r13
	imull	$100000000, %r13d, %edx
	shrq	$32, %r13
	addl	%edx, %r13d
	movl	%r13d, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r10, %r8
	jnb	.L754
.L906:
	cmpq	$32832, %r12
	jne	.L755
.L754:
	movq	48(%rsp), %rax
	movq	%rbx, %r13
	cmpq	%rax, %rdi
	jnb	.L757
	cmpb	$0, 64(%rsp)
	je	.L757
	movl	$555819297, %edx
	vmovdqa	.LC8(%rip), %xmm1
	vmovdqa	.LC9(%rip), %xmm2
	vmovd	%edx, %xmm5
	movl	$808464432, %edx
	vmovdqa	.LC10(%rip), %xmm3
	vmovd	%edx, %xmm6
	vpbroadcastd	%xmm5, %xmm7
	vpbroadcastd	%xmm6, %xmm8
	testb	$1, %bl
	jne	.L907
	movq	%r12, 56(%rsp)
	movq	%rax, %r12
	jmp	.L758
	.p2align 4
	.p2align 3
.L925:
	vmovdqu	(%rdi), %xmm9
	incq	%r13
	vpcmpgtb	%xmm9, %xmm7, %xmm12
	vpsubusb	%xmm8, %xmm9, %xmm15
	vpmovmskb	%xmm12, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm15, %xmm0
	vmovdqa	%xmm13, %xmm14
	vpmaddubsw	%xmm1, %xmm0, %xmm11
	vpor	%ymm14, %ymm4, %ymm4
	vpmaddwd	%xmm2, %xmm11, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	%r12, %rdi
	jnb	.L914
	cmpq	$32832, %r13
	je	.L914
.L758:
	vmovdqu	(%rdi), %xmm9
	incq	%r13
	vpcmpgtb	%xmm9, %xmm7, %xmm12
	vpsubusb	%xmm8, %xmm9, %xmm15
	vpmovmskb	%xmm12, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm15, %xmm0
	vmovdqa	%xmm13, %xmm14
	vpmaddubsw	%xmm1, %xmm0, %xmm11
	vpor	%ymm14, %ymm4, %ymm4
	vpmaddwd	%xmm2, %xmm11, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	%r12, %rdi
	jb	.L925
.L914:
	movq	56(%rsp), %r12
.L757:
	movq	32(%rsp), %rax
	cmpq	%rax, %rsi
	jnb	.L760
	cmpb	$0, 64(%rsp)
	je	.L760
	movl	$555819297, %edx
	vmovdqa	.LC8(%rip), %xmm1
	vmovdqa	.LC9(%rip), %xmm2
	vmovd	%edx, %xmm7
	movl	$808464432, %edx
	vmovdqa	.LC10(%rip), %xmm3
	vmovd	%edx, %xmm8
	vpbroadcastd	%xmm7, %xmm7
	vpbroadcastd	%xmm8, %xmm8
	testb	$1, %bl
	jne	.L909
	movq	%r12, 64(%rsp)
	movq	%rax, %r12
	jmp	.L761
	.p2align 4
	.p2align 3
.L926:
	vmovdqu	(%rsi), %xmm9
	incq	%rbx
	vpcmpgtb	%xmm9, %xmm7, %xmm12
	vpsubusb	%xmm8, %xmm9, %xmm15
	vpmovmskb	%xmm12, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm15, %xmm0
	vmovdqa	%xmm13, %xmm14
	vpmaddubsw	%xmm1, %xmm0, %xmm11
	vpor	%ymm14, %ymm4, %ymm4
	vpmaddwd	%xmm2, %xmm11, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	%r12, %rsi
	jnb	.L915
	cmpq	$32832, %rbx
	je	.L915
.L761:
	vmovdqu	(%rsi), %xmm9
	incq	%rbx
	vpcmpgtb	%xmm9, %xmm7, %xmm12
	vpsubusb	%xmm8, %xmm9, %xmm15
	vpmovmskb	%xmm12, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm15, %xmm0
	vmovdqa	%xmm13, %xmm14
	vpmaddubsw	%xmm1, %xmm0, %xmm11
	vpor	%ymm14, %ymm4, %ymm4
	vpmaddwd	%xmm2, %xmm11, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	%r12, %rsi
	jb	.L926
.L915:
	movq	64(%rsp), %r12
.L760:
	vpmovmskb	%ymm4, %eax
	cmpq	%rcx, %r9
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
	movzbl	%r9b, %r8d
	setne	%r10b
	orl	%r10d, %eax
	orl	%eax, %r8d
	jne	.L927
	vzeroupper
	leaq	(%r15,%r14,4), %rdi
	leaq	0(,%r12,4), %rdx
	movl	$_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, %esi
	addq	%r14, %r12
	call	memcpy
	leaq	0(,%r13,4), %rdx
	movl	$_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131328, %esi
	leaq	(%r15,%r12,4), %rdi
	addq	%r13, %r12
	call	memcpy
	leaq	(%r15,%r12,4), %rdi
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262656, %esi
	call	memcpy
	vmovdqa	.LC4(%rip), %ymm9
	addq	%rbx, %r12
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC2(%rip), %ymm6
	leaq	(%r15,%r12,4), %r15
	subq	%r12, 24(%rsp)
.L790:
	cmpq	$65600, 24(%rsp)
	jbe	.L922
.L765:
	movq	32(%rsp), %r11
	jmp	.L791
.L909:
	vmovdqu	(%rsi), %xmm9
	incq	%rbx
	vpcmpgtb	%xmm9, %xmm7, %xmm12
	vpsubusb	%xmm8, %xmm9, %xmm15
	vpmovmskb	%xmm12, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm15, %xmm0
	vmovdqa	%xmm13, %xmm14
	vpmaddubsw	%xmm1, %xmm0, %xmm11
	vpor	%ymm14, %ymm4, %ymm4
	vpmaddwd	%xmm2, %xmm11, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	32(%rsp), %rsi
	jnb	.L760
	cmpq	$32832, %rbx
	je	.L760
	movq	%r12, 64(%rsp)
	movq	32(%rsp), %r12
	jmp	.L761
.L907:
	vmovdqu	(%rdi), %xmm9
	vpcmpgtb	%xmm9, %xmm7, %xmm12
	vpsubusb	%xmm8, %xmm9, %xmm15
	vpmovmskb	%xmm12, %r13d
	tzcntl	%r13d, %eax
	leaq	1(%rbx), %r13
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm15, %xmm0
	vmovdqa	%xmm13, %xmm14
	vpmaddubsw	%xmm1, %xmm0, %xmm11
	vpor	%ymm14, %ymm4, %ymm4
	vpmaddwd	%xmm2, %xmm11, %xmm10
	vpackusdw	%xmm10, %xmm10, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	48(%rsp), %rdi
	jnb	.L757
	cmpq	$32832, %r13
	je	.L757
	movq	%r12, 56(%rsp)
	movq	48(%rsp), %r12
	jmp	.L758
.L922:
	vzeroupper
.L748:
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
.L927:
	.cfi_restore_state
	cmpq	32(%rsp), %r11
	jnb	.L928
	movq	32(%rsp), %r13
	movl	$1, %edi
	leaq	-1(%r13), %rsi
	cmpq	%rsi, %r11
	cmovbe	%r11, %rsi
	cmpq	%r11, %rsi
	movq	%rsi, %r12
	setnb	%r14b
	subq	%r11, %r12
	cmpq	%r11, %rsi
	leaq	1(%r12), %rcx
	cmovb	%rdi, %rcx
	cmpq	$30, %r12
	jbe	.L796
	cmpq	%r11, %rsi
	jb	.L796
	movq	%rcx, %r9
	movl	$538976288, %ebx
	vmovq	%rdi, %xmm2
	movq	%r11, %rdx
	andq	$-32, %r9
	vmovd	%ebx, %xmm4
	vpxor	%xmm1, %xmm1, %xmm1
	vpbroadcastq	%xmm2, %ymm12
	leaq	(%r9,%r11), %rax
	vpbroadcastd	%xmm4, %ymm3
.L767:
	vmovdqu	(%rdx), %ymm7
	addq	$32, %rdx
	vpcmpgtb	%ymm3, %ymm7, %ymm8
	vpmovsxbw	%xmm8, %ymm13
	vextracti128	$0x1, %ymm8, %xmm14
	vpmovsxwd	%xmm13, %ymm11
	vextracti128	$0x1, %ymm13, %xmm0
	vpmovsxbw	%xmm14, %ymm15
	vpmovsxdq	%xmm11, %ymm4
	vextracti128	$0x1, %ymm11, %xmm7
	vpmovsxwd	%xmm0, %ymm9
	vpmovsxwd	%xmm15, %ymm5
	vpand	%ymm12, %ymm4, %ymm2
	vpmovsxdq	%xmm7, %ymm8
	vextracti128	$0x1, %ymm9, %xmm11
	vpmovsxdq	%xmm9, %ymm14
	vpsubq	%ymm8, %ymm2, %ymm13
	vextracti128	$0x1, %ymm15, %xmm10
	vpmovsxdq	%xmm11, %ymm0
	vpsubq	%ymm14, %ymm13, %ymm15
	vpmovsxwd	%xmm10, %ymm6
	vpmovsxdq	%xmm5, %ymm10
	vpsubq	%ymm0, %ymm15, %ymm9
	vextracti128	$0x1, %ymm5, %xmm5
	vpmovsxdq	%xmm6, %ymm7
	vpsubq	%ymm10, %ymm9, %ymm4
	vpmovsxdq	%xmm5, %ymm2
	vextracti128	$0x1, %ymm6, %xmm6
	vpsubq	%ymm2, %ymm4, %ymm8
	vpmovsxdq	%xmm6, %ymm14
	vpsubq	%ymm7, %ymm8, %ymm13
	vpsubq	%ymm14, %ymm13, %ymm15
	vpaddq	%ymm15, %ymm1, %ymm1
	cmpq	%rdx, %rax
	jne	.L767
	vextracti128	$0x1, %ymm1, %xmm3
	vpaddq	%xmm1, %xmm3, %xmm9
	vpsrldq	$8, %xmm9, %xmm12
	vpaddq	%xmm12, %xmm9, %xmm11
	vmovq	%xmm11, %rdx
	cmpq	%rcx, %r9
	je	.L768
.L766:
	subq	%r9, %rcx
	leaq	-1(%rcx), %r8
	cmpq	$14, %r8
	jbe	.L769
	vmovdqu	(%r11,%r9), %xmm0
	movl	$538976288, %r10d
	movl	$1, %r13d
	vmovd	%r10d, %xmm10
	vpbroadcastd	%xmm10, %xmm4
	vpcmpgtb	%xmm4, %xmm0, %xmm5
	vmovq	%r13, %xmm0
	vpmovsxbw	%xmm5, %xmm8
	vpunpcklqdq	%xmm0, %xmm0, %xmm10
	vpsrldq	$8, %xmm5, %xmm2
	vpmovsxbw	%xmm2, %xmm13
	vpmovsxwd	%xmm8, %xmm6
	vpsrldq	$8, %xmm8, %xmm7
	vpmovsxwd	%xmm7, %xmm14
	vpmovsxwd	%xmm13, %xmm15
	vpsrldq	$8, %xmm6, %xmm3
	vpmovsxdq	%xmm3, %xmm11
	vpmovsxdq	%xmm14, %xmm5
	vpsrldq	$8, %xmm13, %xmm1
	vpand	%xmm10, %xmm11, %xmm4
	vpsrldq	$8, %xmm14, %xmm2
	vpmovsxdq	%xmm2, %xmm13
	vpmovsxdq	%xmm15, %xmm14
	vpsubq	%xmm5, %xmm4, %xmm8
	vpmovsxwd	%xmm1, %xmm12
	vpsrldq	$8, %xmm15, %xmm15
	vpmovsxdq	%xmm15, %xmm3
	vpaddq	%xmm9, %xmm8, %xmm9
	vpmovsxdq	%xmm12, %xmm0
	vpsrldq	$8, %xmm12, %xmm12
	vpmovsxdq	%xmm12, %xmm4
	vpsubq	%xmm13, %xmm9, %xmm7
	vpmovsxdq	%xmm6, %xmm6
	vpsubq	%xmm14, %xmm7, %xmm1
	vpsubq	%xmm3, %xmm1, %xmm11
	vpsubq	%xmm0, %xmm11, %xmm10
	vpsubq	%xmm4, %xmm10, %xmm5
	vpsubq	%xmm6, %xmm5, %xmm8
	vpsrldq	$8, %xmm8, %xmm9
	vpaddq	%xmm9, %xmm8, %xmm2
	vmovq	%xmm2, %rdx
	testb	$15, %cl
	je	.L768
	andq	$-16, %rcx
	addq	%rcx, %rax
.L769:
	xorl	%ecx, %ecx
	cmpb	$32, (%rax)
	leaq	1(%rax), %rdi
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rdi, %rsi
	jnb	.L929
.L768:
	xorl	%esi, %esi
	testb	%r14b, %r14b
	cmovne	%r12, %rsi
	movq	32(%rsp), %r12
	leaq	1(%r11,%rsi), %r14
	cmpq	%r12, %r14
	jnb	.L789
	movq	%r14, %rdi
	notq	%rdi
	addq	%r12, %rdi
	andl	$7, %edi
	cmpb	$32, (%r14)
	jg	.L930
.L825:
	leaq	1(%r14), %rax
	cmpq	32(%rsp), %rax
	jnb	.L789
	testq	%rdi, %rdi
	je	.L788
	cmpq	$1, %rdi
	je	.L873
	cmpq	$2, %rdi
	je	.L874
	cmpq	$3, %rdi
	je	.L875
	cmpq	$4, %rdi
	je	.L876
	cmpq	$5, %rdi
	je	.L877
	cmpq	$6, %rdi
	je	.L878
	cmpb	$32, 1(%r14)
	jg	.L931
.L827:
	incq	%rax
.L878:
	cmpb	$32, (%rax)
	jle	.L830
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
.L830:
	incq	%rax
.L877:
	cmpb	$32, (%rax)
	jg	.L932
.L833:
	incq	%rax
.L876:
	cmpb	$32, (%rax)
	jg	.L933
.L836:
	incq	%rax
.L875:
	cmpb	$32, (%rax)
	jg	.L934
.L839:
	incq	%rax
.L874:
	cmpb	$32, (%rax)
	jle	.L842
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L842:
	incq	%rax
.L873:
	cmpb	$32, (%rax)
	jle	.L845
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L845:
	incq	%rax
	cmpq	32(%rsp), %rax
	jnb	.L789
.L788:
	cmpb	$32, (%rax)
	jle	.L787
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L787:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %r12
	jle	.L848
	xorl	%edi, %edi
	cmpb	$32, -1(%r12)
	setle	%dil
	addq	%rdi, %rdx
.L848:
	cmpb	$32, 1(%r12)
	jle	.L850
	xorl	%eax, %eax
	cmpb	$32, (%r12)
	setle	%al
	addq	%rax, %rdx
.L850:
	cmpb	$32, 2(%r12)
	jle	.L852
	xorl	%ebx, %ebx
	cmpb	$32, 1(%r12)
	setle	%bl
	addq	%rbx, %rdx
.L852:
	cmpb	$32, 3(%r12)
	jle	.L854
	xorl	%r9d, %r9d
	cmpb	$32, 2(%r12)
	setle	%r9b
	addq	%r9, %rdx
.L854:
	cmpb	$32, 4(%r12)
	jle	.L856
	xorl	%r8d, %r8d
	cmpb	$32, 3(%r12)
	setle	%r8b
	addq	%r8, %rdx
.L856:
	cmpb	$32, 5(%r12)
	jle	.L858
	xorl	%r10d, %r10d
	cmpb	$32, 4(%r12)
	setle	%r10b
	addq	%r10, %rdx
.L858:
	cmpb	$32, 6(%r12)
	jle	.L860
	xorl	%r13d, %r13d
	cmpb	$32, 5(%r12)
	setle	%r13b
	addq	%r13, %rdx
.L860:
	leaq	7(%r12), %rax
	cmpq	32(%rsp), %rax
	jb	.L788
.L789:
	subq	%rdx, 24(%rsp)
	movq	%r15, %rsi
	movq	%r11, %rdi
	leaq	(%r15,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm6
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm9
	jmp	.L790
.L930:
	xorl	%eax, %eax
	cmpb	$32, -1(%r14)
	setle	%al
	addq	%rax, %rdx
	jmp	.L825
.L929:
	xorl	%ebx, %ebx
	cmpb	$32, 1(%rax)
	leaq	2(%rax), %r9
	setg	%bl
	addq	%rbx, %rdx
	cmpq	%r9, %rsi
	jb	.L768
	xorl	%r8d, %r8d
	cmpb	$32, 2(%rax)
	leaq	3(%rax), %r10
	setg	%r8b
	addq	%r8, %rdx
	cmpq	%r10, %rsi
	jb	.L768
	xorl	%r13d, %r13d
	cmpb	$32, 3(%rax)
	leaq	4(%rax), %rcx
	setg	%r13b
	addq	%r13, %rdx
	cmpq	%rcx, %rsi
	jb	.L768
	xorl	%edi, %edi
	cmpb	$32, 4(%rax)
	leaq	5(%rax), %rbx
	setg	%dil
	addq	%rdi, %rdx
	cmpq	%rbx, %rsi
	jb	.L768
	xorl	%r9d, %r9d
	cmpb	$32, 5(%rax)
	leaq	6(%rax), %r8
	setg	%r9b
	addq	%r9, %rdx
	cmpq	%r8, %rsi
	jb	.L768
	xorl	%r10d, %r10d
	cmpb	$32, 6(%rax)
	leaq	7(%rax), %r13
	setg	%r10b
	addq	%r10, %rdx
	cmpq	%r13, %rsi
	jb	.L768
	xorl	%ecx, %ecx
	cmpb	$32, 7(%rax)
	leaq	8(%rax), %rdi
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rdi, %rsi
	jb	.L768
	cmpb	$32, 8(%rax)
	jle	.L779
	incq	%rdx
.L779:
	leaq	9(%rax), %rbx
	cmpq	%rbx, %rsi
	jb	.L768
	cmpb	$32, 9(%rax)
	jle	.L780
	incq	%rdx
.L780:
	leaq	10(%rax), %r9
	cmpq	%r9, %rsi
	jb	.L768
	cmpb	$32, 10(%rax)
	jle	.L781
	incq	%rdx
.L781:
	leaq	11(%rax), %r8
	cmpq	%r8, %rsi
	jb	.L768
	cmpb	$32, 11(%rax)
	jle	.L782
	incq	%rdx
.L782:
	leaq	12(%rax), %r10
	cmpq	%r10, %rsi
	jb	.L768
	cmpb	$32, 12(%rax)
	jle	.L783
	incq	%rdx
.L783:
	leaq	13(%rax), %r13
	cmpq	%r13, %rsi
	jb	.L768
	cmpb	$32, 13(%rax)
	jle	.L784
	incq	%rdx
.L784:
	leaq	14(%rax), %rcx
	cmpq	%rcx, %rsi
	jb	.L768
	cmpb	$32, 14(%rax)
	jle	.L768
	incq	%rdx
	jmp	.L768
	.p2align 4
	.p2align 3
.L934:
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
	jmp	.L839
.L933:
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
	jmp	.L836
.L932:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L833
.L792:
	movq	%rdi, 32(%rsp)
	jmp	.L748
.L928:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r11, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm6
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm9
	jmp	.L765
.L796:
	movq	%r11, %rax
	vpxor	%xmm9, %xmm9, %xmm9
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	jmp	.L766
.L931:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L827
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
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rsi, %r15
	movq	%rdx, %r14
	andq	$-32, %rsp
	subq	$64, %rsp
	cmpq	$66688, %rdx
	jbe	.L977
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm7
	vmovdqa	.LC14(%rip), %ymm9
	.p2align 4
	.p2align 3
.L976:
	movl	$555819297, %eax
	vmovd	%eax, %xmm6
	vpbroadcastd	%xmm6, %ymm0
	vmovdqa	%ymm0, 32(%rsp)
	vmovdqa	32(%rsp), %ymm1
	vpcmpgtb	66624(%r9), %ymm1, %ymm2
	vpcmpgtb	133248(%r9), %ymm1, %ymm3
	vpmovmskb	%ymm2, %edx
	vpmovmskb	%ymm3, %edi
	tzcntl	%edx, %ecx
	tzcntl	%edi, %r10d
	movl	%ecx, %ebx
	movl	%r10d, %r11d
	leaq	66625(%rbx), %rsi
	leaq	66625(%r9,%rbx), %r8
	leaq	133249(%r11), %rax
	leaq	133249(%r9,%r11), %r12
	subq	%rsi, %rax
	cmpq	%rsi, %rax
	cmovg	%rsi, %rax
	cmpq	$64, %rax
	jbe	.L1073
	movabsq	$1135184250689818561, %r13
	movl	$808464432, %edi
	movl	$100000000, %r10d
	movq	%r8, %rsi
	mulq	%r13
	vmovd	%edi, %xmm8
	vmovd	%r10d, %xmm10
	movq	%r9, %rcx
	vpxor	%xmm3, %xmm3, %xmm3
	xorl	%ebx, %ebx
	vpbroadcastd	%xmm8, %ymm15
	vpbroadcastd	%xmm10, %ymm6
	movq	%r12, 8(%rsp)
	shrq	$2, %rdx
	.p2align 4
	.p2align 3
.L940:
	leaq	(%rbx,%rdx,4), %r11
	movq	%rbx, %rdi
	movq	%rdx, 24(%rsp)
	movq	%rbx, 16(%rsp)
	.p2align 4
	.p2align 3
.L943:
	vmovdqu	(%rcx), %ymm11
	vmovdqa	32(%rsp), %ymm12
	vpcmpgtb	%ymm11, %ymm12, %ymm13
	vpcmpgtb	32(%rcx), %ymm12, %ymm14
	vpmovmskb	%ymm13, %eax
	blsr	%eax, %r12d
	tzcntl	%eax, %ebx
	blsr	%r12d, %r13d
	tzcntl	%r12d, %r10d
	vpmovmskb	%ymm14, %r12d
	blsr	%r13d, %eax
	tzcntl	%r13d, %edx
	salq	$32, %r12
	movl	%eax, %r13d
	orq	%r12, %r13
	movl	%ebx, %r12d
	vinserti128	$0x1, 1(%rcx,%r12), %ymm11, %ymm1
	incl	%r12d
	tzcntq	%r13, %rax
	movl	%r10d, %r13d
	salq	$4, %r12
	vmovdqu	1(%rcx,%r13), %xmm0
	movl	%edx, %r13d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm8
	movl	%r10d, %r12d
	vinserti128	$0x1, 1(%rcx,%r13), %ymm0, %ymm2
	subl	%ebx, %r12d
	movl	%edx, %ebx
	salq	$4, %r12
	subl	%r10d, %ebx
	movl	%eax, %r10d
	incl	%eax
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm8, %ymm11
	salq	$4, %rbx
	subl	%edx, %r10d
	addq	%rax, %rcx
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rbx), %xmm10
	salq	$4, %r10
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm10, %ymm13
	vpsubusb	%ymm15, %ymm1, %ymm14
	vpsubusb	%ymm15, %ymm2, %ymm2
	vpshufb	%ymm11, %ymm14, %ymm1
	vpmaddubsw	%ymm5, %ymm1, %ymm0
	vmovdqu	(%rsi), %ymm1
	vpshufb	%ymm13, %ymm2, %ymm10
	vmovdqa	32(%rsp), %ymm2
	vpmaddwd	%ymm4, %ymm0, %ymm8
	vpor	%ymm13, %ymm11, %ymm11
	vpmaddubsw	%ymm5, %ymm10, %ymm14
	vpor	%ymm3, %ymm11, %ymm3
	vpmaddwd	%ymm4, %ymm14, %ymm0
	vpcmpgtb	%ymm1, %ymm12, %ymm12
	vpmovmskb	%ymm12, %edx
	vpcmpgtb	32(%rsi), %ymm2, %ymm10
	blsr	%edx, %eax
	tzcntl	%edx, %ebx
	blsr	%eax, %r13d
	tzcntl	%eax, %r10d
	blsr	%r13d, %r12d
	tzcntl	%r13d, %edx
	vpmovmskb	%ymm10, %r13d
	movl	%r12d, %eax
	movl	%ebx, %r12d
	vinserti128	$0x1, 1(%rsi,%r12), %ymm1, %ymm1
	incl	%r12d
	salq	$32, %r13
	salq	$4, %r12
	orq	%r13, %rax
	movl	%r10d, %r13d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm12
	movl	%r10d, %r12d
	tzcntq	%rax, %rax
	vmovdqu	1(%rsi,%r13), %xmm14
	subl	%ebx, %r12d
	movl	%edx, %ebx
	movl	%edx, %r13d
	salq	$4, %r12
	subl	%r10d, %ebx
	movl	%eax, %r10d
	vinserti128	$0x1, 1(%rsi,%r13), %ymm14, %ymm2
	salq	$4, %rbx
	subl	%edx, %r10d
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm12, %ymm14
	incl	%eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rbx), %xmm10
	salq	$4, %r10
	addq	%rax, %rsi
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm10, %ymm12
	vpsubusb	%ymm15, %ymm1, %ymm1
	vpsubusb	%ymm15, %ymm2, %ymm2
	vpor	%ymm14, %ymm3, %ymm13
	vpshufb	%ymm14, %ymm1, %ymm14
	vpmaddubsw	%ymm5, %ymm14, %ymm10
	vpor	%ymm12, %ymm13, %ymm3
	vpshufb	%ymm12, %ymm2, %ymm12
	vpmaddwd	%ymm4, %ymm10, %ymm11
	vpmaddubsw	%ymm5, %ymm12, %ymm13
	vpackusdw	%ymm11, %ymm8, %ymm8
	vpmaddwd	%ymm4, %ymm13, %ymm14
	vpmaddwd	%ymm7, %ymm8, %ymm1
	vpackusdw	%ymm14, %ymm0, %ymm0
	vpmaddwd	%ymm7, %ymm0, %ymm10
	vshufps	$136, %ymm10, %ymm1, %ymm11
	vshufps	$221, %ymm10, %ymm1, %ymm12
	vpmulld	%ymm6, %ymm11, %ymm2
	vpaddd	%ymm12, %ymm2, %ymm13
	vpermd	%ymm13, %ymm9, %ymm14
	vpermq	$216, %ymm14, %ymm8
	vmovdqu	%xmm8, (%r15,%rdi,4)
	vextracti128	$0x1, %ymm8, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region(,%rdi,4)
	addq	$4, %rdi
	cmpq	%r11, %rdi
	jne	.L943
	movq	8(%rsp), %r13
	movq	%r8, %rdx
	movq	24(%rsp), %r11
	movabsq	$1135184250689818561, %rax
	subq	%rcx, %rdx
	movq	16(%rsp), %rdi
	subq	%rsi, %r13
	cmpq	%rdx, %r13
	leaq	(%rdi,%r11,4), %rbx
	cmovg	%rdx, %r13
	mulq	%r13
	shrq	$2, %rdx
	cmpq	$64, %r13
	ja	.L940
	movq	8(%rsp), %r12
	cmpq	$66687, %rbx
	setbe	%r10b
.L938:
	movq	%rbx, %r13
	cmpq	%r8, %rcx
	jnb	.L942
	vmovdqa	.LC8(%rip), %xmm4
	vmovdqa	.LC9(%rip), %xmm5
	movl	$555819297, %r11d
	movl	$808464432, %edi
	vmovdqa	.LC10(%rip), %xmm7
	vmovd	%r11d, %xmm9
	vmovd	%edi, %xmm6
	vpbroadcastd	%xmm9, %xmm15
	vpbroadcastd	%xmm6, %xmm10
	.p2align 4
	.p2align 3
.L941:
	vmovdqu	(%rcx), %xmm0
	incq	%r13
	vpcmpgtb	%xmm0, %xmm15, %xmm11
	vpsubusb	%xmm10, %xmm0, %xmm13
	vpmovmskb	%xmm11, %edx
	tzcntl	%edx, %eax
	incl	%eax
	movq	%rax, %r11
	addq	%rax, %rcx
	salq	$4, %r11
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r11), %xmm2
	vpshufb	%xmm2, %xmm13, %xmm14
	vmovdqa	%xmm2, %xmm12
	vpmaddubsw	%xmm4, %xmm14, %xmm8
	vpor	%ymm12, %ymm3, %ymm3
	vpmaddwd	%xmm5, %xmm8, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm9
	vpmaddwd	%xmm7, %xmm9, %xmm6
	vmovq	%xmm6, %rdx
	imull	$100000000, %edx, %edi
	shrq	$32, %rdx
	addl	%edi, %edx
	movl	%edx, -4(%r15,%r13,4)
	cmpq	%r8, %rcx
	jb	.L941
.L942:
	cmpq	%r12, %rsi
	jnb	.L945
	testb	%r10b, %r10b
	je	.L945
	movl	$555819297, %r10d
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm4
	vmovdqa	.LC9(%rip), %xmm5
	vmovd	%r10d, %xmm15
	vmovd	%eax, %xmm10
	vmovdqa	.LC10(%rip), %xmm7
	vpbroadcastd	%xmm15, %xmm2
	vpbroadcastd	%xmm10, %xmm13
	testb	$1, %bl
	jne	.L1072
	jmp	.L946
	.p2align 4
	.p2align 3
.L1061:
	cmpq	$66688, %rbx
	je	.L945
.L946:
	vmovdqu	(%rsi), %xmm0
	incq	%rbx
	vpcmpgtb	%xmm0, %xmm2, %xmm11
	vpsubusb	%xmm13, %xmm0, %xmm8
	vpmovmskb	%xmm11, %r11d
	tzcntl	%r11d, %edi
	incl	%edi
	movq	%rdi, %rdx
	addq	%rdi, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm8, %xmm1
	vmovdqa	%xmm14, %xmm12
	vpmaddubsw	%xmm4, %xmm1, %xmm9
	vpor	%ymm12, %ymm3, %ymm3
	vpmaddwd	%xmm5, %xmm9, %xmm6
	vpackusdw	%xmm6, %xmm6, %xmm15
	vpmaddwd	%xmm7, %xmm15, %xmm10
	vmovq	%xmm10, %r10
	imull	$100000000, %r10d, %eax
	shrq	$32, %r10
	addl	%eax, %r10d
	movl	%r10d, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%rbx,4)
	cmpq	%r12, %rsi
	jnb	.L945
.L1072:
	vmovdqu	(%rsi), %xmm0
	incq	%rbx
	vpcmpgtb	%xmm0, %xmm2, %xmm11
	vpsubusb	%xmm13, %xmm0, %xmm8
	vpmovmskb	%xmm11, %r11d
	tzcntl	%r11d, %edi
	incl	%edi
	movq	%rdi, %rdx
	addq	%rdi, %rsi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm8, %xmm1
	vmovdqa	%xmm14, %xmm12
	vpmaddubsw	%xmm4, %xmm1, %xmm9
	vpor	%ymm12, %ymm3, %ymm3
	vpmaddwd	%xmm5, %xmm9, %xmm6
	vpackusdw	%xmm6, %xmm6, %xmm15
	vpmaddwd	%xmm7, %xmm15, %xmm10
	vmovq	%xmm10, %r10
	imull	$100000000, %r10d, %eax
	shrq	$32, %r10
	addl	%eax, %r10d
	movl	%r10d, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%rbx,4)
	cmpq	%r12, %rsi
	jb	.L1061
.L945:
	vpmovmskb	%ymm3, %r11d
	xorl	%edi, %edi
	andl	$-2147450880, %r11d
	cmpq	%rsi, %r12
	setne	%dil
	xorl	%esi, %esi
	orl	%edi, %r11d
	cmpq	%rcx, %r8
	setne	%sil
	orl	%esi, %r11d
	jne	.L1074
	leaq	(%r15,%r13,4), %rdi
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, %esi
	vzeroupper
	call	memcpy
	vmovdqa	.LC14(%rip), %ymm9
	addq	%rbx, %r13
	vmovdqa	.LC4(%rip), %ymm7
	vmovdqa	.LC3(%rip), %ymm4
	leaq	(%r15,%r13,4), %r15
	subq	%r13, %r14
	vmovdqa	.LC2(%rip), %ymm5
.L975:
	cmpq	$66688, %r14
	jbe	.L1070
.L950:
	movq	%r12, %r9
	jmp	.L976
.L1073:
	movq	%r8, %rsi
	movq	%r9, %rcx
	movl	$1, %r10d
	vpxor	%xmm3, %xmm3, %xmm3
	xorl	%ebx, %ebx
	jmp	.L938
.L1070:
	vzeroupper
.L937:
	leaq	-40(%rbp), %rsp
	movq	%r14, %rdx
	movq	%r15, %rsi
	movq	%r12, %rdi
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	_ZN13qp_parse_flat12parse_tokensEPcPjm
.L1074:
	.cfi_restore_state
	cmpq	%r12, %r9
	jnb	.L1075
	leaq	-1(%r12), %r13
	movl	$1, %r11d
	cmpq	%r13, %r9
	cmovbe	%r9, %r13
	cmpq	%r9, %r13
	movq	%r13, %rdi
	setnb	%r8b
	subq	%r9, %rdi
	cmpq	%r9, %r13
	leaq	1(%rdi), %rcx
	cmovb	%r11, %rcx
	cmpq	$30, %rdi
	jbe	.L980
	cmpq	%r9, %r13
	jb	.L980
	movq	%rcx, %r10
	movl	$538976288, %ebx
	vmovq	%r11, %xmm3
	movq	%r9, %rdx
	andq	$-32, %r10
	vmovd	%ebx, %xmm2
	vpxor	%xmm1, %xmm1, %xmm1
	vpbroadcastq	%xmm3, %ymm14
	leaq	(%r10,%r9), %rax
	vpbroadcastd	%xmm2, %ymm13
.L952:
	vmovdqu	(%rdx), %ymm0
	addq	$32, %rdx
	vpcmpgtb	%ymm13, %ymm0, %ymm11
	vpmovsxbw	%xmm11, %ymm12
	vextracti128	$0x1, %ymm11, %xmm8
	vpmovsxwd	%xmm12, %ymm9
	vextracti128	$0x1, %ymm12, %xmm6
	vpmovsxbw	%xmm8, %ymm15
	vpmovsxdq	%xmm9, %ymm2
	vextracti128	$0x1, %ymm9, %xmm0
	vpmovsxwd	%xmm6, %ymm10
	vpmovsxwd	%xmm15, %ymm7
	vpand	%ymm14, %ymm2, %ymm3
	vpmovsxdq	%xmm0, %ymm11
	vextracti128	$0x1, %ymm10, %xmm9
	vpmovsxdq	%xmm10, %ymm8
	vpsubq	%ymm11, %ymm3, %ymm12
	vextracti128	$0x1, %ymm15, %xmm4
	vpmovsxdq	%xmm9, %ymm6
	vpmovsxdq	%xmm7, %ymm10
	vpsubq	%ymm8, %ymm12, %ymm15
	vpmovsxwd	%xmm4, %ymm5
	vextracti128	$0x1, %ymm7, %xmm7
	vpsubq	%ymm6, %ymm15, %ymm4
	vpmovsxdq	%xmm7, %ymm3
	vpmovsxdq	%xmm5, %ymm11
	vpsubq	%ymm10, %ymm4, %ymm2
	vextracti128	$0x1, %ymm5, %xmm5
	vpsubq	%ymm3, %ymm2, %ymm0
	vpmovsxdq	%xmm5, %ymm8
	vpsubq	%ymm11, %ymm0, %ymm12
	vpsubq	%ymm8, %ymm12, %ymm15
	vpaddq	%ymm15, %ymm1, %ymm1
	cmpq	%rdx, %rax
	jne	.L952
	vextracti128	$0x1, %ymm1, %xmm13
	vpaddq	%xmm1, %xmm13, %xmm6
	vpsrldq	$8, %xmm6, %xmm14
	vpaddq	%xmm14, %xmm6, %xmm9
	vmovq	%xmm9, %rdx
	cmpq	%rcx, %r10
	je	.L953
.L951:
	subq	%r10, %rcx
	leaq	-1(%rcx), %rsi
	cmpq	$14, %rsi
	jbe	.L954
	vmovdqu	(%r9,%r10), %xmm4
	movl	$538976288, %r11d
	movl	$1, %edx
	vmovd	%r11d, %xmm10
	vpbroadcastd	%xmm10, %xmm2
	vpcmpgtb	%xmm2, %xmm4, %xmm7
	vmovq	%rdx, %xmm4
	vpmovsxbw	%xmm7, %xmm3
	vpunpcklqdq	%xmm4, %xmm4, %xmm10
	vpsrldq	$8, %xmm7, %xmm0
	vpmovsxbw	%xmm0, %xmm11
	vpmovsxwd	%xmm3, %xmm12
	vpsrldq	$8, %xmm3, %xmm5
	vpmovsxwd	%xmm5, %xmm8
	vpmovsxwd	%xmm11, %xmm15
	vpsrldq	$8, %xmm12, %xmm14
	vpmovsxdq	%xmm14, %xmm9
	vpmovsxdq	%xmm8, %xmm7
	vpsrldq	$8, %xmm11, %xmm1
	vpand	%xmm10, %xmm9, %xmm2
	vpmovsxwd	%xmm1, %xmm13
	vpmovsxdq	%xmm12, %xmm12
	vpsubq	%xmm7, %xmm2, %xmm3
	vpmovsxdq	%xmm13, %xmm4
	vpsrldq	$8, %xmm13, %xmm13
	vpmovsxdq	%xmm13, %xmm2
	vpaddq	%xmm6, %xmm3, %xmm0
	vpsrldq	$8, %xmm8, %xmm6
	vpmovsxdq	%xmm6, %xmm11
	vpmovsxdq	%xmm15, %xmm8
	vpsubq	%xmm11, %xmm0, %xmm5
	vpsrldq	$8, %xmm15, %xmm15
	vpmovsxdq	%xmm15, %xmm14
	vpsubq	%xmm8, %xmm5, %xmm1
	vpsubq	%xmm14, %xmm1, %xmm9
	vpsubq	%xmm4, %xmm9, %xmm10
	vpsubq	%xmm2, %xmm10, %xmm7
	vpsubq	%xmm12, %xmm7, %xmm3
	vpsrldq	$8, %xmm3, %xmm0
	vpaddq	%xmm0, %xmm3, %xmm6
	vmovq	%xmm6, %rdx
	testb	$15, %cl
	je	.L953
	andq	$-16, %rcx
	addq	%rcx, %rax
.L954:
	xorl	%ecx, %ecx
	cmpb	$32, (%rax)
	leaq	1(%rax), %rbx
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rbx, %r13
	jnb	.L1076
.L953:
	xorl	%r13d, %r13d
	testb	%r8b, %r8b
	cmovne	%rdi, %r13
	leaq	1(%r9,%r13), %r8
	cmpq	%r12, %r8
	jnb	.L974
	movq	%r8, %rdi
	notq	%rdi
	addq	%r12, %rdi
	andl	$7, %edi
	cmpb	$32, (%r8)
	jg	.L1077
.L996:
	leaq	1(%r8), %rax
	cmpq	%r12, %rax
	jnb	.L974
	testq	%rdi, %rdi
	je	.L973
	cmpq	$1, %rdi
	je	.L1038
	cmpq	$2, %rdi
	je	.L1039
	cmpq	$3, %rdi
	je	.L1040
	cmpq	$4, %rdi
	je	.L1041
	cmpq	$5, %rdi
	je	.L1042
	cmpq	$6, %rdi
	je	.L1043
	cmpb	$32, 1(%r8)
	jg	.L1078
.L998:
	incq	%rax
.L1043:
	cmpb	$32, (%rax)
	jle	.L1001
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L1001:
	incq	%rax
.L1042:
	cmpb	$32, (%rax)
	jg	.L1079
.L1004:
	incq	%rax
.L1041:
	cmpb	$32, (%rax)
	jg	.L1080
.L1007:
	incq	%rax
.L1040:
	cmpb	$32, (%rax)
	jg	.L1081
.L1010:
	incq	%rax
.L1039:
	cmpb	$32, (%rax)
	jle	.L1013
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
.L1013:
	incq	%rax
.L1038:
	cmpb	$32, (%rax)
	jle	.L1016
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
.L1016:
	incq	%rax
	cmpq	%r12, %rax
	jnb	.L974
.L973:
	cmpb	$32, (%rax)
	jle	.L972
	xorl	%edi, %edi
	cmpb	$32, -1(%rax)
	setle	%dil
	addq	%rdi, %rdx
.L972:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %r10
	jle	.L1019
	xorl	%eax, %eax
	cmpb	$32, -1(%r10)
	setle	%al
	addq	%rax, %rdx
.L1019:
	cmpb	$32, 1(%r10)
	jle	.L1021
	xorl	%esi, %esi
	cmpb	$32, (%r10)
	setle	%sil
	addq	%rsi, %rdx
.L1021:
	cmpb	$32, 2(%r10)
	jle	.L1023
	xorl	%r11d, %r11d
	cmpb	$32, 1(%r10)
	setle	%r11b
	addq	%r11, %rdx
.L1023:
	cmpb	$32, 3(%r10)
	jle	.L1025
	xorl	%ecx, %ecx
	cmpb	$32, 2(%r10)
	setle	%cl
	addq	%rcx, %rdx
.L1025:
	cmpb	$32, 4(%r10)
	jle	.L1027
	xorl	%ebx, %ebx
	cmpb	$32, 3(%r10)
	setle	%bl
	addq	%rbx, %rdx
.L1027:
	cmpb	$32, 5(%r10)
	jle	.L1029
	xorl	%r13d, %r13d
	cmpb	$32, 4(%r10)
	setle	%r13b
	addq	%r13, %rdx
.L1029:
	cmpb	$32, 6(%r10)
	jle	.L1031
	xorl	%r8d, %r8d
	cmpb	$32, 5(%r10)
	setle	%r8b
	addq	%r8, %rdx
.L1031:
	leaq	7(%r10), %rax
	cmpq	%r12, %rax
	jb	.L973
.L974:
	subq	%rdx, %r14
	movq	%r15, %rsi
	movq	%r9, %rdi
	leaq	(%r15,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm7
	vmovdqa	.LC14(%rip), %ymm9
	jmp	.L975
.L1077:
	xorl	%eax, %eax
	cmpb	$32, -1(%r8)
	setle	%al
	addq	%rax, %rdx
	jmp	.L996
.L1076:
	xorl	%r10d, %r10d
	cmpb	$32, 1(%rax)
	leaq	2(%rax), %rsi
	setg	%r10b
	addq	%r10, %rdx
	cmpq	%rsi, %r13
	jb	.L953
	xorl	%r11d, %r11d
	cmpb	$32, 2(%rax)
	leaq	3(%rax), %rcx
	setg	%r11b
	addq	%r11, %rdx
	cmpq	%rcx, %r13
	jb	.L953
	xorl	%ebx, %ebx
	cmpb	$32, 3(%rax)
	leaq	4(%rax), %r10
	setg	%bl
	addq	%rbx, %rdx
	cmpq	%r10, %r13
	jb	.L953
	xorl	%esi, %esi
	cmpb	$32, 4(%rax)
	leaq	5(%rax), %r11
	setg	%sil
	addq	%rsi, %rdx
	cmpq	%r11, %r13
	jb	.L953
	xorl	%ecx, %ecx
	cmpb	$32, 5(%rax)
	leaq	6(%rax), %rbx
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rbx, %r13
	jb	.L953
	xorl	%r10d, %r10d
	cmpb	$32, 6(%rax)
	leaq	7(%rax), %rsi
	setg	%r10b
	addq	%r10, %rdx
	cmpq	%rsi, %r13
	jb	.L953
	xorl	%r11d, %r11d
	cmpb	$32, 7(%rax)
	leaq	8(%rax), %rcx
	setg	%r11b
	addq	%r11, %rdx
	cmpq	%rcx, %r13
	jb	.L953
	cmpb	$32, 8(%rax)
	jle	.L964
	incq	%rdx
.L964:
	leaq	9(%rax), %rbx
	cmpq	%rbx, %r13
	jb	.L953
	cmpb	$32, 9(%rax)
	jle	.L965
	incq	%rdx
.L965:
	leaq	10(%rax), %r10
	cmpq	%r10, %r13
	jb	.L953
	cmpb	$32, 10(%rax)
	jle	.L966
	incq	%rdx
.L966:
	leaq	11(%rax), %rsi
	cmpq	%rsi, %r13
	jb	.L953
	cmpb	$32, 11(%rax)
	jle	.L967
	incq	%rdx
.L967:
	leaq	12(%rax), %r11
	cmpq	%r11, %r13
	jb	.L953
	cmpb	$32, 12(%rax)
	jle	.L968
	incq	%rdx
.L968:
	leaq	13(%rax), %rcx
	cmpq	%rcx, %r13
	jb	.L953
	cmpb	$32, 13(%rax)
	jle	.L969
	incq	%rdx
.L969:
	leaq	14(%rax), %rbx
	cmpq	%rbx, %r13
	jb	.L953
	cmpb	$32, 14(%rax)
	jle	.L953
	incq	%rdx
	jmp	.L953
	.p2align 4
	.p2align 3
.L1081:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L1010
.L1080:
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
	jmp	.L1007
.L1079:
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rax)
	setle	%r11b
	addq	%r11, %rdx
	jmp	.L1004
.L977:
	movq	%rdi, %r12
	jmp	.L937
.L1075:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r9, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm7
	vmovdqa	.LC14(%rip), %ymm9
	jmp	.L950
.L980:
	movq	%r9, %rax
	vpxor	%xmm6, %xmm6, %xmm6
	xorl	%r10d, %r10d
	xorl	%edx, %edx
	jmp	.L951
.L1078:
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
	jmp	.L998
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
.LC2:
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
.LC3:
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
.LC4:
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
.LC5:
	.long	100000000
	.long	100000000
	.long	100000000
	.long	100000000
	.long	100000000
	.long	100000000
	.long	100000000
	.long	100000000
	.align 32
.LC6:
	.long	0
	.long	4
	.long	2
	.long	6
	.long	0
	.long	4
	.long	2
	.long	6
	.set	.LC8,.LC2
	.set	.LC9,.LC3
	.set	.LC10,.LC4
	.align 32
.LC14:
	.long	0
	.long	4
	.long	1
	.long	5
	.long	2
	.long	6
	.long	3
	.long	7
	.set	.LC23,.LC5
	.align 32
.LC24:
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.align 32
.LC25:
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.align 32
.LC30:
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.align 32
.LC31:
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.align 32
.LC32:
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.align 32
.LC44:
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
.LC45:
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
.LC46:
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
.LC47:
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
.LC48:
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
.LC49:
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
