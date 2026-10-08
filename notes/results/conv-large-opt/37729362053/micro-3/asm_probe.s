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
	movq	%rdi, %rbx
	andq	$-64, %rsp
	subq	$8392, %rsp
	movl	$0, -56(%rsp)
	testq	%rdx, %rdx
	je	.L3
	vmovdqa	.LC8(%rip), %xmm7
	vmovdqa	.LC2(%rip), %ymm6
	movq	%rsi, %r12
	movq	%rdx, %r13
	vmovdqa	.LC3(%rip), %ymm5
	vmovdqa	.LC4(%rip), %ymm8
	movl	$1, %eax
	movl	$1, %r14d
	vmovdqa	.LC6(%rip), %ymm9
.L2:
	movl	$538976288, %edx
	leaq	2048(%rax), %rdi
	vpbroadcastd	%edx, %ymm10
	.p2align 4
	.p2align 3
.L17:
	leaq	-1(%r14), %rcx
	cmpq	%r13, %rcx
	jnb	.L21
	vpminsb	31(%rbx,%rax), %ymm10, %ymm1
	vpminsb	-1(%rbx,%rax), %ymm10, %ymm0
	leaq	-56(%rsp,%r14,4), %rcx
	vpbroadcastd	%eax, %ymm4
	vpcmpeqb	31(%rbx,%rax), %ymm1, %ymm3
	vpcmpeqb	-1(%rbx,%rax), %ymm0, %ymm2
	vpmovmskb	%ymm3, %r8d
	vpmovmskb	%ymm2, %esi
	salq	$32, %r8
	orq	%rsi, %r8
	popcntq	%r8, %rsi
	.p2align 4
	.p2align 3
.L18:
	tzcntq	%r8, %r15
	blsr	%r8, %r9
	blsr	%r9, %r10
	blsr	%r10, %rdx
	tzcntq	%r10, %r11
	vmovq	%r15, %xmm11
	blsr	%rdx, %r15
	tzcntq	%r15, %r10
	tzcntq	%r9, %r8
	vmovq	%r10, %xmm13
	tzcntq	%rdx, %r9
	blsr	%r15, %rdx
	blsr	%rdx, %r10
	tzcntq	%r10, %r15
	vmovq	%r11, %xmm12
	tzcntq	%rdx, %r11
	vmovq	%r15, %xmm14
	blsr	%r10, %rdx
	tzcntq	%rdx, %r10
	vpinsrq	$1, %r11, %xmm13, %xmm0
	vpinsrq	$1, %r10, %xmm14, %xmm15
	vpinsrq	$1, %r9, %xmm12, %xmm2
	vpinsrq	$1, %r8, %xmm11, %xmm3
	addq	$32, %rcx
	vinserti64x2	$0x1, %xmm15, %ymm0, %ymm1
	vinserti64x2	$0x1, %xmm2, %ymm3, %ymm11
	vinserti64x4	$0x1, %ymm1, %zmm11, %zmm12
	vpmovqd	%zmm12, %ymm13
	vpaddd	%ymm4, %ymm13, %ymm14
	vmovdqu	%ymm14, -32(%rcx)
	blsr	%rdx, %r8
	jne	.L18
	addq	$64, %rax
	addq	%rsi, %r14
	cmpq	%rdi, %rax
	jne	.L17
.L21:
	vmovdqa	.LC9(%rip), %xmm4
	vmovdqa	.LC10(%rip), %xmm15
	movl	$808464432, %edi
	xorl	%esi, %esi
	vpbroadcastd	%edi, %xmm10
	vpbroadcastd	%edi, %ymm2
	.p2align 4
	.p2align 3
.L19:
	cmpq	$3, %r13
	jbe	.L22
.L90:
	leaq	4(%rsi), %rdi
	cmpq	%r14, %rdi
	jnb	.L23
	leaq	1(%rsi), %r8
	movl	-48(%rsp,%rsi,4), %r9d
	movl	-56(%rsp,%rsi,4), %ecx
	movl	-56(%rsp,%r8,4), %r10d
	movq	%r8, -80(%rsp)
	movl	-44(%rsp,%rsi,4), %r8d
	movl	%r9d, %r11d
	subl	%r10d, %r11d
	movl	%r8d, %r15d
	movl	%r10d, %esi
	movl	%r11d, -60(%rsp)
	movl	-56(%rsp,%rdi,4), %r11d
	subl	%r9d, %r15d
	subl	%ecx, %esi
	movl	%r15d, -64(%rsp)
	leal	-1(%rsi), %edx
	subl	$2, %esi
	subl	%r8d, %r11d
	movl	%r11d, -68(%rsp)
	leal	-2(%r15), %r11d
	movl	-68(%rsp), %r15d
	subl	$2, %r15d
	orl	%r15d, %r11d
	movl	-60(%rsp), %r15d
	subl	$2, %r15d
	orl	%r15d, %esi
	orl	%esi, %r11d
	cmpl	$15, %r11d
	ja	.L30
	salq	$4, %rdx
	vmovdqu	(%rbx,%r9), %xmm1
	vmovdqa	_ZN13qp_parse_flat11right_alignE(%rdx), %xmm13
	movl	-60(%rsp), %r9d
	subq	$4, %r13
	movl	-64(%rsp), %edx
	movl	-68(%rsp), %r15d
	vinserti64x2	$0x1, (%rbx,%r8), %ymm1, %ymm11
	addq	$16, %r12
	vmovdqu	(%rbx,%rcx), %xmm14
	vinserti64x2	$0x1, (%rbx,%r10), %ymm14, %ymm0
	movl	$100000000, %r10d
	leal	-1(%r9), %r8d
	leal	-1(%rdx), %r11d
	leal	-1(%r15), %esi
	salq	$4, %rsi
	vpsubusb	%ymm2, %ymm11, %ymm12
	vpsubusb	%ymm2, %ymm0, %ymm3
	salq	$4, %r8
	salq	$4, %r11
	vinserti64x2	$0x1, _ZN13qp_parse_flat11right_alignE(%r8), %ymm13, %ymm14
	vmovdqa	_ZN13qp_parse_flat11right_alignE(%r11), %xmm1
	vinserti64x2	$0x1, _ZN13qp_parse_flat11right_alignE(%rsi), %ymm1, %ymm11
	vpbroadcastd	%r10d, %ymm1
	movq	%rdi, %rsi
	vpshufb	%ymm14, %ymm3, %ymm0
	vpshufb	%ymm11, %ymm12, %ymm12
	vpmaddubsw	%ymm6, %ymm0, %ymm3
	vpmaddubsw	%ymm6, %ymm12, %ymm14
	vpmaddwd	%ymm5, %ymm14, %ymm0
	vpmaddwd	%ymm5, %ymm3, %ymm13
	vpackusdw	%ymm0, %ymm13, %ymm3
	vpmaddwd	%ymm8, %ymm3, %ymm13
	vpmulld	%ymm1, %ymm13, %ymm12
	vpsrlq	$32, %ymm13, %ymm11
	vpaddd	%ymm11, %ymm12, %ymm14
	vpermd	%ymm14, %ymm9, %ymm0
	vmovdqu	%xmm0, -16(%r12)
	cmpq	$3, %r13
	ja	.L90
.L22:
	testq	%r13, %r13
	je	.L91
.L23:
	leaq	1(%rsi), %r9
	cmpq	%r14, %r9
	jnb	.L26
	movl	-56(%rsp,%rsi,4), %ecx
	movq	%r9, %rsi
	movl	%ecx, %edx
	notl	%edx
	addl	-56(%rsp,%r9,4), %edx
.L24:
	testl	%edx, %edx
	je	.L19
	vmovdqu	(%rbx,%rcx), %xmm14
	movl	$16, %edi
	cmpl	%edi, %edx
	cmova	%edi, %edx
	decq	%r13
	addq	$4, %r12
	salq	$4, %rdx
	vpsubusb	%xmm10, %xmm14, %xmm0
	vpshufb	_ZN13qp_parse_flat11right_alignE(%rdx), %xmm0, %xmm1
	vpmaddubsw	%xmm7, %xmm1, %xmm3
	vpmaddwd	%xmm4, %xmm3, %xmm11
	vpackusdw	%xmm11, %xmm11, %xmm12
	vpmaddwd	%xmm15, %xmm12, %xmm13
	vmovq	%xmm13, %r10
	imull	$100000000, %r10d, %ecx
	shrq	$32, %r10
	addl	%ecx, %r10d
	movl	%r10d, -4(%r12)
	jmp	.L19
.L26:
	testq	%rsi, %rsi
	je	.L2
	cmpq	%r14, %rsi
	jnb	.L10
	cmpq	$-16, %rsi
	ja	.L6
	movq	%r14, %rcx
	subq	%rsi, %rcx
	leaq	-1(%rcx), %r11
	cmpq	$14, %r11
	jbe	.L28
	movq	%rcx, %rdi
	leaq	-56(%rsp,%rsi,4), %r10
	xorl	%r9d, %r9d
	shrq	$4, %rdi
	salq	$6, %rdi
	leaq	-64(%rdi), %r8
	shrq	$6, %r8
	incq	%r8
	andl	$7, %r8d
	je	.L8
	cmpq	$1, %r8
	je	.L66
	cmpq	$2, %r8
	je	.L67
	cmpq	$3, %r8
	je	.L68
	cmpq	$4, %r8
	je	.L69
	cmpq	$5, %r8
	je	.L70
	cmpq	$6, %r8
	je	.L71
	vmovdqu32	(%r10), %zmm0
	movl	$64, %r9d
	vmovdqa32	%zmm0, -56(%rsp)
.L71:
	vmovdqu32	(%r10,%r9), %zmm1
	vmovdqa32	%zmm1, -56(%rsp,%r9)
	addq	$64, %r9
.L70:
	vmovdqu32	(%r10,%r9), %zmm3
	vmovdqa32	%zmm3, -56(%rsp,%r9)
	addq	$64, %r9
.L69:
	vmovdqu32	(%r10,%r9), %zmm11
	vmovdqa32	%zmm11, -56(%rsp,%r9)
	addq	$64, %r9
.L68:
	vmovdqu32	(%r10,%r9), %zmm12
	vmovdqa32	%zmm12, -56(%rsp,%r9)
	addq	$64, %r9
.L67:
	vmovdqu32	(%r10,%r9), %zmm13
	vmovdqa32	%zmm13, -56(%rsp,%r9)
	addq	$64, %r9
.L66:
	vmovdqu32	(%r10,%r9), %zmm14
	vmovdqa32	%zmm14, -56(%rsp,%r9)
	addq	$64, %r9
	cmpq	%r9, %rdi
	je	.L85
.L8:
	vmovdqu32	(%r10,%r9), %zmm10
	vmovdqa32	%zmm10, -56(%rsp,%r9)
	vmovdqu32	64(%r10,%r9), %zmm4
	vmovdqa32	%zmm4, 8(%rsp,%r9)
	vmovdqu32	128(%r10,%r9), %zmm15
	vmovdqa32	%zmm15, 72(%rsp,%r9)
	vmovdqu32	192(%r10,%r9), %zmm2
	vmovdqa32	%zmm2, 136(%rsp,%r9)
	vmovdqu32	256(%r10,%r9), %zmm0
	vmovdqa32	%zmm0, 200(%rsp,%r9)
	vmovdqu32	320(%r10,%r9), %zmm1
	vmovdqa32	%zmm1, 264(%rsp,%r9)
	vmovdqu32	384(%r10,%r9), %zmm3
	vmovdqa32	%zmm3, 328(%rsp,%r9)
	vmovdqu32	448(%r10,%r9), %zmm11
	vmovdqa32	%zmm11, 392(%rsp,%r9)
	addq	$512, %r9
	cmpq	%r9, %rdi
	jne	.L8
.L85:
	testb	$15, %cl
	je	.L10
	movq	%rcx, %rdx
	andq	$-16, %rdx
	subq	%rdx, %rcx
	leaq	(%rsi,%rdx), %r15
	leaq	-1(%rcx), %r11
	cmpq	$6, %r11
	jbe	.L29
.L92:
	leaq	(%rsi,%rdx), %rdi
	vmovdqu	-56(%rsp,%rdi,4), %ymm12
	vmovdqa	%ymm12, -56(%rsp,%rdx,4)
	testb	$7, %cl
	je	.L10
	movq	%rcx, %r10
	andq	$-8, %r10
	addq	%r10, %r15
.L12:
	subq	%r10, %rcx
	leaq	-1(%rcx), %r8
	cmpq	$2, %r8
	jbe	.L14
	addq	%rdx, %r10
	leaq	(%rsi,%r10), %rdx
	vmovdqu	-56(%rsp,%rdx,4), %xmm13
	vmovdqa	%xmm13, -56(%rsp,%r10,4)
	testb	$3, %cl
	je	.L10
	andq	$-4, %rcx
	addq	%rcx, %r15
.L14:
	movl	-56(%rsp,%r15,4), %r9d
	movq	%r15, %rcx
	leaq	1(%r15), %r11
	subq	%rsi, %rcx
	movl	%r9d, -56(%rsp,%rcx,4)
	cmpq	%r14, %r11
	jnb	.L10
	movl	-56(%rsp,%r11,4), %r10d
	addq	$2, %r15
	subq	%rsi, %r11
	movl	%r10d, -56(%rsp,%r11,4)
	cmpq	%r14, %r15
	jnb	.L10
	movl	-56(%rsp,%r15,4), %edi
	subq	%rsi, %r15
	movl	%edi, -56(%rsp,%r15,4)
.L10:
	subq	%rsi, %r14
	jmp	.L2
.L91:
	movl	-56(%rsp,%rsi,4), %eax
	leaq	(%rbx,%rax), %rbx
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
.L30:
	.cfi_restore_state
	movq	-80(%rsp), %rsi
	jmp	.L24
.L6:
	movl	-56(%rsp,%rsi,4), %r15d
	subq	%rsi, %r14
	movl	%r15d, -56(%rsp)
	jmp	.L2
.L28:
	xorl	%edx, %edx
	movq	%rsi, %r15
	subq	%rdx, %rcx
	leaq	-1(%rcx), %r11
	cmpq	$6, %r11
	ja	.L92
.L29:
	xorl	%r10d, %r10d
	jmp	.L12
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
	movq	%rdx, %r11
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
	movq	%rsi, 120(%rsp)
	cmpq	$133312, %rdx
	jbe	.L130
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	movq	%rdi, 40(%rsp)
	movq	%rdi, %r15
	vmovdqa	.LC4(%rip), %ymm12
	.p2align 4
	.p2align 3
.L129:
	movl	$538976288, %eax
	vmovdqa	.LC14(%rip), %ymm13
	movq	$0, 112(%rsp)
	movq	%r11, 32(%rsp)
	vpbroadcastd	%eax, %ymm10
	vpminsb	199872(%r15), %ymm10, %ymm6
	vpminsb	66624(%r15), %ymm10, %ymm0
	vpminsb	133248(%r15), %ymm10, %ymm2
	vpminsb	266496(%r15), %ymm10, %ymm8
	vpcmpeqb	199872(%r15), %ymm6, %ymm7
	vpcmpeqb	66624(%r15), %ymm0, %ymm1
	vpxor	%xmm6, %xmm6, %xmm6
	vpcmpeqb	133248(%r15), %ymm2, %ymm3
	vpcmpeqb	266496(%r15), %ymm8, %ymm9
	vpmovmskb	%ymm1, %edx
	vpmovmskb	%ymm3, %esi
	vpmovmskb	%ymm7, %r12d
	tzcntl	%edx, %ecx
	vpmovmskb	%ymm9, %eax
	tzcntl	%esi, %edi
	tzcntl	%r12d, %r13d
	movl	%ecx, %ebx
	tzcntl	%eax, %edx
	movl	%edi, %r8d
	movl	%r13d, %r14d
	leaq	66625(%r15,%rbx), %r9
	movl	%edx, %ecx
	leaq	133249(%r15,%r8), %r10
	leaq	199873(%r15,%r14), %r14
	movq	%r9, 64(%rsp)
	leaq	266497(%r15,%rcx), %rbx
	movq	%r10, 56(%rsp)
	movq	%r14, 48(%rsp)
	movl	$808464432, %esi
	movq	%rbx, 72(%rsp)
	vpbroadcastd	%esi, %ymm11
	.p2align 4
	.p2align 3
.L100:
	movq	72(%rsp), %r11
	movq	48(%rsp), %rdi
	movq	56(%rsp), %r8
	movq	64(%rsp), %r12
	subq	%r14, %r11
	subq	%r10, %rdi
	cmpq	%rdi, %r11
	cmovg	%rdi, %r11
	subq	%r9, %r8
	subq	%r15, %r12
	cmpq	%r12, %r8
	cmovg	%r12, %r8
	cmpq	%r8, %r11
	cmovg	%r8, %r11
	cmpq	$64, %r11
	jbe	.L318
	vpminsb	(%r15), %ymm10, %ymm14
	vpminsb	32(%r15), %ymm10, %ymm0
	movabsq	$1135184250689818561, %rax
	movq	%r15, 128(%rsp)
	mulq	%r11
	movq	%r9, 152(%rsp)
	movq	%r10, 176(%rsp)
	movq	%r14, 200(%rsp)
	shrq	$2, %rdx
	vpcmpeqb	(%r15), %ymm14, %ymm15
	vpminsb	(%r9), %ymm10, %ymm14
	vpcmpeqb	32(%r15), %ymm0, %ymm1
	vpminsb	32(%r9), %ymm10, %ymm0
	vpmovmskb	%ymm1, %eax
	movq	%rdx, %r13
	vpmovmskb	%ymm15, %ecx
	salq	$32, %rax
	blsr	%ecx, %ebx
	blsr	%ebx, %esi
	blsr	%esi, %r8d
	tzcntl	%ecx, %r11d
	movl	%r8d, %r12d
	tzcntl	%esi, %edi
	vpcmpeqb	(%r9), %ymm14, %ymm15
	orq	%r12, %rax
	vpcmpeqb	32(%r9), %ymm0, %ymm1
	vmovd	%r11d, %xmm3
	tzcntl	%ebx, %r11d
	vpmovmskb	%ymm15, %ebx
	tzcntq	%rax, %rdx
	vmovd	%edi, %xmm2
	blsr	%ebx, %esi
	tzcntl	%ebx, %r8d
	vpmovmskb	%ymm1, %ebx
	leal	1(%rdx), %ecx
	salq	$32, %rbx
	blsr	%esi, %edi
	vpinsrd	$1, %edx, %xmm2, %xmm7
	vpinsrd	$1, %r11d, %xmm3, %xmm8
	movl	%edx, 96(%rsp)
	leaq	(%r15,%rcx), %rax
	blsr	%edi, %edx
	movl	%edx, %ecx
	vpunpcklqdq	%xmm7, %xmm8, %xmm9
	tzcntl	%edi, %r12d
	orq	%rbx, %rcx
	vpminsb	(%r10), %ymm10, %ymm0
	vmovd	%r12d, %xmm8
	vmovdqu	%xmm9, 136(%rsp)
	vmovd	%r8d, %xmm9
	tzcntl	%esi, %r8d
	tzcntq	%rcx, %rsi
	vpinsrd	$1, %esi, %xmm8, %xmm7
	vpinsrd	$1, %r8d, %xmm9, %xmm14
	movl	%esi, 100(%rsp)
	incl	%esi
	vpunpcklqdq	%xmm7, %xmm14, %xmm15
	vpminsb	32(%r10), %ymm10, %ymm7
	leaq	(%r9,%rsi), %rdx
	vmovdqa	%xmm15, 160(%rsp)
	vpcmpeqb	(%r10), %ymm0, %ymm1
	vpmovmskb	%ymm1, %r12d
	tzcntl	%r12d, %ecx
	blsr	%r12d, %edi
	tzcntl	%edi, %ebx
	blsr	%edi, %esi
	vmovd	%ecx, %xmm25
	tzcntl	%esi, %r12d
	blsr	%esi, %edi
	movl	%edi, %esi
	vpcmpeqb	32(%r10), %ymm7, %ymm14
	vmovd	%r12d, %xmm7
	vpinsrd	$1, %ebx, %xmm25, %xmm0
	movl	%ebx, 104(%rsp)
	vpmovmskb	%ymm14, %ecx
	vpminsb	(%r14), %ymm10, %ymm14
	salq	$32, %rcx
	orq	%rcx, %rsi
	tzcntq	%rsi, %r12
	vpinsrd	$1, %r12d, %xmm7, %xmm15
	movl	%r12d, 92(%rsp)
	incl	%r12d
	vpunpcklqdq	%xmm15, %xmm0, %xmm1
	vpminsb	32(%r14), %ymm10, %ymm0
	vpcmpeqb	(%r14), %ymm14, %ymm15
	leaq	(%r10,%r12), %rcx
	vpmovmskb	%ymm15, %esi
	vmovdqu	%xmm1, 184(%rsp)
	blsr	%esi, %edi
	blsr	%edi, %ebx
	tzcntl	%esi, %r12d
	tzcntl	%ebx, %esi
	vmovd	%r12d, %xmm22
	vmovd	%esi, %xmm29
	blsr	%ebx, %ebx
	movl	%ebx, %esi
	tzcntl	%edi, %edi
	vpinsrd	$1, %edi, %xmm22, %xmm15
	vpcmpeqb	32(%r14), %ymm0, %ymm1
	vpmovmskb	%ymm1, %r12d
	salq	$32, %r12
	orq	%r12, %rsi
	tzcntq	%rsi, %rbx
	vpinsrd	$1, %ebx, %xmm29, %xmm14
	movl	%ebx, 88(%rsp)
	incl	%ebx
	vpunpcklqdq	%xmm14, %xmm15, %xmm0
	leaq	(%r14,%rbx), %rsi
	movq	%r13, %rbx
	vmovdqa	%xmm0, 208(%rsp)
	decq	%rbx
	je	.L319
	movq	112(%rsp), %r12
	movq	%r13, 104(%rsp)
	movl	$100000000, %r9d
	xorl	%r11d, %r11d
	vmovdqa64	%ymm5, %ymm16
	vmovdqa64	%ymm4, %ymm28
	vmovdqa64	%ymm12, %ymm17
	vmovdqa32	%ymm13, %ymm18
	vpbroadcastd	%r9d, %ymm14
	.p2align 4
	.p2align 3
.L98:
	vpminsb	(%rax), %ymm10, %ymm2
	vpminsb	32(%rax), %ymm10, %ymm8
	movq	%r11, %r15
	xorq	$1, %r11
	leaq	(%r11,%r11,2), %r10
	salq	$5, %r10
	movq	%rax, 128(%rsp,%r10)
	vpcmpeqb	(%rax), %ymm2, %ymm3
	vpcmpeqb	32(%rax), %ymm8, %ymm9
	vpmovmskb	%ymm3, %r13d
	blsr	%r13d, %r14d
	blsr	%r14d, %r9d
	tzcntl	%r9d, %edi
	tzcntl	%r13d, %r8d
	vmovd	%edi, %xmm7
	vpmovmskb	%ymm9, %edi
	tzcntl	%r14d, %r13d
	blsr	%r9d, %r14d
	salq	$32, %rdi
	vmovd	%r8d, %xmm15
	movl	%r14d, %r9d
	vpinsrd	$1, %r13d, %xmm15, %xmm0
	orq	%r9, %rdi
	movq	%r11, %r9
	tzcntq	%rdi, %r14
	negq	%r9
	vpinsrd	$1, %r14d, %xmm7, %xmm1
	andl	$96, %r9d
	incl	%r14d
	vpunpcklqdq	%xmm1, %xmm0, %xmm2
	addq	%r14, %rax
	vmovdqu	%xmm2, 136(%rsp,%r9)
	vpminsb	(%rdx), %ymm10, %ymm3
	vpminsb	32(%rdx), %ymm10, %ymm9
	movq	%rdx, 152(%rsp,%r10)
	vpcmpeqb	(%rdx), %ymm3, %ymm8
	vpcmpeqb	32(%rdx), %ymm9, %ymm7
	vpmovmskb	%ymm8, %r13d
	tzcntl	%r13d, %edi
	blsr	%r13d, %r14d
	tzcntl	%r14d, %r13d
	blsr	%r14d, %r8d
	vmovd	%edi, %xmm1
	vpmovmskb	%ymm7, %edi
	tzcntl	%r8d, %r14d
	blsr	%r8d, %r8d
	salq	$32, %rdi
	vmovd	%r14d, %xmm15
	vpinsrd	$1, %r13d, %xmm1, %xmm0
	movl	%r8d, %r14d
	orq	%rdi, %r14
	tzcntq	%r14, %r8
	vpinsrd	$1, %r8d, %xmm15, %xmm2
	leal	1(%r8), %r13d
	vpunpcklqdq	%xmm2, %xmm0, %xmm3
	addq	%r13, %rdx
	vmovdqa	%xmm3, 160(%rsp,%r9)
	vpminsb	(%rcx), %ymm10, %ymm8
	vpminsb	32(%rcx), %ymm10, %ymm7
	movq	%rcx, 176(%rsp,%r10)
	vpcmpeqb	(%rcx), %ymm8, %ymm9
	vpcmpeqb	32(%rcx), %ymm7, %ymm15
	vpmovmskb	%ymm9, %edi
	tzcntl	%edi, %r13d
	blsr	%edi, %r14d
	blsr	%r14d, %r8d
	tzcntl	%r8d, %edi
	vmovd	%edi, %xmm2
	vpmovmskb	%ymm15, %edi
	blsr	%r8d, %r8d
	tzcntl	%r14d, %r14d
	salq	$32, %rdi
	vmovd	%r13d, %xmm1
	movl	%r8d, %r13d
	vpinsrd	$1, %r14d, %xmm1, %xmm0
	orq	%rdi, %r13
	tzcntq	%r13, %r8
	vpinsrd	$1, %r8d, %xmm2, %xmm3
	leal	1(%r8), %r14d
	vpunpcklqdq	%xmm3, %xmm0, %xmm8
	addq	%r14, %rcx
	vmovdqu	%xmm8, 184(%rsp,%r9)
	vpminsb	(%rsi), %ymm10, %ymm9
	vpminsb	32(%rsi), %ymm10, %ymm15
	movq	%rsi, 200(%rsp,%r10)
	vpcmpeqb	(%rsi), %ymm9, %ymm7
	vpcmpeqb	32(%rsi), %ymm15, %ymm2
	vpmovmskb	%ymm7, %r13d
	tzcntl	%r13d, %edi
	blsr	%r13d, %r14d
	blsr	%r14d, %r8d
	tzcntl	%r14d, %r13d
	tzcntl	%r8d, %r10d
	blsr	%r8d, %r14d
	vpmovmskb	%ymm2, %r8d
	vmovd	%edi, %xmm0
	salq	$32, %r8
	vmovd	%r10d, %xmm1
	vpinsrd	$1, %r13d, %xmm0, %xmm8
	movl	%r14d, %r10d
	orq	%r10, %r8
	tzcntq	%r8, %r14
	vpinsrd	$1, %r14d, %xmm1, %xmm3
	leal	1(%r14), %edi
	vpunpcklqdq	%xmm3, %xmm8, %xmm9
	addq	%rdi, %rsi
	vmovdqa	%xmm9, 208(%rsp,%r9)
	leaq	(%r15,%r15,2), %r15
	salq	$5, %r15
	leaq	128(%rsp,%r15), %r15
	movq	(%r15), %rdi
	movl	16(%r15), %r8d
	movl	12(%r15), %r14d
	movl	8(%r15), %r13d
	vmovdqu	1(%rdi,%r14), %xmm2
	movq	%r14, %r10
	movl	%r8d, %r14d
	vmovdqu	(%rdi), %xmm7
	vinserti64x2	$0x1, 1(%rdi,%r14), %ymm2, %ymm3
	vinserti64x2	$0x1, 1(%rdi,%r13), %ymm7, %ymm15
	leal	1(%r13), %edi
	movl	%r10d, %r13d
	subl	8(%r15), %r13d
	movl	%r8d, %r14d
	subl	%r10d, %r14d
	movl	20(%r15), %r10d
	salq	$4, %rdi
	salq	$4, %r13
	vpsubusb	%ymm11, %ymm15, %ymm8
	vpsubusb	%ymm11, %ymm3, %ymm15
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rdi), %xmm1
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm1, %ymm20
	movq	24(%r15), %rdi
	subl	%r8d, %r10d
	movl	40(%r15), %r8d
	movl	32(%r15), %r13d
	salq	$4, %r14
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm0
	movl	36(%r15), %r14d
	vpshufb	%ymm20, %ymm8, %ymm9
	vmovdqu	(%rdi), %xmm8
	vinserti64x2	$0x1, 1(%rdi,%r13), %ymm8, %ymm19
	salq	$4, %r10
	vpmaddubsw	%ymm5, %ymm9, %ymm7
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm0, %ymm24
	vpmaddwd	%ymm4, %ymm7, %ymm1
	vmovdqu	1(%rdi,%r14), %xmm9
	movq	%r14, %r10
	movl	%r8d, %r14d
	vinserti64x2	$0x1, 1(%rdi,%r14), %ymm9, %ymm7
	leal	1(%r13), %edi
	movl	%r10d, %r13d
	subl	32(%r15), %r13d
	movl	%r8d, %r14d
	vpsubusb	%ymm11, %ymm19, %ymm21
	subl	%r10d, %r14d
	movl	44(%r15), %r10d
	salq	$4, %rdi
	vpshufb	%ymm24, %ymm15, %ymm2
	vpternlogq	$254, %ymm6, %ymm24, %ymm20
	salq	$4, %r13
	vpmaddubsw	%ymm5, %ymm2, %ymm3
	vmovdqa64	%ymm20, %ymm6
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rdi), %xmm15
	subl	%r8d, %r10d
	movq	48(%r15), %rdi
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm15, %ymm22
	movl	56(%r15), %r13d
	vpmaddwd	%ymm4, %ymm3, %ymm0
	vpsubusb	%ymm11, %ymm7, %ymm3
	salq	$4, %r14
	salq	$4, %r10
	vpshufb	%ymm22, %ymm21, %ymm25
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm2
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm2, %ymm23
	vmovdqu	(%rdi), %xmm7
	vpmaddubsw	%ymm5, %ymm25, %ymm26
	vinserti64x2	$0x1, 1(%rdi,%r13), %ymm7, %ymm15
	movl	64(%r15), %r8d
	movl	60(%r15), %r14d
	vpmaddwd	%ymm4, %ymm26, %ymm29
	vpackusdw	%ymm29, %ymm1, %ymm1
	vpmaddwd	%ymm12, %ymm1, %ymm20
	vpshufb	%ymm23, %ymm3, %ymm8
	vmovdqu	1(%rdi,%r14), %xmm2
	movq	%r14, %r10
	movl	%r8d, %r14d
	vpmaddubsw	%ymm5, %ymm8, %ymm9
	vpsubusb	%ymm11, %ymm15, %ymm15
	vpternlogq	$254, %ymm23, %ymm22, %ymm6
	vpmaddwd	%ymm4, %ymm9, %ymm8
	vinserti64x2	$0x1, 1(%rdi,%r14), %ymm2, %ymm9
	movl	%r8d, %r14d
	leal	1(%r13), %edi
	subl	%r10d, %r14d
	movl	%r10d, %r13d
	movl	68(%r15), %r10d
	subl	56(%r15), %r13d
	vpackusdw	%ymm8, %ymm0, %ymm0
	salq	$4, %r14
	vpmaddwd	%ymm12, %ymm0, %ymm8
	salq	$4, %rdi
	vpsubusb	%ymm11, %ymm9, %ymm9
	subl	%r8d, %r10d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm7
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rdi), %xmm3
	movl	88(%r15), %r8d
	movq	72(%r15), %rdi
	movl	84(%r15), %r14d
	salq	$4, %r10
	salq	$4, %r13
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm7, %ymm31
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm3, %ymm30
	movl	80(%r15), %r13d
	movq	%r14, %r10
	vpshufb	%ymm31, %ymm9, %ymm7
	vpshufb	%ymm30, %ymm15, %ymm2
	vmovdqu	(%rdi), %xmm9
	vinserti64x2	$0x1, 1(%rdi,%r13), %ymm9, %ymm9
	vpmaddubsw	%ymm5, %ymm7, %ymm15
	vmovdqu	1(%rdi,%r14), %xmm7
	movl	%r8d, %r14d
	vpmaddubsw	%ymm5, %ymm2, %ymm3
	vinserti64x2	$0x1, 1(%rdi,%r14), %ymm7, %ymm7
	leal	1(%r13), %edi
	movl	%r10d, %r13d
	subl	80(%r15), %r13d
	movl	92(%r15), %r15d
	movl	%r8d, %r14d
	vpmaddwd	%ymm4, %ymm15, %ymm2
	vpmaddwd	%ymm4, %ymm3, %ymm3
	subl	%r10d, %r14d
	vpternlogq	$254, %ymm31, %ymm30, %ymm6
	salq	$4, %rdi
	vpsubusb	%ymm11, %ymm9, %ymm9
	salq	$4, %r13
	vpsubusb	%ymm11, %ymm7, %ymm7
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rdi), %xmm15
	subl	%r8d, %r15d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm15, %ymm27
	movq	120(%rsp), %r8
	salq	$4, %r14
	salq	$4, %r15
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r15), %ymm15, %ymm19
	vpshufb	%ymm27, %ymm9, %ymm15
	vpmaddubsw	%ymm5, %ymm15, %ymm9
	vpmaddwd	%ymm4, %ymm9, %ymm15
	vpackusdw	%ymm15, %ymm3, %ymm3
	vpmaddwd	%ymm12, %ymm3, %ymm15
	vshufps	$221, %ymm15, %ymm20, %ymm24
	vpshufb	%ymm19, %ymm7, %ymm9
	vpternlogq	$254, %ymm19, %ymm27, %ymm6
	vpmaddubsw	%ymm5, %ymm9, %ymm7
	vpmaddwd	%ymm4, %ymm7, %ymm9
	vshufps	$136, %ymm15, %ymm20, %ymm7
	vpmulld	%ymm14, %ymm7, %ymm1
	vpackusdw	%ymm9, %ymm2, %ymm2
	vpmaddwd	%ymm12, %ymm2, %ymm9
	vshufps	$136, %ymm9, %ymm8, %ymm7
	vpaddd	%ymm24, %ymm1, %ymm3
	vpmulld	%ymm14, %ymm7, %ymm1
	vpermd	%ymm3, %ymm13, %ymm15
	vshufps	$221, %ymm9, %ymm8, %ymm3
	vpaddd	%ymm3, %ymm1, %ymm0
	vpermd	%ymm0, %ymm13, %ymm8
	vpunpcklqdq	%ymm8, %ymm15, %ymm2
	vpunpckhqdq	%ymm8, %ymm15, %ymm15
	vmovdqu	%xmm2, (%r8,%r12,4)
	vmovdqa	%xmm15, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region(,%r12,4)
	vextracti64x2	$0x1, %ymm2, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266752(,%r12,4)
	vextracti64x2	$0x1, %ymm15, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533504(,%r12,4)
	addq	$4, %r12
	decq	%rbx
	jne	.L98
	leaq	128(%rsp,%r9), %r9
	movq	104(%rsp), %r12
	movq	112(%rsp), %rbx
	movl	44(%r9), %edi
	movl	20(%r9), %r13d
	movl	60(%r9), %r10d
	movl	68(%r9), %r14d
	movq	(%r9), %r15
	vmovd	56(%r9), %xmm25
	vmovd	40(%r9), %xmm8
	vmovd	32(%r9), %xmm9
	movl	36(%r9), %r8d
	vmovd	8(%r9), %xmm3
	vmovd	16(%r9), %xmm2
	leaq	-4(%rbx,%r12,4), %r11
	vmovd	64(%r9), %xmm7
	vmovd	80(%r9), %xmm22
	movq	48(%r9), %r12
	vmovd	88(%r9), %xmm29
	movq	%r11, 112(%rsp)
	movl	%edi, 100(%rsp)
	movl	12(%r9), %r11d
	movl	%r13d, 96(%rsp)
	movq	72(%r9), %rbx
	movq	24(%r9), %r13
	movl	84(%r9), %edi
	movl	92(%r9), %r9d
	movl	%r10d, 104(%rsp)
	movl	%r14d, 92(%rsp)
	movq	%r15, 80(%rsp)
	movq	%rsi, %r14
	movq	%rcx, %r10
	movq	%rax, %r15
	movl	%r9d, 88(%rsp)
	movq	%rdx, %r9
