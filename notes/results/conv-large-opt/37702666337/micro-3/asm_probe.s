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
	.p2align 4
	.globl	_Z16probe_format_asmPKjPcm
	.type	_Z16probe_format_asmPKjPcm, @function
_Z16probe_format_asmPKjPcm:
.LFB8947:
	.cfi_startproc
	movq	%rdx, %r10
	cmpq	$31, %rdx
	jbe	.L175
	leaq	-32(%rdx), %r9
	movl	$_ZN10qp_fmt_asm6constsE, %ecx
	shrq	$5, %r9
	andl	$7, %r9d
#APP
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
	jb	.L176
	testq	%r9, %r9
	je	.L137
	cmpq	$1, %r9
	je	.L162
	cmpq	$2, %r9
	je	.L163
	cmpq	$3, %r9
	je	.L164
	cmpq	$4, %r9
	je	.L165
	cmpq	$5, %r9
	je	.L166
	cmpq	$6, %r9
	je	.L167
#APP
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
.L167:
#APP
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
.L166:
#APP
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
.L165:
#APP
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
.L164:
#APP
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
.L163:
#APP
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
.L162:
#APP
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
	jb	.L176
.L137:
#APP
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
# 159 "/__w/QPoly/QPoly/work/ntt/large_opt/fmt_asm.inc" 1
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
	jnb	.L137
.L176:
	vzeroupper
.L175:
	ret
	.cfi_endproc
.LFE8947:
	.size	_Z16probe_format_asmPKjPcm, .-_Z16probe_format_asmPKjPcm
	.section	.text._ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,"axG",@progbits,_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,comdat
	.p2align 4
	.weak	_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.type	_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m, @function
_ZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m:
.LFB8957:
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
	jbe	.L222
	vmovdqa	.LC2(%rip), %ymm6
	movq	%rdi, %r11
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm9
	.p2align 4
	.p2align 3
.L221:
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
.L183:
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
	jbe	.L354
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
.L182:
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
	jne	.L182
	movq	56(%rsp), %rdx
	leaq	(%rbx,%rdx,2), %rbx
	jmp	.L183
	.p2align 4
	.p2align 3
.L354:
	movq	%r9, %r11
	movq	40(%rsp), %r9
	movq	%rbx, %r14
	cmpq	%r9, %rcx
	jnb	.L181
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
.L180:
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
	jb	.L180
.L181:
	cmpq	$32831, %rbx
	movq	%rbx, %r12
	setbe	64(%rsp)
	cmpq	%r10, %r8
	jnb	.L184
	cmpb	$0, 64(%rsp)
	je	.L184
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
	je	.L185
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
	jb	.L336
	jmp	.L184
	.p2align 4
	.p2align 3
.L185:
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
	jnb	.L184
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
	jnb	.L184
.L336:
	cmpq	$32832, %r12
	jne	.L185
.L184:
	movq	48(%rsp), %rax
	movq	%rbx, %r13
	cmpq	%rax, %rdi
	jnb	.L187
	cmpb	$0, 64(%rsp)
	je	.L187
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
	jne	.L337
	movq	%r12, 56(%rsp)
	movq	%rax, %r12
	jmp	.L188
	.p2align 4
	.p2align 3
.L355:
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
	jnb	.L344
	cmpq	$32832, %r13
	je	.L344
.L188:
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
	jb	.L355
.L344:
	movq	56(%rsp), %r12
.L187:
	movq	32(%rsp), %rax
	cmpq	%rax, %rsi
	jnb	.L190
	cmpb	$0, 64(%rsp)
	je	.L190
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
	jne	.L339
	movq	%r12, 64(%rsp)
	movq	%rax, %r12
	jmp	.L191
	.p2align 4
	.p2align 3
.L356:
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
	jnb	.L345
	cmpq	$32832, %rbx
	je	.L345
.L191:
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
	jb	.L356
.L345:
	movq	64(%rsp), %r12
.L190:
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
	jne	.L357
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
.L220:
	cmpq	$65600, 24(%rsp)
	jbe	.L352
.L195:
	movq	32(%rsp), %r11
	jmp	.L221
.L339:
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
	jnb	.L190
	cmpq	$32832, %rbx
	je	.L190
	movq	%r12, 64(%rsp)
	movq	32(%rsp), %r12
	jmp	.L191
