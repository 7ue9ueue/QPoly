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
	.globl	_Z12probe_formatPKjPcm
	.type	_Z12probe_formatPKjPcm, @function
_Z12probe_formatPKjPcm:
.LFB8934:
	.cfi_startproc
	cmpq	$31, %rdx
	jbe	.L132
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
.L128:
	movl	$429529498, %r10d
	movl	$16122102, %r11d
	movl	$808464432, %edx
	movl	$538976288, %edi
	vmovdqu	(%rcx), %ymm4
	vmovdqu	64(%rcx), %ymm6
	movl	$48, %r9d
	movl	$100000000, %r8d
	vpmuludq	.LC15(%rip), %ymm4, %ymm15
	vmovdqu	32(%rcx), %ymm3
	addq	$320, %rax
	subq	$-128, %rcx
	vpmuludq	.LC14(%rip), %ymm4, %ymm10
	vmovdqu	-32(%rcx), %ymm5
	vpsrlq	$32, %ymm4, %ymm7
	vpmuludq	.LC14(%rip), %ymm7, %ymm8
	vmovdqa	%ymm6, 424(%rsp)
	vpmuludq	.LC15(%rip), %ymm7, %ymm12
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
	vmovdqa	.LC22(%rip), %ymm10
	vpsubd	%ymm2, %ymm4, %ymm12
	vmovdqa	392(%rsp), %ymm2
	vpsubd	%ymm6, %ymm13, %ymm8
	vmovdqa	.LC20(%rip), %ymm13
	vmovdqa	.LC21(%rip), %ymm6
	vpcmpgtd	%ymm4, %ymm2, %ymm14
	vpblendvb	%ymm13, %ymm14, %ymm0, %ymm1
	vmovdqa	232(%rsp), %ymm14
	vpblendvb	%ymm6, %ymm11, %ymm1, %ymm7
	vmovdqa	264(%rsp), %ymm11
	vpblendvb	%ymm10, %ymm9, %ymm7, %ymm10
	vmovdqa	296(%rsp), %ymm9
	vmovdqa	.LC21(%rip), %ymm7
	vpcmpgtd	%ymm4, %ymm14, %ymm1
	vpand	200(%rsp), %ymm1, %ymm6
	vmovdqa	168(%rsp), %ymm14
	vpcmpgtd	%ymm4, %ymm11, %ymm13
	vmovdqa	.LC22(%rip), %ymm11
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
	vpmuludq	.LC14(%rip), %ymm11, %ymm1
	vpblendvb	%ymm13, %ymm6, %ymm12, %ymm13
	vpunpckldq	%ymm13, %ymm9, %ymm10
	vpunpckhdq	%ymm13, %ymm9, %ymm9
	vpmuludq	.LC14(%rip), %ymm3, %ymm13
	vmovdqa	%ymm10, -24(%rsp)
	vmovdqa	%ymm9, 104(%rsp)
	vpmuludq	.LC15(%rip), %ymm11, %ymm9
	vpsrlq	$13, %ymm1, %ymm12
	vpsrlq	$45, %ymm13, %ymm10
	vpblendd	$170, %ymm12, %ymm10, %ymm1
	vpmuludq	.LC15(%rip), %ymm3, %ymm12
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
	vmovdqa	.LC20(%rip), %ymm2
	vpcmpgtd	%ymm3, %ymm10, %ymm12
	vpcmpgtd	%ymm3, %ymm15, %ymm10
	vpblendvb	%ymm2, %ymm13, %ymm10, %ymm13
	vmovdqa	.LC21(%rip), %ymm10
	vmovdqa	.LC22(%rip), %ymm2
	vpblendvb	%ymm10, %ymm12, %ymm13, %ymm12
	vmovdqa	264(%rsp), %ymm13
	vpblendvb	%ymm2, %ymm9, %ymm12, %ymm10
	vmovdqa	296(%rsp), %ymm9
	vmovdqa	232(%rsp), %ymm2
	vpcmpgtd	%ymm3, %ymm13, %ymm13
	vpcmpgtd	%ymm3, %ymm9, %ymm12
	vpcmpgtd	%ymm3, %ymm2, %ymm9
	vmovdqa	.LC21(%rip), %ymm2
	vpand	200(%rsp), %ymm9, %ymm9
	vpblendvb	%ymm2, %ymm13, %ymm9, %ymm13
	vmovdqa	.LC22(%rip), %ymm9
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
	vpmuludq	.LC14(%rip), %ymm13, %ymm2
	vmovdqa	%ymm11, -56(%rsp)
	vmovdqa	%ymm1, -88(%rsp)
	vpsrlq	$32, %ymm13, %ymm12
	vpmuludq	.LC14(%rip), %ymm12, %ymm10
	vpmuludq	.LC15(%rip), %ymm12, %ymm12
	vpsrlq	$45, %ymm2, %ymm11
	vpsrlq	$13, %ymm10, %ymm9
	vpmuludq	.LC15(%rip), %ymm13, %ymm10
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
	vmovdqa	.LC20(%rip), %ymm2
	vpcmpgtd	%ymm13, %ymm10, %ymm13
	vpcmpgtd	424(%rsp), %ymm15, %ymm10
	vpblendvb	%ymm2, %ymm13, %ymm10, %ymm13
	vmovdqa	.LC21(%rip), %ymm10
	vmovdqa	.LC22(%rip), %ymm2
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
	vmovdqa	.LC21(%rip), %ymm2
	vpblendvb	%ymm2, %ymm13, %ymm9, %ymm13
	vmovdqa	.LC22(%rip), %ymm9
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
	vpmuludq	.LC14(%rip), %ymm5, %ymm9
	vpaddw	%ymm11, %ymm12, %ymm10
	vpmuludq	.LC14(%rip), %ymm14, %ymm11
	vpaddb	%ymm7, %ymm10, %ymm13
	vpmuludq	.LC15(%rip), %ymm14, %ymm14
	vpblendvb	%ymm2, %ymm6, %ymm13, %ymm2
	vpunpckldq	%ymm2, %ymm1, %ymm10
	vpunpckhdq	%ymm2, %ymm1, %ymm1
	vpsrlq	$45, %ymm9, %ymm13
	vpsrlq	$13, %ymm11, %ymm12
	vpblendd	$170, %ymm12, %ymm13, %ymm2
	vpmuludq	.LC15(%rip), %ymm5, %ymm12
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
	vmovdqa	.LC20(%rip), %ymm2
	vpblendvb	%ymm2, %ymm15, %ymm12, %ymm12
	vmovdqa	.LC21(%rip), %ymm15
	vmovdqa	.LC22(%rip), %ymm2
	vpblendvb	%ymm15, %ymm14, %ymm12, %ymm14
	vmovdqa	264(%rsp), %ymm15
	vpblendvb	%ymm2, %ymm11, %ymm14, %ymm12
	vmovdqa	296(%rsp), %ymm11
	vmovdqa	232(%rsp), %ymm2
	vpcmpgtd	%ymm5, %ymm15, %ymm15
	vpcmpgtd	%ymm5, %ymm11, %ymm14
	vpcmpgtd	%ymm5, %ymm2, %ymm11
	vmovdqa	.LC21(%rip), %ymm2
	vpand	200(%rsp), %ymm11, %ymm11
	vpblendvb	%ymm2, %ymm15, %ymm11, %ymm15
	vmovdqa	.LC22(%rip), %ymm11
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
	vpshufb	.LC35(%rip), %ymm4, %ymm15
	vpshufb	.LC37(%rip), %ymm4, %ymm13
	vpshufb	.LC36(%rip), %ymm2, %ymm14
	vpshufb	.LC38(%rip), %ymm2, %ymm8
	vpor	%ymm15, %ymm14, %ymm14
	vpshufb	.LC39(%rip), %ymm4, %ymm15
	vmovdqa	104(%rsp), %ymm2
	vpor	%ymm13, %ymm8, %ymm8
	vpshufb	.LC40(%rip), %ymm4, %ymm4
	vmovdqu	%xmm14, -320(%rax)
	vmovdqu	%xmm8, -310(%rax)
	vpshufb	.LC36(%rip), %ymm2, %ymm13
	vpor	%ymm15, %ymm13, %ymm13
	vpshufb	.LC38(%rip), %ymm2, %ymm15
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
	vpshufb	.LC36(%rip), %ymm4, %ymm13
	vpblendvb	%ymm14, %ymm11, %ymm3, %ymm8
	vpshufb	.LC38(%rip), %ymm4, %ymm3
	vpor	%ymm9, %ymm8, %ymm15
	vpshufb	.LC35(%rip), %ymm15, %ymm2
	vpshufb	.LC37(%rip), %ymm15, %ymm14
	vpor	%ymm2, %ymm13, %ymm13
	vmovdqa	-88(%rsp), %ymm2
	vpor	%ymm14, %ymm3, %ymm4
	vpshufb	.LC39(%rip), %ymm15, %ymm8
	vpshufb	.LC40(%rip), %ymm15, %ymm15
	vmovdqu	%xmm13, -240(%rax)
	vmovdqu	%xmm4, -230(%rax)
	vpshufb	.LC36(%rip), %ymm2, %ymm14
	vpshufb	.LC38(%rip), %ymm2, %ymm3
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
	vpshufb	.LC36(%rip), %ymm10, %ymm3
	vpshufb	.LC38(%rip), %ymm10, %ymm10
	vpblendvb	%ymm13, %ymm11, %ymm4, %ymm8
	vpshufb	.LC36(%rip), %ymm1, %ymm4
	vpshufb	.LC38(%rip), %ymm1, %ymm1
	vpor	%ymm9, %ymm8, %ymm2
	vpblendvb	%ymm5, %ymm11, %ymm6, %ymm12
	vpshufb	.LC35(%rip), %ymm2, %ymm15
	vpshufb	.LC37(%rip), %ymm2, %ymm13
	vpor	%ymm9, %ymm12, %ymm11
	vpshufb	.LC39(%rip), %ymm2, %ymm8
	vpshufb	.LC40(%rip), %ymm2, %ymm2
	vpor	%ymm15, %ymm3, %ymm14
	vpor	%ymm13, %ymm10, %ymm15
	vpor	%ymm8, %ymm4, %ymm3
	vpor	%ymm2, %ymm1, %ymm13
	vpshufb	.LC36(%rip), %ymm0, %ymm10
	vmovdqu	%xmm14, -160(%rax)
	vpshufb	.LC35(%rip), %ymm11, %ymm9
	vmovdqu	%xmm15, -150(%rax)
	vpshufb	.LC39(%rip), %ymm11, %ymm1
	vmovdqu	%xmm3, -140(%rax)
	vpshufb	.LC40(%rip), %ymm11, %ymm4
	vmovdqu	%xmm13, -130(%rax)
	vpshufb	.LC38(%rip), %ymm0, %ymm0
	vpor	%ymm1, %ymm10, %ymm8
	vextracti128	$0x1, %ymm14, -120(%rax)
	vpshufb	.LC36(%rip), %ymm7, %ymm14
	vpshufb	.LC38(%rip), %ymm7, %ymm7
	vpor	%ymm4, %ymm0, %ymm2
	vextracti128	$0x1, %ymm15, -110(%rax)
	vextracti128	$0x1, %ymm3, -100(%rax)
	vpshufb	.LC37(%rip), %ymm11, %ymm3
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
	jne	.L128
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
	jbe	.L180
	vmovdqa	.LC2(%rip), %ymm6
	movq	%rdi, %r11
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm9
	.p2align 4
	.p2align 3