.L99:
	movq	80(%rsp), %rcx
	vmovd	%xmm3, %eax
	movl	%r11d, %edx
	vmovd	%xmm2, %esi
	vmovdqu	(%rcx), %xmm14
	vinserti64x2	$0x1, 1(%rcx,%rax), %ymm14, %ymm1
	incl	%eax
	vmovdqu	1(%rcx,%rdx), %xmm0
	salq	$4, %rax
	vmovd	%xmm2, %edx
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm14
	subl	%r11d, %edx
	movl	%r11d, %eax
	movl	96(%rsp), %r11d
	vinserti64x2	$0x1, 1(%rcx,%rsi), %ymm0, %ymm15
	vmovd	%xmm2, %esi
	vmovd	%xmm3, %ecx
	salq	$4, %rdx
	vpsubusb	%ymm11, %ymm1, %ymm2
	subl	%esi, %r11d
	subl	%ecx, %eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rdx), %xmm3
	movl	%r8d, %ecx
	salq	$4, %r11
	vpsubusb	%ymm11, %ymm15, %ymm15
	vmovd	%xmm8, %edx
	vmovd	%xmm8, %esi
	salq	$4, %rax
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm3, %ymm23
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm14, %ymm30
	vmovd	%xmm9, %eax
	subl	%r8d, %esi
	vmovd	%xmm9, %r11d
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rsi), %xmm9
	vmovd	%xmm25, %esi
	vpshufb	%ymm23, %ymm15, %ymm14
	vpshufb	%ymm30, %ymm2, %ymm1
	vmovdqu	0(%r13), %xmm2
	vinserti64x2	$0x1, 1(%r13,%rax), %ymm2, %ymm15
	vpmaddubsw	%ymm16, %ymm14, %ymm3
	vmovdqu	1(%r13,%rcx), %xmm14
	vinserti64x2	$0x1, 1(%r13,%rdx), %ymm14, %ymm2
	movl	%r8d, %r13d
	movl	100(%rsp), %r8d
	incl	%eax
	vpmaddubsw	%ymm16, %ymm1, %ymm0
	subl	%r11d, %r13d
	vpmaddwd	%ymm28, %ymm0, %ymm1
	vpmaddwd	%ymm28, %ymm3, %ymm0
	movl	104(%rsp), %edx
	vmovd	%xmm25, %ecx
	vmovd	%xmm7, %r11d
	vpternlogq	$254, %ymm6, %ymm23, %ymm30
	salq	$4, %rax
	vmovdqa64	%ymm30, %ymm6
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm3
	vmovd	%xmm8, %eax
	vpsubusb	%ymm11, %ymm2, %ymm2
	vpsubusb	%ymm11, %ymm15, %ymm8
	subl	%eax, %r8d
	movl	92(%rsp), %eax
	salq	$4, %r8
	salq	$4, %r13
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r8), %ymm9, %ymm31
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm3, %ymm21
	vmovd	%xmm7, %r8d
	vmovd	%xmm22, %r13d
	subl	%edx, %r8d
	salq	$4, %r8
	vpshufb	%ymm31, %ymm2, %ymm3
	vpshufb	%ymm21, %ymm8, %ymm15
	vmovdqu	(%r12), %xmm8
	vpternlogq	$254, %ymm31, %ymm21, %ymm6
	vpmaddubsw	%ymm16, %ymm3, %ymm9
	vinserti64x2	$0x1, 1(%r12,%rcx), %ymm8, %ymm3
	incl	%ecx
	vpmaddubsw	%ymm16, %ymm15, %ymm14
	salq	$4, %rcx
	vpmaddwd	%ymm28, %ymm14, %ymm14
	vpmaddwd	%ymm28, %ymm9, %ymm9
	vmovdqu	1(%r12,%rdx), %xmm15
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm8
	vinserti64x2	$0x1, 1(%r12,%r11), %ymm15, %ymm2
	vmovd	%xmm7, %ecx
	movl	%edx, %r12d
	subl	%ecx, %eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r8), %xmm15
	movl	%edi, %edx
	subl	%esi, %r12d
	vmovd	%xmm29, %r11d
	vpackusdw	%ymm14, %ymm1, %ymm1
	vpackusdw	%ymm9, %ymm0, %ymm0
	salq	$4, %r12
	vpsubusb	%ymm11, %ymm3, %ymm7
	vmovd	%xmm29, %esi
	vmovd	%xmm29, %r8d
	vpmaddwd	%ymm17, %ymm1, %ymm14
	salq	$4, %rax
	vpsubusb	%ymm11, %ymm2, %ymm2
	vpmaddwd	%ymm17, %ymm0, %ymm9
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm8, %ymm27
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm15, %ymm26
	subl	%edi, %esi
	movl	%edi, %r12d
	salq	$4, %rsi
	movl	$100000000, %eax
	vpshufb	%ymm27, %ymm7, %ymm3
	vpshufb	%ymm26, %ymm2, %ymm15
	vpternlogq	$254, %ymm26, %ymm27, %ymm6
	vpmaddubsw	%ymm16, %ymm15, %ymm7
	vpmaddubsw	%ymm16, %ymm3, %ymm8
	vmovdqu	1(%rbx,%rdx), %xmm15
	vpmaddwd	%ymm28, %ymm8, %ymm3
	vpmaddwd	%ymm28, %ymm7, %ymm2
	vmovdqu	(%rbx), %xmm8
	vinserti64x2	$0x1, 1(%rbx,%r13), %ymm8, %ymm8
	vinserti64x2	$0x1, 1(%rbx,%r11), %ymm15, %ymm7
	movl	88(%rsp), %edi
	vmovd	%xmm22, %ebx
	incl	%r13d
	subl	%ebx, %r12d
	movq	120(%rsp), %rcx
	salq	$4, %r13
	salq	$4, %r12
	vpsubusb	%ymm11, %ymm8, %ymm8
	vpsubusb	%ymm11, %ymm7, %ymm7
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r13), %xmm15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm15, %ymm19
	subl	%r8d, %edi
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rsi), %xmm15
	salq	$4, %rdi
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rdi), %ymm15, %ymm20
	movq	112(%rsp), %r13
	vpshufb	%ymm19, %ymm8, %ymm15
	vpmaddubsw	%ymm16, %ymm15, %ymm8
	vpmaddwd	%ymm28, %ymm8, %ymm15
	vpackusdw	%ymm15, %ymm3, %ymm3
	vpshufb	%ymm20, %ymm7, %ymm8
	vpternlogq	$254, %ymm20, %ymm19, %ymm6
	vpmaddwd	%ymm17, %ymm3, %ymm15
	vpmaddubsw	%ymm16, %ymm8, %ymm7
	vpbroadcastd	%eax, %ymm8
	vshufps	$136, %ymm15, %ymm14, %ymm1
	vpmaddwd	%ymm28, %ymm7, %ymm7
	vshufps	$221, %ymm15, %ymm14, %ymm14
	vpmulld	%ymm8, %ymm1, %ymm3
	vpackusdw	%ymm7, %ymm2, %ymm2
	vpmaddwd	%ymm17, %ymm2, %ymm7
	vpaddd	%ymm14, %ymm3, %ymm15
	vshufps	$136, %ymm7, %ymm9, %ymm3
	vshufps	$221, %ymm7, %ymm9, %ymm14
	vpmulld	%ymm8, %ymm3, %ymm8
	vpermd	%ymm15, %ymm18, %ymm1
	vpaddd	%ymm14, %ymm8, %ymm15
	vpermd	%ymm15, %ymm18, %ymm0
	vpunpcklqdq	%ymm0, %ymm1, %ymm9
	vpunpckhqdq	%ymm0, %ymm1, %ymm2
	vmovdqu	%xmm9, (%rcx,%r13,4)
	vmovdqa	%xmm2, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region(,%r13,4)
	vextracti64x2	$0x1, %ymm9, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266752(,%r13,4)
	vextracti64x2	$0x1, %ymm2, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533504(,%r13,4)
	addq	$4, %r13
	movq	%r13, 112(%rsp)
	jmp	.L100
	.p2align 4
	.p2align 3
.L318:
	movq	32(%rsp), %r11
	movq	112(%rsp), %r13
	cmpq	64(%rsp), %r15
	jnb	.L97
	vmovdqa	.LC8(%rip), %xmm4
	vmovdqa	.LC9(%rip), %xmm5
	movq	64(%rsp), %rbx
	movl	$538976288, %edx
	vmovdqa	.LC10(%rip), %xmm12
	movq	120(%rsp), %rsi
	movl	$808464432, %r12d
	vpbroadcastd	%edx, %xmm10
	vpbroadcastd	%r12d, %xmm13
	.p2align 4
	.p2align 3
.L96:
	vmovdqu	(%r15), %xmm11
	incq	%r13
	vpminsb	%xmm10, %xmm11, %xmm7
	vpsubusb	%xmm13, %xmm11, %xmm15
	vpcmpeqb	%xmm7, %xmm11, %xmm3
	vpmovmskb	%xmm3, %edi
	tzcntl	%edi, %r8d
	incl	%r8d
	movq	%r8, %rax
	addq	%r8, %r15
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm14
	vpshufb	%xmm14, %xmm15, %xmm0
	vmovdqa	%xmm14, %xmm8
	vpmaddubsw	%xmm4, %xmm0, %xmm9
	vporq	%ymm8, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm9, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm1
	vpmaddwd	%xmm12, %xmm1, %xmm11
	vmovq	%xmm11, %rcx
	imull	$100000000, %ecx, %edx
	shrq	$32, %rcx
	addl	%edx, %ecx
	movl	%ecx, -4(%rsi,%r13,4)
	cmpq	%rbx, %r15
	jb	.L96
.L97:
	movq	112(%rsp), %r12
	movq	56(%rsp), %rcx
	cmpq	$66687, %r12
	setbe	%dil
	cmpq	%rcx, %r9
	jnb	.L133
	testb	%dil, %dil
	je	.L133
	movl	$538976288, %esi
	movl	$808464432, %r8d
	vmovdqa	.LC8(%rip), %xmm4
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm12
	movq	%r12, %rbx
	vpbroadcastd	%esi, %xmm13
	vpbroadcastd	%r8d, %xmm3
	testb	$1, %r12b
	je	.L102
	vmovdqu	(%r9), %xmm14
	incq	%rbx
	vpminsb	%xmm13, %xmm14, %xmm10
	vpsubusb	%xmm3, %xmm14, %xmm0
	vpcmpeqb	%xmm10, %xmm14, %xmm7
	vpmovmskb	%xmm7, %eax
	tzcntl	%eax, %ecx
	incl	%ecx
	movq	%rcx, %rdx
	addq	%rcx, %r9
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm8
	vpshufb	%xmm8, %xmm0, %xmm9
	vmovdqa	%xmm8, %xmm15
	vpmaddubsw	%xmm4, %xmm9, %xmm2
	vporq	%ymm15, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm2, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm11
	vpmaddwd	%xmm12, %xmm11, %xmm14
	vmovq	%xmm14, %r12
	imull	$100000000, %r12d, %esi
	shrq	$32, %r12
	addl	%r12d, %esi
	movl	%esi, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region-4(,%rbx,4)
	cmpq	56(%rsp), %r9
	jnb	.L101
	movq	56(%rsp), %rcx
	cmpq	$66688, %rbx
	jne	.L102
	jmp	.L101
	.p2align 4
	.p2align 3
.L320:
	vmovdqu	(%r9), %xmm15
	incq	%rbx
	vpminsb	%xmm13, %xmm15, %xmm10
	vpsubusb	%xmm3, %xmm15, %xmm2
	vpcmpeqb	%xmm10, %xmm15, %xmm7
	vpmovmskb	%xmm7, %r8d
	tzcntl	%r8d, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r9
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm9
	vpshufb	%xmm9, %xmm2, %xmm1
	vmovdqa	%xmm9, %xmm0
	vpmaddubsw	%xmm4, %xmm1, %xmm11
	vporq	%ymm0, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm11, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm8
	vpmaddwd	%xmm12, %xmm8, %xmm15
	vmovq	%xmm15, %r12
	imull	$100000000, %r12d, %esi
	shrq	$32, %r12
	addl	%esi, %r12d
	movl	%r12d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region-4(,%rbx,4)
	cmpq	%rcx, %r9
	jnb	.L101
	cmpq	$66688, %rbx
	je	.L101
.L102:
	vmovdqu	(%r9), %xmm8
	incq	%rbx
	vpminsb	%xmm13, %xmm8, %xmm10
	vpsubusb	%xmm3, %xmm8, %xmm9
	vpcmpeqb	%xmm10, %xmm8, %xmm7
	vpmovmskb	%xmm7, %r8d
	tzcntl	%r8d, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r9
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm15
	vpshufb	%xmm15, %xmm9, %xmm2
	vmovdqa	%xmm15, %xmm0
	vpmaddubsw	%xmm4, %xmm2, %xmm1
	vporq	%ymm0, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm1, %xmm11
	vpackusdw	%xmm11, %xmm11, %xmm14
	vpmaddwd	%xmm12, %xmm14, %xmm8
	vmovq	%xmm8, %r12
	imull	$100000000, %r12d, %esi
	shrq	$32, %r12
	addl	%esi, %r12d
	movl	%r12d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region-4(,%rbx,4)
	cmpq	%rcx, %r9
	jb	.L320
.L101:
	movq	48(%rsp), %rdx
	cmpq	%rdx, %r10
	jnb	.L134
	testb	%dil, %dil
	je	.L134
	movq	112(%rsp), %rcx
	movl	$538976288, %r8d
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm4
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm12
	vpbroadcastd	%r8d, %xmm13
	vpbroadcastd	%eax, %xmm3
	movq	%rcx, %r12
	testb	$1, %cl
	je	.L105
	vmovdqu	(%r10), %xmm9
	vpminsb	%xmm13, %xmm9, %xmm10
	vpsubusb	%xmm3, %xmm9, %xmm1
	vpcmpeqb	%xmm10, %xmm9, %xmm7
	vpmovmskb	%xmm7, %edx
	tzcntl	%edx, %r12d
	incl	%r12d
	movq	%r12, %rsi
	addq	%r12, %r10
	leaq	1(%rcx), %r12
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm2
	vpshufb	%xmm2, %xmm1, %xmm11
	vmovdqa	%xmm2, %xmm0
	vpmaddubsw	%xmm4, %xmm11, %xmm14
	vporq	%ymm0, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm14, %xmm8
	vpackusdw	%xmm8, %xmm8, %xmm15
	vpmaddwd	%xmm12, %xmm15, %xmm9
	vmovq	%xmm9, %r8
	imull	$100000000, %r8d, %ecx
	shrq	$32, %r8
	addl	%r8d, %ecx
	movl	%ecx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266748(,%r12,4)
	cmpq	48(%rsp), %r10
	jnb	.L104
	movq	48(%rsp), %rdx
	cmpq	$66688, %r12
	jne	.L105
	jmp	.L104
	.p2align 4
	.p2align 3
.L321:
	vmovdqu	(%r10), %xmm1
	incq	%r12
	vpminsb	%xmm13, %xmm1, %xmm10
	vpsubusb	%xmm3, %xmm1, %xmm14
	vpcmpeqb	%xmm10, %xmm1, %xmm7
	vpmovmskb	%xmm7, %r8d
	tzcntl	%r8d, %ecx
	incl	%ecx
	movq	%rcx, %rsi
	addq	%rcx, %r10
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm11
	vpshufb	%xmm11, %xmm14, %xmm8
	vmovdqa	%xmm11, %xmm0
	vpmaddubsw	%xmm4, %xmm8, %xmm15
	vporq	%ymm0, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm15, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm2
	vpmaddwd	%xmm12, %xmm2, %xmm1
	vmovq	%xmm1, %rax
	imull	$100000000, %eax, %r8d
	shrq	$32, %rax
	addl	%r8d, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266748(,%r12,4)
	cmpq	%rdx, %r10
	jnb	.L104
	cmpq	$66688, %r12
	je	.L104
.L105:
	vmovdqu	(%r10), %xmm2
	incq	%r12
	vpminsb	%xmm13, %xmm2, %xmm10
	vpsubusb	%xmm3, %xmm2, %xmm11
	vpcmpeqb	%xmm10, %xmm2, %xmm7
	vpmovmskb	%xmm7, %eax
	tzcntl	%eax, %r8d
	incl	%r8d
	movq	%r8, %rsi
	addq	%r8, %r10
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm1
	vpshufb	%xmm1, %xmm11, %xmm14
	vmovdqa	%xmm1, %xmm0
	vpmaddubsw	%xmm4, %xmm14, %xmm8
	vporq	%ymm0, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm8, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm9
	vpmaddwd	%xmm12, %xmm9, %xmm2
	vmovq	%xmm2, %rcx
	imull	$100000000, %ecx, %eax
	shrq	$32, %rcx
	addl	%eax, %ecx
	movl	%ecx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266748(,%r12,4)
	cmpq	%rdx, %r10
	jb	.L321
.L104:
	movq	72(%rsp), %rsi
	cmpq	%rsi, %r14
	jnb	.L107
	testb	%dil, %dil
	je	.L107
	movq	112(%rsp), %rax
	movl	$538976288, %edi
	movl	$808464432, %edx
	vmovdqa	.LC8(%rip), %xmm1
	vmovdqa	.LC9(%rip), %xmm2
	vmovdqa	.LC10(%rip), %xmm3
	vpbroadcastd	%edi, %xmm8
	movq	%rsi, %r8
	vpbroadcastd	%edx, %xmm9
	testb	$1, %al
	je	.L108
	vmovdqu	(%r14), %xmm4
	incq	112(%rsp)
	vpminsb	%xmm8, %xmm4, %xmm5
	vpsubusb	%xmm9, %xmm4, %xmm7
	vpcmpeqb	%xmm5, %xmm4, %xmm12
	vpmovmskb	%xmm12, %ecx
	tzcntl	%ecx, %eax
	movq	112(%rsp), %rcx
	incl	%eax
	movq	%rax, %r8
	addq	%rax, %r14
	salq	$4, %r8
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r8), %xmm13
	vpshufb	%xmm13, %xmm7, %xmm11
	vmovdqa	%xmm13, %xmm10
	vpmaddubsw	%xmm1, %xmm11, %xmm0
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm2, %xmm0, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm15
	vpmaddwd	%xmm3, %xmm15, %xmm4
	vmovq	%xmm4, %rdi
	imull	$100000000, %edi, %edx
	shrq	$32, %rdi
	addl	%edi, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533500(,%rcx,4)
	cmpq	72(%rsp), %r14
	jnb	.L107
	cmpq	$66688, %rcx
	je	.L107
	movq	112(%rsp), %rax
	movq	%rsi, %r8
	jmp	.L108
	.p2align 4
	.p2align 3
.L322:
	vmovdqu	(%r14), %xmm12
	incq	%rax
	vpminsb	%xmm8, %xmm12, %xmm13
	vpsubusb	%xmm9, %xmm12, %xmm0
	vpcmpeqb	%xmm13, %xmm12, %xmm7
	vpmovmskb	%xmm7, %edi
	tzcntl	%edi, %ecx
	incl	%ecx
	movq	%rcx, %rdx
	addq	%rcx, %r14
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm11
	vpshufb	%xmm11, %xmm0, %xmm14
	vmovdqa	%xmm11, %xmm10
	vpmaddubsw	%xmm1, %xmm14, %xmm15
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm2, %xmm15, %xmm4
	vpackusdw	%xmm4, %xmm4, %xmm5
	vpmaddwd	%xmm3, %xmm5, %xmm12
	vmovq	%xmm12, %rdi
	imull	$100000000, %edi, %esi
	shrq	$32, %rdi
	addl	%esi, %edi
	movl	%edi, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533500(,%rax,4)
	cmpq	%r8, %r14
	jnb	.L308
	cmpq	$66688, %rax
	je	.L308
.L108:
	vmovdqu	(%r14), %xmm5
	incq	%rax
	vpminsb	%xmm8, %xmm5, %xmm12
	vpsubusb	%xmm9, %xmm5, %xmm11
	vpcmpeqb	%xmm12, %xmm5, %xmm13
	vpmovmskb	%xmm13, %esi
	tzcntl	%esi, %edi
	incl	%edi
	movq	%rdi, %rcx
	addq	%rdi, %r14
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm7
	vpshufb	%xmm7, %xmm11, %xmm0
	vmovdqa	%xmm7, %xmm10
	vpmaddubsw	%xmm1, %xmm0, %xmm14
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm2, %xmm14, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm4
	vpmaddwd	%xmm3, %xmm4, %xmm5
	vmovq	%xmm5, %rdx
	imull	$100000000, %edx, %esi
	shrq	$32, %rdx
	addl	%esi, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533500(,%rax,4)
	cmpq	%r8, %r14
	jb	.L322
.L308:
	movq	%rax, 112(%rsp)
.L107:
	cmpq	%r15, 64(%rsp)
	vpmovmskb	%ymm6, %r8d
	setne	%r15b
	cmpq	%r9, 56(%rsp)
	setne	%r9b
	orl	%r9d, %r15d
	cmpq	%r10, 48(%rsp)
	setne	%r10b
	andl	$-2147450880, %r8d
	xorl	%ecx, %ecx
	orl	%r10d, %r15d
	cmpq	%r14, 72(%rsp)
	movzbl	%r15b, %eax
	setne	%cl
	orl	%ecx, %r8d
	orl	%r8d, %eax
	jne	.L323
	movq	%r11, 104(%rsp)
	movq	120(%rsp), %r15
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region, %esi
	vzeroupper
	leaq	(%r15,%r13,4), %rdi
	addq	%r13, %rbx
	call	memcpy
	leaq	(%r15,%rbx,4), %rdi
	leaq	0(,%r12,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+266752, %esi
	call	memcpy
	addq	%r12, %rbx
	movq	112(%rsp), %r12
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb1EEES2_S2_S3_mRT2_E6region+533504, %esi
	leaq	(%r15,%rbx,4), %rdi
	leaq	0(,%r12,4), %rdx
	addq	%r12, %rbx
	call	memcpy
	leaq	(%r15,%rbx,4), %r11
	vmovdqa	.LC4(%rip), %ymm12
	vmovdqa	.LC3(%rip), %ymm4
	movq	%r11, 120(%rsp)
	vmovdqa	.LC2(%rip), %ymm5
	movq	104(%rsp), %r11
	subq	%rbx, %r11
.L128:
	cmpq	$133312, %r11
	jbe	.L310
.L112:
	movq	72(%rsp), %r15
	movq	%r15, 40(%rsp)
	jmp	.L129
	.p2align 4
	.p2align 3
.L319:
	movq	%r15, 80(%rsp)
	movq	%r14, %rbx
	movq	%r10, %r12
	movq	%r9, %r13
	vmovdqa64	.LC2(%rip), %ymm16
	vmovdqa64	.LC3(%rip), %ymm28
	movq	%rsi, %r14
	movq	%rcx, %r10
	vmovdqa64	.LC4(%rip), %ymm17
	vmovdqa32	.LC14(%rip), %ymm18
	movq	%rdx, %r9
	movq	%rax, %r15
	jmp	.L99
.L134:
	movq	112(%rsp), %r12
	jmp	.L104
.L133:
	movq	112(%rsp), %rbx
	jmp	.L101
.L310:
	vzeroupper
.L94:
	movq	120(%rsp), %rsi
	movq	72(%rsp), %rdi
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
.L323:
	.cfi_restore_state
	movq	72(%rsp), %rbx
	cmpq	%rbx, 40(%rsp)
	jnb	.L324
	movq	40(%rsp), %r14
	leaq	-1(%rbx), %r13
	cmpq	%r13, %r14
	cmovbe	%r14, %r13
	cmpq	%r14, %r13
	movq	%r13, %rsi
	setnb	%dil
	subq	%r14, %rsi
	cmpq	$62, %rsi
	jbe	.L135
	cmpq	%r14, %r13
	jb	.L135
	movl	$1, %eax
	movl	$538976288, %ecx
	movq	%r14, %r15
	vpxor	%xmm1, %xmm1, %xmm1
	movq	%rax, %r9
	vpbroadcastd	%ecx, %zmm6
	subq	%r14, %r9
	vpbroadcastq	%rax, %zmm2
	addq	%r13, %r9
	testb	%dil, %dil
	cmove	%rax, %r9
	movq	%r9, %r10
	andq	$-64, %r10
	leaq	(%r10,%r14), %r8
	testb	$64, %r10b
	je	.L114
	movq	40(%rsp), %rdx
	vmovdqu8	(%rdx), %zmm1
	leaq	64(%rdx), %r15
	vpcmpb	$6, %zmm6, %zmm1, %k1
	vmovdqa64	%zmm2, %zmm1{%k1}{z}
	kshiftrw	$8, %k1, %k5
	kshiftrd	$16, %k1, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k1, %k2
	vpaddq	%zmm2, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k2, %k7
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm1, %zmm1{%k4}
	vpaddq	%zmm2, %zmm1, %zmm1{%k6}
	kshiftrw	$8, %k3, %k1
	vpaddq	%zmm2, %zmm1, %zmm1{%k2}
	vpaddq	%zmm2, %zmm1, %zmm1{%k7}
	vpaddq	%zmm2, %zmm1, %zmm1{%k3}
	vpaddq	%zmm2, %zmm1, %zmm1{%k1}
	cmpq	%r15, %r8
	jne	.L114
.L305:
	vextracti64x4	$0x1, %zmm1, %ymm7
	vpaddq	%ymm1, %ymm7, %ymm11
	vextracti64x2	$0x1, %ymm11, %xmm10
	vpaddq	%xmm11, %xmm10, %xmm0
	vpsrldq	$8, %xmm0, %xmm14
	vpaddq	%xmm14, %xmm0, %xmm15
	vmovq	%xmm15, %rdx
	cmpq	%r9, %r10
	je	.L115
	movq	%r8, %r12
.L289:
	movq	%r13, %rbx
	xorl	%r14d, %r14d
	leaq	1(%r12), %r9
	subq	%r12, %rbx
	andl	$7, %ebx
	cmpb	$32, (%r12)
	setg	%r14b
	addq	%r14, %rdx
	cmpq	%r9, %r13
	jnb	.L325
.L115:
	movq	40(%rsp), %r9
	xorl	%r13d, %r13d
	testb	%dil, %dil
	cmovne	%rsi, %r13
	leaq	(%r9,%r13), %r14
	leaq	1(%r9,%r13), %rsi
	cmpq	72(%rsp), %rsi
	jnb	.L122
	movq	72(%rsp), %r10
	leaq	2(%r14), %rax
	leaq	-2(%r10), %rdi
	subq	%r14, %rdi
	cmpq	$62, %rdi
	jbe	.L235
	cmpq	%rax, %r10
	jb	.L235
	leaq	-1(%r10), %r15
	movl	$1, %r8d
	movl	$538976288, %ebx
	vpxor	%xmm4, %xmm4, %xmm4
	subq	%r14, %r15
	cmpq	%rax, %r10
	vpbroadcastd	%ebx, %zmm12
	cmovb	%r8, %r15
	vpxor	%xmm9, %xmm9, %xmm9
	movq	%r15, %r12
	vpternlogd	$0xFF, %zmm4, %zmm4, %zmm4
	andq	$-64, %r12
	leaq	(%r12,%r14), %rcx
.L120:
	vmovdqu8	1(%r14), %zmm5
	addq	$64, %r14
	vpcmpb	$6, %zmm12, %zmm5, %k7
	vmovdqu8	-64(%r14), %zmm6{%k7}{z}
	vmovdqa64	%zmm9, %zmm5
	kshiftrw	$8, %k7, %k5
	kshiftrd	$16, %k7, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k7, %k2
	kshiftrd	$16, %k2, %k3
	vpcmpb	$2, %zmm12, %zmm6, %k1
	vpabsb	%zmm4, %zmm2{%k1}{z}
	vpmovzxbw	%ymm2, %zmm8
	vextracti64x4	$0x1, %zmm2, %ymm3
	vpmovzxbw	%ymm3, %zmm13
	vpmovzxwd	%ymm8, %zmm7
	vextracti64x4	$0x1, %zmm8, %ymm1
	vpmovzxwd	%ymm1, %zmm11
	vpmovzxwd	%ymm13, %zmm14
	vpmovzxdq	%ymm7, %zmm15
	vextracti64x4	$0x1, %zmm13, %ymm10
	vpmovzxdq	%ymm11, %zmm8
	vpmovzxwd	%ymm10, %zmm0
	vpaddq	%zmm15, %zmm9, %zmm5{%k7}
	vextracti32x8	$0x1, %zmm7, %ymm9
	vpmovzxdq	%ymm14, %zmm1
	kshiftrw	$8, %k2, %k7
	vpmovzxdq	%ymm9, %zmm6
	vextracti32x8	$0x1, %zmm11, %ymm3
	vpmovzxdq	%ymm3, %zmm13
	vextracti32x8	$0x1, %zmm14, %ymm11
	vpaddq	%zmm6, %zmm5, %zmm5{%k5}
	vpmovzxdq	%ymm11, %zmm14
	vpmovzxdq	%ymm0, %zmm10
	vmovdqa64	%zmm5, %zmm2
	vextracti32x8	$0x1, %zmm0, %ymm0
	vpmovzxdq	%ymm0, %zmm15
	vpaddq	%zmm8, %zmm5, %zmm2{%k4}
	vmovdqa64	%zmm2, %zmm7
	vpaddq	%zmm13, %zmm2, %zmm7{%k6}
	vpaddq	%zmm1, %zmm7, %zmm7{%k2}
	kshiftrw	$8, %k3, %k2
	vpaddq	%zmm14, %zmm7, %zmm7{%k7}
	vpaddq	%zmm10, %zmm7, %zmm7{%k3}
	vmovdqa64	%zmm7, %zmm9
	vpaddq	%zmm15, %zmm7, %zmm9{%k2}
	cmpq	%r14, %rcx
	jne	.L120
	vextracti64x4	$0x1, %zmm9, %ymm12
	vpaddq	%ymm9, %ymm12, %ymm4
	vextracti64x2	$0x1, %ymm4, %xmm5
	vpaddq	%xmm4, %xmm5, %xmm6
	vpsrldq	$8, %xmm6, %xmm2
	vpaddq	%xmm2, %xmm6, %xmm8
	vmovq	%xmm8, %r13
	addq	%r13, %rdx
	cmpq	%r12, %r15
	je	.L122
	addq	%r12, %rsi
.L235:
	movq	%rsi, %r9
	notq	%r9
	addq	72(%rsp), %r9
	andl	$7, %r9d
	cmpb	$32, (%rsi)
	jle	.L290
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rsi)
	setle	%r14b
	addq	%r14, %rdx
.L290:
	leaq	1(%rsi), %rax
	cmpq	72(%rsp), %rax
	jnb	.L122
	testq	%r9, %r9
	je	.L125
	cmpq	$1, %r9
	je	.L237
	cmpq	$2, %r9
	je	.L238
	cmpq	$3, %r9
	je	.L239
	cmpq	$4, %r9
	je	.L240
	cmpq	$5, %r9
	je	.L241
	cmpq	$6, %r9
	je	.L242
	cmpb	$32, 1(%rsi)
	jg	.L326
.L292:
	incq	%rax
.L242:
	cmpb	$32, (%rax)
	jle	.L293
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
.L293:
	incq	%rax
.L241:
	cmpb	$32, (%rax)
	jg	.L327
.L294:
	incq	%rax
.L240:
	cmpb	$32, (%rax)
	jg	.L328