.L337:
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
	jnb	.L187
	cmpq	$32832, %r13
	je	.L187
	movq	%r12, 56(%rsp)
	movq	48(%rsp), %r12
	jmp	.L188
.L352:
	vzeroupper
.L178:
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
.L357:
	.cfi_restore_state
	cmpq	32(%rsp), %r11
	jnb	.L358
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
	jbe	.L226
	cmpq	%r11, %rsi
	jb	.L226
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
.L197:
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
	jne	.L197
	vextracti128	$0x1, %ymm1, %xmm3
	vpaddq	%xmm1, %xmm3, %xmm9
	vpsrldq	$8, %xmm9, %xmm12
	vpaddq	%xmm12, %xmm9, %xmm11
	vmovq	%xmm11, %rdx
	cmpq	%rcx, %r9
	je	.L198
.L196:
	subq	%r9, %rcx
	leaq	-1(%rcx), %r8
	cmpq	$14, %r8
	jbe	.L199
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
	je	.L198
	andq	$-16, %rcx
	addq	%rcx, %rax
.L199:
	xorl	%ecx, %ecx
	cmpb	$32, (%rax)
	leaq	1(%rax), %rdi
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rdi, %rsi
	jnb	.L359
.L198:
	xorl	%esi, %esi
	testb	%r14b, %r14b
	cmovne	%r12, %rsi
	movq	32(%rsp), %r12
	leaq	1(%r11,%rsi), %r14
	cmpq	%r12, %r14
	jnb	.L219
	movq	%r14, %rdi
	notq	%rdi
	addq	%r12, %rdi
	andl	$7, %edi
	cmpb	$32, (%r14)
	jg	.L360
.L255:
	leaq	1(%r14), %rax
	cmpq	32(%rsp), %rax
	jnb	.L219
	testq	%rdi, %rdi
	je	.L218
	cmpq	$1, %rdi
	je	.L303
	cmpq	$2, %rdi
	je	.L304
	cmpq	$3, %rdi
	je	.L305
	cmpq	$4, %rdi
	je	.L306
	cmpq	$5, %rdi
	je	.L307
	cmpq	$6, %rdi
	je	.L308
	cmpb	$32, 1(%r14)
	jg	.L361
.L257:
	incq	%rax
.L308:
	cmpb	$32, (%rax)
	jle	.L260
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
.L260:
	incq	%rax
.L307:
	cmpb	$32, (%rax)
	jg	.L362
.L263:
	incq	%rax
.L306:
	cmpb	$32, (%rax)
	jg	.L363
.L266:
	incq	%rax
.L305:
	cmpb	$32, (%rax)
	jg	.L364
.L269:
	incq	%rax
.L304:
	cmpb	$32, (%rax)
	jle	.L272
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L272:
	incq	%rax
.L303:
	cmpb	$32, (%rax)
	jle	.L275
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L275:
	incq	%rax
	cmpq	32(%rsp), %rax
	jnb	.L219
.L218:
	cmpb	$32, (%rax)
	jle	.L217
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L217:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %r12
	jle	.L278
	xorl	%edi, %edi
	cmpb	$32, -1(%r12)
	setle	%dil
	addq	%rdi, %rdx
.L278:
	cmpb	$32, 1(%r12)
	jle	.L280
	xorl	%eax, %eax
	cmpb	$32, (%r12)
	setle	%al
	addq	%rax, %rdx
.L280:
	cmpb	$32, 2(%r12)
	jle	.L282
	xorl	%ebx, %ebx
	cmpb	$32, 1(%r12)
	setle	%bl
	addq	%rbx, %rdx
.L282:
	cmpb	$32, 3(%r12)
	jle	.L284
	xorl	%r9d, %r9d
	cmpb	$32, 2(%r12)
	setle	%r9b
	addq	%r9, %rdx
.L284:
	cmpb	$32, 4(%r12)
	jle	.L286
	xorl	%r8d, %r8d
	cmpb	$32, 3(%r12)
	setle	%r8b
	addq	%r8, %rdx
.L286:
	cmpb	$32, 5(%r12)
	jle	.L288
	xorl	%r10d, %r10d
	cmpb	$32, 4(%r12)
	setle	%r10b
	addq	%r10, %rdx