.L179:
	movl	$555819297, %eax
	vmovdqa	.LC47(%rip), %ymm11
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
.L141:
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
	jbe	.L312
	vpbroadcastd	.LC54(%rip), %ymm10
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
.L140:
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
	jne	.L140
	movq	56(%rsp), %rdx
	leaq	(%rbx,%rdx,2), %rbx
	jmp	.L141
	.p2align 4
	.p2align 3
.L312:
	movq	%r9, %r11
	movq	40(%rsp), %r9
	movq	%rbx, %r14
	cmpq	%r9, %rcx
	jnb	.L139
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
.L138:
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
	jb	.L138
.L139:
	cmpq	$32831, %rbx
	movq	%rbx, %r12
	setbe	64(%rsp)
	cmpq	%r10, %r8
	jnb	.L142
	cmpb	$0, 64(%rsp)
	je	.L142
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
	je	.L143
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
	jb	.L294
	jmp	.L142
	.p2align 4
	.p2align 3
.L143:
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
	jnb	.L142
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
	jnb	.L142
.L294:
	cmpq	$32832, %r12
	jne	.L143
.L142:
	movq	48(%rsp), %rax
	movq	%rbx, %r13
	cmpq	%rax, %rdi
	jnb	.L145
	cmpb	$0, 64(%rsp)
	je	.L145
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
	jne	.L295
	movq	%r12, 56(%rsp)
	movq	%rax, %r12
	jmp	.L146
	.p2align 4
	.p2align 3
