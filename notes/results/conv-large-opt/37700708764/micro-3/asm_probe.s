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
	xorl	%r9d, %r9d
	tzcntq	%r8, %r15
	blsr	%r8, %r9
	xorl	%r10d, %r10d
	tzcntq	%r9, %r8
	vmovq	%r15, %xmm11
	blsr	%r9, %r10
	xorl	%edx, %edx
	tzcntq	%r10, %r11
	vpinsrq	$1, %r8, %xmm11, %xmm3
	blsr	%r10, %rdx
	xorl	%r15d, %r15d
	tzcntq	%rdx, %r9
	vmovq	%r11, %xmm12
	blsr	%rdx, %r15
	xorl	%edx, %edx
	tzcntq	%r15, %r10
	vpinsrq	$1, %r9, %xmm12, %xmm2
	blsr	%r15, %rdx
	vmovq	%r10, %xmm13
	xorl	%r10d, %r10d
	tzcntq	%rdx, %r11
	blsr	%rdx, %r10
	xorl	%edx, %edx
	tzcntq	%r10, %r15
	vpinsrq	$1, %r11, %xmm13, %xmm0
	blsr	%r10, %rdx
	vmovq	%r15, %xmm14
	tzcntq	%rdx, %r10
	vinserti64x2	$0x1, %xmm2, %ymm3, %ymm11
	vpinsrq	$1, %r10, %xmm14, %xmm15
	xorl	%r8d, %r8d
	addq	$32, %rcx
	vinserti64x2	$0x1, %xmm15, %ymm0, %ymm1
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
	subl	%r9d, %r15d
	movl	%r11d, -60(%rsp)
	movl	-56(%rsp,%rdi,4), %r11d
	movl	%r15d, -64(%rsp)
	movl	%r10d, %esi
	subl	%ecx, %esi
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
	movl	-64(%rsp), %edx
	movl	-68(%rsp), %r15d
	vinserti64x2	$0x1, (%rbx,%r8), %ymm1, %ymm11
	vmovdqu	(%rbx,%rcx), %xmm14
	vinserti64x2	$0x1, (%rbx,%r10), %ymm14, %ymm0
	movl	$100000000, %r10d
	subq	$4, %r13
	addq	$16, %r12
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
	shrq	$4, %rdi
	salq	$6, %rdi
	leaq	-64(%rdi), %r8
	leaq	-56(%rsp,%rsi,4), %r10
	xorl	%r9d, %r9d
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
	subq	%rsi, %rcx
	leaq	1(%r15), %r11
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
	.globl	_Z12probe_formatPKjPcm
	.type	_Z12probe_formatPKjPcm, @function
_Z12probe_formatPKjPcm:
.LFB8934:
	.cfi_startproc
	cmpq	$31, %rdx
	jbe	.L99
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
	vmovdqa	%ymm2, 136(%rsp)
	vmovdqa32	.LC14(%rip), %ymm21
	vmovdqa32	.LC15(%rip), %ymm20
	movl	$999, %ecx
	movl	$99, %r8d
	vmovdqa64	.LC33(%rip), %ymm29
	vmovdqa64	.LC34(%rip), %ymm19
	movl	$9, %r9d
	movl	$65280, %r10d
	vmovdqa64	.LC35(%rip), %ymm28
	vmovdqa64	.LC36(%rip), %ymm18
	movl	$343610491, %r11d
	movq	%rsi, %rax
	movq	%rdx, %rsi
	movl	$32, %edx
	vpbroadcastd	%ecx, %ymm3
	vpbroadcastd	%r8d, %ymm4
	vpbroadcastd	%r9d, %ymm6
	vpbroadcastd	%r10d, %ymm7
	vmovdqa	%ymm3, 72(%rsp)
	vmovdqa	%ymm4, 40(%rsp)
	vmovdqa	%ymm6, 8(%rsp)
	vmovdqa	%ymm7, -24(%rsp)
	vpbroadcastd	%r11d, %ymm16
	.p2align 4
	.p2align 3