.L288:
	cmpb	$32, 6(%r12)
	jle	.L290
	xorl	%r13d, %r13d
	cmpb	$32, 5(%r12)
	setle	%r13b
	addq	%r13, %rdx
.L290:
	leaq	7(%r12), %rax
	cmpq	32(%rsp), %rax
	jb	.L218
.L219:
	subq	%rdx, 24(%rsp)
	movq	%r15, %rsi
	movq	%r11, %rdi
	leaq	(%r15,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm6
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm9
	jmp	.L220
.L360:
	xorl	%eax, %eax
	cmpb	$32, -1(%r14)
	setle	%al
	addq	%rax, %rdx
	jmp	.L255
.L359:
	xorl	%ebx, %ebx
	cmpb	$32, 1(%rax)
	leaq	2(%rax), %r9
	setg	%bl
	addq	%rbx, %rdx
	cmpq	%r9, %rsi
	jb	.L198
	xorl	%r8d, %r8d
	cmpb	$32, 2(%rax)
	leaq	3(%rax), %r10
	setg	%r8b
	addq	%r8, %rdx
	cmpq	%r10, %rsi
	jb	.L198
	xorl	%r13d, %r13d
	cmpb	$32, 3(%rax)
	leaq	4(%rax), %rcx
	setg	%r13b
	addq	%r13, %rdx
	cmpq	%rcx, %rsi
	jb	.L198
	xorl	%edi, %edi
	cmpb	$32, 4(%rax)
	leaq	5(%rax), %rbx
	setg	%dil
	addq	%rdi, %rdx
	cmpq	%rbx, %rsi
	jb	.L198
	xorl	%r9d, %r9d
	cmpb	$32, 5(%rax)
	leaq	6(%rax), %r8
	setg	%r9b
	addq	%r9, %rdx
	cmpq	%r8, %rsi
	jb	.L198
	xorl	%r10d, %r10d
	cmpb	$32, 6(%rax)
	leaq	7(%rax), %r13
	setg	%r10b
	addq	%r10, %rdx
	cmpq	%r13, %rsi
	jb	.L198
	xorl	%ecx, %ecx
	cmpb	$32, 7(%rax)
	leaq	8(%rax), %rdi
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rdi, %rsi
	jb	.L198
	cmpb	$32, 8(%rax)
	jle	.L209
	incq	%rdx
.L209:
	leaq	9(%rax), %rbx
	cmpq	%rbx, %rsi
	jb	.L198
	cmpb	$32, 9(%rax)
	jle	.L210
	incq	%rdx
.L210:
	leaq	10(%rax), %r9
	cmpq	%r9, %rsi
	jb	.L198
	cmpb	$32, 10(%rax)
	jle	.L211
	incq	%rdx
.L211:
	leaq	11(%rax), %r8
	cmpq	%r8, %rsi
	jb	.L198
	cmpb	$32, 11(%rax)
	jle	.L212
	incq	%rdx
.L212:
	leaq	12(%rax), %r10
	cmpq	%r10, %rsi
	jb	.L198
	cmpb	$32, 12(%rax)
	jle	.L213
	incq	%rdx
.L213:
	leaq	13(%rax), %r13
	cmpq	%r13, %rsi
	jb	.L198
	cmpb	$32, 13(%rax)
	jle	.L214
	incq	%rdx
.L214:
	leaq	14(%rax), %rcx
	cmpq	%rcx, %rsi
	jb	.L198
	cmpb	$32, 14(%rax)
	jle	.L198
	incq	%rdx
	jmp	.L198
	.p2align 4
	.p2align 3
.L364:
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
	jmp	.L269
.L363:
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
	jmp	.L266
.L362:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L263
.L222:
	movq	%rdi, 32(%rsp)
	jmp	.L178
.L358:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r11, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm6
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm9
	jmp	.L195
.L226:
	movq	%r11, %rax
	vpxor	%xmm9, %xmm9, %xmm9
	xorl	%r9d, %r9d
	xorl	%edx, %edx
	jmp	.L196
.L361:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L257
	.cfi_endproc
.LFE8957:
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
	.section	.text._ZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,"axG",@progbits,_ZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m,comdat
	.p2align 4
	.weak	_ZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.type	_ZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m, @function
_ZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m:
.LFB8966:
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
	jbe	.L411
	vmovdqa	.LC2(%rip), %ymm9
	movq	%rdi, %r10
	vmovdqa	.LC3(%rip), %ymm5
	.p2align 4
	.p2align 3
.L410:
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
	leaq	199873(%r10,%r13), %rsi
	movq	%rdi, 24(%rsp)
	leaq	266497(%r10,%rdx), %rcx
	movq	%rsi, 32(%rsp)
	movq	%r11, %r8
	vpbroadcastd	%xmm10, %ymm8
	movq	%rcx, 40(%rsp)
	movq	%r11, 16(%rsp)
	movq	%r10, %rcx
	movq	%r10, %rbx
	.p2align 4
	.p2align 3
.L372:
	movq	40(%rsp), %rax
	movq	32(%rsp), %r10
	movq	24(%rsp), %r11
	movq	16(%rsp), %r9
	subq	%rsi, %rax
	subq	%rdi, %r10
	cmpq	%r10, %rax
	cmovg	%r10, %rax
	subq	%r8, %r11
	subq	%rcx, %r9
	cmpq	%r9, %r11
	cmovg	%r9, %r11
	cmpq	%r11, %rax
	cmovg	%r11, %rax
	cmpq	$64, %rax
	jbe	.L543
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
.L371:
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
	vmovdqu	(%r8), %ymm7
	vpshufb	%ymm3, %ymm4, %ymm6
	vpmaddubsw	%ymm9, %ymm6, %ymm10
	vpshufb	%ymm15, %ymm11, %ymm12
	vpcmpgtb	32(%r8), %ymm1, %ymm4
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
	vinserti128	$0x1, 1(%r8,%r13), %ymm7, %ymm6
	incl	%r13d
	salq	$32, %r14
	salq	$4, %r13
	orq	%r14, %rax
	movl	%r11d, %r14d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm12
	movl	%r11d, %r13d
	tzcntq	%rax, %rax
	vmovdqu	1(%r8,%r14), %xmm10
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	movl	%r10d, %r14d
	salq	$4, %r13
	subl	%r11d, %r12d
	movl	%eax, %r11d
	vinserti128	$0x1, 1(%r8,%r14), %ymm10, %ymm11
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm12, %ymm14
	salq	$4, %r12
	subl	%r10d, %r11d
	incl	%eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r12), %xmm13
	salq	$4, %r11
	addq	%rax, %r8
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
	vmovdqu	(%rsi), %ymm4
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
	vpcmpgtb	32(%rsi), %ymm10, %ymm7
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
	vinserti128	$0x1, 1(%rsi,%r13), %ymm4, %ymm4
	orq	%r14, %rax
	incl	%r13d
	movl	%r11d, %r14d
	salq	$4, %r13
	tzcntq	%rax, %rax
	vmovdqu	1(%rsi,%r14), %xmm10
	movl	%r10d, %r14d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm7
	movl	%r11d, %r13d
	vinserti128	$0x1, 1(%rsi,%r14), %ymm10, %ymm6
	subl	%r12d, %r13d
	movl	%r10d, %r12d
	subl	%r11d, %r12d
	salq	$4, %r13
	movl	%eax, %r11d
	incl	%eax
	vinserti128	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm7, %ymm10
	salq	$4, %r12
	subl	%r10d, %r11d
	addq	%rax, %rsi
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
	vmovdqa	.LC47(%rip), %ymm6
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
	vmovdqa	.LC47(%rip), %ymm14
	vpermd	%ymm13, %ymm6, %ymm12
	vpaddd	%ymm4, %ymm3, %ymm10
	vpermd	%ymm10, %ymm14, %ymm13
	vpunpcklqdq	%ymm13, %ymm12, %ymm6
	vpunpckhqdq	%ymm13, %ymm12, %ymm12
	vmovdqu	%xmm6, (%r15,%r9,4)
	vextracti128	$0x1, %ymm6, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+266752(,%r9,4)
	vmovdqa	%xmm12, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region(,%r9,4)
	vextracti128	$0x1, %ymm12, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+533504(,%r9,4)
	addq	$4, %r9
	cmpq	%rdx, %r9
	jne	.L371
	movq	56(%rsp), %rdx
	movq	48(%rsp), %r9
	leaq	(%rdx,%r9,4), %r10
	movq	%r10, 56(%rsp)
	jmp	.L372
	.p2align 4
	.p2align 3