.L295:
	incq	%rax
.L239:
	cmpb	$32, (%rax)
	jg	.L329
.L296:
	incq	%rax
.L238:
	cmpb	$32, (%rax)
	jle	.L297
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
.L297:
	incq	%rax
.L237:
	cmpb	$32, (%rax)
	jle	.L298
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L298:
	incq	%rax
	cmpq	72(%rsp), %rax
	jnb	.L122
.L125:
	cmpb	$32, (%rax)
	jle	.L126
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
.L126:
	leaq	1(%rax), %r13
	cmpb	$32, 1(%rax)
	jle	.L291
	xorl	%eax, %eax
	cmpb	$32, -1(%r13)
	setle	%al
	addq	%rax, %rdx
.L291:
	cmpb	$32, 1(%r13)
	jle	.L299
	xorl	%r9d, %r9d
	cmpb	$32, 0(%r13)
	setle	%r9b
	addq	%r9, %rdx
.L299:
	cmpb	$32, 2(%r13)
	jle	.L300
	xorl	%r14d, %r14d
	cmpb	$32, 1(%r13)
	setle	%r14b
	addq	%r14, %rdx
.L300:
	cmpb	$32, 3(%r13)
	jle	.L301
	xorl	%esi, %esi
	cmpb	$32, 2(%r13)
	setle	%sil
	addq	%rsi, %rdx
.L301:
	cmpb	$32, 4(%r13)
	jle	.L302
	xorl	%r10d, %r10d
	cmpb	$32, 3(%r13)
	setle	%r10b
	addq	%r10, %rdx
.L302:
	cmpb	$32, 5(%r13)
	jle	.L303
	xorl	%edi, %edi
	cmpb	$32, 4(%r13)
	setle	%dil
	addq	%rdi, %rdx
.L303:
	cmpb	$32, 6(%r13)
	jle	.L304
	xorl	%r15d, %r15d
	cmpb	$32, 5(%r13)
	setle	%r15b
	addq	%r15, %rdx
.L304:
	leaq	7(%r13), %rax
	cmpq	72(%rsp), %rax
	jb	.L125
.L122:
	subq	%rdx, %r11
	movq	120(%rsp), %rsi
	movq	40(%rsp), %rdi
	movq	%r11, 112(%rsp)
	leaq	(%rsi,%rdx,4), %r12
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm12
	movq	%r12, 120(%rsp)
	movq	112(%rsp), %r11
	jmp	.L128
.L114:
	vmovdqu8	(%r15), %zmm3
	vmovdqa64	%zmm1, %zmm8
	subq	$-128, %r15
	vmovdqu8	-64(%r15), %zmm13
	vpcmpb	$6, %zmm6, %zmm3, %k5
	vpaddq	%zmm2, %zmm1, %zmm8{%k5}
	kshiftrw	$8, %k5, %k6
	kshiftrd	$16, %k5, %k4
	vpaddq	%zmm2, %zmm8, %zmm8{%k6}
	kshiftrw	$8, %k4, %k7
	vpaddq	%zmm2, %zmm8, %zmm8{%k4}
	kshiftrq	$32, %k5, %k2
	vpaddq	%zmm2, %zmm8, %zmm8{%k7}
	kshiftrw	$8, %k2, %k1
	vpaddq	%zmm2, %zmm8, %zmm8{%k2}
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm8, %zmm8{%k1}
	kshiftrw	$8, %k3, %k5
	vpcmpb	$6, %zmm6, %zmm13, %k6
	vpaddq	%zmm2, %zmm8, %zmm8{%k3}
	vpaddq	%zmm2, %zmm8, %zmm8{%k5}
	vmovdqa64	%zmm8, %zmm1
	kshiftrw	$8, %k6, %k7
	kshiftrd	$16, %k6, %k4
	vpaddq	%zmm2, %zmm8, %zmm1{%k6}
	vpaddq	%zmm2, %zmm1, %zmm1{%k7}
	kshiftrw	$8, %k4, %k1
	kshiftrq	$32, %k6, %k2
	vpaddq	%zmm2, %zmm1, %zmm1{%k4}
	vpaddq	%zmm2, %zmm1, %zmm1{%k1}
	kshiftrw	$8, %k2, %k5
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm1, %zmm1{%k2}
	vpaddq	%zmm2, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k3, %k6
	vpaddq	%zmm2, %zmm1, %zmm1{%k3}
	vpaddq	%zmm2, %zmm1, %zmm1{%k6}
	cmpq	%r15, %r8
	je	.L305
	jmp	.L114
.L325:
	testq	%rbx, %rbx
	je	.L117
	cmpq	$1, %rbx
	je	.L243
	cmpq	$2, %rbx
	je	.L244
	cmpq	$3, %rbx
	je	.L245
	cmpq	$4, %rbx
	je	.L246
	cmpq	$5, %rbx
	je	.L247
	cmpq	$6, %rbx
	jne	.L330
.L248:
	xorl	%r10d, %r10d
	cmpb	$32, (%r9)
	setg	%r10b
	incq	%r9
	addq	%r10, %rdx
.L247:
	xorl	%r8d, %r8d
	cmpb	$32, (%r9)
	setg	%r8b
	incq	%r9
	addq	%r8, %rdx
.L246:
	xorl	%ecx, %ecx
	cmpb	$32, (%r9)
	setg	%cl
	incq	%r9
	addq	%rcx, %rdx
.L245:
	xorl	%r15d, %r15d
	cmpb	$32, (%r9)
	setg	%r15b
	incq	%r9
	addq	%r15, %rdx
.L244:
	xorl	%r12d, %r12d
	cmpb	$32, (%r9)
	setg	%r12b
	incq	%r9
	addq	%r12, %rdx
.L243:
	xorl	%ebx, %ebx
	cmpb	$32, (%r9)
	setg	%bl
	incq	%r9
	addq	%rbx, %rdx
	cmpq	%r9, %r13
	jb	.L115
.L117:
	xorl	%r14d, %r14d
	cmpb	$32, (%r9)
	setg	%r14b
	xorl	%eax, %eax
	addq	%r14, %rdx
	cmpb	$32, 1(%r9)
	setg	%al
	xorl	%r10d, %r10d
	addq	%rax, %rdx
	cmpb	$32, 2(%r9)
	setg	%r10b
	xorl	%r8d, %r8d
	addq	%r10, %rdx
	cmpb	$32, 3(%r9)
	setg	%r8b
	xorl	%ecx, %ecx
	addq	%r8, %rdx
	cmpb	$32, 4(%r9)
	setg	%cl
	xorl	%r15d, %r15d
	addq	%rcx, %rdx
	cmpb	$32, 5(%r9)
	setg	%r15b
	xorl	%r12d, %r12d
	addq	%r15, %rdx
	cmpb	$32, 6(%r9)
	setg	%r12b
	xorl	%ebx, %ebx
	addq	%r12, %rdx
	cmpb	$32, 7(%r9)
	setg	%bl
	addq	$8, %r9
	addq	%rbx, %rdx
	cmpq	%r9, %r13
	jb	.L115
	jmp	.L117
	.p2align 4
	.p2align 3
.L329:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L296
.L328:
	xorl	%r15d, %r15d
	cmpb	$32, -1(%rax)
	setle	%r15b
	addq	%r15, %rdx
	jmp	.L295
.L327:
	xorl	%edi, %edi
	cmpb	$32, -1(%rax)
	setle	%dil
	addq	%rdi, %rdx
	jmp	.L294
.L130:
	movq	%rdi, 72(%rsp)
	jmp	.L94
.L324:
	movq	%r11, 112(%rsp)
	movq	120(%rsp), %rsi
	movq	40(%rsp), %rdi
	xorl	%edx, %edx
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm12
	movq	112(%rsp), %r11
	jmp	.L112
.L135:
	movq	40(%rsp), %r12
	xorl	%edx, %edx
	jmp	.L289
.L326:
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
	jmp	.L292
.L330:
	xorl	%eax, %eax
	cmpb	$32, 1(%r12)
	leaq	2(%r12), %r9
	setg	%al
	addq	%rax, %rdx
	jmp	.L248
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
	andq	$-64, %rsp
	subq	$256, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rsi, 80(%rsp)
	movq	%rdx, 24(%rsp)
	cmpq	$133312, %rdx
	jbe	.L369
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm12
.L368:
	movl	$538976288, %eax
	vmovdqa	.LC14(%rip), %ymm13
	movq	%rdi, 16(%rsp)
	vpbroadcastd	%eax, %ymm10
	vpminsb	199872(%rdi), %ymm10, %ymm6
	vpminsb	66624(%rdi), %ymm10, %ymm0
	vpminsb	133248(%rdi), %ymm10, %ymm2
	vpminsb	266496(%rdi), %ymm10, %ymm8
	vpcmpeqb	199872(%rdi), %ymm6, %ymm7
	vpcmpeqb	66624(%rdi), %ymm0, %ymm1
	vpxor	%xmm6, %xmm6, %xmm6
	vpcmpeqb	133248(%rdi), %ymm2, %ymm3
	vpcmpeqb	266496(%rdi), %ymm8, %ymm9
	vpmovmskb	%ymm1, %edx
	vpmovmskb	%ymm3, %esi
	vpmovmskb	%ymm9, %r15d
	tzcntl	%edx, %ecx
	vpmovmskb	%ymm7, %r10d
	tzcntl	%esi, %r8d
	tzcntl	%r15d, %eax
	movl	%ecx, %ebx
	tzcntl	%r10d, %r11d
	movl	%r8d, %r9d
	movl	%eax, %edx
	leaq	66625(%rdi,%rbx), %r14
	movl	%r11d, %r12d
	leaq	133249(%rdi,%r9), %r13
	leaq	266497(%rdi,%rdx), %rcx
	movq	%r14, 32(%rsp)
	leaq	199873(%rdi,%r12), %r12
	movq	%r13, 48(%rsp)
	movq	%rcx, 72(%rsp)
	movl	$808464432, %ebx
	movq	%r12, 40(%rsp)
	vpbroadcastd	%ebx, %ymm11
	xorl	%esi, %esi
	movq	%rdi, %r15
	.p2align 4
	.p2align 3
.L339:
	movq	72(%rsp), %rax
	movq	40(%rsp), %rdi
	movq	48(%rsp), %r8
	movq	32(%rsp), %r9
	subq	%r12, %rax
	subq	%r13, %rdi
	cmpq	%rdi, %rax
	cmovg	%rdi, %rax
	subq	%r14, %r8
	subq	%r15, %r9
	cmpq	%r9, %r8
	cmovg	%r9, %r8
	cmpq	%r8, %rax
	cmovg	%r8, %rax
	cmpq	$64, %rax
	jbe	.L556
	vpminsb	32(%r15), %ymm10, %ymm0
	vpminsb	(%r15), %ymm10, %ymm14
	vpminsb	(%r14), %ymm10, %ymm2
	movabsq	$1135184250689818561, %r10
	mulq	%r10
	vpminsb	32(%r14), %ymm10, %ymm7
	vpminsb	0(%r13), %ymm10, %ymm9
	movq	%rdx, %rbx
	shrq	$2, %rbx
	vpcmpeqb	32(%r15), %ymm0, %ymm1
	vpcmpeqb	(%r15), %ymm14, %ymm15
	vpmovmskb	%ymm1, %edx
	vpmovmskb	%ymm15, %r11d
	vpminsb	32(%r13), %ymm10, %ymm15
	vpcmpeqb	(%r14), %ymm2, %ymm3
	salq	$32, %rdx
	blsr	%r11d, %ecx
	blsr	%ecx, %eax
	blsr	%eax, %r10d
	vpcmpeqb	32(%r14), %ymm7, %ymm8
	vpcmpeqb	0(%r13), %ymm9, %ymm14
	tzcntl	%r11d, %edi
	movl	%r10d, %r11d
	tzcntl	%ecx, %r8d
	tzcntl	%eax, %r9d
	orq	%rdx, %r11
	movl	%edi, 228(%rsp)
	vpmovmskb	%ymm3, %edi
	movl	%r8d, 224(%rsp)
	tzcntq	%r11, %rcx
	blsr	%edi, %r8d
	blsr	%r8d, %eax
	tzcntl	%r8d, %r11d
	vpmovmskb	%ymm8, %r8d
	vpminsb	(%r12), %ymm10, %ymm1
	movl	%ecx, 220(%rsp)
	incl	%ecx
	movl	%r9d, 232(%rsp)
	leaq	(%r15,%rcx), %r10
	tzcntl	%edi, %r9d
	blsr	%eax, %ecx
	movl	%ecx, %edi
	tzcntl	%eax, %edx
	vpminsb	32(%r12), %ymm10, %ymm3
	movl	%r9d, 212(%rsp)
	vpcmpeqb	32(%r13), %ymm15, %ymm0
	vpmovmskb	%ymm14, %r9d
	movl	%edx, 204(%rsp)
	movl	%r11d, 208(%rsp)
	blsr	%r9d, %edx
	blsr	%edx, %ecx
	salq	$32, %r8
	vpcmpeqb	(%r12), %ymm1, %ymm2
	orq	%r8, %rdi
	tzcntl	%edx, %r8d
	vpmovmskb	%ymm0, %edx
	tzcntq	%rdi, %rax
	tzcntl	%r9d, %edi
	blsr	%ecx, %r9d
	movl	%r8d, 192(%rsp)
	movl	%eax, 200(%rsp)
	incl	%eax
	vpmovmskb	%ymm2, %r8d
	movl	%edi, 196(%rsp)
	leaq	(%r14,%rax), %r11
	tzcntl	%ecx, %eax
	vpcmpeqb	32(%r12), %ymm3, %ymm7
	salq	$32, %rdx
	movl	%r9d, %ecx
	movl	%eax, 188(%rsp)
	orq	%rdx, %rcx
	tzcntq	%rcx, %rdi
	movl	%edi, 216(%rsp)
	incl	%edi
	blsr	%r8d, %ecx
	tzcntl	%r8d, %edx
	movl	%edx, 184(%rsp)
	vpmovmskb	%ymm7, %edx
	blsr	%ecx, %eax
	leaq	0(%r13,%rdi), %r9
	tzcntl	%eax, %r8d
	tzcntl	%ecx, %edi
	blsr	%eax, %ecx
	movl	%ecx, %eax
	salq	$32, %rdx
	orq	%rdx, %rax
	movl	%edi, 180(%rsp)
	movl	%r8d, 176(%rsp)
	tzcntq	%rax, %rdi
	movl	%edi, 172(%rsp)
	incl	%edi
	leaq	(%r12,%rdi), %r8
	cmpq	$1, %rbx
	je	.L336
	leaq	-4(%rsi,%rbx,4), %rdi
	movl	$100000000, %ecx
	movq	%r13, 152(%rsp)
	movq	%rbx, 64(%rsp)
	vmovq	%rdi, %xmm17
	movq	%r9, %r13
	movq	%r12, 160(%rsp)
	movq	%rsi, 56(%rsp)
	vmovdqa64	%ymm5, %ymm16
	vmovdqa64	%ymm4, %ymm29
	movq	%rsi, %rbx
	movq	%r8, %rdi
	vmovdqa64	%ymm12, %ymm18
	vmovdqa32	%ymm13, %ymm19
	movq	%r11, %r9
	vpbroadcastd	%ecx, %ymm14
	jmp	.L337
	.p2align 4
	.p2align 3
.L371:
	movq	120(%rsp), %rdi
	movq	128(%rsp), %r13
	movq	136(%rsp), %r9
	movq	144(%rsp), %r10
.L337:
	vpminsb	32(%r10), %ymm10, %ymm15
	vpminsb	(%r10), %ymm10, %ymm8
	movl	228(%rsp), %esi
	movl	224(%rsp), %edx
	vpminsb	(%r9), %ymm10, %ymm1
	vpminsb	32(%r9), %ymm10, %ymm3
	movl	%esi, 240(%rsp)
	vpcmpeqb	32(%r10), %ymm15, %ymm0
	vpcmpeqb	(%r10), %ymm8, %ymm9
	movl	%edx, 248(%rsp)
	vpmovmskb	%ymm0, %esi
	vpmovmskb	%ymm9, %r12d
	vpcmpeqb	(%r9), %ymm1, %ymm2
	salq	$32, %rsi
	blsr	%r12d, %r8d
	blsr	%r8d, %eax
	vpcmpeqb	32(%r9), %ymm3, %ymm7
	tzcntl	%r12d, %r11d
	tzcntl	%r8d, %ecx
	tzcntl	%eax, %r12d
	blsr	%eax, %r8d
	movl	%r8d, %eax
	movl	%ecx, 224(%rsp)
	movl	220(%rsp), %ecx
	movl	%r11d, 228(%rsp)
	orq	%rsi, %rax
	movl	232(%rsp), %r11d
	movl	%r12d, 232(%rsp)
	vpmovmskb	%ymm2, %esi
	tzcntq	%rax, %rdx
	movl	212(%rsp), %r8d
	movl	%edx, 220(%rsp)
	incl	%edx
	leaq	(%r10,%rdx), %r12
	blsr	%esi, %edx
	blsr	%edx, %eax
	movq	%r12, 144(%rsp)
	movl	208(%rsp), %r12d
	movl	%ecx, 168(%rsp)
	tzcntl	%esi, %ecx
	tzcntl	%edx, %esi
	movl	204(%rsp), %edx
	movl	%ecx, 212(%rsp)
	movl	%r8d, 108(%rsp)
	tzcntl	%eax, %r8d
	blsr	%eax, %eax
	movl	%eax, %ecx
	movl	%esi, 208(%rsp)
	movl	%r8d, 204(%rsp)
	movl	%r12d, 116(%rsp)
	vpmovmskb	%ymm7, %r12d
	movl	%edx, 236(%rsp)
	movl	200(%rsp), %edx
	salq	$32, %r12
	orq	%r12, %rcx
	tzcntq	%rcx, %rsi
	movl	%edx, 92(%rsp)
	movl	%esi, 200(%rsp)
	incl	%esi
	leaq	(%r9,%rsi), %r8
	movq	%r8, 136(%rsp)
	vpminsb	0(%r13), %ymm10, %ymm8
	vpminsb	32(%r13), %ymm10, %ymm15
	movl	196(%rsp), %r12d
	movl	192(%rsp), %r8d
	vpminsb	(%rdi), %ymm10, %ymm1
	vpminsb	32(%rdi), %ymm10, %ymm3
	vpcmpeqb	0(%r13), %ymm8, %ymm9
	vpcmpeqb	32(%r13), %ymm15, %ymm0
	movl	%r12d, 96(%rsp)
	movl	%r8d, 100(%rsp)
	vpmovmskb	%ymm9, %ecx
	vpcmpeqb	(%rdi), %ymm1, %ymm2
	vmovdqu	(%r15), %xmm8
	tzcntl	%ecx, %edx
	blsr	%ecx, %esi
	blsr	%esi, %eax
	tzcntl	%eax, %r12d
	movl	%edx, 196(%rsp)
	vpmovmskb	%ymm0, %edx
	blsr	%eax, %eax
	movl	%eax, %r8d
	tzcntl	%esi, %ecx
	movl	188(%rsp), %esi
	movl	%r12d, 188(%rsp)
	movl	216(%rsp), %r12d
	movl	%ecx, 192(%rsp)
	vpcmpeqb	32(%rdi), %ymm3, %ymm7
	salq	$32, %rdx
	orq	%rdx, %r8
	movl	%r12d, 104(%rsp)
	tzcntq	%r8, %rcx
	movl	184(%rsp), %r8d
	movl	%ecx, 216(%rsp)
	incl	%ecx
	addq	%r13, %rcx
	movq	%rcx, 128(%rsp)
	vpmovmskb	%ymm2, %ecx
	blsr	%ecx, %edx
	blsr	%edx, %eax
	tzcntl	%ecx, %r12d
	tzcntl	%edx, %edx
	movl	%r12d, 184(%rsp)
	vpmovmskb	%ymm7, %r12d
	movl	%r8d, 112(%rsp)
	tzcntl	%eax, %r8d
	movl	180(%rsp), %ecx
	blsr	%eax, %eax
	movl	%edx, 180(%rsp)
	movl	176(%rsp), %edx
	movl	%r8d, 176(%rsp)
	movl	%eax, %r8d
	salq	$32, %r12
	orq	%r12, %r8
	movl	172(%rsp), %r12d
	tzcntq	%r8, %rax
	movl	%eax, 172(%rsp)
	incl	%eax
	addq	%rdi, %rax
	movq	%rax, 120(%rsp)
	movl	240(%rsp), %eax
	vinserti64x2	$0x1, 1(%r15,%rax), %ymm8, %ymm9
	movl	248(%rsp), %r8d
	incl	%eax
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm1
	vmovdqu	1(%r15,%r8), %xmm15
	movl	%r11d, %r8d
	vinserti64x2	$0x1, 1(%r15,%r8), %ymm15, %ymm0
	movl	248(%rsp), %r15d
	movl	%r11d, %r8d
	vpsubusb	%ymm11, %ymm9, %ymm3
	movl	%r15d, %eax
	subl	240(%rsp), %eax
	subl	%r15d, %r8d
	movl	168(%rsp), %r15d
	vpsubusb	%ymm11, %ymm0, %ymm9
	salq	$4, %r8
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r8), %xmm2
	salq	$4, %rax
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm1, %ymm21
	subl	%r11d, %r15d
	movl	116(%rsp), %r11d
	movl	108(%rsp), %eax
	salq	$4, %r15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r15), %ymm2, %ymm26
	vmovdqu	(%r14), %xmm2
	movq	%r11, %r15
	vinserti64x2	$0x1, 1(%r14,%rax), %ymm2, %ymm20
	movq	%rax, %r8
	incl	%eax
	vpshufb	%ymm21, %ymm3, %ymm7
	vmovdqu	1(%r14,%r11), %xmm3
	movl	236(%rsp), %r11d
	vpmaddubsw	%ymm5, %ymm7, %ymm8
	salq	$4, %rax
	vpmaddwd	%ymm4, %ymm8, %ymm1
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm8
	vpshufb	%ymm26, %ymm9, %ymm15
	vpternlogq	$254, %ymm6, %ymm26, %ymm21
	vinserti64x2	$0x1, 1(%r14,%r11), %ymm3, %ymm7
	movl	%r15d, %r14d
	vpmaddubsw	%ymm5, %ymm15, %ymm0
	vpsubusb	%ymm11, %ymm20, %ymm22
	subl	%r8d, %r14d
	movl	236(%rsp), %r8d
	vmovdqa64	%ymm21, %ymm6
	vpmaddwd	%ymm4, %ymm0, %ymm0
	salq	$4, %r14
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm8, %ymm24
	movl	%r8d, %eax
	vpsubusb	%ymm11, %ymm7, %ymm15
	subl	%r15d, %eax
	movl	92(%rsp), %r15d
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm9
	movl	96(%rsp), %eax
	vpshufb	%ymm24, %ymm22, %ymm23
	subl	%r8d, %r15d
	movl	100(%rsp), %r8d
	vpmaddubsw	%ymm5, %ymm23, %ymm27
	vpmaddwd	%ymm4, %ymm27, %ymm30
	salq	$4, %r15
	vpackusdw	%ymm30, %ymm1, %ymm1
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r15), %ymm9, %ymm25
	movq	152(%rsp), %r15
	movq	%rax, %r14
	vpmaddwd	%ymm12, %ymm1, %ymm21
	movq	%r8, %r11
	vmovdqu	(%r15), %xmm7
	vinserti64x2	$0x1, 1(%r15,%rax), %ymm7, %ymm9
	incl	%eax
	salq	$4, %rax
	vpshufb	%ymm25, %ymm15, %ymm2
	vpternlogq	$254, %ymm25, %ymm24, %ymm6
	vpmaddubsw	%ymm5, %ymm2, %ymm3
	vmovdqu	1(%r15,%r8), %xmm15
	movl	%esi, %r8d
	vpmaddwd	%ymm4, %ymm3, %ymm8
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm3
	movl	%r11d, %eax
	vinserti64x2	$0x1, 1(%r15,%r8), %ymm15, %ymm2
	subl	%r14d, %eax
	movl	%esi, %r14d
	vpackusdw	%ymm8, %ymm0, %ymm0
	salq	$4, %rax
	vpsubusb	%ymm11, %ymm9, %ymm9
	vpmaddwd	%ymm12, %ymm0, %ymm8
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm3, %ymm31
	movl	104(%rsp), %r15d
	subl	%r11d, %r14d
	movq	160(%rsp), %rax
	movl	112(%rsp), %r11d
	movq	%r13, 152(%rsp)
	movq	%rdi, 160(%rsp)
	vpsubusb	%ymm11, %ymm2, %ymm2
	salq	$4, %r14
	subl	%esi, %r15d
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm7
	subl	%edx, %r12d
	movl	%edx, %r14d
	salq	$4, %r15
	vpshufb	%ymm31, %ymm9, %ymm15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r15), %ymm7, %ymm20
	vpmaddubsw	%ymm5, %ymm15, %ymm3
	movq	%r11, %r8
	vmovdqu	(%rax), %xmm15
	movl	%ecx, %r15d
	movl	%ecx, %esi
	vpmaddwd	%ymm4, %ymm3, %ymm3
	subl	%r8d, %r15d
	salq	$4, %r15
	salq	$4, %r12
	vpshufb	%ymm20, %ymm2, %ymm7
	vpternlogq	$254, %ymm20, %ymm31, %ymm6
	vpmaddubsw	%ymm5, %ymm7, %ymm9
	vmovdqu	1(%rax,%rsi), %xmm7
	vinserti64x2	$0x1, 1(%rax,%r14), %ymm7, %ymm7
	movq	%r9, %r14
	vpmaddwd	%ymm4, %ymm9, %ymm2
	vinserti64x2	$0x1, 1(%rax,%r11), %ymm15, %ymm9
	incl	%r11d
	salq	$4, %r11
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r11), %xmm15
	movl	%edx, %r11d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r15), %ymm15, %ymm28
	vmovq	%xmm17, %rdx
	subl	%ecx, %r11d
	movq	80(%rsp), %rcx
	movq	%r10, %r15
	vpsubusb	%ymm11, %ymm7, %ymm7
	salq	$4, %r11
	vpsubusb	%ymm11, %ymm9, %ymm9
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r11), %xmm15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r12), %ymm15, %ymm22
	vpshufb	%ymm28, %ymm9, %ymm15
	vpmaddubsw	%ymm5, %ymm15, %ymm9
	vpmaddwd	%ymm4, %ymm9, %ymm15
	vpackusdw	%ymm15, %ymm3, %ymm3
	vpmaddwd	%ymm12, %ymm3, %ymm15
	vpshufb	%ymm22, %ymm7, %ymm9
	vshufps	$221, %ymm15, %ymm21, %ymm26
	vpternlogq	$254, %ymm22, %ymm28, %ymm6
	vpmaddubsw	%ymm5, %ymm9, %ymm7
	vpmaddwd	%ymm4, %ymm7, %ymm9
	vshufps	$136, %ymm15, %ymm21, %ymm7
	vpmulld	%ymm14, %ymm7, %ymm1
	vpackusdw	%ymm9, %ymm2, %ymm2
	vpmaddwd	%ymm12, %ymm2, %ymm9
	vshufps	$136, %ymm9, %ymm8, %ymm7
	vpaddd	%ymm26, %ymm1, %ymm3
	vpmulld	%ymm14, %ymm7, %ymm1
	vpermd	%ymm3, %ymm13, %ymm15
	vshufps	$221, %ymm9, %ymm8, %ymm3
	vpaddd	%ymm3, %ymm1, %ymm0
	vpermd	%ymm0, %ymm13, %ymm8
	vpunpcklqdq	%ymm8, %ymm15, %ymm2
	vpunpckhqdq	%ymm8, %ymm15, %ymm15
	vmovdqu	%xmm2, (%rcx,%rbx,4)
	vmovdqa	%xmm15, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region(,%rbx,4)
	vextracti64x2	$0x1, %ymm2, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266752(,%rbx,4)
	vextracti64x2	$0x1, %ymm15, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533504(,%rbx,4)
	addq	$4, %rbx
	cmpq	%rdx, %rbx
	jne	.L371
	movq	56(%rsp), %r12
	movq	64(%rsp), %rbx
	movq	%r9, %r11
	movq	136(%rsp), %r14
	movq	%r13, %r9
	movq	144(%rsp), %r15
	movq	128(%rsp), %r13
	movq	%rdi, %r8
	leaq	-4(%r12,%rbx,4), %rsi
	movq	120(%rsp), %r12
.L338:
	movl	232(%rsp), %edx
	movl	228(%rsp), %eax
	movl	224(%rsp), %edi
	vmovdqu	(%r10), %xmm14
	vmovdqu	1(%r10,%rdi), %xmm1
	vinserti64x2	$0x1, 1(%r10,%rax), %ymm14, %ymm7
	vinserti64x2	$0x1, 1(%r10,%rdx), %ymm1, %ymm3
	movq	%rax, %rcx
	movl	%edi, %r10d
	incl	%eax
	subl	%ecx, %r10d
	movl	220(%rsp), %ecx
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm0
	movl	%edx, %eax
	vpsubusb	%ymm11, %ymm7, %ymm2
	vpsubusb	%ymm11, %ymm3, %ymm14
	salq	$4, %r10
	subl	%edx, %ecx
	subl	%edi, %eax
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r10), %ymm0, %ymm17
	movl	208(%rsp), %edx
	movl	212(%rsp), %r10d
	salq	$4, %rax
	salq	$4, %rcx
	vpshufb	%ymm17, %ymm2, %ymm15
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm8
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rcx), %ymm8, %ymm23
	movl	204(%rsp), %eax
	vpmaddubsw	%ymm16, %ymm15, %ymm9
	vmovdqu	1(%r11,%rdx), %xmm2
	vmovdqu	(%r11), %xmm8
	movq	%r10, %rcx
	vinserti64x2	$0x1, 1(%r11,%r10), %ymm8, %ymm15
	incl	%r10d
	vpmaddwd	%ymm29, %ymm9, %ymm1
	salq	$4, %r10
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm9
	movl	%eax, %r10d
	vpshufb	%ymm23, %ymm14, %ymm7
	vinserti64x2	$0x1, 1(%r11,%rax), %ymm2, %ymm14
	movl	%edx, %r11d
	subl	%edx, %r10d
	subl	%ecx, %r11d
	movl	200(%rsp), %ecx
	vpmaddubsw	%ymm16, %ymm7, %ymm3
	movl	192(%rsp), %edx
	vpmaddwd	%ymm29, %ymm3, %ymm0
	vpsubusb	%ymm11, %ymm15, %ymm3
	vpternlogq	$254, %ymm6, %ymm23, %ymm17
	salq	$4, %r11
	vmovdqa64	%ymm17, %ymm6
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r11), %ymm9, %ymm27
	subl	%eax, %ecx
	movl	196(%rsp), %eax
	vpsubusb	%ymm11, %ymm14, %ymm2
	salq	$4, %r10
	salq	$4, %rcx
	vpshufb	%ymm27, %ymm3, %ymm8
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r10), %xmm7
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rcx), %ymm7, %ymm30
	movl	188(%rsp), %r10d
	vpmaddubsw	%ymm16, %ymm8, %ymm15
	vmovdqu	(%r9), %xmm3
	vpmaddwd	%ymm29, %ymm15, %ymm9
	movq	%rax, %r11
	vinserti64x2	$0x1, 1(%r9,%rax), %ymm3, %ymm15
	incl	%eax
	vpackusdw	%ymm9, %ymm1, %ymm1
	salq	$4, %rax
	vpmaddwd	%ymm18, %ymm1, %ymm9
	movl	%r10d, %ecx
	vpshufb	%ymm30, %ymm2, %ymm14
	vmovdqu	1(%r9,%rdx), %xmm2
	vinserti64x2	$0x1, 1(%r9,%r10), %ymm2, %ymm2
	movl	%edx, %r9d
	subl	%r11d, %r9d
	vpmaddubsw	%ymm16, %ymm14, %ymm7
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm14
	subl	%edx, %ecx
	salq	$4, %r9
	vpmaddwd	%ymm29, %ymm7, %ymm8
	vpsubusb	%ymm11, %ymm15, %ymm3
	vpternlogq	$254, %ymm30, %ymm27, %ymm6
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r9), %ymm14, %ymm31
	movl	216(%rsp), %eax
	movl	184(%rsp), %r11d
	vpackusdw	%ymm8, %ymm0, %ymm0
	movl	180(%rsp), %edx
	movl	176(%rsp), %r9d
	vpmaddwd	%ymm18, %ymm0, %ymm8
	vpsubusb	%ymm11, %ymm2, %ymm2
	salq	$4, %rcx
	subl	%r10d, %eax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm7
	movq	%r11, %r10
	salq	$4, %rax
	vpshufb	%ymm31, %ymm3, %ymm15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm7, %ymm24
	movl	172(%rsp), %eax
	vpmaddubsw	%ymm16, %ymm15, %ymm14
	vmovdqu	(%r8), %xmm15
	movl	%r9d, %ecx
	vpmaddwd	%ymm29, %ymm14, %ymm14
	subl	%edx, %ecx
	salq	$4, %rcx
	subl	%r9d, %eax
	vpshufb	%ymm24, %ymm2, %ymm7
	vmovdqu	1(%r8,%rdx), %xmm2
	vinserti64x2	$0x1, 1(%r8,%r9), %ymm2, %ymm2
	vpternlogq	$254, %ymm24, %ymm31, %ymm6
	vpmaddubsw	%ymm16, %ymm7, %ymm3
	vpmaddwd	%ymm29, %ymm3, %ymm7
	vinserti64x2	$0x1, 1(%r8,%r11), %ymm15, %ymm3
	movl	%edx, %r8d
	incl	%r11d
	subl	%r10d, %r8d
	movq	80(%rsp), %r10
	salq	$4, %r11
	vpsubusb	%ymm11, %ymm2, %ymm2
	salq	$4, %r8
	vpsubusb	%ymm11, %ymm3, %ymm3
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r11), %xmm15
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r8), %ymm15, %ymm20
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rcx), %xmm15
	movl	$100000000, %r11d
	salq	$4, %rax
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm15, %ymm25
	vpshufb	%ymm20, %ymm3, %ymm15
	vpmaddubsw	%ymm16, %ymm15, %ymm3
	vpmaddwd	%ymm29, %ymm3, %ymm15
	vpshufb	%ymm25, %ymm2, %ymm3
	vpackusdw	%ymm15, %ymm14, %ymm14
	vpternlogq	$254, %ymm25, %ymm20, %ymm6
	vpmaddubsw	%ymm16, %ymm3, %ymm2
	vpmaddwd	%ymm18, %ymm14, %ymm15
	vpbroadcastd	%r11d, %ymm14
	vpmaddwd	%ymm29, %ymm2, %ymm2
	vshufps	$136, %ymm15, %ymm9, %ymm3
	vshufps	$221, %ymm15, %ymm9, %ymm9
	vpackusdw	%ymm2, %ymm7, %ymm7
	vpmulld	%ymm14, %ymm3, %ymm1
	vpmaddwd	%ymm18, %ymm7, %ymm2
	vshufps	$136, %ymm2, %ymm8, %ymm3
	vpmulld	%ymm14, %ymm3, %ymm14
	vpaddd	%ymm9, %ymm1, %ymm15
	vshufps	$221, %ymm2, %ymm8, %ymm9
	vpermd	%ymm15, %ymm19, %ymm1
	vpaddd	%ymm9, %ymm14, %ymm15
	vpermd	%ymm15, %ymm19, %ymm0
	vpunpcklqdq	%ymm0, %ymm1, %ymm8
	vpunpckhqdq	%ymm0, %ymm1, %ymm7
	vmovdqu	%xmm8, (%r10,%rsi,4)
	vmovdqa	%xmm7, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region(,%rsi,4)
	vextracti64x2	$0x1, %ymm8, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266752(,%rsi,4)
	vextracti64x2	$0x1, %ymm7, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533504(,%rsi,4)
	addq	$4, %rsi
	jmp	.L339