.L95:
	vmovdqu	-128(%rdi,%rdx,4), %ymm13
	vmovdqa32	-120(%rsp), %ymm27
	movl	$572662306, %ecx
	movl	$1145324612, %r8d
	vmovdqa32	168(%rsp), %ymm30
	vmovdqa32	136(%rsp), %ymm26
	kmovd	%ecx, %k3
	movl	$-2004318072, %r9d
	vmovdqa32	-88(%rsp), %ymm31
	kmovd	%r8d, %k2
	movl	$65436, %r10d
	movl	$429529498, %r11d
	kmovd	%r9d, %k1
	movl	$16122102, %ecx
	movl	$808464432, %r8d
	movl	$538976288, %r9d
	vmovdqu	-96(%rdi,%rdx,4), %ymm4
	vmovdqu	-64(%rdi,%rdx,4), %ymm3
	addq	$320, %rax
	vmovdqu	-32(%rdi,%rdx,4), %ymm2
	addq	$32, %rdx
	vpsrlq	$32, %ymm13, %ymm8
	vpmuludq	%ymm21, %ymm13, %ymm11
	vpmuludq	%ymm20, %ymm8, %ymm15
	vpmuludq	%ymm20, %ymm13, %ymm0
	vpmuludq	%ymm21, %ymm8, %ymm9
	vpminsd	%ymm31, %ymm13, %ymm8
	vpsrlq	$45, %ymm11, %ymm12
	vpsrlq	$24, %ymm15, %ymm5
	vpsrlq	$56, %ymm0, %ymm1
	vpblendd	$170, %ymm5, %ymm1, %ymm11
	vpsrlq	$13, %ymm9, %ymm10
	vpblendd	$170, %ymm10, %ymm12, %ymm14
	vpmulld	%ymm17, %ymm11, %ymm7
	vpmulld	%ymm17, %ymm14, %ymm6
	vpminsd	%ymm30, %ymm13, %ymm5
	vpminsd	%ymm26, %ymm13, %ymm0
	vpcmpeqd	%ymm5, %ymm13, %ymm1
	vpcmpeqd	%ymm0, %ymm13, %ymm0
	vpmuludq	%ymm20, %ymm4, %ymm24
	vpcmpeqd	%ymm8, %ymm13, %ymm10
	vmovdqu8	%ymm1, %ymm0{%k3}
	vpminsd	40(%rsp), %ymm13, %ymm8
	vpsubd	%ymm7, %ymm14, %ymm9
	vpminsd	%ymm27, %ymm13, %ymm14
	vpsubd	%ymm6, %ymm13, %ymm12
	vpminsd	72(%rsp), %ymm13, %ymm6
	vpcmpeqd	%ymm14, %ymm13, %ymm15
	vpminsd	8(%rsp), %ymm13, %ymm14
	vpmulhuw	%ymm16, %ymm9, %ymm5
	vmovdqu8	%ymm15, %ymm0{%k2}
	vmovdqu8	%ymm10, %ymm0{%k1}
	vpcmpeqd	%ymm8, %ymm13, %ymm10
	vpcmpeqd	%ymm6, %ymm13, %ymm7
	vpsrlw	$3, %ymm5, %ymm6
	vpbroadcastd	%r11d, %ymm5
	movl	$48, %r11d
	vpcmpeqd	%ymm14, %ymm13, %ymm15
	vpandq	-24(%rsp), %ymm15, %ymm1
	vpxor	%xmm14, %xmm14, %xmm14
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
	vpaddd	%ymm9, %ymm7, %ymm15
	vpbroadcastd	%ecx, %ymm9
	vpbroadcastd	%r8d, %ymm7
	movl	$32, %ecx
	vpmulhuw	%ymm5, %ymm15, %ymm8
	vmovdqa	%ymm7, 200(%rsp)
	vmovdqa	%ymm13, 104(%rsp)
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
	vpbroadcastd	%ecx, %ymm6
	vpcmpd	$6, %ymm22, %ymm4, %k5
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
	vmovdqa	%ymm6, %ymm12
	vpaddd	104(%rsp), %ymm24, %ymm12{%k5}
	vpcmpd	$6, %ymm22, %ymm3, %k4
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
	vpmulhuw	%ymm16, %ymm26, %ymm30
	vpcmpd	$6, %ymm22, %ymm2, %k1
	vpaddd	104(%rsp), %ymm25, %ymm6{%k1}
	vpbroadcastd	%r8d, %ymm2
	vpcmpb	$5, %ymm14, %ymm11, %k2
	vporq	%ymm2, %ymm13, %ymm13
	vporq	%ymm2, %ymm12, %ymm12
	vpshufb	%ymm18, %ymm23, %ymm22
	vpsrlw	$3, %ymm30, %ymm31
	vpmulld	%ymm10, %ymm31, %ymm30
	vpshufb	%ymm29, %ymm13, %ymm11
	vpaddd	%ymm26, %ymm30, %ymm26
	vmovdqa64	%ymm0, %ymm30
	vporq	%ymm2, %ymm6, %ymm6
	vpmulhuw	%ymm5, %ymm26, %ymm31
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
	vpshufb	.LC37(%rip), %ymm13, %ymm9
	vpshufb	.LC38(%rip), %ymm13, %ymm13
	vporq	%ymm3, %ymm15, %ymm14
	vporq	%ymm9, %ymm11, %ymm10
	vporq	%ymm13, %ymm8, %ymm3
	vpshufb	.LC37(%rip), %ymm12, %ymm15
	vpshufb	.LC38(%rip), %ymm12, %ymm11
	vmovdqu	%xmm14, -310(%rax)
	vpshufb	%ymm28, %ymm12, %ymm8
	vmovdqu	%xmm10, -300(%rax)
	vmovdqu	%xmm3, -290(%rax)
	vextracti64x2	$0x1, %ymm5, -280(%rax)
	vextracti64x2	$0x1, %ymm14, -270(%rax)
	vpshufb	%ymm19, %ymm23, %ymm5
	vextracti64x2	$0x1, %ymm10, -260(%rax)
	vporq	%ymm8, %ymm22, %ymm23
	vpunpckldq	%ymm0, %ymm30, %ymm1
	vextracti64x2	$0x1, %ymm3, -250(%rax)
	vpshufb	%ymm29, %ymm12, %ymm14
	vpunpckhdq	%ymm0, %ymm30, %ymm0
	vpshufb	%ymm19, %ymm7, %ymm3
	vpshufb	%ymm18, %ymm7, %ymm7
	vporq	%ymm14, %ymm5, %ymm10
	vporq	%ymm15, %ymm3, %ymm9
	vmovdqu	%xmm10, -240(%rax)
	vmovdqu64	%xmm23, -230(%rax)
	vporq	%ymm11, %ymm7, %ymm13
	vmovdqu	%xmm9, -220(%rax)
	vmovdqu	%xmm13, -210(%rax)
	vextracti64x2	$0x1, %ymm10, -200(%rax)
	vporq	-56(%rsp), %ymm2, %ymm10
	vextracti64x2	$0x1, %ymm23, -190(%rax)
	vpshufb	%ymm19, %ymm24, %ymm3
	vextracti64x2	$0x1, %ymm9, -180(%rax)
	vpshufb	%ymm18, %ymm24, %ymm24
	vextracti64x2	$0x1, %ymm13, -170(%rax)
	vpshufb	%ymm19, %ymm4, %ymm13
	vpshufb	%ymm18, %ymm4, %ymm4
	vpshufb	%ymm29, %ymm6, %ymm2
	vpshufb	.LC37(%rip), %ymm10, %ymm7
	vpshufb	%ymm28, %ymm10, %ymm11
	vpshufb	.LC38(%rip), %ymm10, %ymm14
	vpshufb	%ymm29, %ymm10, %ymm15
	vporq	%ymm7, %ymm13, %ymm12
	vporq	%ymm11, %ymm24, %ymm25
	vporq	%ymm14, %ymm4, %ymm5
	vpshufb	%ymm28, %ymm6, %ymm7
	vpshufb	%ymm19, %ymm0, %ymm14
	vporq	%ymm15, %ymm3, %ymm9
	vmovdqu	%xmm9, -160(%rax)
	vpshufb	.LC38(%rip), %ymm6, %ymm4
	vmovdqu64	%xmm25, -150(%rax)
	vpshufb	%ymm18, %ymm0, %ymm0
	vmovdqu	%xmm12, -140(%rax)
	vmovdqu	%xmm5, -130(%rax)
	vporq	%ymm4, %ymm0, %ymm8
	vextracti64x2	$0x1, %ymm9, -120(%rax)
	vpshufb	%ymm19, %ymm1, %ymm9
	vextracti64x2	$0x1, %ymm25, -110(%rax)
	vpshufb	%ymm18, %ymm1, %ymm1
	vporq	%ymm2, %ymm9, %ymm11
	vextracti64x2	$0x1, %ymm12, -100(%rax)
	vpshufb	.LC37(%rip), %ymm6, %ymm12
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
	jnb	.L95
	vzeroupper
	leave
	.cfi_def_cfa 7, 8
	ret