.L543:
	movq	%rbx, %r10
	movq	16(%rsp), %r11
	movq	56(%rsp), %rbx
	movq	%rbx, %r14
	cmpq	%r11, %rcx
	jnb	.L370
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
.L369:
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
	jb	.L369
	vmovdqa	%ymm14, 160(%rsp)
.L370:
	movq	24(%rsp), %r13
	cmpq	$66687, %rbx
	movq	%rbx, %r12
	setbe	%r9b
	cmpq	%r13, %r8
	jnb	.L373
	testb	%r9b, %r9b
	je	.L373
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
	jne	.L524
	vmovdqa	160(%rsp), %ymm7
	jmp	.L374
	.p2align 4
	.p2align 3
.L544:
	vmovdqu	(%r8), %xmm4
	incq	%r12
	vpcmpgtb	%xmm4, %xmm11, %xmm10
	vpsubusb	%xmm1, %xmm4, %xmm6
	vpmovmskb	%xmm10, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
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
	movl	%edx, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r13, %r8
	jnb	.L532
	cmpq	$66688, %r12
	je	.L532
.L374:
	vmovdqu	(%r8), %xmm4
	incq	%r12
	vpcmpgtb	%xmm4, %xmm11, %xmm10
	vpsubusb	%xmm1, %xmm4, %xmm6
	vpmovmskb	%xmm10, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
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
	movl	%edx, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r13, %r8
	jb	.L544