.L556:
	movq	32(%rsp), %r10
	movq	%r12, %r11
	movq	%r15, %r12
	movq	16(%rsp), %rdi
	movq	%r13, %r15
	movq	%rsi, %rbx
	movq	%r14, %r13
	movq	%rsi, %r8
	movq	%r12, %r14
	cmpq	%r10, %r12
	jnb	.L335
	vmovdqa	.LC8(%rip), %xmm4
	vmovdqa	.LC9(%rip), %xmm5
	movq	80(%rsp), %rcx
	movl	$538976288, %esi
	vmovdqa	.LC10(%rip), %xmm12
	movl	$808464432, %edx
	vpbroadcastd	%esi, %xmm2
	vpbroadcastd	%edx, %xmm3
	.p2align 4
	.p2align 3
.L334:
	vmovdqu	(%r14), %xmm9
	incq	%r8
	vpminsb	%xmm2, %xmm9, %xmm15
	vpsubusb	%xmm3, %xmm9, %xmm1
	vpcmpeqb	%xmm15, %xmm9, %xmm0
	vpmovmskb	%xmm0, %eax
	tzcntl	%eax, %r9d
	incl	%r9d
	movq	%r9, %r12
	addq	%r9, %r14
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm7
	vpshufb	%xmm7, %xmm1, %xmm10
	vmovdqa	%xmm7, %xmm8
	vpmaddubsw	%xmm4, %xmm10, %xmm11
	vporq	%ymm8, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm11, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm14
	vpmaddwd	%xmm12, %xmm14, %xmm9
	vmovq	%xmm9, %rsi
	imull	$100000000, %esi, %edx
	shrq	$32, %rsi
	addl	%edx, %esi
	movl	%esi, -4(%rcx,%r8,4)
	cmpq	%r10, %r14
	jb	.L334
.L335:
	movq	48(%rsp), %rdx
	cmpq	$66687, %rbx
	movq	%rbx, %r12
	setbe	%cl
	cmpq	%rdx, %r13
	jnb	.L340
	testb	%cl, %cl
	je	.L340
	movl	$538976288, %eax
	movl	$808464432, %r9d
	vmovdqa	.LC8(%rip), %xmm4
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm12
	vpbroadcastd	%eax, %xmm2
	vpbroadcastd	%r9d, %xmm3
	testb	$1, %bl
	je	.L341
	vmovdqu	0(%r13), %xmm15
	vpminsb	%xmm2, %xmm15, %xmm0
	vpsubusb	%xmm3, %xmm15, %xmm10
	vpcmpeqb	%xmm0, %xmm15, %xmm7
	vpmovmskb	%xmm7, %r12d
	tzcntl	%r12d, %esi
	leaq	1(%rbx), %r12
	incl	%esi
	movq	%rsi, %rdx
	addq	%rsi, %r13
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm8
	vpshufb	%xmm8, %xmm10, %xmm11
	vmovdqa	%xmm8, %xmm1
	vpmaddubsw	%xmm4, %xmm11, %xmm13
	vporq	%ymm1, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm13, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm9
	vpmaddwd	%xmm12, %xmm9, %xmm15
	vmovq	%xmm15, %rax
	imull	$100000000, %eax, %r9d
	shrq	$32, %rax
	addl	%eax, %r9d
	movl	%r9d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r12,4)
	cmpq	48(%rsp), %r13
	jnb	.L340
	movq	48(%rsp), %rdx
	cmpq	$66688, %r12
	jne	.L341
	jmp	.L340
	.p2align 4
	.p2align 3
.L557:
	vmovdqu	0(%r13), %xmm8
	incq	%r12
	vpminsb	%xmm2, %xmm8, %xmm7
	vpsubusb	%xmm3, %xmm8, %xmm13
	vpcmpeqb	%xmm7, %xmm8, %xmm1
	vpmovmskb	%xmm1, %r9d
	tzcntl	%r9d, %eax
	incl	%eax
	movq	%rax, %rsi
	addq	%rax, %r13
	salq	$4, %rsi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rsi), %xmm11
	vpshufb	%xmm11, %xmm13, %xmm14
	vmovdqa	%xmm11, %xmm10
	vpmaddubsw	%xmm4, %xmm14, %xmm9
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm9, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm0
	vpmaddwd	%xmm12, %xmm0, %xmm8
	vmovq	%xmm8, %r9
	imull	$100000000, %r9d, %eax
	shrq	$32, %r9
	addl	%eax, %r9d
	movl	%r9d, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r12,4)
	cmpq	%rdx, %r13
	jnb	.L340
	cmpq	$66688, %r12
	je	.L340
.L341:
	vmovdqu	0(%r13), %xmm0
	incq	%r12
	vpminsb	%xmm2, %xmm0, %xmm7
	vpsubusb	%xmm3, %xmm0, %xmm11
	vpcmpeqb	%xmm7, %xmm0, %xmm8
	vpmovmskb	%xmm8, %esi
	tzcntl	%esi, %eax
	incl	%eax
	movq	%rax, %r9
	addq	%rax, %r13
	salq	$4, %r9
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r9), %xmm1
	vpshufb	%xmm1, %xmm11, %xmm13
	vmovdqa	%xmm1, %xmm10
	vpmaddubsw	%xmm4, %xmm13, %xmm14
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm14, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm15
	vpmaddwd	%xmm12, %xmm15, %xmm0
	vmovq	%xmm0, %rax
	imull	$100000000, %eax, %esi
	shrq	$32, %rax
	addl	%esi, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r12,4)
	cmpq	%rdx, %r13
	jb	.L557
.L340:
	movq	40(%rsp), %rsi
	movq	%rbx, %r9
	cmpq	%rsi, %r15
	jnb	.L343
	testb	%cl, %cl
	je	.L343
	movl	$538976288, %edx
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm4
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm12
	vpbroadcastd	%edx, %xmm2
	vpbroadcastd	%eax, %xmm3
	testb	$1, %bl
	je	.L344
	vmovdqu	(%r15), %xmm1
	vpminsb	%xmm2, %xmm1, %xmm7
	vpsubusb	%xmm3, %xmm1, %xmm14
	vpcmpeqb	%xmm7, %xmm1, %xmm11
	vpmovmskb	%xmm11, %r9d
	tzcntl	%r9d, %eax
	leaq	1(%rbx), %r9
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r15
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm14, %xmm9
	vmovdqa	%xmm13, %xmm10
	vpmaddubsw	%xmm4, %xmm9, %xmm15
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm15, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm8
	vpmaddwd	%xmm12, %xmm8, %xmm1
	vmovq	%xmm1, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r9,4)
	cmpq	40(%rsp), %r15
	jb	.L523
	jmp	.L343
	.p2align 4
	.p2align 3
.L344:
	vmovdqu	(%r15), %xmm11
	incq	%r9
	vpminsb	%xmm2, %xmm11, %xmm7
	vpsubusb	%xmm3, %xmm11, %xmm9
	vpcmpeqb	%xmm7, %xmm11, %xmm13
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r15
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm14
	vpshufb	%xmm14, %xmm9, %xmm15
	vmovdqa	%xmm14, %xmm10
	vpmaddubsw	%xmm4, %xmm15, %xmm0
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm0, %xmm8
	vpackusdw	%xmm8, %xmm8, %xmm1
	vpmaddwd	%xmm12, %xmm1, %xmm11
	vmovq	%xmm11, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r9,4)
	cmpq	%rsi, %r15
	jnb	.L343
	vmovdqu	(%r15), %xmm13
	incq	%r9
	vpminsb	%xmm2, %xmm13, %xmm7
	vpsubusb	%xmm3, %xmm13, %xmm15
	vpcmpeqb	%xmm7, %xmm13, %xmm14
	vpmovmskb	%xmm14, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r15
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm9
	vpshufb	%xmm9, %xmm15, %xmm0
	vmovdqa	%xmm9, %xmm10
	vpmaddubsw	%xmm4, %xmm0, %xmm8
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm8, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm11
	vpmaddwd	%xmm12, %xmm11, %xmm13
	vmovq	%xmm13, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r9,4)
	cmpq	%rsi, %r15
	jnb	.L343
.L523:
	cmpq	$66688, %r9
	jne	.L344
.L343:
	movq	72(%rsp), %rdx
	cmpq	%rdx, %r11
	jnb	.L346
	testb	%cl, %cl
	je	.L346
	movl	$538976288, %ecx
	movl	$808464432, %esi
	vmovdqa	.LC8(%rip), %xmm4
	vmovdqa	.LC9(%rip), %xmm5
	vmovdqa	.LC10(%rip), %xmm12
	vpbroadcastd	%ecx, %xmm2
	vpbroadcastd	%esi, %xmm3
	testb	$1, %bl
	je	.L347
	vmovdqu	(%r11), %xmm14
	incq	%rbx
	vpminsb	%xmm2, %xmm14, %xmm7
	vpsubusb	%xmm3, %xmm14, %xmm0
	vpcmpeqb	%xmm7, %xmm14, %xmm9
	vpmovmskb	%xmm9, %eax
	tzcntl	%eax, %ecx
	incl	%ecx
	movq	%rcx, %rdx
	addq	%rcx, %r11
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm15
	vpshufb	%xmm15, %xmm0, %xmm8
	vmovdqa	%xmm15, %xmm10
	vpmaddubsw	%xmm4, %xmm8, %xmm1
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm1, %xmm11
	vpackusdw	%xmm11, %xmm11, %xmm13
	vpmaddwd	%xmm12, %xmm13, %xmm14
	vmovq	%xmm14, %rsi
	imull	$100000000, %esi, %eax
	shrq	$32, %rsi
	addl	%esi, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	72(%rsp), %r11
	jnb	.L346
	movq	72(%rsp), %rdx
	cmpq	$66688, %rbx
	jne	.L347
	jmp	.L346
	.p2align 4
	.p2align 3
.L558:
	vmovdqu	(%r11), %xmm15
	incq	%rbx
	vpminsb	%xmm2, %xmm15, %xmm7
	vpsubusb	%xmm3, %xmm15, %xmm0
	vpcmpeqb	%xmm7, %xmm15, %xmm8
	vpmovmskb	%xmm8, %eax
	tzcntl	%eax, %esi
	incl	%esi
	movq	%rsi, %rcx
	addq	%rsi, %r11
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm1
	vpshufb	%xmm1, %xmm0, %xmm11
	vmovdqa	%xmm1, %xmm10
	vpmaddubsw	%xmm4, %xmm11, %xmm13
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm13, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm9
	vpmaddwd	%xmm12, %xmm9, %xmm15
	vmovq	%xmm15, %rax
	imull	$100000000, %eax, %esi
	shrq	$32, %rax
	addl	%esi, %eax
	movl	%eax, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%rdx, %r11
	jnb	.L346
	cmpq	$66688, %rbx
	je	.L346
.L347:
	vmovdqu	(%r11), %xmm9
	incq	%rbx
	vpminsb	%xmm2, %xmm9, %xmm7
	vpsubusb	%xmm3, %xmm9, %xmm0
	vpcmpeqb	%xmm7, %xmm9, %xmm15
	vpmovmskb	%xmm15, %ecx
	tzcntl	%ecx, %esi
	incl	%esi
	movq	%rsi, %rax
	addq	%rsi, %r11
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm8
	vpshufb	%xmm8, %xmm0, %xmm1
	vmovdqa	%xmm8, %xmm10
	vpmaddubsw	%xmm4, %xmm1, %xmm11
	vporq	%ymm10, %ymm6, %ymm6
	vpmaddwd	%xmm5, %xmm11, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm14
	vpmaddwd	%xmm12, %xmm14, %xmm9
	vmovq	%xmm9, %rsi
	imull	$100000000, %esi, %ecx
	shrq	$32, %rsi
	addl	%ecx, %esi
	movl	%esi, _ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%rdx, %r11
	jb	.L558
.L346:
	cmpq	%r14, %r10
	vpmovmskb	%ymm6, %eax
	setne	%r10b
	cmpq	%r13, 48(%rsp)
	setne	%r13b
	orl	%r13d, %r10d
	cmpq	%r15, 40(%rsp)
	setne	%r15b
	andl	$-2147450880, %eax
	xorl	%edx, %edx
	orl	%r15d, %r10d
	cmpq	%r11, 72(%rsp)
	movzbl	%r10b, %r14d
	setne	%dl
	orl	%edx, %eax
	orl	%eax, %r14d
	jne	.L559
	movq	80(%rsp), %r13
	movq	%r9, 240(%rsp)
	movq	%r8, 248(%rsp)
	leaq	0(,%r12,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region, %esi
	leaq	0(%r13,%r8,4), %rdi
	vzeroupper
	call	memcpy
	addq	248(%rsp), %r12
	movq	240(%rsp), %r11
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+266752, %esi
	leaq	0(%r13,%r12,4), %rdi
	leaq	0(,%r11,4), %rdx
	movq	%r11, 248(%rsp)
	call	memcpy
	addq	248(%rsp), %r12
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN13qp_parse_ms4p10parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEN12qp_parse_ms46NoSideELb0EEES2_S2_S3_mRT2_E6region+533504, %esi
	leaq	0(%r13,%r12,4), %rdi
	addq	%rbx, %r12
	call	memcpy
	leaq	0(%r13,%r12,4), %rdi
	vmovdqa	.LC4(%rip), %ymm12
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC2(%rip), %ymm5
	movq	%rdi, 80(%rsp)
	subq	%r12, 24(%rsp)
.L367:
	cmpq	$133312, 24(%rsp)
	jbe	.L554
.L351:
	movq	72(%rsp), %rdi
	jmp	.L368
.L336:
	movq	%r12, %rbx
	movq	%r13, %rcx
	movq	%r14, %rax
	movq	%r15, %rdx
	movq	%r8, %r12
	movq	%r9, %r13
	movq	%r11, %r14
	movq	%r10, %r15
	vmovdqa64	.LC2(%rip), %ymm16
	vmovdqa64	.LC3(%rip), %ymm29
	movq	%rbx, %r8
	movq	%rcx, %r9
	vmovdqa64	.LC4(%rip), %ymm18
	vmovdqa32	.LC14(%rip), %ymm19
	movq	%rax, %r11
	movq	%rdx, %r10
	jmp	.L338
.L554:
	vzeroupper
.L332:
	movq	24(%rsp), %rdx
	movq	80(%rsp), %rsi
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
.L559:
	.cfi_restore_state
	cmpq	72(%rsp), %rdi
	jnb	.L560
	movq	72(%rsp), %rbx
	leaq	-1(%rbx), %r12
	cmpq	%r12, %rdi
	cmovbe	%rdi, %r12
	cmpq	%rdi, %r12
	movq	%r12, %rsi
	setnb	%r8b
	subq	%rdi, %rsi
	cmpq	$62, %rsi
	jbe	.L374
	cmpq	%rdi, %r12
	jb	.L374
	movl	$1, %ecx
	movl	$538976288, %r15d
	movq	%rdi, %r14
	vpxor	%xmm1, %xmm1, %xmm1
	movq	%rcx, %rax
	vpbroadcastd	%r15d, %zmm6
	subq	%rdi, %rax
	vpbroadcastq	%rcx, %zmm2
	addq	%r12, %rax
	testb	%r8b, %r8b
	cmove	%rcx, %rax
	movq	%rax, %r10
	andq	$-64, %r10
	leaq	(%r10,%rdi), %r9
	testb	$64, %r10b
	je	.L353
	vmovdqu8	(%rdi), %zmm3
	leaq	64(%rdi), %r14
	vpcmpb	$6, %zmm6, %zmm3, %k1
	vmovdqa64	%zmm2, %zmm1{%k1}{z}
	kshiftrw	$8, %k1, %k5
	kshiftrd	$16, %k1, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k1, %k2
	vpaddq	%zmm2, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k2, %k7
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm1, %zmm1{%k4}
	vpaddq	%zmm2, %zmm1, %zmm1{%k6}
	kshiftrw	$8, %k3, %k1
	vpaddq	%zmm2, %zmm1, %zmm1{%k2}
	vpaddq	%zmm2, %zmm1, %zmm1{%k7}
	vpaddq	%zmm2, %zmm1, %zmm1{%k3}
	vpaddq	%zmm2, %zmm1, %zmm1{%k1}
	cmpq	%r14, %r9
	jne	.L353
.L543:
	vextracti64x4	$0x1, %zmm1, %ymm11
	vpaddq	%ymm1, %ymm11, %ymm13
	vextracti64x2	$0x1, %ymm13, %xmm14
	vpaddq	%xmm13, %xmm14, %xmm9
	vpsrldq	$8, %xmm9, %xmm15
	vpaddq	%xmm15, %xmm9, %xmm12
	vmovq	%xmm12, %rdx
	cmpq	%r10, %rax
	je	.L354
	movq	%r9, %r13
.L527:
	movq	%r12, %r11
	xorl	%ebx, %ebx
	leaq	1(%r13), %r10
	subq	%r13, %r11
	andl	$7, %r11d
	cmpb	$32, 0(%r13)
	setg	%bl
	addq	%rbx, %rdx
	cmpq	%r10, %r12
	jnb	.L561
.L354:
	xorl	%r12d, %r12d
	testb	%r8b, %r8b
	cmovne	%rsi, %r12
	leaq	(%rdi,%r12), %rcx
	leaq	1(%rdi,%r12), %rsi
	cmpq	72(%rsp), %rsi
	jnb	.L361
	movq	72(%rsp), %r8
	leaq	2(%rcx), %r10
	leaq	-2(%r8), %rbx
	subq	%rcx, %rbx
	cmpq	$62, %rbx
	jbe	.L473
	cmpq	%r10, %r8
	jb	.L473
	leaq	-1(%r8), %rax
	movl	$1, %r9d
	movl	$538976288, %r13d
	vpxor	%xmm5, %xmm5, %xmm5
	subq	%rcx, %rax
	cmpq	%r10, %r8
	vpbroadcastd	%r13d, %zmm4
	cmovb	%r9, %rax
	vpxor	%xmm6, %xmm6, %xmm6
	movq	%rax, %r15
	vpternlogd	$0xFF, %zmm5, %zmm5, %zmm5
	andq	$-64, %r15
	leaq	(%r15,%rcx), %r14
.L359:
	vmovdqu8	1(%rcx), %zmm2
	addq	$64, %rcx
	vpcmpb	$6, %zmm4, %zmm2, %k7
	vmovdqu8	-64(%rcx), %zmm3{%k7}{z}
	kshiftrw	$8, %k7, %k5
	kshiftrd	$16, %k7, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k7, %k2
	kshiftrd	$16, %k2, %k3
	vpcmpb	$2, %zmm4, %zmm3, %k1
	vpabsb	%zmm5, %zmm7{%k1}{z}
	vpmovzxbw	%ymm7, %zmm8
	vextracti64x4	$0x1, %zmm7, %ymm10
	vpmovzxbw	%ymm10, %zmm0
	vpmovzxwd	%ymm8, %zmm11
	vextracti64x4	$0x1, %zmm8, %ymm1
	vpmovzxwd	%ymm1, %zmm13
	vpmovzxwd	%ymm0, %zmm14
	vpmovzxdq	%ymm11, %zmm12
	vextracti64x4	$0x1, %zmm0, %ymm9
	vpmovzxwd	%ymm9, %zmm15
	vpmovzxdq	%ymm13, %zmm7
	vpaddq	%zmm12, %zmm6, %zmm6{%k7}
	vextracti32x8	$0x1, %zmm13, %ymm8
	vpmovzxdq	%ymm14, %zmm0
	kshiftrw	$8, %k2, %k7
	vmovdqa64	%zmm6, %zmm2
	vextracti32x8	$0x1, %zmm11, %ymm6
	vpmovzxdq	%ymm6, %zmm3
	vpmovzxdq	%ymm8, %zmm10
	vextracti32x8	$0x1, %zmm14, %ymm11
	vpmovzxdq	%ymm15, %zmm13
	vpaddq	%zmm3, %zmm2, %zmm2{%k5}
	vpmovzxdq	%ymm11, %zmm1
	vextracti32x8	$0x1, %zmm15, %ymm14
	vmovdqa64	%zmm2, %zmm3
	vpmovzxdq	%ymm14, %zmm9
	vpaddq	%zmm7, %zmm2, %zmm3{%k4}
	vpaddq	%zmm10, %zmm3, %zmm3{%k6}
	vpaddq	%zmm0, %zmm3, %zmm3{%k2}
	kshiftrw	$8, %k3, %k2
	vpaddq	%zmm1, %zmm3, %zmm3{%k7}
	vpaddq	%zmm13, %zmm3, %zmm3{%k3}
	vmovdqa64	%zmm3, %zmm6
	vpaddq	%zmm9, %zmm3, %zmm6{%k2}
	cmpq	%r14, %rcx
	jne	.L359
	vextracti64x4	$0x1, %zmm6, %ymm4
	vpaddq	%ymm6, %ymm4, %ymm5
	vextracti64x2	$0x1, %ymm5, %xmm15
	vpaddq	%xmm5, %xmm15, %xmm12
	vpsrldq	$8, %xmm12, %xmm2
	vpaddq	%xmm2, %xmm12, %xmm7
	vmovq	%xmm7, %r11
	addq	%r11, %rdx
	cmpq	%r15, %rax
	je	.L361
	addq	%r15, %rsi
.L473:
	movq	%rsi, %r12
	notq	%r12
	addq	72(%rsp), %r12
	andl	$7, %r12d
	cmpb	$32, (%rsi)
	jle	.L528
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rsi)
	setle	%cl
	addq	%rcx, %rdx
.L528:
	leaq	1(%rsi), %rax
	cmpq	72(%rsp), %rax
	jnb	.L361
	testq	%r12, %r12
	je	.L364
	cmpq	$1, %r12
	je	.L475
	cmpq	$2, %r12
	je	.L476
	cmpq	$3, %r12
	je	.L477
	cmpq	$4, %r12
	je	.L478
	cmpq	$5, %r12
	je	.L479
	cmpq	$6, %r12
	je	.L480
	cmpb	$32, 1(%rsi)
	jle	.L530
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
.L530:
	incq	%rax
.L480:
	cmpb	$32, (%rax)
	jle	.L531
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
.L531:
	incq	%rax
.L479:
	cmpb	$32, (%rax)
	jle	.L532
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
.L532:
	incq	%rax
.L478:
	cmpb	$32, (%rax)
	jg	.L562
.L533:
	incq	%rax
.L477:
	cmpb	$32, (%rax)
	jle	.L534
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
.L534:
	incq	%rax
.L476:
	cmpb	$32, (%rax)
	jle	.L535
	xorl	%r15d, %r15d
	cmpb	$32, -1(%rax)
	setle	%r15b
	addq	%r15, %rdx
.L535:
	incq	%rax
.L475:
	cmpb	$32, (%rax)
	jle	.L536
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L536:
	incq	%rax
	cmpq	72(%rsp), %rax
	jnb	.L361
.L364:
	cmpb	$32, (%rax)
	jle	.L365
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
.L365:
	leaq	1(%rax), %r11
	cmpb	$32, 1(%rax)
	jle	.L529
	xorl	%eax, %eax
	cmpb	$32, -1(%r11)
	setle	%al
	addq	%rax, %rdx
.L529:
	cmpb	$32, 1(%r11)
	jle	.L537
	xorl	%r12d, %r12d
	cmpb	$32, (%r11)
	setle	%r12b
	addq	%r12, %rdx
.L537:
	cmpb	$32, 2(%r11)
	jle	.L538
	xorl	%ecx, %ecx
	cmpb	$32, 1(%r11)
	setle	%cl
	addq	%rcx, %rdx
.L538:
	cmpb	$32, 3(%r11)
	jle	.L539
	xorl	%esi, %esi
	cmpb	$32, 2(%r11)
	setle	%sil
	addq	%rsi, %rdx
.L539:
	cmpb	$32, 4(%r11)
	jle	.L540
	xorl	%r10d, %r10d
	cmpb	$32, 3(%r11)
	setle	%r10b
	addq	%r10, %rdx
.L540:
	cmpb	$32, 5(%r11)
	jle	.L541
	xorl	%r8d, %r8d
	cmpb	$32, 4(%r11)
	setle	%r8b
	addq	%r8, %rdx
.L541:
	cmpb	$32, 6(%r11)
	jle	.L542
	xorl	%ebx, %ebx
	cmpb	$32, 5(%r11)
	setle	%bl
	addq	%rbx, %rdx
.L542:
	leaq	7(%r11), %rax
	cmpq	72(%rsp), %rax
	jb	.L364