.L313:
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
	jnb	.L302
	cmpq	$32832, %r13
	je	.L302
.L146:
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
	jb	.L313
.L302:
	movq	56(%rsp), %r12
.L145:
	movq	32(%rsp), %rax
	cmpq	%rax, %rsi
	jnb	.L148
	cmpb	$0, 64(%rsp)
	je	.L148
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
	jne	.L297
	movq	%r12, 64(%rsp)
	movq	%rax, %r12
	jmp	.L149
	.p2align 4
	.p2align 3
.L314:
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
	jnb	.L303
	cmpq	$32832, %rbx
	je	.L303
.L149:
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
	jb	.L314
.L303:
	movq	64(%rsp), %r12
.L148:
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
	jne	.L315
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
.L178:
	cmpq	$65600, 24(%rsp)
	jbe	.L310
.L153:
	movq	32(%rsp), %r11
	jmp	.L179
.L297:
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
	jnb	.L148
	cmpq	$32832, %rbx
	je	.L148
	movq	%r12, 64(%rsp)
	movq	32(%rsp), %r12
	jmp	.L149
.L295:
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
	jnb	.L145
	cmpq	$32832, %r13
	je	.L145
	movq	%r12, 56(%rsp)
	movq	48(%rsp), %r12
	jmp	.L146