.L532:
	vmovdqa	%ymm7, 160(%rsp)
.L373:
	movq	32(%rsp), %rax
	movq	%rbx, %r13
	cmpq	%rax, %rdi
	jnb	.L376
	testb	%r9b, %r9b
	je	.L376
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
	jne	.L526
	movq	%r12, 192(%rsp)
	vmovdqa	160(%rsp), %ymm7
	movq	%rax, %r12
	jmp	.L377
	.p2align 4
	.p2align 3
.L545:
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
	movl	%edx, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+266748(,%r13,4)
	cmpq	%r12, %rdi
	jnb	.L533
	cmpq	$66688, %r13
	je	.L533
.L377:
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
	movl	%edx, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+266748(,%r13,4)
	cmpq	%r12, %rdi
	jb	.L545
.L533:
	movq	192(%rsp), %r12
	vmovdqa	%ymm7, 160(%rsp)
.L376:
	movq	40(%rsp), %rax
	cmpq	%rax, %rsi
	jnb	.L379
	testb	%r9b, %r9b
	je	.L379
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
	jne	.L528
	vmovdqa	160(%rsp), %ymm7
	movq	%rax, %r9
	jmp	.L380
	.p2align 4
	.p2align 3
.L546:
	vmovdqu	(%rsi), %xmm14
	incq	%rbx
	vpcmpgtb	%xmm14, %xmm15, %xmm10
	vpsubusb	%xmm11, %xmm14, %xmm8
	vpmovmskb	%xmm10, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
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
	movl	%edx, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+533500(,%rbx,4)
	cmpq	%r9, %rsi
	jnb	.L534
	cmpq	$66688, %rbx
	je	.L534
.L380:
	vmovdqu	(%rsi), %xmm14
	incq	%rbx
	vpcmpgtb	%xmm14, %xmm15, %xmm10
	vpsubusb	%xmm11, %xmm14, %xmm8
	vpmovmskb	%xmm10, %edx
	tzcntl	%edx, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rsi
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
	movl	%edx, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+533500(,%rbx,4)
	cmpq	%r9, %rsi
	jb	.L546
.L534:
	vmovdqa	%ymm7, 160(%rsp)
.L379:
	cmpq	%rcx, %r11
	vmovdqa	160(%rsp), %ymm1
	setne	%r11b
	cmpq	%r8, 24(%rsp)
	setne	%cl
	orl	%ecx, %r11d
	cmpq	%rdi, 32(%rsp)
	vpmovmskb	%ymm1, %r9d
	setne	%dil
	andl	$-2147450880, %r9d
	xorl	%eax, %eax
	orl	%edi, %r11d
	cmpq	%rsi, 40(%rsp)
	movzbl	%r11b, %r8d
	setne	%al
	orl	%eax, %r9d
	orl	%r9d, %r8d
	jne	.L547
	vzeroupper
	leaq	(%r15,%r14,4), %rdi
	leaq	0(,%r12,4), %rdx
	movl	$_ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, %esi
	addq	%r14, %r12
	call	memcpy
	leaq	0(,%r13,4), %rdx
	movl	$_ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+266752, %esi
	leaq	(%r15,%r12,4), %rdi
	addq	%r13, %r12
	call	memcpy
	leaq	(%r15,%r12,4), %rdi
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+533504, %esi
	call	memcpy
	vmovdqa	.LC3(%rip), %ymm5
	addq	%rbx, %r12
	vmovdqa	.LC2(%rip), %ymm9
	subq	%r12, 8(%rsp)
	leaq	(%r15,%r12,4), %r15