.L99:
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
	andq	$-64, %rsp
	subq	$64, %rsp
	movq	%rdi, 40(%rsp)
	movq	%rdx, 32(%rsp)
	cmpq	$65600, %rdx
	jbe	.L138
	vmovdqa	.LC2(%rip), %ymm4
	vmovdqa	.LC3(%rip), %ymm3
	movq	%rdi, %rbx
	vmovdqa	.LC4(%rip), %ymm7
	.p2align 4
	.p2align 3
.L137:
	movl	$538976288, %edx
	vmovdqa	.LC44(%rip), %ymm15
	vpbroadcastd	%edx, %ymm5
	vpminsb	131072(%rbx), %ymm5, %ymm10
	vpminsb	32768(%rbx), %ymm5, %ymm0
	vpminsb	65536(%rbx), %ymm5, %ymm2
	vpminsb	98304(%rbx), %ymm5, %ymm8
	vpcmpeqb	65536(%rbx), %ymm2, %ymm6
	vpcmpeqb	131072(%rbx), %ymm10, %ymm11
	vpxor	%xmm10, %xmm10, %xmm10
	vpcmpeqb	32768(%rbx), %ymm0, %ymm1
	vpcmpeqb	98304(%rbx), %ymm8, %ymm9
	vpmovmskb	%ymm6, %r8d
	vpmovmskb	%ymm1, %ecx
	vpmovmskb	%ymm9, %r13d
	tzcntl	%r8d, %r9d
	vpmovmskb	%ymm11, %edx
	tzcntl	%ecx, %esi
	tzcntl	%r13d, %r14d
	movl	%r9d, %r11d
	tzcntl	%edx, %ecx
	movl	%esi, %edi
	movl	%r14d, %eax
	leaq	65537(%rbx,%r11), %r8
	movl	%ecx, %esi
	leaq	32769(%rbx,%rdi), %r10
	leaq	65537(%rbx,%r11), %r12
	movl	$808464432, %r13d
	leaq	131073(%rbx,%rsi), %rdi
	leaq	98305(%rbx,%rax), %r11
	movq	%rbx, %rsi
	movq	%r10, %r9
	movq	%rdi, 48(%rsp)
	xorl	%ebx, %ebx
	movq	%r11, %rdi
	vpbroadcastd	%r13d, %ymm6
	.p2align 4
	.p2align 3
.L108:
	movq	48(%rsp), %r14
	movq	%r11, %rax
	subq	%r8, %rax
	subq	%rdi, %r14
	cmpq	%rax, %r14
	cmovg	%rax, %r14
	movq	%r12, %rdx
	subq	%r9, %rdx
	movq	%r10, %rcx
	subq	%rsi, %rcx
	cmpq	%rcx, %rdx
	cmovg	%rcx, %rdx
	cmpq	%rdx, %r14
	cmovg	%rdx, %r14
	cmpq	$32, %r14
	jbe	.L328
	movabsq	$1117984489315730401, %rax
	movl	$100000000, %ecx
	mulq	%r14
	vpbroadcastd	%ecx, %ymm8
	movq	%rdx, %r14
	shrq	%r14
	movq	%r14, 56(%rsp)
	andq	$-2, %rdx
	leaq	(%rdx,%rbx), %r13
	movq	%rbx, %rdx
	.p2align 4
	.p2align 3