.L310:
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
.L315:
	.cfi_restore_state
	cmpq	32(%rsp), %r11
	jnb	.L316
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
	jbe	.L184
	cmpq	%r11, %rsi
	jb	.L184
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
.L155:
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
	jne	.L155
	vextracti128	$0x1, %ymm1, %xmm3
	vpaddq	%xmm1, %xmm3, %xmm9
	vpsrldq	$8, %xmm9, %xmm12
	vpaddq	%xmm12, %xmm9, %xmm11
	vmovq	%xmm11, %rdx
	cmpq	%rcx, %r9
	je	.L156
.L154:
	subq	%r9, %rcx
	leaq	-1(%rcx), %r8
	cmpq	$14, %r8
	jbe	.L157
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
	je	.L156
	andq	$-16, %rcx
	addq	%rcx, %rax
.L157:
	xorl	%ecx, %ecx
	cmpb	$32, (%rax)
	leaq	1(%rax), %rdi
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rdi, %rsi
	jnb	.L317
.L156:
	xorl	%esi, %esi
	testb	%r14b, %r14b
	cmovne	%r12, %rsi
	movq	32(%rsp), %r12
	leaq	1(%r11,%rsi), %r14
	cmpq	%r12, %r14
	jnb	.L177
	movq	%r14, %rdi
	notq	%rdi
	addq	%r12, %rdi
	andl	$7, %edi
	cmpb	$32, (%r14)
	jg	.L318
.L213:
	leaq	1(%r14), %rax
	cmpq	32(%rsp), %rax
	jnb	.L177
	testq	%rdi, %rdi
	je	.L176
	cmpq	$1, %rdi
	je	.L261
	cmpq	$2, %rdi
	je	.L262
	cmpq	$3, %rdi
	je	.L263
	cmpq	$4, %rdi
	je	.L264
	cmpq	$5, %rdi
	je	.L265
	cmpq	$6, %rdi
	je	.L266
	cmpb	$32, 1(%r14)
	jg	.L319
.L215:
	incq	%rax
.L266:
	cmpb	$32, (%rax)
	jle	.L218
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
.L218:
	incq	%rax
.L265:
	cmpb	$32, (%rax)
	jg	.L320
.L221:
	incq	%rax
.L264:
	cmpb	$32, (%rax)
	jg	.L321
.L224:
	incq	%rax
.L263:
	cmpb	$32, (%rax)
	jg	.L322
.L227:
	incq	%rax
.L262:
	cmpb	$32, (%rax)
	jle	.L230
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L230:
	incq	%rax
.L261:
	cmpb	$32, (%rax)
	jle	.L233
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L233:
	incq	%rax
	cmpq	32(%rsp), %rax
	jnb	.L177
.L176:
	cmpb	$32, (%rax)
	jle	.L175
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L175:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %r12
	jle	.L236
	xorl	%edi, %edi
	cmpb	$32, -1(%r12)
	setle	%dil
	addq	%rdi, %rdx
.L236:
	cmpb	$32, 1(%r12)
	jle	.L238
	xorl	%eax, %eax
	cmpb	$32, (%r12)
	setle	%al
	addq	%rax, %rdx
.L238:
	cmpb	$32, 2(%r12)
	jle	.L240
	xorl	%ebx, %ebx
	cmpb	$32, 1(%r12)
	setle	%bl
	addq	%rbx, %rdx
.L240:
	cmpb	$32, 3(%r12)
	jle	.L242
	xorl	%r9d, %r9d
	cmpb	$32, 2(%r12)
	setle	%r9b
	addq	%r9, %rdx
.L242:
	cmpb	$32, 4(%r12)
	jle	.L244
	xorl	%r8d, %r8d
	cmpb	$32, 3(%r12)
	setle	%r8b
	addq	%r8, %rdx