.L409:
	cmpq	$133312, 8(%rsp)
	jbe	.L541
.L384:
	movq	40(%rsp), %r10
	jmp	.L410
.L528:
	vmovdqu	(%rsi), %xmm14
	incq	%rbx
	vpcmpgtb	%xmm14, %xmm15, %xmm10
	vpsubusb	%xmm11, %xmm14, %xmm8
	vpmovmskb	%xmm10, %eax
	tzcntl	%eax, %r9d
	incl	%r9d
	movq	%r9, %rdx
	addq	%r9, %rsi
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
	movl	%r9d, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+533500(,%rbx,4)
	cmpq	40(%rsp), %rsi
	jnb	.L379
	movq	40(%rsp), %r9
	vmovdqa	%ymm12, %ymm7
	cmpq	$66688, %rbx
	jne	.L380
	jmp	.L379
	.p2align 4
	.p2align 3
.L526:
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
	movl	%edx, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+266748(,%r13,4)
	cmpq	32(%rsp), %rdi
	jnb	.L376
	cmpq	$66688, %r13
	je	.L376
	movq	%r12, 192(%rsp)
	vmovdqa	%ymm13, %ymm7
	movq	32(%rsp), %r12
	jmp	.L377
.L524:
	vmovdqu	(%r8), %xmm4
	vpcmpgtb	%xmm4, %xmm11, %xmm10
	vpsubusb	%xmm1, %xmm4, %xmm12
	vpmovmskb	%xmm10, %r12d
	tzcntl	%r12d, %eax
	leaq	1(%rbx), %r12
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
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
	movl	%edx, _ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	24(%rsp), %r8
	jnb	.L373
	vmovdqa	%ymm6, %ymm7
	cmpq	$66688, %r12
	jne	.L374
	jmp	.L373
.L541:
	vzeroupper
.L367:
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
.L547:
	.cfi_restore_state
	cmpq	40(%rsp), %r10
	jnb	.L548
	movq	40(%rsp), %r13
	movl	$1, %edx
	leaq	-1(%r13), %r14
	cmpq	%r14, %r10
	cmovbe	%r10, %r14
	cmpq	%r10, %r14
	movq	%r14, %r9
	setnb	%r12b
	subq	%r10, %r9
	cmpq	%r10, %r14
	leaq	1(%r9), %rcx
	cmovb	%rdx, %rcx
	cmpq	$30, %r9
	jbe	.L415
	cmpq	%r10, %r14
	jb	.L415
	movq	%rcx, %rsi
	movl	$538976288, %r11d
	vmovq	%rdx, %xmm11
	movq	%r10, %rdi
	andq	$-32, %rsi
	vmovd	%r11d, %xmm3
	vpxor	%xmm2, %xmm2, %xmm2
	vpbroadcastq	%xmm11, %ymm14
	leaq	(%rsi,%r10), %rbx
	vpbroadcastd	%xmm3, %ymm15
.L386:
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
	jne	.L386
	vextracti128	$0x1, %ymm2, %xmm15
	vpaddq	%xmm2, %xmm15, %xmm14
	vpsrldq	$8, %xmm14, %xmm8
	vpaddq	%xmm8, %xmm14, %xmm4
	vmovq	%xmm4, %rdx
	cmpq	%rcx, %rsi
	je	.L387
	vmovdqa	%xmm14, %xmm5
.L385:
	subq	%rsi, %rcx
	leaq	-1(%rcx), %r8
	cmpq	$14, %r8
	jbe	.L388
	vmovdqu	(%r10,%rsi), %xmm6
	movl	$538976288, %eax
	movl	$1, %r13d
	vmovd	%eax, %xmm1
	vpbroadcastd	%xmm1, %xmm3
	vpcmpgtb	%xmm3, %xmm6, %xmm11
	vmovq	%r13, %xmm6
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
	testb	$15, %cl
	je	.L387
	andq	$-16, %rcx
	addq	%rcx, %rdi