.L107:
	vmovdqu	(%rsi), %ymm12
	xorl	%ecx, %ecx
	vpminsb	%ymm5, %ymm12, %ymm13
	vpcmpeqb	%ymm13, %ymm12, %ymm14
	vmovdqu	(%r9), %ymm13
	vpmovmskb	%ymm14, %eax
	tzcntl	%eax, %r14d
	blsr	%eax, %ecx
	tzcntl	%ecx, %ecx
	movl	%r14d, %eax
	vinserti64x2	$0x1, 1(%rsi,%rax), %ymm12, %ymm0
	incl	%eax
	salq	$4, %rax
	vpminsb	%ymm5, %ymm13, %ymm14
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm1
	movl	%ecx, %eax
	subl	%r14d, %eax
	leal	1(%rcx), %r14d
	salq	$4, %rax
	vpsubusb	%ymm6, %ymm0, %ymm9
	vpcmpeqb	%ymm14, %ymm13, %ymm0
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%rax), %ymm1, %ymm2
	vpmovmskb	%ymm0, %ecx
	addq	%r14, %rsi
	xorl	%eax, %eax
	tzcntl	%ecx, %r14d
	blsr	%ecx, %eax
	tzcntl	%eax, %ecx
	vmovdqu	(%r8), %ymm0
	movl	%r14d, %eax
	vpshufb	%ymm2, %ymm9, %ymm11
	vpmaddubsw	%ymm4, %ymm11, %ymm12
	vinserti64x2	$0x1, 1(%r9,%rax), %ymm13, %ymm11
	incl	%eax
	salq	$4, %rax
	vpmaddwd	%ymm3, %ymm12, %ymm9
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm1
	movl	%ecx, %eax
	subl	%r14d, %eax
	leal	1(%rcx), %r14d
	salq	$4, %rax
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%rax), %ymm1, %ymm12
	vpminsb	%ymm5, %ymm0, %ymm1
	addq	%r14, %r9
	xorl	%eax, %eax
	vmovdqa	%ymm12, %ymm14
	vpternlogq	$254, %ymm10, %ymm2, %ymm14
	vpsubusb	%ymm6, %ymm11, %ymm10
	vpshufb	%ymm12, %ymm10, %ymm2
	vpcmpeqb	%ymm1, %ymm0, %ymm12
	vpmovmskb	%ymm12, %ecx
	vpmaddubsw	%ymm4, %ymm2, %ymm13
	tzcntl	%ecx, %r14d
	blsr	%ecx, %eax
	tzcntl	%eax, %ecx
	vpmaddwd	%ymm3, %ymm13, %ymm11
	movl	%r14d, %eax
	vpackusdw	%ymm11, %ymm9, %ymm9
	vinserti64x2	$0x1, 1(%r8,%rax), %ymm0, %ymm10
	incl	%eax
	vpmaddwd	%ymm7, %ymm9, %ymm11
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm2
	movl	%ecx, %eax
	subl	%r14d, %eax
	leal	1(%rcx), %r14d
	salq	$4, %rax
	vpsubusb	%ymm6, %ymm10, %ymm0
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%rax), %ymm2, %ymm13
	vmovdqu	(%rdi), %ymm2
	addq	%r14, %r8
	xorl	%eax, %eax
	vpshufb	%ymm13, %ymm0, %ymm1
	vpminsb	%ymm5, %ymm2, %ymm10
	vpmaddubsw	%ymm4, %ymm1, %ymm12
	vpcmpeqb	%ymm10, %ymm2, %ymm1
	vpmovmskb	%ymm1, %ecx
	vpmaddwd	%ymm3, %ymm12, %ymm0
	tzcntl	%ecx, %r14d
	blsr	%ecx, %eax
	tzcntl	%eax, %ecx
	movl	%r14d, %eax
	vinserti64x2	$0x1, 1(%rdi,%rax), %ymm2, %ymm2
	incl	%eax
	salq	$4, %rax
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rax), %xmm12
	movl	%ecx, %eax
	subl	%r14d, %eax
	leal	1(%rcx), %r14d
	salq	$4, %rax
	vinserti64x2	$0x1, _ZN12qp_parse_ms211right_alignE(%rax), %ymm12, %ymm12
	addq	%r14, %rdi
	vmovdqa	%ymm12, %ymm10
	vpternlogq	$254, %ymm14, %ymm13, %ymm10
	vpsubusb	%ymm6, %ymm2, %ymm14
	vpshufb	%ymm12, %ymm14, %ymm13
	vpmaddubsw	%ymm4, %ymm13, %ymm1
	vpmaddwd	%ymm3, %ymm1, %ymm12
	vpackusdw	%ymm12, %ymm0, %ymm0
	vpmaddwd	%ymm7, %ymm0, %ymm2
	vshufps	$136, %ymm2, %ymm11, %ymm14
	vshufps	$221, %ymm2, %ymm11, %ymm1
	vpmulld	%ymm8, %ymm14, %ymm13
	vpaddd	%ymm1, %ymm13, %ymm12
	vpermd	%ymm12, %ymm15, %ymm9
	vextracti64x2	$1, %ymm9, %xmm0
	vextracti64x2	$0x1, %ymm9, %xmm2
	vmovq	%xmm9, (%r15,%rdx,4)
	vmovhpd	%xmm9, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region(,%rdx,4)
	vmovhpd	%xmm2, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262656(,%rdx,4)
	vmovq	%xmm0, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131328(,%rdx,4)
	addq	$2, %rdx
	cmpq	%r13, %rdx
	jne	.L107
	movq	56(%rsp), %r13
	leaq	(%rbx,%r13,2), %rbx
	jmp	.L108
	.p2align 4
	.p2align 3
.L328:
	movq	%r12, %rdx
	movq	%rbx, %r14
	cmpq	%r10, %rsi
	jnb	.L106
	vmovdqa	.LC8(%rip), %xmm3
	vmovdqa	.LC9(%rip), %xmm4
	movl	$538976288, %r12d
	movl	$808464432, %eax
	vmovdqa	.LC10(%rip), %xmm7
	vpbroadcastd	%r12d, %xmm5
	vpbroadcastd	%eax, %xmm15
	.p2align 4
	.p2align 3
.L105:
	vmovdqu	(%rsi), %xmm6
	incq	%r14
	vpminsb	%xmm5, %xmm6, %xmm8
	vpsubusb	%xmm15, %xmm6, %xmm12
	vpcmpeqb	%xmm8, %xmm6, %xmm14
	vpmovmskb	%xmm14, %ecx
	tzcntl	%ecx, %r13d
	incl	%r13d
	movq	%r13, %r12
	salq	$4, %r12
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r12), %xmm13
	addq	%r13, %rsi
	vpshufb	%xmm13, %xmm12, %xmm9
	vmovdqa	%xmm13, %xmm1
	vpmaddubsw	%xmm3, %xmm9, %xmm11
	vporq	%ymm1, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm11, %xmm2
	vpackusdw	%xmm2, %xmm2, %xmm0
	vpmaddwd	%xmm7, %xmm0, %xmm6
	vmovq	%xmm6, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%ecx, %eax
	movl	%eax, -4(%r15,%r14,4)
	cmpq	%r10, %rsi
	jb	.L105
.L106:
	cmpq	$32831, %rbx
	movq	%rbx, %r12
	setbe	56(%rsp)
	cmpq	%rdx, %r9
	jnb	.L109
	cmpb	$0, 56(%rsp)
	je	.L109
	movl	$538976288, %r13d
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm3
	vmovdqa	.LC9(%rip), %xmm4
	vmovdqa	.LC10(%rip), %xmm7
	vpbroadcastd	%r13d, %xmm5
	vpbroadcastd	%eax, %xmm15
	testb	$1, %bl
	je	.L110
	vmovdqu	(%r9), %xmm8
	vpminsb	%xmm5, %xmm8, %xmm14
	vpsubusb	%xmm15, %xmm8, %xmm9
	vpcmpeqb	%xmm14, %xmm8, %xmm13
	vpmovmskb	%xmm13, %r12d
	tzcntl	%r12d, %r13d
	leaq	1(%rbx), %r12
	incl	%r13d
	movq	%r13, %rcx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm1
	addq	%r13, %r9
	vpshufb	%xmm1, %xmm9, %xmm11
	vmovdqa	%xmm1, %xmm12
	vpmaddubsw	%xmm3, %xmm11, %xmm2
	vporq	%ymm12, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm2, %xmm0
	vpackusdw	%xmm0, %xmm0, %xmm6
	vpmaddwd	%xmm7, %xmm6, %xmm8
	vmovq	%xmm8, %rax
	imull	$100000000, %eax, %r13d
	shrq	$32, %rax
	addl	%eax, %r13d
	movl	%r13d, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%rdx, %r9
	jb	.L290
	jmp	.L109
	.p2align 4
	.p2align 3