.L244:
	cmpb	$32, 5(%r12)
	jle	.L246
	xorl	%r10d, %r10d
	cmpb	$32, 4(%r12)
	setle	%r10b
	addq	%r10, %rdx
.L246:
	cmpb	$32, 6(%r12)
	jle	.L248
	xorl	%r13d, %r13d
	cmpb	$32, 5(%r12)
	setle	%r13b
	addq	%r13, %rdx
.L248:
	leaq	7(%r12), %rax
	cmpq	32(%rsp), %rax
	jb	.L176
.L177:
	subq	%rdx, 24(%rsp)
	movq	%r15, %rsi
	movq	%r11, %rdi
	leaq	(%r15,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm6
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm9
	jmp	.L178
.L318:
	xorl	%eax, %eax
	cmpb	$32, -1(%r14)
	setle	%al
	addq	%rax, %rdx
	jmp	.L213
.L317:
	xorl	%ebx, %ebx
	cmpb	$32, 1(%rax)
	leaq	2(%rax), %r9
	setg	%bl
	addq	%rbx, %rdx
	cmpq	%r9, %rsi
	jb	.L156
	xorl	%r8d, %r8d
	cmpb	$32, 2(%rax)
	leaq	3(%rax), %r10
	setg	%r8b
	addq	%r8, %rdx
	cmpq	%r10, %rsi
	jb	.L156
	xorl	%r13d, %r13d
	cmpb	$32, 3(%rax)
	leaq	4(%rax), %rcx
	setg	%r13b
	addq	%r13, %rdx
	cmpq	%rcx, %rsi
	jb	.L156
	xorl	%edi, %edi
	cmpb	$32, 4(%rax)
	leaq	5(%rax), %rbx
	setg	%dil
	addq	%rdi, %rdx
	cmpq	%rbx, %rsi
	jb	.L156
	xorl	%r9d, %r9d
	cmpb	$32, 5(%rax)
	leaq	6(%rax), %r8
	setg	%r9b
	addq	%r9, %rdx
	cmpq	%r8, %rsi
	jb	.L156
	xorl	%r10d, %r10d
	cmpb	$32, 6(%rax)
	leaq	7(%rax), %r13
	setg	%r10b
	addq	%r10, %rdx
	cmpq	%r13, %rsi
	jb	.L156
	xorl	%ecx, %ecx
	cmpb	$32, 7(%rax)
	leaq	8(%rax), %rdi
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rdi, %rsi
	jb	.L156
	cmpb	$32, 8(%rax)
	jle	.L167
	incq	%rdx
.L167:
	leaq	9(%rax), %rbx
	cmpq	%rbx, %rsi
	jb	.L156
	cmpb	$32, 9(%rax)
	jle	.L168
	incq	%rdx
.L168:
	leaq	10(%rax), %r9
	cmpq	%r9, %rsi
	jb	.L156
	cmpb	$32, 10(%rax)
	jle	.L169
	incq	%rdx
.L169:
	leaq	11(%rax), %r8
	cmpq	%r8, %rsi
	jb	.L156
	cmpb	$32, 11(%rax)
	jle	.L170
	incq	%rdx
.L170:
	leaq	12(%rax), %r10
	cmpq	%r10, %rsi
	jb	.L156
	cmpb	$32, 12(%rax)
	jle	.L171
	incq	%rdx
.L171:
	leaq	13(%rax), %r13
	cmpq	%r13, %rsi
	jb	.L156
	cmpb	$32, 13(%rax)
	jle	.L172
	incq	%rdx
.L172:
	leaq	14(%rax), %rcx
	cmpq	%rcx, %rsi
	jb	.L156
	cmpb	$32, 14(%rax)
	jle	.L156
	incq	%rdx
	jmp	.L156
	.p2align 4
	.p2align 3
.L322:
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
	jmp	.L227
.L321:
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
	jmp	.L224
.L320:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L221
.L180:
	movq	%rdi, 32(%rsp)
	jmp	.L136
.L316:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r11, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm6
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm9
	jmp	.L153
.L184:
	movq	%r11, %rax
	vpxor	%xmm9, %xmm9, %xmm9
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	jmp	.L154
.L319:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L215
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
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.align 32
.LC15:
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.align 32
.LC20:
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
.LC21:
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
.LC22:
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
.LC35:
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
.LC36:
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
.LC37:
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
.LC38:
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
.LC39:
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
.LC40:
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
.LC47:
	.long	0
	.long	4
	.long	1
	.long	5
	.long	2
	.long	6
	.long	3
	.long	7
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC54:
	.long	100000000
	.ident	"GCC: (GNU) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