.L361:
	movq	80(%rsp), %rsi
	subq	%rdx, 24(%rsp)
	leaq	(%rsi,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm12
	movq	%r15, 80(%rsp)
	jmp	.L367
.L353:
	vmovdqu8	(%r14), %zmm7
	vmovdqa64	%zmm1, %zmm8
	subq	$-128, %r14
	vmovdqu8	-64(%r14), %zmm0
	vpcmpb	$6, %zmm6, %zmm7, %k5
	vpaddq	%zmm2, %zmm1, %zmm8{%k5}
	kshiftrw	$8, %k5, %k6
	kshiftrd	$16, %k5, %k4
	vpaddq	%zmm2, %zmm8, %zmm8{%k6}
	kshiftrw	$8, %k4, %k7
	vpaddq	%zmm2, %zmm8, %zmm8{%k4}
	kshiftrq	$32, %k5, %k2
	vpaddq	%zmm2, %zmm8, %zmm8{%k7}
	kshiftrw	$8, %k2, %k1
	vpaddq	%zmm2, %zmm8, %zmm8{%k2}
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm8, %zmm8{%k1}
	kshiftrw	$8, %k3, %k5
	vpcmpb	$6, %zmm6, %zmm0, %k6
	vpaddq	%zmm2, %zmm8, %zmm8{%k3}
	vpaddq	%zmm2, %zmm8, %zmm8{%k5}
	vmovdqa64	%zmm8, %zmm1
	kshiftrw	$8, %k6, %k7
	kshiftrd	$16, %k6, %k4
	vpaddq	%zmm2, %zmm8, %zmm1{%k6}
	vpaddq	%zmm2, %zmm1, %zmm1{%k7}
	kshiftrw	$8, %k4, %k1
	kshiftrq	$32, %k6, %k2
	vpaddq	%zmm2, %zmm1, %zmm1{%k4}
	vpaddq	%zmm2, %zmm1, %zmm1{%k1}
	kshiftrw	$8, %k2, %k5
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm1, %zmm1{%k2}
	vpaddq	%zmm2, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k3, %k6
	vpaddq	%zmm2, %zmm1, %zmm1{%k3}
	vpaddq	%zmm2, %zmm1, %zmm1{%k6}
	cmpq	%r14, %r9
	je	.L543
	jmp	.L353
.L561:
	testq	%r11, %r11
	je	.L356
	cmpq	$1, %r11
	je	.L481
	cmpq	$2, %r11
	je	.L482
	cmpq	$3, %r11
	je	.L483
	cmpq	$4, %r11
	je	.L484
	cmpq	$5, %r11
	je	.L485
	cmpq	$6, %r11
	jne	.L563
.L486:
	xorl	%eax, %eax
	cmpb	$32, (%r10)
	setg	%al
	incq	%r10
	addq	%rax, %rdx
.L485:
	xorl	%r9d, %r9d
	cmpb	$32, (%r10)
	setg	%r9b
	incq	%r10
	addq	%r9, %rdx
.L484:
	xorl	%r15d, %r15d
	cmpb	$32, (%r10)
	setg	%r15b
	incq	%r10
	addq	%r15, %rdx
.L483:
	xorl	%r14d, %r14d
	cmpb	$32, (%r10)
	setg	%r14b
	incq	%r10
	addq	%r14, %rdx
.L482:
	xorl	%r13d, %r13d
	cmpb	$32, (%r10)
	setg	%r13b
	incq	%r10
	addq	%r13, %rdx
.L481:
	xorl	%r11d, %r11d
	cmpb	$32, (%r10)
	setg	%r11b
	incq	%r10
	addq	%r11, %rdx
	cmpq	%r10, %r12
	jb	.L354
.L356:
	xorl	%ebx, %ebx
	cmpb	$32, (%r10)
	setg	%bl
	xorl	%ecx, %ecx
	addq	%rbx, %rdx
	cmpb	$32, 1(%r10)
	setg	%cl
	xorl	%eax, %eax
	addq	%rcx, %rdx
	cmpb	$32, 2(%r10)
	setg	%al
	xorl	%r9d, %r9d
	addq	%rax, %rdx
	cmpb	$32, 3(%r10)
	setg	%r9b
	xorl	%r15d, %r15d
	addq	%r9, %rdx
	cmpb	$32, 4(%r10)
	setg	%r15b
	xorl	%r14d, %r14d
	addq	%r15, %rdx
	cmpb	$32, 5(%r10)
	setg	%r14b
	xorl	%r13d, %r13d
	addq	%r14, %rdx
	cmpb	$32, 6(%r10)
	setg	%r13b
	xorl	%r11d, %r11d
	addq	%r13, %rdx
	cmpb	$32, 7(%r10)
	setg	%r11b
	addq	$8, %r10
	addq	%r11, %rdx
	cmpq	%r10, %r12
	jb	.L354
	jmp	.L356
	.p2align 4
	.p2align 3
.L562:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L533
.L369:
	movq	%rdi, 72(%rsp)
	jmp	.L332
.L560:
	movq	80(%rsp), %rsi
	xorl	%edx, %edx
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm5
	vmovdqa	.LC3(%rip), %ymm4
	vmovdqa	.LC4(%rip), %ymm12
	jmp	.L351
.L374:
	movq	%rdi, %r13
	xorl	%edx, %edx
	jmp	.L527
.L563:
	xorl	%ecx, %ecx
	cmpb	$32, 1(%r13)
	leaq	2(%r13), %r10
	setg	%cl
	addq	%rcx, %rdx
	jmp	.L486
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
	movq	%rsi, %r12
	andq	$-64, %rsp
	subq	$64, %rsp
	movq	%rdx, 16(%rsp)
	cmpq	$133312, %rdx
	jbe	.L600
	vmovdqa	.LC2(%rip), %ymm3
	vmovdqa	.LC3(%rip), %ymm2
	movq	%rdi, %r11
	vmovdqa	.LC4(%rip), %ymm6
	.p2align 4
	.p2align 3
.L599:
	movl	$538976288, %eax
	movq	%r11, 8(%rsp)
	vpxor	%xmm14, %xmm14, %xmm14
	vpbroadcastd	%eax, %ymm4
	vpminsb	133248(%r11), %ymm4, %ymm5
	vpminsb	199872(%r11), %ymm4, %ymm8
	vpminsb	66624(%r11), %ymm4, %ymm0
	vpminsb	266496(%r11), %ymm4, %ymm10
	vpcmpeqb	133248(%r11), %ymm5, %ymm7
	vpcmpeqb	199872(%r11), %ymm8, %ymm9
	vmovdqa	.LC14(%rip), %ymm8
	vpcmpeqb	66624(%r11), %ymm0, %ymm1
	vpmovmskb	%ymm7, %esi
	vpmovmskb	%ymm1, %edx
	vpmovmskb	%ymm9, %r9d
	tzcntl	%esi, %edi
	vpcmpeqb	266496(%r11), %ymm10, %ymm11
	tzcntl	%edx, %ecx
	tzcntl	%r9d, %r10d
	movl	%edi, %r8d
	vpmovmskb	%ymm11, %eax
	movl	%ecx, %ebx
	movl	%r10d, %r14d
	leaq	133249(%r11,%r8), %rdi
	tzcntl	%eax, %edx
	leaq	66625(%r11,%rbx), %r13
	leaq	199873(%r11,%r14), %r15
	movq	%rdi, 40(%rsp)
	movl	%edx, %ecx
	movq	%r13, 32(%rsp)
	movq	%r15, 24(%rsp)
	leaq	266497(%r11,%rcx), %rbx
	movl	$808464432, %r9d
	movq	%rbx, 48(%rsp)
	movq	%r15, %r8
	movq	%r13, %rsi
	vpbroadcastd	%r9d, %ymm5
	movq	%r11, %rcx
	xorl	%ebx, %ebx
	.p2align 4
	.p2align 3
.L570:
	movq	48(%rsp), %rax
	movq	24(%rsp), %r11
	movq	40(%rsp), %r13
	movq	32(%rsp), %r10
	subq	%r8, %rax
	subq	%rdi, %r11
	cmpq	%r11, %rax
	cmovg	%r11, %rax
	subq	%rsi, %r13
	subq	%rcx, %r10
	cmpq	%r10, %r13
	cmovg	%r10, %r13
	cmpq	%r13, %rax
	cmovg	%r13, %rax
	cmpq	$64, %rax
	jbe	.L790
	movabsq	$1135184250689818561, %r14
	movq	%rbx, %r9
	mulq	%r14
	movl	$100000000, %eax
	vpbroadcastd	%eax, %ymm7
	movq	%rdx, %r15
	andq	$-4, %rdx
	shrq	$2, %r15
	movq	%r15, 56(%rsp)
	leaq	(%rdx,%rbx), %rdx
	.p2align 4
	.p2align 3
.L569:
	vmovdqu	(%rcx), %ymm12
	vpminsb	32(%rcx), %ymm4, %ymm0
	vpminsb	%ymm4, %ymm12, %ymm13
	vpcmpeqb	32(%rcx), %ymm0, %ymm1
	vpcmpeqb	%ymm13, %ymm12, %ymm15
	vpmovmskb	%ymm15, %r11d
	blsr	%r11d, %r10d
	tzcntl	%r10d, %r13d
	blsr	%r10d, %r14d
	tzcntl	%r14d, %r10d
	blsr	%r14d, %eax
	vpmovmskb	%ymm1, %r14d
	tzcntl	%r11d, %r15d
	movl	%eax, %r11d
	salq	$32, %r14
	orq	%r14, %r11
	movl	%r15d, %r14d
	vinserti64x2	$0x1, 1(%rcx,%r14), %ymm12, %ymm11
	incl	%r14d
	tzcntq	%r11, %rax
	movl	%r13d, %r11d
	salq	$4, %r14
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm12
	movl	%r13d, %r14d
	vmovdqu	1(%rcx,%r11), %xmm9
	movl	%r10d, %r11d
	subl	%r15d, %r14d
	movl	%r10d, %r15d
	vinserti64x2	$0x1, 1(%rcx,%r11), %ymm9, %ymm10
	subl	%r13d, %r15d
	movl	%eax, %r13d
	incl	%eax
	salq	$4, %r14
	subl	%r10d, %r13d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm12, %ymm15
	addq	%rax, %rcx
	salq	$4, %r15
	vpsubusb	%ymm5, %ymm10, %ymm10
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r15), %xmm13
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm13, %ymm1
	vmovdqa	%ymm15, %ymm13
	vpternlogq	$254, %ymm14, %ymm1, %ymm13
	vpsubusb	%ymm5, %ymm11, %ymm14
	vpshufb	%ymm1, %ymm10, %ymm12
	vpshufb	%ymm15, %ymm14, %ymm0
	vmovdqu	(%rsi), %ymm14
	vpmaddubsw	%ymm3, %ymm12, %ymm15
	vpmaddubsw	%ymm3, %ymm0, %ymm11
	vpmaddwd	%ymm2, %ymm15, %ymm10
	vpmaddwd	%ymm2, %ymm11, %ymm9
	vpminsb	32(%rsi), %ymm4, %ymm11
	vpminsb	%ymm4, %ymm14, %ymm1
	vpcmpeqb	%ymm1, %ymm14, %ymm0
	vpmovmskb	%ymm0, %r10d
	vpcmpeqb	32(%rsi), %ymm11, %ymm12
	tzcntl	%r10d, %r15d
	blsr	%r10d, %eax
	tzcntl	%eax, %r13d
	blsr	%eax, %r11d
	blsr	%r11d, %r14d
	movl	%r14d, %eax
	movl	%r15d, %r14d
	tzcntl	%r11d, %r10d
	vinserti64x2	$0x1, 1(%rsi,%r14), %ymm14, %ymm14
	vpmovmskb	%ymm12, %r11d
	incl	%r14d
	salq	$32, %r11
	salq	$4, %r14
	orq	%r11, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm1
	movl	%r13d, %r14d
	movl	%r13d, %r11d
	tzcntq	%rax, %rax
	subl	%r15d, %r14d
	movl	%r10d, %r15d
	vmovdqu	1(%rsi,%r11), %xmm15
	salq	$4, %r14
	subl	%r13d, %r15d
	movl	%eax, %r13d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm1, %ymm12
	movl	%r10d, %r11d
	subl	%r10d, %r13d
	vinserti64x2	$0x1, 1(%rsi,%r11), %ymm15, %ymm11
	incl	%eax
	salq	$4, %r15
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r15), %xmm0
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm0, %ymm1
	vmovdqa	%ymm12, %ymm15
	addq	%rax, %rsi
	vpsubusb	%ymm5, %ymm11, %ymm11
	vpternlogq	$254, %ymm1, %ymm13, %ymm15
	vpsubusb	%ymm5, %ymm14, %ymm13
	vpshufb	%ymm1, %ymm11, %ymm0
	vpshufb	%ymm12, %ymm13, %ymm14
	vpmaddubsw	%ymm3, %ymm0, %ymm1
	vpmaddubsw	%ymm3, %ymm14, %ymm12
	vmovdqu	(%rdi), %ymm14
	vpmaddwd	%ymm2, %ymm1, %ymm11
	vpminsb	32(%rdi), %ymm4, %ymm1
	vpmaddwd	%ymm2, %ymm12, %ymm13
	vpackusdw	%ymm11, %ymm10, %ymm10
	vpackusdw	%ymm13, %ymm9, %ymm9
	vpmaddwd	%ymm6, %ymm10, %ymm11
	vpmaddwd	%ymm6, %ymm9, %ymm9
	vpminsb	%ymm4, %ymm14, %ymm12
	vpcmpeqb	%ymm12, %ymm14, %ymm0
	vpcmpeqb	32(%rdi), %ymm1, %ymm12
	vpmovmskb	%ymm0, %r10d
	tzcntl	%r10d, %r15d
	blsr	%r10d, %eax
	tzcntl	%eax, %r13d
	blsr	%eax, %r11d
	blsr	%r11d, %r14d
	movl	%r14d, %eax
	movl	%r15d, %r14d
	tzcntl	%r11d, %r10d
	vinserti64x2	$0x1, 1(%rdi,%r14), %ymm14, %ymm0
	vpmovmskb	%ymm12, %r11d
	incl	%r14d
	salq	$32, %r11
	salq	$4, %r14
	orq	%r11, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm12
	movl	%r13d, %r14d
	movl	%r13d, %r11d
	tzcntq	%rax, %rax
	subl	%r15d, %r14d
	movl	%r10d, %r15d
	vmovdqu	1(%rdi,%r11), %xmm14
	subl	%r13d, %r15d
	movl	%eax, %r13d
	movl	%r10d, %r11d
	incl	%eax
	salq	$4, %r14
	subl	%r10d, %r13d
	vinserti64x2	$0x1, 1(%rdi,%r11), %ymm14, %ymm1
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm12, %ymm14
	addq	%rax, %rdi
	salq	$4, %r15
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r15), %xmm12
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm12, %ymm12
	vmovdqa64	%ymm14, %ymm18
	vpsubusb	%ymm5, %ymm1, %ymm1
	vpternlogq	$254, %ymm12, %ymm15, %ymm18
	vpsubusb	%ymm5, %ymm0, %ymm15
	vpshufb	%ymm12, %ymm1, %ymm12
	vpshufb	%ymm14, %ymm15, %ymm0
	vpmaddubsw	%ymm3, %ymm0, %ymm14
	vpmaddubsw	%ymm3, %ymm12, %ymm0
	vpmaddwd	%ymm2, %ymm14, %ymm15
	vmovdqu	(%r8), %ymm14
	vpmaddwd	%ymm2, %ymm0, %ymm12
	vpminsb	%ymm4, %ymm14, %ymm1
	vpcmpeqb	%ymm1, %ymm14, %ymm0
	vpminsb	32(%r8), %ymm4, %ymm1
	vpmovmskb	%ymm0, %r10d
	tzcntl	%r10d, %r15d
	blsr	%r10d, %eax
	blsr	%eax, %r11d
	tzcntl	%r11d, %r10d
	blsr	%r11d, %r14d
	tzcntl	%eax, %r13d
	movl	%r14d, %eax
	movl	%r15d, %r14d
	vpcmpeqb	32(%r8), %ymm1, %ymm0
	vpmovmskb	%ymm0, %r11d
	vinserti64x2	$0x1, 1(%r8,%r14), %ymm14, %ymm0
	salq	$32, %r11
	orq	%r11, %rax
	incl	%r14d
	movl	%r13d, %r11d
	salq	$4, %r14
	vmovdqu	1(%r8,%r11), %xmm14
	movl	%r10d, %r11d
	tzcntq	%rax, %rax
	vpsubusb	%ymm5, %ymm0, %ymm0
	vinserti64x2	$0x1, 1(%r8,%r11), %ymm14, %ymm1
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r14), %xmm14
	movl	%r13d, %r14d
	subl	%r15d, %r14d
	movl	%r10d, %r15d
	salq	$4, %r14
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm14, %ymm17
	subl	%r13d, %r15d
	movl	%eax, %r13d
	incl	%eax
	subl	%r10d, %r13d
	addq	%rax, %r8
	salq	$4, %r15
	vpsubusb	%ymm5, %ymm1, %ymm1
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r15), %xmm14
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r13), %ymm14, %ymm16
	vpshufb	%ymm17, %ymm0, %ymm0
	vmovdqa64	%ymm17, %ymm14
	vpmaddubsw	%ymm3, %ymm0, %ymm0
	vpmaddwd	%ymm2, %ymm0, %ymm0
	vpackusdw	%ymm0, %ymm15, %ymm13
	vpmaddwd	%ymm6, %ymm13, %ymm15
	vshufps	$136, %ymm15, %ymm9, %ymm0
	vshufps	$221, %ymm15, %ymm9, %ymm9
	vpshufb	%ymm16, %ymm1, %ymm1
	vpmulld	%ymm7, %ymm0, %ymm13
	vpternlogq	$254, %ymm16, %ymm18, %ymm14
	vpmaddubsw	%ymm3, %ymm1, %ymm1
	vpmaddwd	%ymm2, %ymm1, %ymm1
	vpackusdw	%ymm1, %ymm12, %ymm12
	vpaddd	%ymm9, %ymm13, %ymm15
	vpmaddwd	%ymm6, %ymm12, %ymm13
	vpermd	%ymm15, %ymm8, %ymm0
	vshufps	$136, %ymm13, %ymm11, %ymm1
	vshufps	$221, %ymm13, %ymm11, %ymm15
	vpmulld	%ymm7, %ymm1, %ymm9
	vpaddd	%ymm15, %ymm9, %ymm10
	vpermd	%ymm10, %ymm8, %ymm11
	vpunpcklqdq	%ymm11, %ymm0, %ymm12
	vpunpckhqdq	%ymm11, %ymm0, %ymm0
	vmovdqu	%xmm12, (%r12,%r9,4)
	vmovdqa	%xmm0, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region(,%r9,4)
	vextracti64x2	$0x1, %ymm12, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266752(,%r9,4)
	vextracti64x2	$0x1, %ymm0, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533504(,%r9,4)
	addq	$4, %r9
	cmpq	%rdx, %r9
	jne	.L569
	movq	56(%rsp), %rdx
	leaq	(%rbx,%rdx,4), %rbx
	jmp	.L570
	.p2align 4
	.p2align 3
.L790:
	movq	32(%rsp), %r13
	movq	24(%rsp), %r10
	movq	8(%rsp), %r11
	movq	%rbx, %r9
	cmpq	%r13, %rcx
	jnb	.L568
	vmovdqa	.LC8(%rip), %xmm2
	vmovdqa	.LC9(%rip), %xmm3
	movl	$538976288, %eax
	movl	$808464432, %r14d
	vmovdqa	.LC10(%rip), %xmm6
	vpbroadcastd	%eax, %xmm4
	vpbroadcastd	%r14d, %xmm5
	.p2align 4
	.p2align 3
.L567:
	vmovdqu	(%rcx), %xmm7
	incq	%r9
	vpminsb	%xmm4, %xmm7, %xmm8
	vpsubusb	%xmm5, %xmm7, %xmm10
	vpcmpeqb	%xmm8, %xmm7, %xmm1
	vpmovmskb	%xmm1, %r15d
	tzcntl	%r15d, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rcx
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm9
	vpshufb	%xmm9, %xmm10, %xmm11
	vmovdqa	%xmm9, %xmm15
	vpmaddubsw	%xmm2, %xmm11, %xmm12
	vporq	%ymm15, %ymm14, %ymm14
	vpmaddwd	%xmm3, %xmm12, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm13
	vpmaddwd	%xmm6, %xmm13, %xmm7
	vmovq	%xmm7, %r14
	imull	$100000000, %r14d, %r15d
	shrq	$32, %r14
	addl	%r15d, %r14d
	movl	%r14d, -4(%r12,%r9,4)
	cmpq	%r13, %rcx
	jb	.L567
.L568:
	movq	40(%rsp), %rdx
	cmpq	$66687, %rbx
	movq	%rbx, %r14
	setbe	56(%rsp)
	cmpq	%rdx, %rsi
	jnb	.L571
	cmpb	$0, 56(%rsp)
	je	.L571
	movl	$538976288, %eax
	movl	$808464432, %r15d
	vmovdqa	.LC8(%rip), %xmm2
	vmovdqa	.LC9(%rip), %xmm3
	vmovdqa	.LC10(%rip), %xmm6
	vpbroadcastd	%eax, %xmm4
	vpbroadcastd	%r15d, %xmm5
	testb	$1, %bl
	je	.L572
	vmovdqu	(%rsi), %xmm8
	vpminsb	%xmm4, %xmm8, %xmm1
	vpsubusb	%xmm5, %xmm8, %xmm11
	vpcmpeqb	%xmm1, %xmm8, %xmm9
	vpmovmskb	%xmm9, %edx
	tzcntl	%edx, %r14d
	incl	%r14d
	movq	%r14, %rax
	addq	%r14, %rsi
	leaq	1(%rbx), %r14
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm15
	vpshufb	%xmm15, %xmm11, %xmm12
	vmovdqa	%xmm15, %xmm10
	vpmaddubsw	%xmm2, %xmm12, %xmm0
	vporq	%ymm10, %ymm14, %ymm14
	vpmaddwd	%xmm3, %xmm0, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm7
	vpmaddwd	%xmm6, %xmm7, %xmm8
	vmovq	%xmm8, %r15
	imull	$100000000, %r15d, %edx
	shrq	$32, %r15
	addl	%r15d, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r14,4)
	cmpq	40(%rsp), %rsi
	jnb	.L571
	movq	40(%rsp), %rdx
	cmpq	$66688, %r14
	jne	.L572
	jmp	.L571
	.p2align 4
	.p2align 3
.L791:
	vmovdqu	(%rsi), %xmm9
	incq	%r14
	vpminsb	%xmm4, %xmm9, %xmm15
	vpsubusb	%xmm5, %xmm9, %xmm0
	vpcmpeqb	%xmm15, %xmm9, %xmm11
	vpmovmskb	%xmm11, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %r15
	addq	%rax, %rsi
	salq	$4, %r15
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r15), %xmm12
	vpshufb	%xmm12, %xmm0, %xmm13
	vmovdqa	%xmm12, %xmm10
	vpmaddubsw	%xmm2, %xmm13, %xmm7
	vporq	%ymm10, %ymm14, %ymm14
	vpmaddwd	%xmm3, %xmm7, %xmm8
	vpackusdw	%xmm8, %xmm8, %xmm1
	vpmaddwd	%xmm6, %xmm1, %xmm9
	vmovq	%xmm9, %rax
	imull	$100000000, %eax, %r15d
	shrq	$32, %rax
	addl	%eax, %r15d
	movl	%r15d, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r14,4)
	cmpq	%rdx, %rsi
	jnb	.L571
	cmpq	$66688, %r14
	je	.L571
.L572:
	vmovdqu	(%rsi), %xmm1
	incq	%r14
	vpminsb	%xmm4, %xmm1, %xmm9
	vpsubusb	%xmm5, %xmm1, %xmm12
	vpcmpeqb	%xmm9, %xmm1, %xmm15
	vpmovmskb	%xmm15, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %r15
	addq	%rax, %rsi
	salq	$4, %r15
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r15), %xmm11
	vpshufb	%xmm11, %xmm12, %xmm0
	vmovdqa	%xmm11, %xmm10
	vpmaddubsw	%xmm2, %xmm0, %xmm13
	vporq	%ymm10, %ymm14, %ymm14
	vpmaddwd	%xmm3, %xmm13, %xmm7
	vpackusdw	%xmm7, %xmm7, %xmm8
	vpmaddwd	%xmm6, %xmm8, %xmm1
	vmovq	%xmm1, %rax
	imull	$100000000, %eax, %r15d
	shrq	$32, %rax
	addl	%eax, %r15d
	movl	%r15d, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region-4(,%r14,4)
	cmpq	%rdx, %rsi
	jb	.L791
.L571:
	movq	%rbx, %r15
	cmpq	%r10, %rdi
	jnb	.L574
	cmpb	$0, 56(%rsp)
	je	.L574
	movl	$538976288, %edx
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm2
	vmovdqa	.LC9(%rip), %xmm3
	vmovdqa	.LC10(%rip), %xmm6
	vpbroadcastd	%edx, %xmm4
	vpbroadcastd	%eax, %xmm5
	testb	$1, %bl
	je	.L575
	vmovdqu	(%rdi), %xmm15
	vpminsb	%xmm4, %xmm15, %xmm11
	vpsubusb	%xmm5, %xmm15, %xmm0
	vpcmpeqb	%xmm11, %xmm15, %xmm12
	vpmovmskb	%xmm12, %r15d
	tzcntl	%r15d, %eax
	leaq	1(%rbx), %r15
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm0, %xmm7
	vmovdqa	%xmm13, %xmm10
	vpmaddubsw	%xmm2, %xmm7, %xmm8
	vporq	%ymm10, %ymm14, %ymm14
	vpmaddwd	%xmm3, %xmm8, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm9
	vpmaddwd	%xmm6, %xmm9, %xmm15
	vmovq	%xmm15, %rax
	jmp	.L789
	.p2align 4
	.p2align 3
.L792:
	cmpq	$66688, %r15
	je	.L574
.L575:
	vmovdqu	(%rdi), %xmm11
	incq	%r15
	vpminsb	%xmm4, %xmm11, %xmm12
	vpsubusb	%xmm5, %xmm11, %xmm0
	vpcmpeqb	%xmm12, %xmm11, %xmm13
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm7
	vpshufb	%xmm7, %xmm0, %xmm8
	vmovdqa	%xmm7, %xmm10
	vpmaddubsw	%xmm2, %xmm8, %xmm1
	vporq	%ymm10, %ymm14, %ymm14
	vpmaddwd	%xmm3, %xmm1, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm15
	vpmaddwd	%xmm6, %xmm15, %xmm11
	vmovq	%xmm11, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r15,4)
	cmpq	%r10, %rdi
	jnb	.L574
	vmovdqu	(%rdi), %xmm12
	incq	%r15
	vpminsb	%xmm4, %xmm12, %xmm13
	vpsubusb	%xmm5, %xmm12, %xmm0
	vpcmpeqb	%xmm13, %xmm12, %xmm7
	vpmovmskb	%xmm7, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %rdi
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm8
	vpshufb	%xmm8, %xmm0, %xmm1
	vmovdqa	%xmm8, %xmm10
	vpmaddubsw	%xmm2, %xmm1, %xmm9
	vporq	%ymm10, %ymm14, %ymm14
	vpmaddwd	%xmm3, %xmm9, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm11
	vpmaddwd	%xmm6, %xmm11, %xmm12
	vmovq	%xmm12, %rax
.L789:
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266748(,%r15,4)
	cmpq	%r10, %rdi
	jb	.L792
.L574:
	movq	48(%rsp), %rdx
	cmpq	%rdx, %r8
	jnb	.L577
	cmpb	$0, 56(%rsp)
	je	.L577
	movl	$538976288, %eax
	vmovdqa	.LC8(%rip), %xmm1
	vmovdqa	.LC9(%rip), %xmm4
	vmovdqa	.LC10(%rip), %xmm5
	vpbroadcastd	%eax, %xmm8
	movl	$808464432, %eax
	vpbroadcastd	%eax, %xmm9
	testb	$1, %bl
	jne	.L755
	movq	%r13, 56(%rsp)
	movq	%rdx, %r13
	jmp	.L578
	.p2align 4
	.p2align 3
.L793:
	vmovdqu	(%r8), %xmm6
	incq	%rbx
	vpminsb	%xmm8, %xmm6, %xmm13
	vpsubusb	%xmm9, %xmm6, %xmm0
	vpcmpeqb	%xmm13, %xmm6, %xmm7
	vpmovmskb	%xmm7, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm15
	vpshufb	%xmm15, %xmm0, %xmm11
	vmovdqa	%xmm15, %xmm10
	vpmaddubsw	%xmm1, %xmm11, %xmm12
	vporq	%ymm10, %ymm14, %ymm14
	vpmaddwd	%xmm4, %xmm12, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm3
	vpmaddwd	%xmm5, %xmm3, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%r13, %r8
	jnb	.L777
	cmpq	$66688, %rbx
	je	.L777
.L578:
	vmovdqu	(%r8), %xmm3
	incq	%rbx
	vpminsb	%xmm8, %xmm3, %xmm6
	vpsubusb	%xmm9, %xmm3, %xmm0
	vpcmpeqb	%xmm6, %xmm3, %xmm13
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm7
	vpshufb	%xmm7, %xmm0, %xmm15
	vmovdqa	%xmm7, %xmm10
	vpmaddubsw	%xmm1, %xmm15, %xmm11
	vporq	%ymm10, %ymm14, %ymm14
	vpmaddwd	%xmm4, %xmm11, %xmm12
	vpackusdw	%xmm12, %xmm12, %xmm2
	vpmaddwd	%xmm5, %xmm2, %xmm3
	vmovq	%xmm3, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	%r13, %r8
	jb	.L793
.L777:
	movq	56(%rsp), %r13
.L577:
	cmpq	%rcx, %r13
	vpmovmskb	%ymm14, %eax
	setne	%dl
	cmpq	%rsi, 40(%rsp)
	setne	%cl
	orl	%ecx, %edx
	cmpq	%rdi, %r10
	setne	%sil
	andl	$-2147450880, %eax
	xorl	%r10d, %r10d
	orl	%esi, %edx
	cmpq	%r8, 48(%rsp)
	movzbl	%dl, %edi
	setne	%r10b
	orl	%r10d, %eax
	orl	%eax, %edi
	jne	.L794
	movq	%r9, 56(%rsp)
	leaq	(%r12,%r9,4), %rdi
	leaq	0(,%r14,4), %rdx
	movl	$_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region, %esi
	vzeroupper
	call	memcpy
	movq	56(%rsp), %r11
	leaq	0(,%r15,4), %rdx
	movl	$_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+266752, %esi
	leaq	(%r11,%r14), %r14
	leaq	(%r12,%r14,4), %rdi
	addq	%r15, %r14
	call	memcpy
	leaq	(%r12,%r14,4), %rdi
	leaq	0(,%rbx,4), %rdx
	movl	$_ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533504, %esi
	call	memcpy
	vmovdqa	.LC4(%rip), %ymm6
	vmovdqa	.LC3(%rip), %ymm2
	addq	%rbx, %r14
	vmovdqa	.LC2(%rip), %ymm3
	subq	%r14, 16(%rsp)
	leaq	(%r12,%r14,4), %r12
.L598:
	cmpq	$133312, 16(%rsp)
	jbe	.L786
.L582:
	movq	48(%rsp), %r11
	jmp	.L599
.L755:
	vmovdqu	(%r8), %xmm2
	incq	%rbx
	vpminsb	%xmm8, %xmm2, %xmm3
	vpsubusb	%xmm9, %xmm2, %xmm10
	vpcmpeqb	%xmm3, %xmm2, %xmm6
	vpmovmskb	%xmm6, %edx
	tzcntl	%edx, %eax
	incl	%eax
	movq	%rax, %rdx
	addq	%rax, %r8
	salq	$4, %rdx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdx), %xmm13
	vpshufb	%xmm13, %xmm10, %xmm0
	vmovdqa	%xmm13, %xmm7
	vpmaddubsw	%xmm1, %xmm0, %xmm15
	vporq	%ymm7, %ymm14, %ymm14
	vpmaddwd	%xmm4, %xmm15, %xmm11
	vpackusdw	%xmm11, %xmm11, %xmm12
	vpmaddwd	%xmm5, %xmm12, %xmm2
	vmovq	%xmm2, %rax
	imull	$100000000, %eax, %edx
	shrq	$32, %rax
	addl	%eax, %edx
	movl	%edx, _ZZN12qp_parse_ms410parse_sideILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEENS_6NoSideELb0EEES2_S2_S3_mRT2_E6region+533500(,%rbx,4)
	cmpq	48(%rsp), %r8
	jnb	.L577
	cmpq	$66688, %rbx
	je	.L577
	movq	%r13, 56(%rsp)
	movq	48(%rsp), %r13
	jmp	.L578
.L786:
	vzeroupper
.L565:
	movq	16(%rsp), %rdx
	movq	48(%rsp), %rdi
	leaq	-40(%rbp), %rsp
	movq	%r12, %rsi
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	_ZN13qp_parse_flat12parse_tokensEPcPjm
.L794:
	.cfi_restore_state
	cmpq	48(%rsp), %r11
	jnb	.L795
	movq	48(%rsp), %r15
	leaq	-1(%r15), %r13
	cmpq	%r13, %r11
	cmovbe	%r11, %r13
	cmpq	%r11, %r13
	movq	%r13, %rsi
	setnb	%dil
	subq	%r11, %rsi
	cmpq	$62, %rsi
	jbe	.L604
	cmpq	%r11, %r13
	jb	.L604
	movl	$1, %eax
	movl	$538976288, %ebx
	movq	%r11, %rdx
	vpxor	%xmm1, %xmm1, %xmm1
	movq	%rax, %r9
	vpbroadcastd	%ebx, %zmm14
	subq	%r11, %r9
	vpbroadcastq	%rax, %zmm4
	addq	%r13, %r9
	testb	%dil, %dil
	cmove	%rax, %r9
	movq	%r9, %rcx
	andq	$-64, %rcx
	leaq	(%r11,%rcx), %r8
	testb	$64, %cl
	je	.L584
	vmovdqu8	(%r11), %zmm1
	leaq	64(%r11), %rdx
	vpcmpb	$6, %zmm14, %zmm1, %k1
	vmovdqa64	%zmm4, %zmm1{%k1}{z}
	kshiftrw	$8, %k1, %k5
	kshiftrd	$16, %k1, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k1, %k2
	vpaddq	%zmm4, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k2, %k7
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm4, %zmm1, %zmm1{%k4}
	vpaddq	%zmm4, %zmm1, %zmm1{%k6}
	kshiftrw	$8, %k3, %k1
	vpaddq	%zmm4, %zmm1, %zmm1{%k2}
	vpaddq	%zmm4, %zmm1, %zmm1{%k7}
	vpaddq	%zmm4, %zmm1, %zmm1{%k3}
	vpaddq	%zmm4, %zmm1, %zmm1{%k1}
	cmpq	%r8, %rdx
	jne	.L584
.L774:
	vextracti64x4	$0x1, %zmm1, %ymm7
	vpaddq	%ymm1, %ymm7, %ymm15
	vextracti64x2	$0x1, %ymm15, %xmm10
	vpaddq	%xmm15, %xmm10, %xmm0
	vpsrldq	$8, %xmm0, %xmm11
	vpaddq	%xmm11, %xmm0, %xmm12
	vmovq	%xmm12, %rdx
	cmpq	%rcx, %r9
	je	.L585
	movq	%r8, %r10
.L758:
	movq	%r13, %r14
	xorl	%r15d, %r15d
	leaq	1(%r10), %r9
	subq	%r10, %r14
	andl	$7, %r14d
	cmpb	$32, (%r10)
	setg	%r15b
	addq	%r15, %rdx
	cmpq	%r9, %r13
	jnb	.L796
.L585:
	xorl	%r13d, %r13d
	testb	%dil, %dil
	cmovne	%rsi, %r13
	leaq	(%r11,%r13), %r10
	leaq	1(%r11,%r13), %rsi
	cmpq	48(%rsp), %rsi
	jnb	.L592
	movq	48(%rsp), %r8
	leaq	2(%r10), %r9
	leaq	-2(%r8), %rdi
	subq	%r10, %rdi
	cmpq	$62, %rdi
	jbe	.L704
	cmpq	%r9, %r8
	jb	.L704
	leaq	-1(%r8), %rbx
	movl	$1, %ecx
	movl	$538976288, %eax
	vpxor	%xmm2, %xmm2, %xmm2
	subq	%r10, %rbx
	cmpq	%r9, %r8
	vpbroadcastd	%eax, %zmm6
	cmovb	%rcx, %rbx
	vpxor	%xmm10, %xmm10, %xmm10
	movq	%rbx, %r14
	vpternlogd	$0xFF, %zmm2, %zmm2, %zmm2
	andq	$-64, %r14
	leaq	(%r14,%r10), %r15
.L590:
	vmovdqu8	1(%r10), %zmm3
	vmovdqa64	%zmm10, %zmm11
	addq	$64, %r10
	vpcmpb	$6, %zmm6, %zmm3, %k7
	vmovdqu8	-64(%r10), %zmm14{%k7}{z}
	kshiftrw	$8, %k7, %k5
	kshiftrd	$16, %k7, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k7, %k2
	kshiftrd	$16, %k2, %k3
	vpcmpb	$2, %zmm6, %zmm14, %k1
	vpabsb	%zmm2, %zmm4{%k1}{z}
	vpmovzxbw	%ymm4, %zmm8
	vextracti64x4	$0x1, %zmm4, %ymm5
	vpmovzxbw	%ymm5, %zmm9
	vpmovzxwd	%ymm8, %zmm13
	vextracti64x4	$0x1, %zmm8, %ymm1
	vpmovzxwd	%ymm1, %zmm7
	vpmovzxwd	%ymm9, %zmm15
	vpmovzxdq	%ymm13, %zmm3
	vextracti64x4	$0x1, %zmm9, %ymm0
	vpmovzxdq	%ymm7, %zmm4
	vextracti32x8	$0x1, %zmm7, %ymm5
	vpaddq	%zmm3, %zmm10, %zmm11{%k7}
	vextracti32x8	$0x1, %zmm13, %ymm10
	vpmovzxdq	%ymm5, %zmm9
	kshiftrw	$8, %k2, %k7
	vpmovzxdq	%ymm10, %zmm14
	vpmovzxdq	%ymm15, %zmm1
	vextracti32x8	$0x1, %zmm15, %ymm7
	vpmovzxwd	%ymm0, %zmm12
	vpaddq	%zmm14, %zmm11, %zmm11{%k5}
	vpmovzxdq	%ymm7, %zmm15
	vmovdqa64	%zmm11, %zmm8
	vpmovzxdq	%ymm12, %zmm0
	vextracti32x8	$0x1, %zmm12, %ymm12
	vpmovzxdq	%ymm12, %zmm3
	vpaddq	%zmm4, %zmm11, %zmm8{%k4}
	vmovdqa64	%zmm8, %zmm13
	vpaddq	%zmm9, %zmm8, %zmm13{%k6}
	vpaddq	%zmm1, %zmm13, %zmm13{%k2}
	kshiftrw	$8, %k3, %k2
	vpaddq	%zmm15, %zmm13, %zmm13{%k7}
	vmovdqa64	%zmm13, %zmm10
	vpaddq	%zmm0, %zmm13, %zmm10{%k3}
	vpaddq	%zmm3, %zmm10, %zmm10{%k2}
	cmpq	%r15, %r10
	jne	.L590
	vextracti64x4	$0x1, %zmm10, %ymm6
	vpaddq	%ymm10, %ymm6, %ymm2
	vextracti64x2	$0x1, %ymm2, %xmm11
	vpaddq	%xmm2, %xmm11, %xmm14
	vpsrldq	$8, %xmm14, %xmm4
	vpaddq	%xmm4, %xmm14, %xmm8
	vmovq	%xmm8, %r13
	addq	%r13, %rdx
	cmpq	%rbx, %r14
	je	.L592
	addq	%r14, %rsi
.L704:
	movq	%rsi, %r10
	notq	%r10
	addq	48(%rsp), %r10
	andl	$7, %r10d
	cmpb	$32, (%rsi)
	jle	.L759
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rsi)
	setle	%r9b
	addq	%r9, %rdx
.L759:
	leaq	1(%rsi), %rax
	cmpq	48(%rsp), %rax
	jnb	.L592
	testq	%r10, %r10
	je	.L595
	cmpq	$1, %r10
	je	.L706
	cmpq	$2, %r10
	je	.L707
	cmpq	$3, %r10
	je	.L708
	cmpq	$4, %r10
	je	.L709
	cmpq	$5, %r10
	je	.L710
	cmpq	$6, %r10
	je	.L711
	cmpb	$32, 1(%rsi)
	jg	.L797
.L761:
	incq	%rax
.L711:
	cmpb	$32, (%rax)
	jle	.L762
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
.L762:
	incq	%rax
.L710:
	cmpb	$32, (%rax)
	jg	.L798
.L763:
	incq	%rax
.L709:
	cmpb	$32, (%rax)
	jg	.L799
.L764:
	incq	%rax
.L708:
	cmpb	$32, (%rax)
	jg	.L800
.L765:
	incq	%rax