.L110:
	vmovdqu	(%r9), %xmm14
	incq	%r12
	vpminsb	%xmm5, %xmm14, %xmm13
	vpsubusb	%xmm15, %xmm14, %xmm11
	vpcmpeqb	%xmm13, %xmm14, %xmm1
	vpmovmskb	%xmm1, %ecx
	tzcntl	%ecx, %eax
	incl	%eax
	movq	%rax, %r13
	salq	$4, %r13
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%r13), %xmm12
	addq	%rax, %r9
	vpshufb	%xmm12, %xmm11, %xmm2
	vmovdqa	%xmm12, %xmm9
	vpmaddubsw	%xmm3, %xmm2, %xmm0
	vporq	%ymm9, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm0, %xmm6
	vpackusdw	%xmm6, %xmm6, %xmm8
	vpmaddwd	%xmm7, %xmm8, %xmm14
	vmovq	%xmm14, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%ecx, %eax
	movl	%eax, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%rdx, %r9
	jnb	.L109
	vmovdqu	(%r9), %xmm13
	incq	%r12
	vpminsb	%xmm5, %xmm13, %xmm1
	vpsubusb	%xmm15, %xmm13, %xmm2
	vpcmpeqb	%xmm1, %xmm13, %xmm12
	vpmovmskb	%xmm12, %r13d
	tzcntl	%r13d, %eax
	incl	%eax
	movq	%rax, %rcx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm9
	addq	%rax, %r9
	vpshufb	%xmm9, %xmm2, %xmm0
	vmovdqa	%xmm9, %xmm11
	vpmaddubsw	%xmm3, %xmm0, %xmm6
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm6, %xmm8
	vpackusdw	%xmm8, %xmm8, %xmm14
	vpmaddwd	%xmm7, %xmm14, %xmm13
	vmovq	%xmm13, %r13
	imull	$100000000, %r13d, %eax
	shrq	$32, %r13
	addl	%eax, %r13d
	movl	%r13d, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region-4(,%r12,4)
	cmpq	%rdx, %r9
	jnb	.L109
.L290:
	cmpq	$32832, %r12
	jne	.L110
.L109:
	movq	%rbx, %r13
	cmpq	%r11, %r8
	jnb	.L112
	cmpb	$0, 56(%rsp)
	je	.L112
	movl	$538976288, %ecx
	movl	$808464432, %eax
	vmovdqa	.LC8(%rip), %xmm3
	vmovdqa	.LC9(%rip), %xmm4
	vmovdqa	.LC10(%rip), %xmm7
	vpbroadcastd	%ecx, %xmm5
	vpbroadcastd	%eax, %xmm15
	testb	$1, %bl
	je	.L113
	vmovdqu	(%r8), %xmm1
	vpminsb	%xmm5, %xmm1, %xmm12
	vpsubusb	%xmm15, %xmm1, %xmm0
	vpcmpeqb	%xmm12, %xmm1, %xmm9
	vpmovmskb	%xmm9, %r13d
	tzcntl	%r13d, %eax
	leaq	1(%rbx), %r13
	incl	%eax
	movq	%rax, %rcx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm2
	addq	%rax, %r8
	vpshufb	%xmm2, %xmm0, %xmm6
	vmovdqa	%xmm2, %xmm11
	vpmaddubsw	%xmm3, %xmm6, %xmm8
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm8, %xmm14
	vpackusdw	%xmm14, %xmm14, %xmm13
	vpmaddwd	%xmm7, %xmm13, %xmm1
	vmovq	%xmm1, %rax
	jmp	.L327
	.p2align 4
	.p2align 3
.L329:
	cmpq	$32832, %r13
	je	.L112
.L113:
	vmovdqu	(%r8), %xmm12
	incq	%r13
	vpminsb	%xmm5, %xmm12, %xmm9
	vpsubusb	%xmm15, %xmm12, %xmm0
	vpcmpeqb	%xmm9, %xmm12, %xmm2
	vpmovmskb	%xmm2, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rcx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm6
	addq	%rax, %r8
	vpshufb	%xmm6, %xmm0, %xmm8
	vmovdqa	%xmm6, %xmm11
	vpmaddubsw	%xmm3, %xmm8, %xmm14
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm14, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm1
	vpmaddwd	%xmm7, %xmm1, %xmm12
	vmovq	%xmm12, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	%r11, %r8
	jnb	.L112
	vmovdqu	(%r8), %xmm9
	incq	%r13
	vpminsb	%xmm5, %xmm9, %xmm2
	vpsubusb	%xmm15, %xmm9, %xmm0
	vpcmpeqb	%xmm2, %xmm9, %xmm6
	vpmovmskb	%xmm6, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rcx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm8
	addq	%rax, %r8
	vpshufb	%xmm8, %xmm0, %xmm14
	vmovdqa	%xmm8, %xmm11
	vpmaddubsw	%xmm3, %xmm14, %xmm13
	vporq	%ymm11, %ymm10, %ymm10
	vpmaddwd	%xmm4, %xmm13, %xmm1
	vpackusdw	%xmm1, %xmm1, %xmm12
	vpmaddwd	%xmm7, %xmm12, %xmm9
	vmovq	%xmm9, %rax
.L327:
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+131324(,%r13,4)
	cmpq	%r11, %r8
	jb	.L329
.L112:
	movq	48(%rsp), %rcx
	cmpq	%rcx, %rdi
	jnb	.L115
	cmpb	$0, 56(%rsp)
	je	.L115
	movl	$538976288, %eax
	vmovdqa	.LC8(%rip), %xmm1
	vmovdqa	.LC9(%rip), %xmm2
	vmovdqa	.LC10(%rip), %xmm5
	vpbroadcastd	%eax, %xmm8
	movl	$808464432, %eax
	vpbroadcastd	%eax, %xmm9
	testb	$1, %bl
	jne	.L293
	movq	%r11, 56(%rsp)
	movq	%rcx, %r11
	jmp	.L116
	.p2align 4
	.p2align 3
.L330:
	vmovdqu	(%rdi), %xmm7
	incq	%rbx
	vpminsb	%xmm8, %xmm7, %xmm15
	vpsubusb	%xmm9, %xmm7, %xmm0
	vpcmpeqb	%xmm15, %xmm7, %xmm6
	vpmovmskb	%xmm6, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rcx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm14
	addq	%rax, %rdi
	vpshufb	%xmm14, %xmm0, %xmm13
	vmovdqa	%xmm14, %xmm11
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
	jnb	.L315
	cmpq	$32832, %rbx
	je	.L315