.L388:
	xorl	%ecx, %ecx
	cmpb	$32, (%rdi)
	leaq	1(%rdi), %rbx
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rbx, %r14
	jnb	.L549
.L387:
	xorl	%r14d, %r14d
	testb	%r12b, %r12b
	cmovne	%r9, %r14
	movq	40(%rsp), %r9
	leaq	1(%r10,%r14), %r12
	cmpq	%r9, %r12
	jnb	.L408
	movq	%r12, %rdi
	notq	%rdi
	addq	%r9, %rdi
	andl	$7, %edi
	cmpb	$32, (%r12)
	jg	.L550
.L444:
	leaq	1(%r12), %rax
	cmpq	40(%rsp), %rax
	jnb	.L408
	testq	%rdi, %rdi
	je	.L407
	cmpq	$1, %rdi
	je	.L492
	cmpq	$2, %rdi
	je	.L493
	cmpq	$3, %rdi
	je	.L494
	cmpq	$4, %rdi
	je	.L495
	cmpq	$5, %rdi
	je	.L496
	cmpq	$6, %rdi
	je	.L497
	cmpb	$32, 1(%r12)
	jg	.L551
.L446:
	incq	%rax
.L497:
	cmpb	$32, (%rax)
	jle	.L449
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L449:
	incq	%rax
.L496:
	cmpb	$32, (%rax)
	jg	.L552
.L452:
	incq	%rax
.L495:
	cmpb	$32, (%rax)
	jg	.L553
.L455:
	incq	%rax
.L494:
	cmpb	$32, (%rax)
	jg	.L554
.L458:
	incq	%rax
.L493:
	cmpb	$32, (%rax)
	jle	.L461
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L461:
	incq	%rax
.L492:
	cmpb	$32, (%rax)
	jle	.L464
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
.L464:
	incq	%rax
	cmpq	40(%rsp), %rax
	jnb	.L408
.L407:
	cmpb	$32, (%rax)
	jle	.L406
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
.L406:
	cmpb	$32, 1(%rax)
	leaq	1(%rax), %rdi
	jle	.L467
	xorl	%eax, %eax
	cmpb	$32, -1(%rdi)
	setle	%al
	addq	%rax, %rdx
.L467:
	cmpb	$32, 1(%rdi)
	jle	.L469
	xorl	%ebx, %ebx
	cmpb	$32, (%rdi)
	setle	%bl
	addq	%rbx, %rdx
.L469:
	cmpb	$32, 2(%rdi)
	jle	.L471
	xorl	%r11d, %r11d
	cmpb	$32, 1(%rdi)
	setle	%r11b
	addq	%r11, %rdx
.L471:
	cmpb	$32, 3(%rdi)
	jle	.L473
	xorl	%esi, %esi
	cmpb	$32, 2(%rdi)
	setle	%sil
	addq	%rsi, %rdx
.L473:
	cmpb	$32, 4(%rdi)
	jle	.L475
	xorl	%r8d, %r8d
	cmpb	$32, 3(%rdi)
	setle	%r8b
	addq	%r8, %rdx
.L475:
	cmpb	$32, 5(%rdi)
	jle	.L477
	xorl	%r13d, %r13d
	cmpb	$32, 4(%rdi)
	setle	%r13b
	addq	%r13, %rdx
.L477:
	cmpb	$32, 6(%rdi)
	jle	.L479
	xorl	%ecx, %ecx
	cmpb	$32, 5(%rdi)
	setle	%cl
	addq	%rcx, %rdx
.L479:
	leaq	7(%rdi), %rax
	cmpq	40(%rsp), %rax
	jb	.L407