.L707:
	cmpb	$32, (%rax)
	jle	.L766
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L766:
	incq	%rax
.L706:
	cmpb	$32, (%rax)
	jle	.L767
	xorl	%r15d, %r15d
	cmpb	$32, -1(%rax)
	setle	%r15b
	addq	%r15, %rdx
.L767:
	incq	%rax
	cmpq	48(%rsp), %rax
	jnb	.L592
.L595:
	cmpb	$32, (%rax)
	jle	.L596
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
.L596:
	leaq	1(%rax), %r10
	cmpb	$32, 1(%rax)
	jle	.L760
	xorl	%eax, %eax
	cmpb	$32, -1(%r10)
	setle	%al
	addq	%rax, %rdx
.L760:
	cmpb	$32, 1(%r10)
	jle	.L768
	xorl	%r9d, %r9d
	cmpb	$32, (%r10)
	setle	%r9b
	addq	%r9, %rdx
.L768:
	cmpb	$32, 2(%r10)
	jle	.L769
	xorl	%esi, %esi
	cmpb	$32, 1(%r10)
	setle	%sil
	addq	%rsi, %rdx
.L769:
	cmpb	$32, 3(%r10)
	jle	.L770
	xorl	%r8d, %r8d
	cmpb	$32, 2(%r10)
	setle	%r8b
	addq	%r8, %rdx
.L770:
	cmpb	$32, 4(%r10)
	jle	.L771
	xorl	%edi, %edi
	cmpb	$32, 3(%r10)
	setle	%dil
	addq	%rdi, %rdx
.L771:
	cmpb	$32, 5(%r10)
	jle	.L772
	xorl	%ebx, %ebx
	cmpb	$32, 4(%r10)
	setle	%bl
	addq	%rbx, %rdx
.L772:
	cmpb	$32, 6(%r10)
	jle	.L773
	xorl	%ecx, %ecx
	cmpb	$32, 5(%r10)
	setle	%cl
	addq	%rcx, %rdx
.L773:
	leaq	7(%r10), %rax
	cmpq	48(%rsp), %rax
	jb	.L595
.L592:
	subq	%rdx, 16(%rsp)
	movq	%r12, %rsi
	movq	%r11, %rdi
	leaq	(%r12,%rdx,4), %r12
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm3
	vmovdqa	.LC3(%rip), %ymm2
	vmovdqa	.LC4(%rip), %ymm6
	jmp	.L598
.L584:
	vmovdqu8	(%rdx), %zmm5
	vmovdqa64	%zmm1, %zmm8
	subq	$-128, %rdx
	vmovdqu8	-64(%rdx), %zmm13
	vpcmpb	$6, %zmm14, %zmm5, %k5
	vpaddq	%zmm4, %zmm1, %zmm8{%k5}
	kshiftrw	$8, %k5, %k6
	kshiftrd	$16, %k5, %k4
	vpaddq	%zmm4, %zmm8, %zmm8{%k6}
	kshiftrw	$8, %k4, %k7
	vpaddq	%zmm4, %zmm8, %zmm8{%k4}
	kshiftrq	$32, %k5, %k2
	vpaddq	%zmm4, %zmm8, %zmm8{%k7}
	kshiftrw	$8, %k2, %k1
	vpaddq	%zmm4, %zmm8, %zmm8{%k2}
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm4, %zmm8, %zmm8{%k1}
	kshiftrw	$8, %k3, %k5
	vpcmpb	$6, %zmm14, %zmm13, %k6
	vpaddq	%zmm4, %zmm8, %zmm8{%k3}
	vpaddq	%zmm4, %zmm8, %zmm8{%k5}
	vmovdqa64	%zmm8, %zmm1
	kshiftrw	$8, %k6, %k7
	kshiftrd	$16, %k6, %k4
	vpaddq	%zmm4, %zmm8, %zmm1{%k6}
	vpaddq	%zmm4, %zmm1, %zmm1{%k7}
	kshiftrw	$8, %k4, %k1
	kshiftrq	$32, %k6, %k2
	vpaddq	%zmm4, %zmm1, %zmm1{%k4}
	vpaddq	%zmm4, %zmm1, %zmm1{%k1}
	kshiftrw	$8, %k2, %k5
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm4, %zmm1, %zmm1{%k2}
	vpaddq	%zmm4, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k3, %k6
	vpaddq	%zmm4, %zmm1, %zmm1{%k3}
	vpaddq	%zmm4, %zmm1, %zmm1{%k6}
	cmpq	%r8, %rdx
	je	.L774
	jmp	.L584
.L796:
	testq	%r14, %r14
	je	.L587
	cmpq	$1, %r14
	je	.L712
	cmpq	$2, %r14
	je	.L713
	cmpq	$3, %r14
	je	.L714
	cmpq	$4, %r14
	je	.L715
	cmpq	$5, %r14
	je	.L716
	cmpq	$6, %r14
	jne	.L801
.L717:
	xorl	%ecx, %ecx
	cmpb	$32, (%r9)
	setg	%cl
	incq	%r9
	addq	%rcx, %rdx
.L716:
	xorl	%r8d, %r8d
	cmpb	$32, (%r9)
	setg	%r8b
	incq	%r9
	addq	%r8, %rdx
.L715:
	xorl	%ebx, %ebx
	cmpb	$32, (%r9)
	setg	%bl
	incq	%r9
	addq	%rbx, %rdx
.L714:
	xorl	%r10d, %r10d
	cmpb	$32, (%r9)
	setg	%r10b
	incq	%r9
	addq	%r10, %rdx
.L713:
	xorl	%r14d, %r14d
	cmpb	$32, (%r9)
	setg	%r14b
	incq	%r9
	addq	%r14, %rdx
.L712:
	xorl	%r15d, %r15d
	cmpb	$32, (%r9)
	setg	%r15b
	incq	%r9
	addq	%r15, %rdx
	cmpq	%r9, %r13
	jb	.L585
.L587:
	xorl	%eax, %eax
	cmpb	$32, (%r9)
	setg	%al
	xorl	%ecx, %ecx
	addq	%rax, %rdx
	cmpb	$32, 1(%r9)
	setg	%cl
	xorl	%r8d, %r8d
	addq	%rcx, %rdx
	cmpb	$32, 2(%r9)
	setg	%r8b
	xorl	%ebx, %ebx
	addq	%r8, %rdx
	cmpb	$32, 3(%r9)
	setg	%bl
	xorl	%r10d, %r10d
	addq	%rbx, %rdx
	cmpb	$32, 4(%r9)
	setg	%r10b
	xorl	%r14d, %r14d
	addq	%r10, %rdx
	cmpb	$32, 5(%r9)
	setg	%r14b
	xorl	%r15d, %r15d
	addq	%r14, %rdx
	cmpb	$32, 6(%r9)
	setg	%r15b
	xorl	%eax, %eax
	addq	%r15, %rdx
	cmpb	$32, 7(%r9)
	setg	%al
	addq	$8, %r9
	addq	%rax, %rdx
	cmpq	%r9, %r13
	jb	.L585
	jmp	.L587
	.p2align 4
	.p2align 3
.L800:
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
	jmp	.L765
.L799:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L764
.L798:
	xorl	%edi, %edi
	cmpb	$32, -1(%rax)
	setle	%dil
	addq	%rdi, %rdx
	jmp	.L763
.L600:
	movq	%rdi, 48(%rsp)
	jmp	.L565
.L795:
	xorl	%edx, %edx
	movq	%r12, %rsi
	movq	%r11, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm3
	vmovdqa	.LC3(%rip), %ymm2
	vmovdqa	.LC4(%rip), %ymm6
	jmp	.L582
.L604:
	movq	%r11, %r10
	xorl	%edx, %edx
	jmp	.L758
.L797:
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
	jmp	.L761
.L801:
	xorl	%eax, %eax
	cmpb	$32, 1(%r10)
	leaq	2(%r10), %r9
	setg	%al
	addq	%rax, %rdx
	jmp	.L717
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
	jbe	.L808
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	$10000, %ecx
	movl	$9999999, %r8d
	movl	$999999, %r9d
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	movl	$99999, %r10d
	vpbroadcastd	%r8d, %ymm5
	subq	$232, %rsp
	vpbroadcastd	%r9d, %ymm0
	vpbroadcastd	%r10d, %ymm1
	movl	$9999, %r11d
	vpbroadcastd	%ecx, %ymm17
	vpbroadcastd	%r11d, %ymm2
	vmovdqa	%ymm5, -88(%rsp)
	vmovdqa	%ymm0, -120(%rsp)
	vmovdqa	%ymm1, 168(%rsp)
	vmovdqa32	.LC21(%rip), %ymm21
	vmovdqa32	.LC22(%rip), %ymm20
	movl	$999, %ecx
	movl	$99, %r8d
	vmovdqa64	.LC40(%rip), %ymm29
	vmovdqa64	.LC41(%rip), %ymm19
	movl	$9, %r9d
	movl	$65280, %r10d
	vmovdqa64	.LC42(%rip), %ymm28
	vmovdqa64	.LC43(%rip), %ymm18
	movl	$343610491, %r11d
	movq	%rsi, %rax
	movq	%rdx, %rsi
	movl	$32, %edx
	vpbroadcastd	%ecx, %ymm3
	vpbroadcastd	%r8d, %ymm4
	vpbroadcastd	%r9d, %ymm6
	vpbroadcastd	%r10d, %ymm7
	vmovdqa	%ymm2, 136(%rsp)
	vpbroadcastd	%r11d, %ymm16
	vmovdqa	%ymm3, 72(%rsp)
	vmovdqa	%ymm4, 40(%rsp)
	vmovdqa	%ymm6, 8(%rsp)
	vmovdqa	%ymm7, -24(%rsp)
	.p2align 4
	.p2align 3
.L804:
	vmovdqu	-128(%rdi,%rdx,4), %ymm13
	vmovdqa32	-120(%rsp), %ymm27
	movl	$572662306, %ecx
	movl	$1145324612, %r8d
	vmovdqa32	168(%rsp), %ymm30
	vmovdqa32	136(%rsp), %ymm26
	kmovd	%ecx, %k3
	movl	$-2004318072, %r9d
	vmovdqa32	-88(%rsp), %ymm31
	movl	$65436, %r10d
	movl	$429529498, %r11d
	movl	$16122102, %ecx
	kmovd	%r8d, %k2
	movl	$808464432, %r8d
	vmovdqu	-96(%rdi,%rdx,4), %ymm4
	vmovdqu	-64(%rdi,%rdx,4), %ymm3
	vmovdqu	-32(%rdi,%rdx,4), %ymm2
	addq	$32, %rdx
	addq	$320, %rax
	kmovd	%r9d, %k1
	movl	$538976288, %r9d
	vpsrlq	$32, %ymm13, %ymm8
	vpmuludq	%ymm21, %ymm13, %ymm11
	vpmuludq	%ymm20, %ymm8, %ymm15
	vpmuludq	%ymm20, %ymm13, %ymm0
	vpmuludq	%ymm21, %ymm8, %ymm9
	vpminsd	%ymm31, %ymm13, %ymm8
	vpsrlq	$45, %ymm11, %ymm12
	vpmuludq	%ymm20, %ymm4, %ymm24
	vpsrlq	$24, %ymm15, %ymm5
	vpsrlq	$56, %ymm0, %ymm1
	vpblendd	$170, %ymm5, %ymm1, %ymm11
	vpminsd	%ymm26, %ymm13, %ymm0
	vpmulld	%ymm17, %ymm11, %ymm7
	vpsrlq	$13, %ymm9, %ymm10
	vpcmpeqd	%ymm0, %ymm13, %ymm0
	vpblendd	$170, %ymm10, %ymm12, %ymm14
	vpmulld	%ymm17, %ymm14, %ymm6
	vpcmpeqd	%ymm8, %ymm13, %ymm10
	vpminsd	%ymm30, %ymm13, %ymm5
	vpminsd	40(%rsp), %ymm13, %ymm8
	vpcmpeqd	%ymm5, %ymm13, %ymm1
	vpsubd	%ymm7, %ymm14, %ymm9
	vpminsd	%ymm27, %ymm13, %ymm14
	vmovdqu8	%ymm1, %ymm0{%k3}
	vpcmpeqd	%ymm14, %ymm13, %ymm15
	vpminsd	8(%rsp), %ymm13, %ymm14
	vpsubd	%ymm6, %ymm13, %ymm12
	vpminsd	72(%rsp), %ymm13, %ymm6
	vmovdqu8	%ymm15, %ymm0{%k2}
	vpmulhuw	%ymm16, %ymm9, %ymm5
	vmovdqu8	%ymm10, %ymm0{%k1}
	vpcmpeqd	%ymm8, %ymm13, %ymm10
	vpcmpeqd	%ymm14, %ymm13, %ymm15
	vpandq	-24(%rsp), %ymm15, %ymm1
	vpcmpeqd	%ymm6, %ymm13, %ymm7
	vpsrlw	$3, %ymm5, %ymm6
	vpbroadcastd	%r11d, %ymm5
	vpxor	%xmm14, %xmm14, %xmm14
	movl	$48, %r11d
	vpcmpb	$5, %ymm14, %ymm0, %k4
	vmovdqu8	%ymm10, %ymm1{%k2}
	vpbroadcastd	%r10d, %ymm10
	movl	$99999999, %r10d
	vmovdqu8	%ymm7, %ymm1{%k1}
	vpmulld	%ymm10, %ymm6, %ymm7
	vpbroadcastd	%r10d, %ymm22
	vpcmpb	$5, %ymm14, %ymm1, %k5
	vpcmpd	$6, %ymm22, %ymm13, %k6
	vpbroadcastd	%r11d, %ymm13
	vmovdqa	%ymm13, 104(%rsp)
	vpaddd	%ymm9, %ymm7, %ymm15
	vpbroadcastd	%ecx, %ymm9
	vpbroadcastd	%r8d, %ymm7
	movl	$32, %ecx
	vpmulhuw	%ymm5, %ymm15, %ymm8
	vmovdqa	%ymm7, 200(%rsp)
	movl	$536870912, %r8d
	vpmullw	%ymm9, %ymm8, %ymm0
	vpaddw	%ymm15, %ymm0, %ymm6
	vpmulhuw	%ymm16, %ymm12, %ymm15
	vpbroadcastd	%r9d, %ymm0
	vmovdqa	%ymm0, %ymm8
	vpaddb	200(%rsp), %ymm6, %ymm8{%k4}
	vpsrlw	$3, %ymm15, %ymm6
	vpmulld	%ymm10, %ymm6, %ymm7
	vpaddd	%ymm12, %ymm7, %ymm15
	vmovdqa	%ymm0, %ymm7
	vpmulhuw	%ymm5, %ymm15, %ymm12
	vpmullw	%ymm9, %ymm12, %ymm1
	vpsrlq	$32, %ymm4, %ymm12
	vpaddw	%ymm15, %ymm1, %ymm6
	vpaddb	200(%rsp), %ymm6, %ymm7{%k5}
	vpcmpd	$6, %ymm22, %ymm4, %k5
	vpbroadcastd	%ecx, %ymm6
	vmovdqa	%ymm6, %ymm13
	vpaddd	104(%rsp), %ymm11, %ymm13{%k6}
	vpmuludq	%ymm21, %ymm12, %ymm11
	vpmuludq	%ymm20, %ymm12, %ymm12
	vpsrlq	$13, %ymm11, %ymm1
	vpunpckldq	%ymm7, %ymm8, %ymm15
	vpunpckhdq	%ymm7, %ymm8, %ymm8
	vpmuludq	%ymm21, %ymm4, %ymm7
	vpsrlq	$45, %ymm7, %ymm11
	vpsrlq	$56, %ymm24, %ymm7
	vpblendd	$170, %ymm1, %ymm11, %ymm11
	vpsrlq	$24, %ymm12, %ymm1
	vpblendd	$170, %ymm1, %ymm7, %ymm12
	vpminsd	%ymm31, %ymm4, %ymm7
	vpmulld	%ymm17, %ymm11, %ymm23
	vpmulld	%ymm17, %ymm12, %ymm1
	vmovdqa32	%ymm12, %ymm24
	vpminsd	%ymm27, %ymm4, %ymm12
	vpcmpeqd	%ymm12, %ymm4, %ymm12
	vpsubd	%ymm23, %ymm4, %ymm23
	vpsubd	%ymm1, %ymm11, %ymm11
	vpcmpeqd	%ymm7, %ymm4, %ymm1
	vpminsd	%ymm30, %ymm4, %ymm7
	vpcmpeqd	%ymm7, %ymm4, %ymm7
	vmovdqa32	%ymm7, %ymm25
	vpminsd	%ymm26, %ymm4, %ymm7
	vpmuludq	%ymm20, %ymm3, %ymm26
	vpcmpeqd	%ymm7, %ymm4, %ymm7
	vmovdqu8	%ymm25, %ymm7{%k3}
	vmovdqu8	%ymm12, %ymm7{%k2}
	vmovdqu8	%ymm1, %ymm7{%k1}
	vpminsd	72(%rsp), %ymm4, %ymm1
	vpcmpb	$5, %ymm14, %ymm7, %k7
	vpcmpeqd	%ymm1, %ymm4, %ymm12
	vpminsd	40(%rsp), %ymm4, %ymm1
	vpcmpeqd	%ymm1, %ymm4, %ymm1
	vmovdqa32	%ymm1, %ymm30
	vpminsd	8(%rsp), %ymm4, %ymm1
	vpcmpeqd	%ymm1, %ymm4, %ymm1
	vpandq	-24(%rsp), %ymm1, %ymm1
	vmovdqu8	%ymm30, %ymm1{%k2}
	vmovdqa32	%ymm27, %ymm30
	vmovdqu8	%ymm12, %ymm1{%k1}
	vpmulhuw	%ymm16, %ymm11, %ymm12
	vpcmpb	$5, %ymm14, %ymm1, %k4
	vpsrlw	$3, %ymm12, %ymm12
	vpmulld	%ymm10, %ymm12, %ymm12
	vpaddd	%ymm11, %ymm12, %ymm11
	vpmulhuw	%ymm5, %ymm11, %ymm12
	vpmullw	%ymm9, %ymm12, %ymm7
	vpmulhuw	%ymm16, %ymm23, %ymm12
	vpaddw	%ymm11, %ymm7, %ymm11
	vmovdqa	%ymm0, %ymm7
	vpaddb	200(%rsp), %ymm11, %ymm7{%k7}
	vpsrlw	$3, %ymm12, %ymm11
	vpmulld	%ymm10, %ymm11, %ymm12
	vpaddd	%ymm23, %ymm12, %ymm11
	vpmulhuw	%ymm5, %ymm11, %ymm12
	vpmullw	%ymm9, %ymm12, %ymm1
	vpaddw	%ymm11, %ymm1, %ymm12
	vmovdqa	%ymm0, %ymm11
	vpaddb	200(%rsp), %ymm12, %ymm11{%k4}
	vpsrlq	$32, %ymm3, %ymm1
	vpmuludq	%ymm21, %ymm1, %ymm4
	vpcmpd	$6, %ymm22, %ymm3, %k4
	vmovdqa	%ymm6, %ymm12
	vpaddd	104(%rsp), %ymm24, %ymm12{%k5}
	vpmuludq	%ymm20, %ymm1, %ymm1
	vpsrlq	$13, %ymm4, %ymm4
	vpsrlq	$24, %ymm1, %ymm1
	vpunpckldq	%ymm11, %ymm7, %ymm23
	vpunpckhdq	%ymm11, %ymm7, %ymm7
	vpmuludq	%ymm21, %ymm3, %ymm11
	vpsrlq	$45, %ymm11, %ymm11
	vpblendd	$170, %ymm4, %ymm11, %ymm11
	vpsrlq	$56, %ymm26, %ymm4
	vpblendd	$170, %ymm1, %ymm4, %ymm1
	vpmulld	%ymm17, %ymm1, %ymm4
	vpmulld	%ymm17, %ymm11, %ymm24
	vmovdqa32	%ymm1, %ymm25
	vpminsd	%ymm31, %ymm3, %ymm1
	vpcmpeqd	%ymm1, %ymm3, %ymm1
	vpsubd	%ymm4, %ymm11, %ymm11
	vpminsd	%ymm27, %ymm3, %ymm4
	vpsubd	%ymm24, %ymm3, %ymm24
	vpcmpeqd	%ymm4, %ymm3, %ymm4
	vmovdqa32	%ymm4, %ymm26
	vpminsd	168(%rsp), %ymm3, %ymm4
	vpcmpeqd	%ymm4, %ymm3, %ymm4
	vmovdqa32	%ymm4, %ymm27
	vpminsd	136(%rsp), %ymm3, %ymm4
	vpcmpeqd	%ymm4, %ymm3, %ymm4
	vmovdqu8	%ymm27, %ymm4{%k3}
	vmovdqu8	%ymm26, %ymm4{%k2}
	vmovdqu8	%ymm1, %ymm4{%k1}
	vpminsd	72(%rsp), %ymm3, %ymm1
	vpcmpb	$5, %ymm14, %ymm4, %k6
	vpcmpeqd	%ymm1, %ymm3, %ymm1
	vmovdqa32	%ymm1, %ymm26
	vpminsd	40(%rsp), %ymm3, %ymm1
	vpcmpeqd	%ymm1, %ymm3, %ymm1
	vmovdqa32	%ymm1, %ymm27
	vpminsd	8(%rsp), %ymm3, %ymm1
	vpcmpeqd	%ymm1, %ymm3, %ymm1
	vpandq	-24(%rsp), %ymm1, %ymm1
	vmovdqa	%ymm6, %ymm3
	vmovdqu8	%ymm27, %ymm1{%k2}
	vmovdqu8	%ymm26, %ymm1{%k1}
	vpmulhuw	%ymm16, %ymm11, %ymm26
	vpcmpb	$5, %ymm14, %ymm1, %k7
	vpsrlw	$3, %ymm26, %ymm27
	vpmulld	%ymm10, %ymm27, %ymm26
	vpaddd	%ymm11, %ymm26, %ymm11
	vpmulhuw	%ymm5, %ymm11, %ymm27
	vpmullw	%ymm9, %ymm27, %ymm4
	vpmuludq	%ymm20, %ymm2, %ymm27
	vpaddw	%ymm11, %ymm4, %ymm11
	vmovdqa	%ymm0, %ymm4
	vpaddb	200(%rsp), %ymm11, %ymm4{%k6}
	vpmulhuw	%ymm16, %ymm24, %ymm11
	vpsrlw	$3, %ymm11, %ymm11
	vpmulld	%ymm10, %ymm11, %ymm11
	vpaddd	%ymm24, %ymm11, %ymm11
	vpmulhuw	%ymm5, %ymm11, %ymm24
	vpmullw	%ymm9, %ymm24, %ymm1
	vpaddw	%ymm11, %ymm1, %ymm1
	vmovdqa	%ymm0, %ymm11
	vpaddb	200(%rsp), %ymm1, %ymm11{%k7}
	vpaddd	104(%rsp), %ymm25, %ymm3{%k4}
	vpsrlq	$32, %ymm2, %ymm1
	vpmuludq	%ymm21, %ymm1, %ymm25
	vpmuludq	%ymm20, %ymm1, %ymm1
	vpsrlq	$13, %ymm25, %ymm26
	vpsrlq	$56, %ymm27, %ymm25
	vpsrlq	$24, %ymm1, %ymm1
	vpunpckldq	%ymm11, %ymm4, %ymm24
	vpunpckhdq	%ymm11, %ymm4, %ymm4
	vpmuludq	%ymm21, %ymm2, %ymm11
	vmovdqa	%ymm3, -56(%rsp)
	vpsrlq	$45, %ymm11, %ymm3
	vmovdqa32	%ymm26, %ymm11
	vpblendd	$170, %ymm11, %ymm3, %ymm3
	vmovdqa32	%ymm25, %ymm11
	vpblendd	$170, %ymm1, %ymm11, %ymm1
	vpmulld	%ymm17, %ymm3, %ymm26
	vpmulld	%ymm17, %ymm1, %ymm11
	vmovdqa32	%ymm1, %ymm25
	vpminsd	%ymm30, %ymm2, %ymm1
	vpsubd	%ymm26, %ymm2, %ymm27
	vpsubd	%ymm11, %ymm3, %ymm26
	vpminsd	%ymm31, %ymm2, %ymm3
	vpcmpeqd	%ymm3, %ymm2, %ymm11
	vpcmpeqd	%ymm1, %ymm2, %ymm3
	vpminsd	168(%rsp), %ymm2, %ymm1
	vmovdqa32	%ymm3, %ymm30
	vpcmpeqd	%ymm1, %ymm2, %ymm3
	vpminsd	136(%rsp), %ymm2, %ymm1
	vpcmpeqd	%ymm1, %ymm2, %ymm1
	vmovdqu8	%ymm3, %ymm1{%k3}
	vmovdqu8	%ymm30, %ymm1{%k2}
	vmovdqu8	%ymm11, %ymm1{%k1}
	vpminsd	72(%rsp), %ymm2, %ymm11
	vpcmpb	$5, %ymm14, %ymm1, %k3
	vpcmpeqd	%ymm11, %ymm2, %ymm3
	vpminsd	40(%rsp), %ymm2, %ymm11
	vmovdqa32	%ymm3, %ymm30
	vpcmpeqd	%ymm11, %ymm2, %ymm3
	vpminsd	8(%rsp), %ymm2, %ymm11
	vmovdqa32	%ymm3, %ymm31
	vpcmpeqd	%ymm11, %ymm2, %ymm3
	vpandq	-24(%rsp), %ymm3, %ymm11
	vmovdqu8	%ymm31, %ymm11{%k2}
	vmovdqu8	%ymm30, %ymm11{%k1}
	vpcmpd	$6, %ymm22, %ymm2, %k1
	vpmulhuw	%ymm16, %ymm26, %ymm30
	vpbroadcastd	%r8d, %ymm2
	vpcmpb	$5, %ymm14, %ymm11, %k2
	vporq	%ymm2, %ymm13, %ymm13
	vporq	%ymm2, %ymm12, %ymm12
	vpaddd	104(%rsp), %ymm25, %ymm6{%k1}
	vpshufb	%ymm29, %ymm13, %ymm11
	vpsrlw	$3, %ymm30, %ymm31
	vpmulld	%ymm10, %ymm31, %ymm30
	vpshufb	%ymm18, %ymm23, %ymm22
	vpaddd	%ymm26, %ymm30, %ymm26
	vmovdqa64	%ymm0, %ymm30
	vpmulhuw	%ymm5, %ymm26, %ymm31
	vporq	%ymm2, %ymm6, %ymm6
	vpmullw	%ymm9, %ymm31, %ymm1
	vpaddw	%ymm26, %ymm1, %ymm3
	vpmulhuw	%ymm16, %ymm27, %ymm1
	vpaddb	200(%rsp), %ymm3, %ymm30{%k3}
	vpsrlw	$3, %ymm1, %ymm3
	vpmulld	%ymm10, %ymm3, %ymm10
	vpaddd	%ymm27, %ymm10, %ymm3
	vpshufb	%ymm19, %ymm15, %ymm10
	vpshufb	%ymm18, %ymm15, %ymm15
	vpmulhuw	%ymm5, %ymm3, %ymm5
	vpmullw	%ymm9, %ymm5, %ymm14
	vporq	%ymm11, %ymm10, %ymm5
	vpshufb	%ymm19, %ymm8, %ymm11
	vpshufb	%ymm18, %ymm8, %ymm8
	vmovdqu	%xmm5, -320(%rax)
	vpaddw	%ymm3, %ymm14, %ymm9
	vpshufb	%ymm28, %ymm13, %ymm3
	vpaddb	200(%rsp), %ymm9, %ymm0{%k2}
	vpshufb	.LC44(%rip), %ymm13, %ymm9
	vpshufb	.LC45(%rip), %ymm13, %ymm13
	vporq	%ymm3, %ymm15, %ymm14
	vporq	%ymm9, %ymm11, %ymm10
	vporq	%ymm13, %ymm8, %ymm3
	vpshufb	.LC44(%rip), %ymm12, %ymm15
	vpshufb	.LC45(%rip), %ymm12, %ymm11
	vmovdqu	%xmm14, -310(%rax)
	vpshufb	%ymm28, %ymm12, %ymm8
	vmovdqu	%xmm10, -300(%rax)
	vmovdqu	%xmm3, -290(%rax)
	vextracti64x2	$0x1, %ymm5, -280(%rax)
	vpshufb	%ymm19, %ymm23, %ymm5
	vporq	%ymm8, %ymm22, %ymm23
	vpunpckldq	%ymm0, %ymm30, %ymm1
	vextracti64x2	$0x1, %ymm14, -270(%rax)
	vpshufb	%ymm29, %ymm12, %ymm14
	vpunpckhdq	%ymm0, %ymm30, %ymm0
	vextracti64x2	$0x1, %ymm10, -260(%rax)
	vporq	%ymm14, %ymm5, %ymm10
	vextracti64x2	$0x1, %ymm3, -250(%rax)
	vpshufb	%ymm19, %ymm7, %ymm3
	vpshufb	%ymm18, %ymm7, %ymm7
	vporq	%ymm15, %ymm3, %ymm9
	vmovdqu	%xmm10, -240(%rax)
	vporq	%ymm11, %ymm7, %ymm13
	vmovdqu64	%xmm23, -230(%rax)
	vpshufb	%ymm19, %ymm24, %ymm3
	vmovdqu	%xmm9, -220(%rax)
	vpshufb	%ymm18, %ymm24, %ymm24
	vmovdqu	%xmm13, -210(%rax)
	vextracti64x2	$0x1, %ymm10, -200(%rax)
	vporq	-56(%rsp), %ymm2, %ymm10
	vpshufb	%ymm29, %ymm6, %ymm2
	vextracti64x2	$0x1, %ymm23, -190(%rax)
	vextracti64x2	$0x1, %ymm9, -180(%rax)
	vextracti64x2	$0x1, %ymm13, -170(%rax)
	vpshufb	%ymm19, %ymm4, %ymm13
	vpshufb	%ymm18, %ymm4, %ymm4
	vpshufb	.LC44(%rip), %ymm10, %ymm7
	vpshufb	%ymm28, %ymm10, %ymm11
	vpshufb	.LC45(%rip), %ymm10, %ymm14
	vpshufb	%ymm29, %ymm10, %ymm15
	vporq	%ymm7, %ymm13, %ymm12
	vporq	%ymm11, %ymm24, %ymm25
	vporq	%ymm14, %ymm4, %ymm5
	vpshufb	%ymm28, %ymm6, %ymm7
	vpshufb	%ymm19, %ymm0, %ymm14
	vporq	%ymm15, %ymm3, %ymm9
	vmovdqu	%xmm9, -160(%rax)
	vpshufb	.LC45(%rip), %ymm6, %ymm4
	vmovdqu64	%xmm25, -150(%rax)
	vpshufb	%ymm18, %ymm0, %ymm0
	vmovdqu	%xmm12, -140(%rax)
	vporq	%ymm4, %ymm0, %ymm8
	vmovdqu	%xmm5, -130(%rax)
	vextracti64x2	$0x1, %ymm9, -120(%rax)
	vpshufb	%ymm19, %ymm1, %ymm9
	vextracti64x2	$0x1, %ymm25, -110(%rax)
	vpshufb	%ymm18, %ymm1, %ymm1
	vporq	%ymm2, %ymm9, %ymm11
	vextracti64x2	$0x1, %ymm12, -100(%rax)
	vpshufb	.LC44(%rip), %ymm6, %ymm12
	vporq	%ymm7, %ymm1, %ymm13
	vextracti64x2	$0x1, %ymm5, -90(%rax)
	vporq	%ymm12, %ymm14, %ymm5
	vmovdqu	%xmm11, -80(%rax)
	vmovdqu	%xmm13, -70(%rax)
	vmovdqu	%xmm5, -60(%rax)
	vmovdqu	%xmm8, -50(%rax)
	vextracti64x2	$0x1, %ymm11, -40(%rax)
	vextracti64x2	$0x1, %ymm13, -30(%rax)
	vextracti64x2	$0x1, %ymm5, -20(%rax)
	vextracti64x2	$0x1, %ymm8, -10(%rax)
	cmpq	%rdx, %rsi
	jnb	.L804
	vzeroupper
	leave
	.cfi_def_cfa 7, 8
	ret
.L808:
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
	jbe	.L852
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
	jb	.L853
	testq	%r9, %r9
	je	.L814
	cmpq	$1, %r9
	je	.L839
	cmpq	$2, %r9
	je	.L840
	cmpq	$3, %r9
	je	.L841
	cmpq	$4, %r9
	je	.L842
	cmpq	$5, %r9
	je	.L843
	cmpq	$6, %r9
	je	.L844
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
.L844:
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
.L843:
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
.L842:
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
.L841:
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
.L840:
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
.L839:
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
	jb	.L853
.L814:
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
	jnb	.L814
.L853:
	vzeroupper
.L852:
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
	andq	$-64, %rsp
	subq	$64, %rsp
	movq	%rdi, 40(%rsp)
	movq	%rdx, 32(%rsp)
	cmpq	$65600, %rdx
	jbe	.L892
	vmovdqa	.LC2(%rip), %ymm4
	vmovdqa	.LC3(%rip), %ymm3
	movq	%rdi, %rbx
	vmovdqa	.LC4(%rip), %ymm7
	.p2align 4
	.p2align 3