.L116:
	vmovdqu	(%rdi), %xmm4
	incq	%rbx
	vpminsb	%xmm8, %xmm4, %xmm7
	vpsubusb	%xmm9, %xmm4, %xmm0
	vpcmpeqb	%xmm7, %xmm4, %xmm15
	vpmovmskb	%xmm15, %eax
	tzcntl	%eax, %eax
	incl	%eax
	movq	%rax, %rcx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm6
	addq	%rax, %rdi
	vpshufb	%xmm6, %xmm0, %xmm14
	vmovdqa	%xmm6, %xmm11
	vpmaddubsw	%xmm1, %xmm14, %xmm13
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
	jb	.L330
.L315:
	movq	56(%rsp), %r11
.L115:
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
	jne	.L331
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
.L136:
	cmpq	$65600, 32(%rsp)
	jbe	.L324
.L120:
	movq	48(%rsp), %rbx
	movq	%rbx, 40(%rsp)
	jmp	.L137
.L293:
	vmovdqu	(%rdi), %xmm3
	incq	%rbx
	vpminsb	%xmm8, %xmm3, %xmm4
	vpsubusb	%xmm9, %xmm3, %xmm11
	vpcmpeqb	%xmm4, %xmm3, %xmm7
	vpmovmskb	%xmm7, %ecx
	tzcntl	%ecx, %eax
	incl	%eax
	movq	%rax, %rcx
	salq	$4, %rcx
	vmovdqa	_ZN12qp_parse_ms211right_alignE(%rcx), %xmm15
	addq	%rax, %rdi
	vpshufb	%xmm15, %xmm11, %xmm0
	vmovdqa	%xmm15, %xmm6
	vpmaddubsw	%xmm1, %xmm0, %xmm14
	vporq	%ymm6, %ymm10, %ymm10
	vpmaddwd	%xmm2, %xmm14, %xmm13
	vpackusdw	%xmm13, %xmm13, %xmm12
	vpmaddwd	%xmm5, %xmm12, %xmm3
	vmovq	%xmm3, %rax
	imull	$100000000, %eax, %ecx
	shrq	$32, %rax
	addl	%eax, %ecx
	movl	%ecx, _ZZN12qp_parse_ms212parse_tokensILm131072EXadL_ZN13qp_parse_flat12parse_tokensEPcPjmEEEES2_S2_S3_mE6region+262652(,%rbx,4)
	cmpq	48(%rsp), %rdi
	jnb	.L115
	cmpq	$32832, %rbx
	je	.L115
	movq	%r11, 56(%rsp)
	movq	48(%rsp), %r11
	jmp	.L116
.L324:
	vzeroupper
.L103:
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
.L331:
	.cfi_restore_state
	movq	48(%rsp), %r12
	cmpq	%r12, 40(%rsp)
	jnb	.L332
	movq	40(%rsp), %r14
	leaq	-1(%r12), %r13
	cmpq	%r13, %r14
	cmovbe	%r14, %r13
	cmpq	%r14, %r13
	setnb	%dil
	movq	%r13, %rsi
	subq	%r14, %rsi
	cmpq	$62, %rsi
	jbe	.L142
	cmpq	%r14, %r13
	jb	.L142
	movl	$1, %ecx
	movl	$538976288, %r11d
	movq	%r14, %rax
	vpxor	%xmm1, %xmm1, %xmm1
	movq	%rcx, %r9
	subq	%r14, %r9
	vpbroadcastd	%r11d, %zmm10
	vpbroadcastq	%rcx, %zmm2
	addq	%r13, %r9
	testb	%dil, %dil
	cmove	%rcx, %r9
	movq	%r9, %r10
	andq	$-64, %r10
	leaq	(%r10,%r14), %r8
	testb	$64, %r10b
	je	.L122
	vmovdqu8	(%r14), %zmm1
	leaq	64(%r14), %rax
	vpcmpb	$6, %zmm10, %zmm1, %k1
	vmovdqa64	%zmm2, %zmm1{%k1}{z}
	kshiftrw	$8, %k1, %k5
	kshiftrd	$16, %k1, %k4
	kshiftrw	$8, %k4, %k6
	kshiftrq	$32, %k1, %k2
	kshiftrw	$8, %k2, %k7
	vpaddq	%zmm2, %zmm1, %zmm1{%k5}
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm1, %zmm1{%k4}
	kshiftrw	$8, %k3, %k1
	vpaddq	%zmm2, %zmm1, %zmm1{%k6}
	vpaddq	%zmm2, %zmm1, %zmm1{%k2}
	vpaddq	%zmm2, %zmm1, %zmm1{%k7}
	vpaddq	%zmm2, %zmm1, %zmm1{%k3}
	vpaddq	%zmm2, %zmm1, %zmm1{%k1}
	cmpq	%rax, %r8
	jne	.L122
.L312:
	vextracti64x4	$0x1, %zmm1, %ymm6
	vpaddq	%ymm1, %ymm6, %ymm14
	vextracti64x2	$0x1, %ymm14, %xmm11
	vpaddq	%xmm14, %xmm11, %xmm0
	vpsrldq	$8, %xmm0, %xmm13
	vpaddq	%xmm13, %xmm0, %xmm12
	vmovq	%xmm12, %rdx
	cmpq	%r10, %r9
	je	.L123
	movq	%r8, %r12
.L296:
	movq	%r13, %r14
	subq	%r12, %r14
	xorl	%ecx, %ecx
	leaq	1(%r12), %r10
	andl	$7, %r14d
	cmpb	$32, (%r12)
	setg	%cl
	addq	%rcx, %rdx
	cmpq	%r10, %r13
	jnb	.L333