.L408:
	subq	%rdx, 8(%rsp)
	movq	%r15, %rsi
	movq	%r10, %rdi
	leaq	(%r15,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm9
	vmovdqa	.LC3(%rip), %ymm5
	jmp	.L409
.L550:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%r12)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L444
.L549:
	xorl	%r11d, %r11d
	cmpb	$32, 1(%rdi)
	leaq	2(%rdi), %rsi
	setg	%r11b
	addq	%r11, %rdx
	cmpq	%rsi, %r14
	jb	.L387
	xorl	%r8d, %r8d
	cmpb	$32, 2(%rdi)
	leaq	3(%rdi), %rax
	setg	%r8b
	addq	%r8, %rdx
	cmpq	%rax, %r14
	jb	.L387
	xorl	%r13d, %r13d
	cmpb	$32, 3(%rdi)
	leaq	4(%rdi), %rcx
	setg	%r13b
	addq	%r13, %rdx
	cmpq	%rcx, %r14
	jb	.L387
	xorl	%ebx, %ebx
	cmpb	$32, 4(%rdi)
	leaq	5(%rdi), %r11
	setg	%bl
	addq	%rbx, %rdx
	cmpq	%r11, %r14
	jb	.L387
	xorl	%esi, %esi
	cmpb	$32, 5(%rdi)
	leaq	6(%rdi), %r8
	setg	%sil
	addq	%rsi, %rdx
	cmpq	%r8, %r14
	jb	.L387
	xorl	%eax, %eax
	cmpb	$32, 6(%rdi)
	leaq	7(%rdi), %r13
	setg	%al
	addq	%rax, %rdx
	cmpq	%r13, %r14
	jb	.L387
	xorl	%ecx, %ecx
	cmpb	$32, 7(%rdi)
	leaq	8(%rdi), %rbx
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%rbx, %r14
	jb	.L387
	cmpb	$32, 8(%rdi)
	jle	.L398
	incq	%rdx
.L398:
	leaq	9(%rdi), %r11
	cmpq	%r11, %r14
	jb	.L387
	cmpb	$32, 9(%rdi)
	jle	.L399
	incq	%rdx
.L399:
	leaq	10(%rdi), %rsi
	cmpq	%rsi, %r14
	jb	.L387
	cmpb	$32, 10(%rdi)
	jle	.L400
	incq	%rdx
.L400:
	leaq	11(%rdi), %r8
	cmpq	%r8, %r14
	jb	.L387
	cmpb	$32, 11(%rdi)
	jle	.L401
	incq	%rdx
.L401:
	leaq	12(%rdi), %rax
	cmpq	%rax, %r14
	jb	.L387
	cmpb	$32, 12(%rdi)
	jle	.L402
	incq	%rdx
.L402:
	leaq	13(%rdi), %r13
	cmpq	%r13, %r14
	jb	.L387
	cmpb	$32, 13(%rdi)
	jle	.L403
	incq	%rdx
.L403:
	leaq	14(%rdi), %rcx
	cmpq	%rcx, %r14
	jb	.L387
	cmpb	$32, 14(%rdi)
	jle	.L387
	incq	%rdx
	jmp	.L387
	.p2align 4
	.p2align 3
.L554:
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
	jmp	.L458
.L553:
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
	jmp	.L455
.L552:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L452
.L411:
	movq	%rdi, 40(%rsp)
	jmp	.L367
.L548:
	xorl	%edx, %edx
	movq	%r15, %rsi
	movq	%r10, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm9
	vmovdqa	.LC3(%rip), %ymm5
	jmp	.L384
.L415:
	movq	%r10, %rdi
	vpxor	%xmm5, %xmm5, %xmm5
	xorl	%esi, %esi
	xorl	%edx, %edx
	jmp	.L385
.L551:
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rax)
	setle	%r11b
	addq	%r11, %rdx
	jmp	.L446
	.cfi_endproc
.LFE8966:
	.size	_ZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m, .-_ZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.text
	.p2align 4
	.globl	_Z12probe_parse4PcPjm
	.type	_Z12probe_parse4PcPjm, @function
_Z12probe_parse4PcPjm:
.LFB8946:
	.cfi_startproc
	jmp	_ZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_m
	.cfi_endproc
.LFE8946:
	.size	_Z12probe_parse4PcPjm, .-_Z12probe_parse4PcPjm
	.weak	_ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region
	.section	.bss._ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region,"awG",@nobits,_ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region,comdat
	.align 64
	.type	_ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, @gnu_unique_object
	.size	_ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, 800256
_ZZN12qp_parse_ms412parse_tokensILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region:
	.zero	800256
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
	.size	_ZN10qp_fmt_asm6constsE, 896
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
	.set	.LC54,.LC5
	.ident	"GCC: (GNU) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