.L891:
	movl	$538976288, %edx
	vmovdqa	.LC14(%rip), %ymm14
	vpbroadcastd	%edx, %ymm5
	vpminsb	131072(%rbx), %ymm5, %ymm10
	vpminsb	32768(%rbx), %ymm5, %ymm0
	vpminsb	65536(%rbx), %ymm5, %ymm2
	vpminsb	98304(%rbx), %ymm5, %ymm8
	vpcmpeqb	131072(%rbx), %ymm10, %ymm11
	vpcmpeqb	32768(%rbx), %ymm0, %ymm1
	vpxor	%xmm10, %xmm10, %xmm10
	vpcmpeqb	65536(%rbx), %ymm2, %ymm6
	vpcmpeqb	98304(%rbx), %ymm8, %ymm9
	vpmovmskb	%ymm1, %ecx
	vpmovmskb	%ymm6, %r8d
	vpmovmskb	%ymm9, %r13d
	tzcntl	%ecx, %esi
	vpmovmskb	%ymm11, %edx
	tzcntl	%r8d, %r9d
	tzcntl	%r13d, %r14d
	movl	%esi, %edi
	tzcntl	%edx, %ecx
	movl	%r9d, %r11d
	movl	%r14d, %eax
	leaq	32769(%rbx,%rdi), %r10
	movl	%ecx, %esi
	leaq	65537(%rbx,%r11), %r8
	leaq	65537(%rbx,%r11), %r12
	movl	$808464432, %r13d
	leaq	131073(%rbx,%rsi), %rdi
	leaq	98305(%rbx,%rax), %r11
	movq	%rbx, %rsi
	movq	%r10, %r9
	movq	%rdi, 48(%rsp)
	xorl	%ebx, %ebx
	movq	%r11, %rdi
	vpbroadcastd	%r13d, %ymm15
	.p2align 4
	.p2align 3
.L862:
	movq	48(%rsp), %r14
	movq	%r11, %rax
	movq	%r12, %rdx
	movq	%r10, %rcx
	subq	%r8, %rax
	subq	%rdi, %r14
	cmpq	%rax, %r14
	cmovg	%rax, %r14
	subq	%r9, %rdx
	subq	%rsi, %rcx
	cmpq	%rcx, %rdx
	cmovg	%rcx, %rdx
	cmpq	%rdx, %r14
	cmovg	%rdx, %r14
	cmpq	$32, %r14
	jbe	.L1082
	movabsq	$1117984489315730401, %rax
	movl	$100000000, %ecx
	mulq	%r14
	vpbroadcastd	%ecx, %ymm6
	movq	%rdx, %r14
	andq	$-2, %rdx
	shrq	%r14
	movq	%r14, 56(%rsp)
	leaq	(%rdx,%rbx), %r13
	movq	%rbx, %rdx
	.p2align 4
	.p2align 3
.L861:
	vmovdqu	(%rsi), %ymm12
	vpminsb	%ymm5, %ymm12, %ymm13
	vpcmpeqb	%ymm13, %ymm12, %ymm0
	vmovdqu	(%r9), %ymm13
	vpmovmskb	%ymm0, %eax
	tzcntl	%eax, %r14d
	blsr	%eax, %ecx
	tzcntl	%ecx, %ecx
	movl	%r14d, %eax
	vinserti64x2	$0x1, 1(%rsi,%rax), %ymm12, %ymm1
	incl	%eax
	salq	$4, %rax
	vpminsb	%ymm5, %ymm13, %ymm0
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm2
	movl	%ecx, %eax
	subl	%r14d, %eax
	leal	1(%rcx), %r14d
	salq	$4, %rax
	vpsubusb	%ymm15, %ymm1, %ymm9
	vpcmpeqb	%ymm0, %ymm13, %ymm1
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%rax), %ymm2, %ymm8
	vpmovmskb	%ymm1, %ecx
	addq	%r14, %rsi
	tzcntl	%ecx, %r14d
	blsr	%ecx, %eax
	tzcntl	%eax, %ecx
	movl	%r14d, %eax
	vinserti64x2	$0x1, 1(%r9,%rax), %ymm13, %ymm2
	incl	%eax
	salq	$4, %rax
	vpshufb	%ymm8, %ymm9, %ymm11
	vpmaddubsw	%ymm4, %ymm11, %ymm12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm11
	movl	%ecx, %eax
	subl	%r14d, %eax
	vpmaddwd	%ymm3, %ymm12, %ymm9
	leal	1(%rcx), %r14d
	salq	$4, %rax
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%rax), %ymm11, %ymm12
	vmovdqu	(%r8), %ymm11
	addq	%r14, %r9
	vmovdqa	%ymm12, %ymm13
	vpminsb	%ymm5, %ymm11, %ymm1
	vpternlogq	$254, %ymm10, %ymm8, %ymm13
	vpsubusb	%ymm15, %ymm2, %ymm10
	vpshufb	%ymm12, %ymm10, %ymm8
	vpcmpeqb	%ymm1, %ymm11, %ymm12
	vpmovmskb	%ymm12, %ecx
	vpmaddubsw	%ymm4, %ymm8, %ymm0
	tzcntl	%ecx, %r14d
	blsr	%ecx, %eax
	tzcntl	%eax, %ecx
	vpmaddwd	%ymm3, %ymm0, %ymm2
	movl	%r14d, %eax
	vpackusdw	%ymm2, %ymm9, %ymm9
	vinserti64x2	$0x1, 1(%r8,%rax), %ymm11, %ymm8
	incl	%eax
	vpmaddwd	%ymm7, %ymm9, %ymm2
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm10
	movl	%ecx, %eax
	subl	%r14d, %eax
	leal	1(%rcx), %r14d
	salq	$4, %rax
	vpsubusb	%ymm15, %ymm8, %ymm0
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%rax), %ymm10, %ymm10
	addq	%r14, %r8
	vpshufb	%ymm10, %ymm0, %ymm11
	vmovdqu	(%rdi), %ymm0
	vpmaddubsw	%ymm4, %ymm11, %ymm1
	vpmaddwd	%ymm3, %ymm1, %ymm8
	vpminsb	%ymm5, %ymm0, %ymm12
	vpcmpeqb	%ymm12, %ymm0, %ymm11
	vpmovmskb	%ymm11, %ecx
	tzcntl	%ecx, %r14d
	blsr	%ecx, %eax
	tzcntl	%eax, %ecx
	movl	%r14d, %eax
	vinserti64x2	$0x1, 1(%rdi,%rax), %ymm0, %ymm1
	incl	%eax
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm0
	movl	%ecx, %eax
	subl	%r14d, %eax
	leal	1(%rcx), %r14d
	salq	$4, %rax
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%rax), %ymm0, %ymm12
	addq	%r14, %rdi
	vpternlogq	$254, %ymm12, %ymm13, %ymm10
	vpsubusb	%ymm15, %ymm1, %ymm13
	vpshufb	%ymm12, %ymm13, %ymm11
	vpmaddubsw	%ymm4, %ymm11, %ymm1
	vpmaddwd	%ymm3, %ymm1, %ymm0
	vpackusdw	%ymm0, %ymm8, %ymm8
	vpmaddwd	%ymm7, %ymm8, %ymm12
	vshufps	$136, %ymm12, %ymm2, %ymm13
	vshufps	$221, %ymm12, %ymm2, %ymm1
	vpmulld	%ymm6, %ymm13, %ymm11
	vpaddd	%ymm1, %ymm11, %ymm0
	vpermd	%ymm0, %ymm14, %ymm9
	vextracti64x2	$1, %ymm9, %xmm12
	vextracti64x2	$0x1, %ymm9, %xmm2
	vmovq	%xmm9, (%r15,%rdx,4)
	vmovhpd	%xmm9, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region(,%rdx,4)
	vmovhpd	%xmm2, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262656(,%rdx,4)
	vmovq	%xmm12, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131328(,%rdx,4)
	addq	$2, %rdx
	cmpq	%r13, %rdx
	jne	.L861
	movq	56(%rsp), %r13
	leaq	(%rbx,%r13,2), %rbx
	jmp	.L862
	.p2align 4
	.p2align 3
.L1082:
	movq	%r12, %rdx
	movq	%rbx, %r14
	cmpq	%r10, %rsi
	jnb	.L860
	vmovdqa	.LC8(%rip), %xmm3
	vmovdqa	.LC9(%rip), %xmm4
	movl	$538976288, %r12d
	movl	$808464432, %eax
	vmovdqa	.LC10(%rip), %xmm7
	vpbroadcastd	%r12d, %xmm5
	vpbroadcastd	%eax, %xmm14
	.p2align 4
	.p2align 3
.L859:
	vmovdqu	(%rsi), %xmm15
	incq	%r14
	vpminsb	%xmm5, %xmm15, %xmm6
	vpsubusb	%xmm14, %xmm15, %xmm0
	vpcmpeqb	%xmm6, %xmm15, %xmm13
	vpmovmskb	%xmm13, %ecx
	tzcntl	%ecx, %r13d
	incl	%r13d
	movq	%r13, %r12
	addq	%r13, %rsi
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm11
	vpshufb	%xmm11, %xmm0, %xmm9
	vmovdqa	%xmm11, %xmm1
	vpmaddubsw	%xmm3, %xmm9, %xmm8
	vporq	%ymm1, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm8, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm12
	vpmaddwd	%xmm7, %xmm12, %xmm15
	vmovq	%xmm15, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%ecx, %eax
	movl	%eax, -4(%r15,%r14,4)
	cmpq	%r10, %rsi
	jb	.L859
.L860:
	cmpq	$32831, %rbx
	movq	%rbx, %r12
	setbe	56(%rsp)
	cmpq	%rdx, %r9
	jnb	.L863
	cmpb	$0, 56(%rsp)
	je	.L863
	movl	$538976288, %r13d
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm3
	vmovdqa	.LC9(%rip), %xmm4
	vmovdqa	.LC10(%rip), %xmm7
	vpbroadcastd	%r13d, %xmm5
	vpbroadcastd	%eax, %xmm14
	testb	$1, %bl
	je	.L864
	vmovdqu	(%r9), %xmm13
	vpminsb	%xmm5, %xmm13, %xmm6
	vpsubusb	%xmm14, %xmm13, %xmm9
	vpcmpeqb	%xmm6, %xmm13, %xmm11
	vpmovmskb	%xmm11, %r12d
	tzcntl	%r12d, %r13d
	leaq	1(%rbx), %r12
	incl	%r13d
	movq	%r13, %rcx
	addq	%r13, %r9
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm1
	vpshufb	%xmm1, %xmm9, %xmm8
	vmovdqa	%xmm1, %xmm0
	vpmaddubsw	%xmm3, %xmm8, %xmm2
	vporq	%ymm0, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm2, %xmm12
	vpackusdw	%xmm12, %xmm12, %xmm15
	vpmaddwd	%xmm7, %xmm15, %xmm13
	vmovq	%xmm13, %rax
	imull	$100000000, %eax, %r13d
	shrq	$32, %rax
	addl	%eax, %r13d
	movl	%r13d, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%rdx, %r9
	jb	.L1044
	jmp	.L863
	.p2align 4
	.p2align 3
.L864:
	vmovdqu	(%r9), %xmm1
	incq	%r12
	vpminsb	%xmm5, %xmm1, %xmm6
	vpsubusb	%xmm14, %xmm1, %xmm8
	vpcmpeqb	%xmm6, %xmm1, %xmm11
	vpmovmskb	%xmm11, %ecx
	tzcntl	%ecx, %eax
	incl	%eax
	movq	%rax, %r13
	addq	%rax, %r9
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r13), %xmm9
	vpshufb	%xmm9, %xmm8, %xmm2
	vmovdqa	%xmm9, %xmm0
	vpmaddubsw	%xmm3, %xmm2, %xmm12
	vporq	%ymm0, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm12, %xmm15
	vpackusdw	%xmm15, %xmm15, %xmm13
	vpmaddwd	%xmm7, %xmm13, %xmm1
	vmovq	%xmm1, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%ecx, %eax
	movl	%eax, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%rdx, %r9
	jnb	.L863
	vmovdqu	(%r9), %xmm9
	incq	%r12
	vpminsb	%xmm5, %xmm9, %xmm6
	vpsubusb	%xmm14, %xmm9, %xmm2
	vpcmpeqb	%xmm6, %xmm9, %xmm11
	vpmovmskb	%xmm11, %r13d
	tzcntl	%r13d, %eax
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %r9
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm8
	vpshufb	%xmm8, %xmm2, %xmm12
	vmovdqa	%xmm8, %xmm0
	vpmaddubsw	%xmm3, %xmm12, %xmm15
	vporq	%ymm0, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm15, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm1
	vpmaddwd	%xmm7, %xmm1, %xmm9
	vmovq	%xmm9, %r13
	imull	$100000000, %r13d, %eax
	shrq	$32, %r13
	addl	%eax, %r13d
	movl	%r13d, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%rdx, %r9
	jnb	.L863
.L1044:
	cmpq	$32832, %r12
	jne	.L864
.L863:
	movq	%rbx, %r13
	cmpq	%r11, %r8
	jnb	.L866
	cmpb	$0, 56(%rsp)
	je	.L866
	movl	$538976288, %ecx
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm3
	vmovdqa	.LC9(%rip), %xmm4
	vmovdqa	.LC10(%rip), %xmm7
	vpbroadcastd	%ecx, %xmm5
	vpbroadcastd	%eax, %xmm14
	testb	$1, %bl
	je	.L867
	vmovdqu	(%r8), %xmm8
	vpminsb	%xmm5, %xmm8, %xmm6
	vpsubusb	%xmm14, %xmm8, %xmm12
	vpcmpeqb	%xmm6, %xmm8, %xmm11
	vpmovmskb	%xmm11, %r13d
	tzcntl	%r13d, %eax
	leaq	1(%rbx), %r13
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %r8
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm2
	vpshufb	%xmm2, %xmm12, %xmm15
	vmovdqa	%xmm2, %xmm0
	vpmaddubsw	%xmm3, %xmm15, %xmm13
	vporq	%ymm0, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm13, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm9
	vpmaddwd	%xmm7, %xmm9, %xmm8
	vmovq	%xmm8, %rax
	jmp	.L1081
	.p2align 4
	.p2align 3
.L1083:
	cmpq	$32832, %r13
	je	.L866
.L867:
	vmovdqu	(%r8), %xmm2
	incq	%r13
	vpminsb	%xmm5, %xmm2, %xmm6
	vpsubusb	%xmm14, %xmm2, %xmm15
	vpcmpeqb	%xmm6, %xmm2, %xmm11
	vpmovmskb	%xmm11, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %r8
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm12
	vpshufb	%xmm12, %xmm15, %xmm13
	vmovdqa	%xmm12, %xmm0
	vpmaddubsw	%xmm3, %xmm13, %xmm1
	vporq	%ymm0, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm1, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm8
	vpmaddwd	%xmm7, %xmm8, %xmm2
	vmovq	%xmm2, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	%r11, %r8
	jnb	.L866
	vmovdqu	(%r8), %xmm12
	incq	%r13
	vpminsb	%xmm5, %xmm12, %xmm6
	vpsubusb	%xmm14, %xmm12, %xmm13
	vpcmpeqb	%xmm6, %xmm12, %xmm11
	vpmovmskb	%xmm11, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %r8
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm15
	vpshufb	%xmm15, %xmm13, %xmm1
	vmovdqa	%xmm15, %xmm0
	vpmaddubsw	%xmm3, %xmm1, %xmm9
	vporq	%ymm0, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm9, %xmm8
	vpackusdw	%xmm8, %xmm8, %xmm2
	vpmaddwd	%xmm7, %xmm2, %xmm12
	vmovq	%xmm12, %rax
.L1081:
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	%r11, %r8
	jb	.L1083
.L866:
	movq	48(%rsp), %rcx
	cmpq	%rcx, %rdi
	jnb	.L869
	cmpb	$0, 56(%rsp)
	je	.L869
	movl	$538976288, %eax
	vmovdqa	.LC8(%rip), %xmm1
	vmovdqa	.LC9(%rip), %xmm2
	vmovdqa	.LC10(%rip), %xmm5
	vpbroadcastd	%eax, %xmm8
	movl	$808464432, %eax
	vpbroadcastd	%eax, %xmm9
	testb	$1, %bl
	jne	.L1047
	movq	%r11, 56(%rsp)
	movq	%rcx, %r11
	jmp	.L870
	.p2align 4
	.p2align 3
.L1084:
	vmovdqu	(%rdi), %xmm7
	incq	%rbx
	vpminsb	%xmm8, %xmm7, %xmm14
	vpsubusb	%xmm9, %xmm7, %xmm0
	vpcmpeqb	%xmm14, %xmm7, %xmm6
	vpmovmskb	%xmm6, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %rdi
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm15
	vpshufb	%xmm15, %xmm0, %xmm13
	vmovdqa	%xmm15, %xmm11
	vpmaddubsw	%xmm1, %xmm13, %xmm12
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm12, %xmm3
	vpackusdw	%xmm3, %xmm3, %xmm4
	vpmaddwd	%xmm5, %xmm4, %xmm7
	vmovq	%xmm7, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	%r11, %rdi
	jnb	.L1069
	cmpq	$32832, %rbx
	je	.L1069
.L870:
	vmovdqu	(%rdi), %xmm4
	incq	%rbx
	vpminsb	%xmm8, %xmm4, %xmm7
	vpsubusb	%xmm9, %xmm4, %xmm15
	vpcmpeqb	%xmm7, %xmm4, %xmm14
	vpmovmskb	%xmm14, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %rdi
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm6
	vpshufb	%xmm6, %xmm15, %xmm0
	vmovdqa	%xmm6, %xmm11
	vpmaddubsw	%xmm1, %xmm0, %xmm13
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm13, %xmm12
	vpackusdw	%xmm12, %xmm12, %xmm3
	vpmaddwd	%xmm5, %xmm3, %xmm4
	vmovq	%xmm4, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	%r11, %rdi
	jb	.L1084
.L1069:
	movq	56(%rsp), %r11
.L869:
	cmpq	%rsi, %r10
	vpmovmskb	%ymm10, %eax
	setne	%sil
	cmpq	%r9, %rdx
	setne	%dl
	orl	%edx, %esi
	cmpq	%r8, %r11
	setne	%r8b
	andl	$-2147450880, %eax
	xorl	%r10d, %r10d
	orl	%r8d, %esi
	cmpq	%rdi, 48(%rsp)
	movzbl	%sil, %r9d
	setne	%r10b
	orl	%r10d, %eax
	orl	%eax, %r9d
	jne	.L1085
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
	vmovdqa	.LC4(%rip), %ymm7
	vmovdqa	.LC3(%rip), %ymm3
	addq	%rbx, %r12
	vmovdqa	.LC2(%rip), %ymm4
	subq	%r12, 32(%rsp)
	leaq	(%r15,%r12,4), %r15
.L890:
	cmpq	$65600, 32(%rsp)
	jbe	.L1078
.L874:
	movq	48(%rsp), %rbx
	movq	%rbx, 40(%rsp)
	jmp	.L891
.L1047:
	vmovdqu	(%rdi), %xmm3
	incq	%rbx
	vpminsb	%xmm8, %xmm3, %xmm4
	vpsubusb	%xmm9, %xmm3, %xmm11
	vpcmpeqb	%xmm4, %xmm3, %xmm7
	vpmovmskb	%xmm7, %ecx
	tzcntl	%ecx, %eax
	incl	%eax
	movq	%rax, %rcx
	addq	%rax, %rdi
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm14
	vpshufb	%xmm14, %xmm11, %xmm15
	vmovdqa	%xmm14, %xmm6
	vpmaddubsw	%xmm1, %xmm15, %xmm0
	vporq	%ymm6, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm0, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm12
	vpmaddwd	%xmm5, %xmm12, %xmm3
	vmovq	%xmm3, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	48(%rsp), %rdi
	jnb	.L869
	cmpq	$32832, %rbx
	je	.L869
	movq	%r11, 56(%rsp)
	movq	48(%rsp), %r11
	jmp	.L870
.L1078:
	vzeroupper
.L857:
	movq	32(%rsp), %rdx
	movq	48(%rsp), %rdi
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
.L1085:
	.cfi_restore_state
	movq	48(%rsp), %r12
	cmpq	%r12, 40(%rsp)
	jnb	.L1086
	movq	40(%rsp), %r14
	leaq	-1(%r12), %r13
	cmpq	%r13, %r14
	cmovbe	%r14, %r13
	cmpq	%r14, %r13
	movq	%r13, %rsi
	setnb	%dil
	subq	%r14, %rsi
	cmpq	$62, %rsi
	jbe	.L896
	cmpq	%r14, %r13
	jb	.L896
	movl	$1, %ecx
	movl	$538976288, %r11d
	movq	%r14, %rax
	vpxor	%xmm1, %xmm1, %xmm1
	movq	%rcx, %r9
	vpbroadcastd	%r11d, %zmm10
	subq	%r14, %r9
	vpbroadcastq	%rcx, %zmm2
	addq	%r13, %r9
	testb	%dil, %dil
	cmove	%rcx, %r9
	movq	%r9, %r10
	andq	$-64, %r10
	leaq	(%r10,%r14), %r8
	testb	$64, %r10b
	je	.L876
	vmovdqu8	(%r14), %zmm1
	leaq	64(%r14), %rax
	vpcmpb	$6, %zmm10, %zmm1, %k1
	vmovdqa64	%zmm2, %zmm1{%k1}{z}
	kshiftrw	$8, %k1, %k5
	kshiftrd	$16, %k1, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k1, %k2
	vpaddq	%zmm2, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k2, %k7
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm1, %zmm1{%k4}
	vpaddq	%zmm2, %zmm1, %zmm1{%k6}
	kshiftrw	$8, %k3, %k1
	vpaddq	%zmm2, %zmm1, %zmm1{%k2}
	vpaddq	%zmm2, %zmm1, %zmm1{%k7}
	vpaddq	%zmm2, %zmm1, %zmm1{%k3}
	vpaddq	%zmm2, %zmm1, %zmm1{%k1}
	cmpq	%rax, %r8
	jne	.L876
.L1066:
	vextracti64x4	$0x1, %zmm1, %ymm6
	vpaddq	%ymm1, %ymm6, %ymm15
	vextracti64x2	$0x1, %ymm15, %xmm11
	vpaddq	%xmm15, %xmm11, %xmm0
	vpsrldq	$8, %xmm0, %xmm13
	vpaddq	%xmm13, %xmm0, %xmm12
	vmovq	%xmm12, %rdx
	cmpq	%r10, %r9
	je	.L877
	movq	%r8, %r12
.L1050:
	movq	%r13, %r14
	xorl	%ecx, %ecx
	leaq	1(%r12), %r10
	subq	%r12, %r14
	andl	$7, %r14d
	cmpb	$32, (%r12)
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%r10, %r13
	jnb	.L1087
.L877:
	movq	40(%rsp), %r10
	xorl	%r13d, %r13d
	testb	%dil, %dil
	cmovne	%rsi, %r13
	leaq	(%r10,%r13), %r11
	leaq	1(%r10,%r13), %rsi
	cmpq	48(%rsp), %rsi
	jnb	.L884
	movq	48(%rsp), %r8
	leaq	2(%r11), %r9
	leaq	-2(%r8), %rdi
	subq	%r11, %rdi
	cmpq	$62, %rdi
	jbe	.L996
	cmpq	%r9, %r8
	jb	.L996
	leaq	-1(%r8), %rbx
	movl	$1, %ecx
	movl	$538976288, %r14d
	vpxor	%xmm3, %xmm3, %xmm3
	subq	%r11, %rbx
	cmpq	%r9, %r8
	vpbroadcastd	%r14d, %zmm7
	cmovb	%rcx, %rbx
	vpxor	%xmm10, %xmm10, %xmm10
	movq	%rbx, %r12
	vpternlogd	$0xFF, %zmm3, %zmm3, %zmm3
	andq	$-64, %r12
	leaq	(%r12,%r11), %rax
.L882:
	vmovdqu8	1(%r11), %zmm4
	addq	$64, %r11
	vpcmpb	$6, %zmm7, %zmm4, %k7
	vmovdqu8	-64(%r11), %zmm2{%k7}{z}
	vmovdqa64	%zmm10, %zmm4
	kshiftrw	$8, %k7, %k5
	kshiftrd	$16, %k7, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k7, %k2
	kshiftrd	$16, %k2, %k3
	vpcmpb	$2, %zmm7, %zmm2, %k1
	vpabsb	%zmm3, %zmm5{%k1}{z}
	vpmovzxbw	%ymm5, %zmm8
	vextracti64x4	$0x1, %zmm5, %ymm9
	vpmovzxbw	%ymm9, %zmm14
	vpmovzxwd	%ymm8, %zmm6
	vextracti64x4	$0x1, %zmm8, %ymm1
	vpmovzxwd	%ymm1, %zmm15
	vpmovzxwd	%ymm14, %zmm13
	vpmovzxdq	%ymm6, %zmm12
	vextracti64x4	$0x1, %zmm14, %ymm11
	vpmovzxdq	%ymm15, %zmm5
	vpmovzxwd	%ymm11, %zmm0
	vpaddq	%zmm12, %zmm10, %zmm4{%k7}
	vextracti32x8	$0x1, %zmm6, %ymm10
	vpmovzxdq	%ymm13, %zmm6
	kshiftrw	$8, %k2, %k7
	vpmovzxdq	%ymm10, %zmm2
	vextracti32x8	$0x1, %zmm15, %ymm9
	vpmovzxdq	%ymm9, %zmm14
	vextracti32x8	$0x1, %zmm13, %ymm1
	vpaddq	%zmm2, %zmm4, %zmm4{%k5}
	vpmovzxdq	%ymm1, %zmm15
	vpmovzxdq	%ymm0, %zmm13
	vmovdqa64	%zmm4, %zmm8
	vextracti32x8	$0x1, %zmm0, %ymm11
	vpmovzxdq	%ymm11, %zmm0
	vpaddq	%zmm5, %zmm4, %zmm8{%k4}
	vmovdqa64	%zmm8, %zmm2
	vpaddq	%zmm14, %zmm8, %zmm2{%k6}
	vpaddq	%zmm6, %zmm2, %zmm2{%k2}
	kshiftrw	$8, %k3, %k2
	vpaddq	%zmm15, %zmm2, %zmm2{%k7}
	vpaddq	%zmm13, %zmm2, %zmm2{%k3}
	vmovdqa64	%zmm2, %zmm10
	vpaddq	%zmm0, %zmm2, %zmm10{%k2}
	cmpq	%rax, %r11
	jne	.L882
	vextracti64x4	$0x1, %zmm10, %ymm7
	vpaddq	%ymm10, %ymm7, %ymm3
	vextracti64x2	$0x1, %ymm3, %xmm12
	vpaddq	%xmm3, %xmm12, %xmm4
	vpsrldq	$8, %xmm4, %xmm5
	vpaddq	%xmm5, %xmm4, %xmm8
	vmovq	%xmm8, %r13
	addq	%r13, %rdx
	cmpq	%r12, %rbx
	je	.L884
	addq	%r12, %rsi
.L996:
	movq	%rsi, %r10
	notq	%r10
	addq	48(%rsp), %r10
	andl	$7, %r10d
	cmpb	$32, (%rsi)
	jle	.L1051
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rsi)
	setle	%r11b
	addq	%r11, %rdx
.L1051:
	leaq	1(%rsi), %rax
	cmpq	48(%rsp), %rax
	jnb	.L884
	testq	%r10, %r10
	je	.L887
	cmpq	$1, %r10
	je	.L998
	cmpq	$2, %r10
	je	.L999
	cmpq	$3, %r10
	je	.L1000
	cmpq	$4, %r10
	je	.L1001
	cmpq	$5, %r10
	je	.L1002
	cmpq	$6, %r10
	je	.L1003
	cmpb	$32, 1(%rsi)
	jg	.L1088
.L1053:
	incq	%rax
.L1003:
	cmpb	$32, (%rax)
	jle	.L1054
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
.L1054:
	incq	%rax
.L1002:
	cmpb	$32, (%rax)
	jg	.L1089
.L1055:
	incq	%rax
.L1001:
	cmpb	$32, (%rax)
	jg	.L1090
.L1056:
	incq	%rax
.L1000:
	cmpb	$32, (%rax)
	jg	.L1091
.L1057:
	incq	%rax
.L999:
	cmpb	$32, (%rax)
	jle	.L1058
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L1058:
	incq	%rax
.L998:
	cmpb	$32, (%rax)
	jle	.L1059
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
.L1059:
	incq	%rax
	cmpq	48(%rsp), %rax
	jnb	.L884
.L887:
	cmpb	$32, (%rax)
	jle	.L888
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L888:
	leaq	1(%rax), %r13
	cmpb	$32, 1(%rax)
	jle	.L1052
	xorl	%eax, %eax
	cmpb	$32, -1(%r13)
	setle	%al
	addq	%rax, %rdx
.L1052:
	cmpb	$32, 1(%r13)
	jle	.L1060
	xorl	%r10d, %r10d
	cmpb	$32, 0(%r13)
	setle	%r10b
	addq	%r10, %rdx
.L1060:
	cmpb	$32, 2(%r13)
	jle	.L1061
	xorl	%r11d, %r11d
	cmpb	$32, 1(%r13)
	setle	%r11b
	addq	%r11, %rdx
.L1061:
	cmpb	$32, 3(%r13)
	jle	.L1062
	xorl	%esi, %esi
	cmpb	$32, 2(%r13)
	setle	%sil
	addq	%rsi, %rdx
.L1062:
	cmpb	$32, 4(%r13)
	jle	.L1063
	xorl	%r9d, %r9d
	cmpb	$32, 3(%r13)
	setle	%r9b
	addq	%r9, %rdx
.L1063:
	cmpb	$32, 5(%r13)
	jle	.L1064
	xorl	%r8d, %r8d
	cmpb	$32, 4(%r13)
	setle	%r8b
	addq	%r8, %rdx
.L1064:
	cmpb	$32, 6(%r13)
	jle	.L1065
	xorl	%edi, %edi
	cmpb	$32, 5(%r13)
	setle	%dil
	addq	%rdi, %rdx
.L1065:
	leaq	7(%r13), %rax
	cmpq	48(%rsp), %rax
	jb	.L887