.L123:
	movq	40(%rsp), %r10
	xorl	%r13d, %r13d
	testb	%dil, %dil
	cmovne	%rsi, %r13
	leaq	(%r10,%r13), %r11
	leaq	1(%r10,%r13), %rsi
	cmpq	48(%rsp), %rsi
	jnb	.L130
	movq	48(%rsp), %r8
	leaq	2(%r11), %r9
	leaq	-2(%r8), %rdi
	subq	%r11, %rdi
	cmpq	$62, %rdi
	jbe	.L242
	cmpq	%r9, %r8
	jb	.L242
	leaq	-1(%r8), %rbx
	movl	$1, %ecx
	movl	$538976288, %r14d
	vpxor	%xmm3, %xmm3, %xmm3
	subq	%r11, %rbx
	cmpq	%r9, %r8
	vpbroadcastd	%r14d, %zmm7
	vpxor	%xmm10, %xmm10, %xmm10
	cmovb	%rcx, %rbx
	vpternlogd	$0xFF, %zmm3, %zmm3, %zmm3
	movq	%rbx, %r12
	andq	$-64, %r12
	leaq	(%r12,%r11), %rax
.L128:
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
	vpmovzxbw	%ymm9, %zmm15
	vpmovzxwd	%ymm8, %zmm6
	vextracti64x4	$0x1, %zmm8, %ymm1
	vpmovzxwd	%ymm1, %zmm14
	vpmovzxwd	%ymm15, %zmm13
	vpmovzxdq	%ymm6, %zmm12
	vextracti64x4	$0x1, %zmm15, %ymm11
	vpmovzxdq	%ymm14, %zmm5
	vextracti32x8	$0x1, %zmm14, %ymm9
	vpaddq	%zmm12, %zmm10, %zmm4{%k7}
	vextracti32x8	$0x1, %zmm6, %ymm10
	vpmovzxdq	%ymm9, %zmm15
	kshiftrw	$8, %k2, %k7
	vpmovzxdq	%ymm10, %zmm2
	vpmovzxwd	%ymm11, %zmm0
	vpmovzxdq	%ymm13, %zmm6
	vextracti32x8	$0x1, %zmm13, %ymm1
	vpaddq	%zmm2, %zmm4, %zmm4{%k5}
	vpmovzxdq	%ymm1, %zmm14
	vpmovzxdq	%ymm0, %zmm13
	vmovdqa64	%zmm4, %zmm8
	vextracti32x8	$0x1, %zmm0, %ymm11
	vpmovzxdq	%ymm11, %zmm0
	vpaddq	%zmm5, %zmm4, %zmm8{%k4}
	vmovdqa64	%zmm8, %zmm2
	vpaddq	%zmm15, %zmm8, %zmm2{%k6}
	vpaddq	%zmm6, %zmm2, %zmm2{%k2}
	kshiftrw	$8, %k3, %k2
	vpaddq	%zmm14, %zmm2, %zmm2{%k7}
	vpaddq	%zmm13, %zmm2, %zmm2{%k3}
	vmovdqa64	%zmm2, %zmm10
	vpaddq	%zmm0, %zmm2, %zmm10{%k2}
	cmpq	%rax, %r11
	jne	.L128
	vextracti64x4	$0x1, %zmm10, %ymm7
	vpaddq	%ymm10, %ymm7, %ymm3
	vextracti64x2	$0x1, %ymm3, %xmm12
	vpaddq	%xmm3, %xmm12, %xmm4
	vpsrldq	$8, %xmm4, %xmm5
	vpaddq	%xmm5, %xmm4, %xmm8
	vmovq	%xmm8, %r13
	addq	%r13, %rdx
	cmpq	%r12, %rbx
	je	.L130
	addq	%r12, %rsi
.L242:
	movq	%rsi, %r10
	notq	%r10
	addq	48(%rsp), %r10
	andl	$7, %r10d
	cmpb	$32, (%rsi)
	jle	.L297
	xorl	%r11d, %r11d
	cmpb	$32, -1(%rsi)
	setle	%r11b
	addq	%r11, %rdx
.L297:
	leaq	1(%rsi), %rax
	cmpq	48(%rsp), %rax
	jnb	.L130
	testq	%r10, %r10
	je	.L133
	cmpq	$1, %r10
	je	.L244
	cmpq	$2, %r10
	je	.L245
	cmpq	$3, %r10
	je	.L246
	cmpq	$4, %r10
	je	.L247
	cmpq	$5, %r10
	je	.L248
	cmpq	$6, %r10
	je	.L249
	cmpb	$32, 1(%rsi)
	jg	.L334
.L299:
	incq	%rax
.L249:
	cmpb	$32, (%rax)
	jle	.L300
	xorl	%r9d, %r9d
	cmpb	$32, -1(%rax)
	setle	%r9b
	addq	%r9, %rdx
.L300:
	incq	%rax
.L248:
	cmpb	$32, (%rax)
	jg	.L335
.L301:
	incq	%rax
.L247:
	cmpb	$32, (%rax)
	jg	.L336
.L302:
	incq	%rax
.L246:
	cmpb	$32, (%rax)
	jg	.L337
.L303:
	incq	%rax
.L245:
	cmpb	$32, (%rax)
	jle	.L304
	xorl	%ecx, %ecx
	cmpb	$32, -1(%rax)
	setle	%cl
	addq	%rcx, %rdx
.L304:
	incq	%rax
.L244:
	cmpb	$32, (%rax)
	jle	.L305
	xorl	%r12d, %r12d
	cmpb	$32, -1(%rax)
	setle	%r12b
	addq	%r12, %rdx
.L305:
	incq	%rax
	cmpq	48(%rsp), %rax
	jnb	.L130
.L133:
	cmpb	$32, (%rax)
	jle	.L134
	xorl	%r14d, %r14d
	cmpb	$32, -1(%rax)
	setle	%r14b
	addq	%r14, %rdx
.L134:
	leaq	1(%rax), %r13
	cmpb	$32, 1(%rax)
	jle	.L298
	xorl	%eax, %eax
	cmpb	$32, -1(%r13)
	setle	%al
	addq	%rax, %rdx
.L298:
	cmpb	$32, 1(%r13)
	jle	.L306
	xorl	%r10d, %r10d
	cmpb	$32, 0(%r13)
	setle	%r10b
	addq	%r10, %rdx
.L306:
	cmpb	$32, 2(%r13)
	jle	.L307
	xorl	%r11d, %r11d
	cmpb	$32, 1(%r13)
	setle	%r11b
	addq	%r11, %rdx
.L307:
	cmpb	$32, 3(%r13)
	jle	.L308
	xorl	%esi, %esi
	cmpb	$32, 2(%r13)
	setle	%sil
	addq	%rsi, %rdx
.L308:
	cmpb	$32, 4(%r13)
	jle	.L309
	xorl	%r9d, %r9d
	cmpb	$32, 3(%r13)
	setle	%r9b
	addq	%r9, %rdx
.L309:
	cmpb	$32, 5(%r13)
	jle	.L310
	xorl	%r8d, %r8d
	cmpb	$32, 4(%r13)
	setle	%r8b
	addq	%r8, %rdx
.L310:
	cmpb	$32, 6(%r13)
	jle	.L311
	xorl	%edi, %edi
	cmpb	$32, 5(%r13)
	setle	%dil
	addq	%rdi, %rdx
.L311:
	leaq	7(%r13), %rax
	cmpq	48(%rsp), %rax
	jb	.L133
.L130:
	subq	%rdx, 32(%rsp)
	movq	40(%rsp), %rdi
	movq	%r15, %rsi
	leaq	(%r15,%rdx,4), %r15
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm4
	vmovdqa	.LC3(%rip), %ymm3
	vmovdqa	.LC4(%rip), %ymm7
	jmp	.L136
.L122:
	vmovdqu8	(%rax), %zmm5
	vmovdqu8	64(%rax), %zmm15
	vmovdqa64	%zmm1, %zmm8
	subq	$-128, %rax
	vpcmpb	$6, %zmm10, %zmm5, %k5
	kshiftrw	$8, %k5, %k6
	vpaddq	%zmm2, %zmm1, %zmm8{%k5}
	kshiftrd	$16, %k5, %k4
	kshiftrw	$8, %k4, %k7
	vpaddq	%zmm2, %zmm8, %zmm8{%k6}
	kshiftrq	$32, %k5, %k2
	vpcmpb	$6, %zmm10, %zmm15, %k6
	kshiftrw	$8, %k2, %k1
	vpaddq	%zmm2, %zmm8, %zmm8{%k4}
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm8, %zmm8{%k7}
	kshiftrw	$8, %k3, %k5
	vpaddq	%zmm2, %zmm8, %zmm8{%k2}
	vpaddq	%zmm2, %zmm8, %zmm8{%k1}
	kshiftrw	$8, %k6, %k7
	vpaddq	%zmm2, %zmm8, %zmm8{%k3}
	kshiftrd	$16, %k6, %k4
	kshiftrw	$8, %k4, %k1
	vpaddq	%zmm2, %zmm8, %zmm8{%k5}
	kshiftrq	$32, %k6, %k2
	vmovdqa64	%zmm8, %zmm1
	kshiftrw	$8, %k2, %k5
	kshiftrd	$16, %k2, %k3
	vpaddq	%zmm2, %zmm8, %zmm1{%k6}
	kshiftrw	$8, %k3, %k6
	vpaddq	%zmm2, %zmm1, %zmm1{%k7}
	vpaddq	%zmm2, %zmm1, %zmm1{%k4}
	vpaddq	%zmm2, %zmm1, %zmm1{%k1}
	vpaddq	%zmm2, %zmm1, %zmm1{%k2}
	vpaddq	%zmm2, %zmm1, %zmm1{%k5}
	vpaddq	%zmm2, %zmm1, %zmm1{%k3}
	vpaddq	%zmm2, %zmm1, %zmm1{%k6}
	cmpq	%rax, %r8
	je	.L312
	jmp	.L122
.L333:
	testq	%r14, %r14
	je	.L125
	cmpq	$1, %r14
	je	.L250
	cmpq	$2, %r14
	je	.L251
	cmpq	$3, %r14
	je	.L252
	cmpq	$4, %r14
	je	.L253
	cmpq	$5, %r14
	je	.L254
	cmpq	$6, %r14
	jne	.L338
.L255:
	xorl	%r8d, %r8d
	cmpb	$32, (%r10)
	setg	%r8b
	incq	%r10
	addq	%r8, %rdx
.L254:
	xorl	%r11d, %r11d
	cmpb	$32, (%r10)
	setg	%r11b
	incq	%r10
	addq	%r11, %rdx
.L253:
	xorl	%ebx, %ebx
	cmpb	$32, (%r10)
	setg	%bl
	incq	%r10
	addq	%rbx, %rdx
.L252:
	xorl	%eax, %eax
	cmpb	$32, (%r10)
	setg	%al
	incq	%r10
	addq	%rax, %rdx
.L251:
	xorl	%r12d, %r12d
	cmpb	$32, (%r10)
	setg	%r12b
	incq	%r10
	addq	%r12, %rdx
.L250:
	xorl	%r14d, %r14d
	cmpb	$32, (%r10)
	setg	%r14b
	incq	%r10
	addq	%r14, %rdx
	cmpq	%r10, %r13
	jb	.L123
.L125:
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
	jb	.L123
	jmp	.L125
	.p2align 4
	.p2align 3
.L337:
	xorl	%ebx, %ebx
	cmpb	$32, -1(%rax)
	setle	%bl
	addq	%rbx, %rdx
	jmp	.L303
.L336:
	xorl	%edi, %edi
	cmpb	$32, -1(%rax)
	setle	%dil
	addq	%rdi, %rdx
	jmp	.L302
.L335:
	xorl	%r8d, %r8d
	cmpb	$32, -1(%rax)
	setle	%r8b
	addq	%r8, %rdx
	jmp	.L301
.L138:
	movq	%rdi, 48(%rsp)
	jmp	.L103
.L332:
	movq	40(%rsp), %rdi
	xorl	%edx, %edx
	movq	%r15, %rsi
	vzeroupper
	call	_ZN13qp_parse_flat12parse_tokensEPcPjm
	vmovdqa	.LC2(%rip), %ymm4
	vmovdqa	.LC3(%rip), %ymm3
	vmovdqa	.LC4(%rip), %ymm7
	jmp	.L120
.L142:
	movq	40(%rsp), %r12
	xorl	%edx, %edx
	jmp	.L296
.L334:
	xorl	%esi, %esi
	cmpb	$32, -1(%rax)
	setle	%sil
	addq	%rsi, %rdx
	jmp	.L299
.L338:
	xorl	%r9d, %r9d
	cmpb	$32, 1(%r12)
	leaq	2(%r12), %r10
	setg	%r9b
	addq	%r9, %rdx
	jmp	.L255
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
.LC44:
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