.L884:
	subq	%rdx, 32(%rsp)
	movq	40(%rsp), %rdi
	movq	%r15, %rsi
	leaq	(%r15,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm4
	vmovdqa	.LC3(%rip), %ymm3
	vmovdqa	.LC4(%rip), %ymm7
	jmp	.L890
.L876:
	vmovdqu8	(%rax), %zmm5
	vmovdqa64	%zmm1, %zmm8
	subq	$-128, %rax
	vmovdqu8	-64(%rax), %zmm14
	vpcmpb	$6, %zmm10, %zmm5, %k5
	vpaddq	%zmm2, %zmm1, %zmm8{%k5}
	kshiftrw	$8, %k5, %k6
	kshiftrd	$16, %k5, %k4
	vpaddq	%zmm2, %zmm8, %zmm8{%k6}
	kshiftrw	$8, %k4, %k7
	vpaddq	%zmm2, %zmm8, %zmm8{%k4}
	kshiftrq	$32, %k5, %k2
	vpaddq	%zmm2, %zmm8, %zmm8{%k7}
	kshiftrw	$8, %k2, %k1
	vpaddq	%zmm2, %zmm8, %zmm8{%k2}
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm8, %zmm8{%k1}
	kshiftrw	$8, %k3, %k5
	vpcmpb	$6, %zmm10, %zmm14, %k6
	vpaddq	%zmm2, %zmm8, %zmm8{%k3}
	vpaddq	%zmm2, %zmm8, %zmm8{%k5}
	vmovdqa64	%zmm8, %zmm1
	kshiftrw	$8, %k6, %k7
	kshiftrd	$16, %k6, %k4
	vpaddq	%zmm2, %zmm8, %zmm1{%k6}
	vpaddq	%zmm2, %zmm1, %zmm1{%k7}
	kshiftrw	$8, %k4, %k1
	kshiftrq	$32, %k6, %k2
	vpaddq	%zmm2, %zmm1, %zmm1{%k4}
	vpaddq	%zmm2, %zmm1, %zmm1{%k1}
	kshiftrw	$8, %k2, %k5
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm1, %zmm1{%k2}
	vpaddq	%zmm2, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k3, %k6
	vpaddq	%zmm2, %zmm1, %zmm1{%k3}
	vpaddq	%zmm2, %zmm1, %zmm1{%k6}
	cmpq	%rax, %r8
	je	.L1066
	jmp	.L876
.L1087:
	testq	%r14, %r14
	je	.L879
	cmpq	$1, %r14
	je	.L1004
	cmpq	$2, %r14
	je	.L1005
	cmpq	$3, %r14
	je	.L1006
	cmpq	$4, %r14
	je	.L1007
	cmpq	$5, %r14
	je	.L1008
	cmpq	$6, %r14
	jne	.L1092
.L1009:
	xorl	%r8d, %r8d
	cmpb	$32, (%r10)
	setg	%r8b
	incq	%r10
	addq	%r8, %rdx
.L1008:
	xorl	%r11d, %r11d
	cmpb	$32, (%r10)
	setg	%r11b
	incq	%r10
	addq	%r11, %rdx
.L1007:
	xorl	%ebx, %ebx
	cmpb	$32, (%r10)
	setg	%bl
	incq	%r10
	addq	%rbx, %rdx
.L1006:
	xorl	%eax, %eax
	cmpb	$32, (%r10)
	setg	%al
	incq	%r10
	addq	%rax, %rdx
.L1005:
	xorl	%r12d, %r12d
	cmpb	$32, (%r10)
	setg	%r12b
	incq	%r10
	addq	%r12, %rdx
.L1004:
	xorl	%r14d, %r14d
	cmpb	$32, (%r10)
	setg	%r14b
	incq	%r10
	addq	%r14, %rdx
	cmpq	%r10, %r13
	jb	.L877
.L879:
	xorl	%ecx, %ecx
	cmpb	$32, (%r10)
	setg	%cl
	xorl	%r9d, %r9d
	addq	%rcx, %rdx
	cmpb	$32, 1(%r10)
	setg	%r9b
	xorl	%r8d, %r8d
	addq	%r9, %rdx
	cmpb	$32, 2(%r10)
	setg	%r8b
	xorl	%r11d, %r11d
	addq	%r8, %rdx
	cmpb	$32, 3(%r10)
	setg	%r11b
	xorl	%ebx, %ebx
	addq	%r11, %rdx
	cmpb	$32, 4(%r10)
	setg	%bl
	xorl	%eax, %eax
	addq	%rbx, %rdx
	cmpb	$32, 5(%r10)
	setg	%al
	xorl	%r12d, %r12d
	addq	%rax, %rdx
	cmpb	$32, 6(%r10)
	setg	%r12b
	xorl	%r14d, %r14d
	addq	%r12, %rdx
	cmpb	$32, 7(%r10)
	setg	%r14b
	addq	$8, %r10
	addq	%r14, %rdx
	cmpq	%r10, %r13
	jb	.L877
	jmp	.L879
	.p2align 4
	.p2align 3
.L1091:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L1057
.L1090:
	xorl	%edi, %edi
	cmpb	$32, -1(%rax)
	setle	%dil
	addq	%rdi, %rdx
	jmp	.L1056
.L1089:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L1055
.L892:
	movq	%rdi, 48(%rsp)
	jmp	.L857
.L1086:
	movq	40(%rsp), %rdi
	xorl	%edx, %edx
	movq	%r15, %rsi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm4
	vmovdqa	.LC3(%rip), %ymm3
	vmovdqa	.LC4(%rip), %ymm7
	jmp	.L874
.L896:
	movq	40(%rsp), %r12
	xorl	%edx, %edx
	jmp	.L1050
.L1088:
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
	jmp	.L1053
.L1092:
	xorl	%r9d, %r9d
	cmpb	$32, 1(%r12)
	leaq	2(%r12), %r10
	setg	%r9b
	addq	%r9, %rdx
	jmp	.L1009
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
	movq	%rdi, %r8
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
	movq	%rdx, %r15
	movq	%rsi, %rbx
	andq	$-64, %rsp
	subq	$64, %rsp
	cmpq	$66688, %rdx
	jbe	.L1095
	vmovdqa	.LC2(%rip), %ymm3
	vmovdqa	.LC3(%rip), %ymm2
	vmovdqa	.LC4(%rip), %ymm6
	vmovdqa	.LC14(%rip), %ymm10
	.p2align 4
	.p2align 3
.L1125:
	movl	$538976288, %eax
	vpbroadcastd	%eax, %ymm4
	vpminsb	66624(%r8), %ymm4, %ymm0
	vpminsb	133248(%r8), %ymm4, %ymm5
	vpcmpeqb	66624(%r8), %ymm0, %ymm1
	vpcmpeqb	133248(%r8), %ymm5, %ymm7
	vpmovmskb	%ymm1, %edx
	vpmovmskb	%ymm7, %r9d
	tzcntl	%edx, %ecx
	tzcntl	%r9d, %r11d
	movl	%ecx, %esi
	movl	%r11d, %r12d
	leaq	66625(%rsi), %rdi
	leaq	133249(%r12), %rax
	leaq	133249(%r8,%r12), %r13
	leaq	66625(%r8,%rsi), %r10
	subq	%rdi, %rax
	movq	%r13, 40(%rsp)
	cmpq	%rdi, %rax
	cmovg	%rdi, %rax
	cmpq	$64, %rax
	jbe	.L1276
	movabsq	$1135184250689818561, %r14
	movq	%r10, 48(%rsp)
	movq	%r8, 32(%rsp)
	movl	$808464432, %edi
	movl	$100000000, %r9d
	movq	%r10, %rsi
	vpxor	%xmm7, %xmm7, %xmm7
	vpbroadcastd	%edi, %ymm8
	mulq	%r14
	movq	%r8, %rcx
	xorl	%r12d, %r12d
	vpbroadcastd	%r9d, %ymm9
	shrq	$2, %rdx
	.p2align 4
	.p2align 3
.L1098:
	movq	%rdx, 56(%rsp)
	movq	%r12, %r9
	leaq	(%r12,%rdx,4), %r10
	.p2align 4
	.p2align 3
.L1101:
	vmovdqu	(%rcx), %ymm11
	vpminsb	32(%rcx), %ymm4, %ymm14
	vpminsb	%ymm4, %ymm11, %ymm12
	vpcmpeqb	32(%rcx), %ymm14, %ymm15
	vpcmpeqb	%ymm12, %ymm11, %ymm13
	vpmovmskb	%ymm13, %r11d
	tzcntl	%r11d, %r8d
	blsr	%r11d, %eax
	blsr	%eax, %edx
	tzcntl	%edx, %edi
	blsr	%edx, %r11d
	vpmovmskb	%ymm15, %edx
	tzcntl	%eax, %r14d
	movl	%r11d, %eax
	salq	$32, %rdx
	orq	%rax, %rdx
	movl	%r8d, %eax
	movl	%r14d, %r11d
	vinserti64x2	$0x1, 1(%rcx,%rax), %ymm11, %ymm0
	incl	%eax
	tzcntq	%rdx, %rdx
	vmovdqu	1(%rcx,%r11), %xmm1
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm11
	movl	%r14d, %eax
	movl	%edi, %r11d
	subl	%r8d, %eax
	movl	%edi, %r8d
	vinserti64x2	$0x1, 1(%rcx,%r11), %ymm1, %ymm5
	salq	$4, %rax
	vpsubusb	%ymm8, %ymm0, %ymm14
	subl	%r14d, %r8d
	movl	%edx, %r14d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm11, %ymm13
	subl	%edi, %r14d
	leal	1(%rdx), %edi
	salq	$4, %r8
	vpsubusb	%ymm8, %ymm5, %ymm1
	salq	$4, %r14
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r8), %xmm12
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm12, %ymm16
	vpshufb	%ymm13, %ymm14, %ymm15
	vmovdqu	(%rsi), %ymm14
	vpmaddubsw	%ymm3, %ymm15, %ymm0
	addq	%rdi, %rcx
	vpmaddwd	%ymm2, %ymm0, %ymm11
	vpshufb	%ymm16, %ymm1, %ymm5
	vpminsb	32(%rsi), %ymm4, %ymm1
	vpminsb	%ymm4, %ymm14, %ymm15
	vpternlogq	$254, %ymm7, %ymm16, %ymm13
	vpcmpeqb	%ymm15, %ymm14, %ymm0
	vmovdqa	%ymm13, %ymm7
	vpmaddubsw	%ymm3, %ymm5, %ymm12
	vpmovmskb	%ymm0, %edx
	vpmaddwd	%ymm2, %ymm12, %ymm5
	tzcntl	%edx, %r8d
	blsr	%edx, %r11d
	blsr	%r11d, %eax
	tzcntl	%eax, %edi
	blsr	%eax, %edx
	tzcntl	%r11d, %r14d
	movl	%edx, %r11d
	vpcmpeqb	32(%rsi), %ymm1, %ymm12
	vpmovmskb	%ymm12, %eax
	salq	$32, %rax
	orq	%r11, %rax
	movl	%r14d, %r11d
	tzcntq	%rax, %rdx
	movl	%r8d, %eax
	vinserti64x2	$0x1, 1(%rsi,%rax), %ymm14, %ymm0
	incl	%eax
	vmovdqu	1(%rsi,%r11), %xmm14
	movl	%edi, %r11d
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms44rowsE(%rax), %xmm15
	movl	%r14d, %eax
	vinserti64x2	$0x1, 1(%rsi,%r11), %ymm14, %ymm1
	subl	%r8d, %eax
	movl	%edi, %r8d
	subl	%r14d, %r8d
	movl	%edx, %r14d
	salq	$4, %rax
	vpsubusb	%ymm8, %ymm0, %ymm13
	salq	$4, %r8
	vpsubusb	%ymm8, %ymm1, %ymm1
	subl	%edi, %r14d
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%rax), %ymm15, %ymm12
	vmovdqa	_ZN12qp_parse_ms44rowsE(%r8), %xmm14
	leal	1(%rdx), %edi
	salq	$4, %r14
	vinserti64x2	$0x1, _ZN12qp_parse_ms44rowsE(%r14), %ymm14, %ymm15
	addq	%rdi, %rsi
	vpshufb	%ymm12, %ymm13, %ymm0
	vpternlogq	$254, %ymm15, %ymm12, %ymm7
	vpshufb	%ymm15, %ymm1, %ymm15
	vpmaddubsw	%ymm3, %ymm0, %ymm12
	vpmaddubsw	%ymm3, %ymm15, %ymm13
	vpmaddwd	%ymm2, %ymm12, %ymm14
	vpmaddwd	%ymm2, %ymm13, %ymm0
	vpackusdw	%ymm14, %ymm11, %ymm11
	vpackusdw	%ymm0, %ymm5, %ymm5
	vpmaddwd	%ymm6, %ymm11, %ymm12
	vpmaddwd	%ymm6, %ymm5, %ymm14
	vshufps	$136, %ymm14, %ymm12, %ymm1
	vshufps	$221, %ymm14, %ymm12, %ymm13
	vpmulld	%ymm9, %ymm1, %ymm15
	vpaddd	%ymm13, %ymm15, %ymm0
	vpermd	%ymm0, %ymm10, %ymm11
	vpermq	$216, %ymm11, %ymm12
	vmovdqu	%xmm12, (%rbx,%r9,4)
	vextracti64x2	$0x1, %ymm12, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region(,%r9,4)
	addq	$4, %r9
	cmpq	%r10, %r9
	jne	.L1101
	movq	48(%rsp), %rdx
	movq	%r13, %r10
	movq	56(%rsp), %r9
	movabsq	$1135184250689818561, %rax
	subq	%rsi, %r10
	subq	%rcx, %rdx
	leaq	(%r12,%r9,4), %r12
	cmpq	%rdx, %r10
	cmovg	%rdx, %r10
	mulq	%r10
	shrq	$2, %rdx
	cmpq	$64, %r10
	ja	.L1098
	movq	48(%rsp), %r10
	movq	32(%rsp), %r8
	cmpq	$66687, %r12
	setbe	%r13b
.L1096:
	movq	%r12, %r14
	cmpq	%r10, %rcx
	jnb	.L1100
	vmovdqa	.LC8(%rip), %xmm2
	vmovdqa	.LC9(%rip), %xmm3
	movl	$538976288, %r11d
	movl	$808464432, %edi
	vmovdqa	.LC10(%rip), %xmm6
	vpbroadcastd	%r11d, %xmm10
	vpbroadcastd	%edi, %xmm4
	.p2align 4
	.p2align 3
.L1099:
	vmovdqu	(%rcx), %xmm8
	incq	%r14
	vpminsb	%xmm10, %xmm8, %xmm9
	vpsubusb	%xmm4, %xmm8, %xmm13
	vpcmpeqb	%xmm9, %xmm8, %xmm14
	vpmovmskb	%xmm14, %r9d
	tzcntl	%r9d, %edx
	incl	%edx
	movq	%rdx, %rax
	addq	%rdx, %rcx
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm1
	vpshufb	%xmm1, %xmm13, %xmm0
	vmovdqa	%xmm1, %xmm15
	vpmaddubsw	%xmm2, %xmm0, %xmm11
	vporq	%ymm15, %ymm7, %ymm7
	vpmaddwd	%xmm3, %xmm11, %xmm12
	vpackusdw	%xmm12, %xmm12, %xmm5
	vpmaddwd	%xmm6, %xmm5, %xmm8
	vmovq	%xmm8, %r11
	imull	$100000000, %r11d, %edi
	shrq	$32, %r11
	addl	%edi, %r11d
	movl	%r11d, -4(%rbx,%r14,4)
	cmpq	%r10, %rcx
	jb	.L1099
.L1100:
	movq	40(%rsp), %r9
	cmpq	%r9, %rsi
	jnb	.L1103
	testb	%r13b, %r13b
	je	.L1103
	movl	$538976288, %r13d
	movl	$808464432, %edx
	vmovdqa	.LC8(%rip), %xmm2
	vmovdqa	.LC9(%rip), %xmm3
	vmovdqa	.LC10(%rip), %xmm6
	vpbroadcastd	%r13d, %xmm10
	vpbroadcastd	%edx, %xmm4
	testb	$1, %r12b
	je	.L1104
	vmovdqu	(%rsi), %xmm9
	incq	%r12
	vpminsb	%xmm10, %xmm9, %xmm14
	vpsubusb	%xmm4, %xmm9, %xmm0
	vpcmpeqb	%xmm14, %xmm9, %xmm1
	vpmovmskb	%xmm1, %eax
	tzcntl	%eax, %r11d
	incl	%r11d
	movq	%r11, %rdi
	addq	%r11, %rsi
	salq	$4, %rdi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdi), %xmm15
	vpshufb	%xmm15, %xmm0, %xmm11
	vmovdqa	%xmm15, %xmm13
	vpmaddubsw	%xmm2, %xmm11, %xmm12
	vporq	%ymm13, %ymm7, %ymm7
	vpmaddwd	%xmm3, %xmm12, %xmm5
	vpackusdw	%xmm5, %xmm5, %xmm8
	vpmaddwd	%xmm6, %xmm8, %xmm9
	vmovq	%xmm9, %r13
	imull	$100000000, %r13d, %edx
	shrq	$32, %r13
	addl	%edx, %r13d
	movl	%r13d, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	40(%rsp), %rsi
	jnb	.L1103
	cmpq	$66688, %r12
	jne	.L1104
	jmp	.L1103
	.p2align 4
	.p2align 3
.L1277:
	vmovdqu	(%rsi), %xmm1
	incq	%r12
	vpminsb	%xmm10, %xmm1, %xmm15
	vpsubusb	%xmm4, %xmm1, %xmm12
	vpcmpeqb	%xmm15, %xmm1, %xmm13
	vpmovmskb	%xmm13, %eax
	tzcntl	%eax, %r11d
	incl	%r11d
	movq	%r11, %rdi
	addq	%r11, %rsi
	salq	$4, %rdi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdi), %xmm11
	vpshufb	%xmm11, %xmm12, %xmm5
	vmovdqa	%xmm11, %xmm0
	vpmaddubsw	%xmm2, %xmm5, %xmm8
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm3, %xmm8, %xmm9
	vpackusdw	%xmm9, %xmm9, %xmm14
	vpmaddwd	%xmm6, %xmm14, %xmm1
	vmovq	%xmm1, %r13
	imull	$100000000, %r13d, %edx
	shrq	$32, %r13
	addl	%edx, %r13d
	movl	%r13d, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r9, %rsi
	jnb	.L1103
	cmpq	$66688, %r12
	je	.L1103
.L1104:
	vmovdqu	(%rsi), %xmm14
	incq	%r12
	vpminsb	%xmm10, %xmm14, %xmm1
	vpsubusb	%xmm4, %xmm14, %xmm11
	vpcmpeqb	%xmm1, %xmm14, %xmm15
	vpmovmskb	%xmm15, %eax
	tzcntl	%eax, %r11d
	incl	%r11d
	movq	%r11, %rdi
	addq	%r11, %rsi
	salq	$4, %rdi
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rdi), %xmm13
	vpshufb	%xmm13, %xmm11, %xmm12
	vmovdqa	%xmm13, %xmm0
	vpmaddubsw	%xmm2, %xmm12, %xmm5
	vporq	%ymm0, %ymm7, %ymm7
	vpmaddwd	%xmm3, %xmm5, %xmm8
	vpackusdw	%xmm8, %xmm8, %xmm9
	vpmaddwd	%xmm6, %xmm9, %xmm14
	vmovq	%xmm14, %r13
	imull	$100000000, %r13d, %edx
	shrq	$32, %r13
	addl	%edx, %r13d
	movl	%r13d, _ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%r9, %rsi
	jb	.L1277
.L1103:
	vpmovmskb	%ymm7, %r9d
	xorl	%eax, %eax
	andl	$-2147450880, %r9d
	cmpq	%rsi, 40(%rsp)
	setne	%al
	xorl	%esi, %esi
	orl	%eax, %r9d
	cmpq	%rcx, %r10
	setne	%sil
	orl	%esi, %r9d
	jne	.L1278
	leaq	(%rbx,%r14,4), %rdi
	leaq	0(,%r12,4), %rdx
	movl	$_ZZN12qp_parse_ms413parse_tokens2ILm65536ELm1088EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region, %esi
	vzeroupper
	call	memcpy
	vmovdqa	.LC14(%rip), %ymm10
	vmovdqa	.LC4(%rip), %ymm6
	addq	%r12, %r14
	vmovdqa	.LC3(%rip), %ymm2
	vmovdqa	.LC2(%rip), %ymm3
	leaq	(%rbx,%r14,4), %rbx
	subq	%r14, %r15
.L1124:
	cmpq	$66688, %r15
	jbe	.L1269
.L1108:
	movq	40(%rsp), %r8
	jmp	.L1125
.L1269:
	movq	40(%rsp), %r8
	vzeroupper
.L1095:
	leaq	-40(%rbp), %rsp
	movq	%r15, %rdx
	movq	%rbx, %rsi
	popq	%rbx
	popq	%r12
	popq	%r13
	movq	%r8, %rdi
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	_ZN13qp_parse_flat12parse_tokensEPcPjm
.L1276:
	.cfi_restore_state
	movq	%r10, %rsi
	movq	%r8, %rcx
	movl	$1, %r13d
	vpxor	%xmm7, %xmm7, %xmm7
	xorl	%r12d, %r12d
	jmp	.L1096
.L1278:
	cmpq	40(%rsp), %r8
	jnb	.L1279
	movq	40(%rsp), %rcx
	leaq	-1(%rcx), %r14
	cmpq	%r14, %r8
	cmovbe	%r8, %r14
	cmpq	%r8, %r14
	movq	%r14, %rsi
	setnb	%dil
	subq	%r8, %rsi
	cmpq	$62, %rsi
	jbe	.L1129
	cmpq	%r8, %r14
	jb	.L1129
	movl	$1, %r13d
	movl	$538976288, %r12d
	movq	%r8, %rdx
	vpxor	%xmm1, %xmm1, %xmm1
	movq	%r13, %r10
	vpbroadcastd	%r12d, %zmm4
	subq	%r8, %r10
	vpbroadcastq	%r13, %zmm7
	addq	%r14, %r10
	testb	%dil, %dil
	cmove	%r13, %r10
	movq	%r10, %r11
	andq	$-64, %r11
	leaq	(%r11,%r8), %r9
	testb	$64, %r11b
	je	.L1110
	vmovdqu8	(%r8), %zmm15
	leaq	64(%r8), %rdx
	vpcmpb	$6, %zmm4, %zmm15, %k1
	vmovdqa64	%zmm7, %zmm1{%k1}{z}
	kshiftrw	$8, %k1, %k5
	kshiftrd	$16, %k1, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k1, %k2
	vpaddq	%zmm7, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k2, %k7
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm7, %zmm1, %zmm1{%k4}
	vpaddq	%zmm7, %zmm1, %zmm1{%k6}
	kshiftrw	$8, %k3, %k1
	vpaddq	%zmm7, %zmm1, %zmm1{%k2}
	vpaddq	%zmm7, %zmm1, %zmm1{%k7}
	vpaddq	%zmm7, %zmm1, %zmm1{%k3}
	vpaddq	%zmm7, %zmm1, %zmm1{%k1}
	cmpq	%rdx, %r9
	jne	.L1110
.L1266:
	vextracti64x4	$0x1, %zmm1, %ymm5
	vpaddq	%ymm1, %ymm5, %ymm8
	vextracti64x2	$0x1, %ymm8, %xmm9
	vpaddq	%xmm8, %xmm9, %xmm14
	vpsrldq	$8, %xmm14, %xmm10
	vpaddq	%xmm10, %xmm14, %xmm6
	vmovq	%xmm6, %rdx
	cmpq	%r11, %r10
	je	.L1111
	movq	%r9, %rax
.L1250:
	movq	%r14, %rcx
	xorl	%r13d, %r13d
	leaq	1(%rax), %r11
	subq	%rax, %rcx
	andl	$7, %ecx
	cmpb	$32, (%rax)
	setg	%r13b
	addq	%r13, %rdx
	cmpq	%r11, %r14
	jnb	.L1280
.L1111:
	xorl	%r14d, %r14d
	testb	%dil, %dil
	cmovne	%rsi, %r14
	leaq	(%r8,%r14), %r11
	leaq	1(%r8,%r14), %rsi
	cmpq	40(%rsp), %rsi
	jnb	.L1118
	movq	40(%rsp), %rdi
	leaq	2(%r11), %rax
	subq	$2, %rdi
	subq	%r11, %rdi
	cmpq	$62, %rdi
	jbe	.L1210
	movq	40(%rsp), %rcx
	cmpq	%rax, %rcx
	jb	.L1210
	leaq	-1(%rcx), %r13
	movl	$1, %r10d
	movl	$538976288, %r14d
	vpxor	%xmm3, %xmm3, %xmm3
	subq	%r11, %r13
	cmpq	%rax, %rcx
	vpbroadcastd	%r14d, %zmm2
	cmovb	%r10, %r13
	vpxor	%xmm11, %xmm11, %xmm11
	movq	%r13, %r9
	vpternlogd	$0xFF, %zmm3, %zmm3, %zmm3
	andq	$-64, %r9
	leaq	(%r9,%r11), %r12
.L1116:
	vmovdqu8	1(%r11), %zmm4
	addq	$64, %r11
	vpcmpb	$6, %zmm2, %zmm4, %k7
	vmovdqu8	-64(%r11), %zmm7{%k7}{z}
	kshiftrw	$8, %k7, %k5
	kshiftrd	$16, %k7, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k7, %k2
	kshiftrd	$16, %k2, %k3
	vpcmpb	$2, %zmm2, %zmm7, %k1
	vpabsb	%zmm3, %zmm15{%k1}{z}
	vpmovzxbw	%ymm15, %zmm13
	vextracti64x4	$0x1, %zmm15, %ymm0
	vmovdqa64	%zmm11, %zmm15
	vpmovzxbw	%ymm0, %zmm12
	vpmovzxwd	%ymm13, %zmm8
	vextracti64x4	$0x1, %zmm13, %ymm1
	vpmovzxwd	%ymm1, %zmm9
	vpmovzxwd	%ymm12, %zmm5
	vpmovzxdq	%ymm8, %zmm6
	vextracti64x4	$0x1, %zmm12, %ymm14
	vpmovzxdq	%ymm9, %zmm13
	vextracti32x8	$0x1, %zmm9, %ymm0
	vpaddq	%zmm6, %zmm11, %zmm15{%k7}
	vextracti32x8	$0x1, %zmm8, %ymm11
	kshiftrw	$8, %k2, %k7
	vpmovzxdq	%ymm11, %zmm4
	vmovdqa64	%zmm15, %zmm7
	vpmovzxdq	%ymm0, %zmm12
	vpmovzxdq	%ymm5, %zmm8
	vpmovzxwd	%ymm14, %zmm10
	vpaddq	%zmm4, %zmm15, %zmm7{%k5}
	vextracti32x8	$0x1, %zmm5, %ymm1
	vpmovzxdq	%ymm1, %zmm14
	vpaddq	%zmm13, %zmm7, %zmm7{%k4}
	vpaddq	%zmm12, %zmm7, %zmm7{%k6}
	vmovdqa64	%zmm7, %zmm9
	vpmovzxdq	%ymm10, %zmm5
	vextracti32x8	$0x1, %zmm10, %ymm10
	vpmovzxdq	%ymm10, %zmm6
	vpaddq	%zmm8, %zmm7, %zmm9{%k2}
	kshiftrw	$8, %k3, %k2
	vmovdqa64	%zmm9, %zmm4
	vpaddq	%zmm14, %zmm9, %zmm4{%k7}
	vpaddq	%zmm5, %zmm4, %zmm4{%k3}
	vmovdqa64	%zmm4, %zmm11
	vpaddq	%zmm6, %zmm4, %zmm11{%k2}
	cmpq	%r12, %r11
	jne	.L1116
	vextracti64x4	$0x1, %zmm11, %ymm2
	vpaddq	%ymm11, %ymm2, %ymm3
	vextracti64x2	$0x1, %ymm3, %xmm15
	vpaddq	%xmm3, %xmm15, %xmm7
	vpsrldq	$8, %xmm7, %xmm13
	vpaddq	%xmm13, %xmm7, %xmm0
	vmovq	%xmm0, %r11
	addq	%r11, %rdx
	cmpq	%r9, %r13
	je	.L1118
	addq	%r9, %rsi
.L1210:
	movq	%rsi, %rdi
	notq	%rdi
	addq	40(%rsp), %rdi
	andl	$7, %edi
	cmpb	$32, (%rsi)
	jle	.L1251
	xorl	%eax, %eax
	cmpb	$32, -1(%rsi)
	setle	%al
	addq	%rax, %rdx
.L1251:
	leaq	1(%rsi), %rax
	cmpq	40(%rsp), %rax
	jnb	.L1118
	testq	%rdi, %rdi
	je	.L1121
	cmpq	$1, %rdi
	je	.L1212
	cmpq	$2, %rdi
	je	.L1213
	cmpq	$3, %rdi
	je	.L1214
	cmpq	$4, %rdi
	je	.L1215
	cmpq	$5, %rdi
	je	.L1216
	cmpq	$6, %rdi
	je	.L1217
	cmpb	$32, 1(%rsi)
	jg	.L1281
.L1253:
	incq	%rax
.L1217:
	cmpb	$32, (%rax)
	jle	.L1254
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L1254:
	incq	%rax
.L1216:
	cmpb	$32, (%rax)
	jg	.L1282
.L1255:
	incq	%rax
.L1215:
	cmpb	$32, (%rax)
	jg	.L1283
.L1256:
	incq	%rax
.L1214:
	cmpb	$32, (%rax)
	jg	.L1284
.L1257:
	incq	%rax
.L1213:
	cmpb	$32, (%rax)
	jle	.L1258
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
.L1258:
	incq	%rax
.L1212:
	cmpb	$32, (%rax)
	jle	.L1259
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L1259:
	incq	%rax
	cmpq	40(%rsp), %rax
	jnb	.L1118
.L1121:
	cmpb	$32, (%rax)
	jle	.L1122
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rax)
	setle	%r11b
	addq	%r11, %rdx
.L1122:
	leaq	1(%rax), %rdi
	cmpb	$32, 1(%rax)
	jle	.L1252
	xorl	%eax, %eax
	cmpb	$32, -1(%rdi)
	setle	%al
	addq	%rax, %rdx
.L1252:
	cmpb	$32, 1(%rdi)
	jle	.L1260
	xorl	%esi, %esi
	cmpb	$32, (%rdi)
	setle	%sil
	addq	%rsi, %rdx
.L1260:
	cmpb	$32, 2(%rdi)
	jle	.L1261
	xorl	%ecx, %ecx
	cmpb	$32, 1(%rdi)
	setle	%cl
	addq	%rcx, %rdx
.L1261:
	cmpb	$32, 3(%rdi)
	jle	.L1262
	xorl	%r13d, %r13d
	cmpb	$32, 2(%rdi)
	setle	%r13b
	addq	%r13, %rdx
.L1262:
	cmpb	$32, 4(%rdi)
	jle	.L1263
	xorl	%r10d, %r10d
	cmpb	$32, 3(%rdi)
	setle	%r10b
	addq	%r10, %rdx
.L1263:
	cmpb	$32, 5(%rdi)
	jle	.L1264
	xorl	%r9d, %r9d
	cmpb	$32, 4(%rdi)
	setle	%r9b
	addq	%r9, %rdx
.L1264:
	cmpb	$32, 6(%rdi)
	jle	.L1265
	xorl	%r12d, %r12d
	cmpb	$32, 5(%rdi)
	setle	%r12b
	addq	%r12, %rdx
.L1265:
	leaq	7(%rdi), %rax
	cmpq	40(%rsp), %rax
	jb	.L1121
.L1118:
	subq	%rdx, %r15
	movq	%rbx, %rsi
	movq	%r8, %rdi
	vzeroupper
	leaq	(%rbx,%rdx,4), %rbx
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm3
	vmovdqa	.LC3(%rip), %ymm2
	vmovdqa	.LC4(%rip), %ymm6
	vmovdqa	.LC14(%rip), %ymm10
	jmp	.L1124
.L1110:
	vmovdqu8	(%rdx), %zmm13
	vmovdqa64	%zmm1, %zmm11
	subq	$-128, %rdx
	vmovdqu8	-64(%rdx), %zmm12
	vpcmpb	$6, %zmm4, %zmm13, %k5
	vpaddq	%zmm7, %zmm1, %zmm11{%k5}
	kshiftrw	$8, %k5, %k6
	kshiftrd	$16, %k5, %k4
	vpaddq	%zmm7, %zmm11, %zmm11{%k6}
	kshiftrw	$8, %k4, %k7
	vpaddq	%zmm7, %zmm11, %zmm11{%k4}
	kshiftrq	$32, %k5, %k2
	vpaddq	%zmm7, %zmm11, %zmm11{%k7}
	kshiftrw	$8, %k2, %k1
	vpaddq	%zmm7, %zmm11, %zmm11{%k2}
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm7, %zmm11, %zmm11{%k1}
	kshiftrw	$8, %k3, %k5
	vpcmpb	$6, %zmm4, %zmm12, %k6
	vpaddq	%zmm7, %zmm11, %zmm11{%k3}
	vpaddq	%zmm7, %zmm11, %zmm11{%k5}
	vmovdqa64	%zmm11, %zmm1
	kshiftrw	$8, %k6, %k7
	kshiftrd	$16, %k6, %k4
	vpaddq	%zmm7, %zmm11, %zmm1{%k6}
	vpaddq	%zmm7, %zmm1, %zmm1{%k7}
	kshiftrw	$8, %k4, %k1
	kshiftrq	$32, %k6, %k2
	vpaddq	%zmm7, %zmm1, %zmm1{%k4}
	vpaddq	%zmm7, %zmm1, %zmm1{%k1}
	kshiftrw	$8, %k2, %k5
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm7, %zmm1, %zmm1{%k2}
	vpaddq	%zmm7, %zmm1, %zmm1{%k5}
	kshiftrw	$8, %k3, %k6
	vpaddq	%zmm7, %zmm1, %zmm1{%k3}
	vpaddq	%zmm7, %zmm1, %zmm1{%k6}
	cmpq	%rdx, %r9
	je	.L1266
	jmp	.L1110
.L1280:
	testq	%rcx, %rcx
	je	.L1113
	cmpq	$1, %rcx
	je	.L1218
	cmpq	$2, %rcx
	je	.L1219
	cmpq	$3, %rcx
	je	.L1220
	cmpq	$4, %rcx
	je	.L1221
	cmpq	$5, %rcx
	je	.L1222
	cmpq	$6, %rcx
	jne	.L1285
.L1223:
	xorl	%r9d, %r9d
	cmpb	$32, (%r11)
	setg	%r9b
	incq	%r11
	addq	%r9, %rdx
.L1222:
	xorl	%r12d, %r12d
	cmpb	$32, (%r11)
	setg	%r12b
	incq	%r11
	addq	%r12, %rdx
.L1221:
	xorl	%eax, %eax
	cmpb	$32, (%r11)
	setg	%al
	incq	%r11
	addq	%rax, %rdx
.L1220:
	xorl	%ecx, %ecx
	cmpb	$32, (%r11)
	setg	%cl
	incq	%r11
	addq	%rcx, %rdx
.L1219:
	xorl	%r13d, %r13d
	cmpb	$32, (%r11)
	setg	%r13b
	incq	%r11
	addq	%r13, %rdx
.L1218:
	xorl	%r10d, %r10d
	cmpb	$32, (%r11)
	setg	%r10b
	incq	%r11
	addq	%r10, %rdx
	cmpq	%r11, %r14
	jb	.L1111
.L1113:
	xorl	%r9d, %r9d
	cmpb	$32, (%r11)
	setg	%r9b
	xorl	%r12d, %r12d
	addq	%r9, %rdx
	cmpb	$32, 1(%r11)
	setg	%r12b
	xorl	%eax, %eax
	addq	%r12, %rdx
	cmpb	$32, 2(%r11)
	setg	%al
	xorl	%ecx, %ecx
	addq	%rax, %rdx
	cmpb	$32, 3(%r11)
	setg	%cl
	xorl	%r13d, %r13d
	addq	%rcx, %rdx
	cmpb	$32, 4(%r11)
	setg	%r13b
	xorl	%r10d, %r10d
	addq	%r13, %rdx
	cmpb	$32, 5(%r11)
	setg	%r10b
	xorl	%r9d, %r9d
	addq	%r10, %rdx
	cmpb	$32, 6(%r11)
	setg	%r9b
	xorl	%r12d, %r12d
	addq	%r9, %rdx
	cmpb	$32, 7(%r11)
	setg	%r12b
	addq	$8, %r11
	addq	%r12, %rdx
	cmpq	%r11, %r14
	jb	.L1111
	jmp	.L1113
	.p2align 4
	.p2align 3
.L1284:
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
	jmp	.L1257
.L1283:
	xorl	%r10d, %r10d
	cmpb	$32, -1(%rax)
	setle	%r10b
	addq	%r10, %rdx
	jmp	.L1256
.L1282:
	xorl	%r13d, %r13d
	cmpb	$32, -1(%rax)
	setle	%r13b
	addq	%r13, %rdx
	jmp	.L1255
.L1279:
	xorl	%edx, %edx
	movq	%rbx, %rsi
	movq	%r8, %rdi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm3
	vmovdqa	.LC3(%rip), %ymm2
	vmovdqa	.LC4(%rip), %ymm6
	vmovdqa	.LC14(%rip), %ymm10
	jmp	.L1108
.L1129:
	movq	%r8, %rax
	xorl	%edx, %edx
	jmp	.L1250
.L1281:
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
	jmp	.L1253
.L1285:
	xorl	%r10d, %r10d
	cmpb	$32, 1(%rax)
	leaq	2(%rax), %r11
	setg	%r10b
	addq	%r10, %rdx
	jmp	.L1223
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
	.align 32
.LC21:
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.long	-776530087
	.long	0
	.align 32
.LC22:
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.long	720575941
	.long	0
	.align 32
.LC40:
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
.LC41:
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
.LC42:
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
.LC43:
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
.LC44:
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
.LC45:
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
