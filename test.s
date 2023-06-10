	.file	"test.c"
	.text
	.section	.rodata
.LC0:
	.string	"://"
.LC1:
	.string	":"
.LC2:
	.string	"/"
.LC3:
	.string	"80"
.LC4:
	.string	""
.LC5:
	.string	"http"
.LC6:
	.string	"tcp"
	.text
	.globl	split_url
	.type	split_url, @function
split_url:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$88, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -88(%rbp)
	movq	%rsi, -96(%rbp)
	cmpq	$0, -88(%rbp)
	je	.L2
	cmpq	$0, -96(%rbp)
	jne	.L3
.L2:
	movl	$0, %eax
	jmp	.L4
.L3:
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	addq	$1, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, %rdx
	movq	-96(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	-88(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-96(%rbp), %rax
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	movq	-88(%rbp), %rdx
	movq	%rax, 8(%rdx)
	movq	-88(%rbp), %rax
	movq	8(%rax), %rax
	testq	%rax, %rax
	je	.L5
	movq	-88(%rbp), %rax
	movq	8(%rax), %rax
	leaq	3(%rax), %rdx
	movq	-88(%rbp), %rax
	movq	%rdx, 8(%rax)
	movq	-88(%rbp), %rax
	movq	8(%rax), %rbx
	movq	-88(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	addq	$1, %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	calloc@PLT
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	-88(%rbp), %rdx
	movq	%rax, 8(%rdx)
	movq	-40(%rbp), %rax
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	-88(%rbp), %rdx
	movq	%rax, 8(%rdx)
	jmp	.L6
.L5:
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	addq	$1, %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	calloc@PLT
	movq	%rax, %rdx
	movq	-96(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	-88(%rbp), %rdx
	movq	%rax, 8(%rdx)
	movq	-32(%rbp), %rax
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	-88(%rbp), %rdx
	movq	%rax, 8(%rdx)
.L6:
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	addq	$1, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, %rdx
	movq	-96(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	addq	$6, %rax
	movl	$58, %esi
	movq	%rax, %rdi
	call	strchr@PLT
	movq	-88(%rbp), %rdx
	movq	%rax, 16(%rdx)
	movq	$0, -56(%rbp)
	movq	$0, -24(%rbp)
	movq	-88(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L7
	call	__ctype_b_loc@PLT
	movq	(%rax), %rdx
	movq	-88(%rbp), %rax
	movq	16(%rax), %rax
	addq	$1, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$2048, %eax
	testl	%eax, %eax
	je	.L7
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	addq	$1, %rax
	movq	%rax, %rdi
	call	malloc@PLT
	movq	%rax, %rdx
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	%rax, -24(%rbp)
	movq	-56(%rbp), %rax
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -64(%rbp)
	cmpq	$0, -64(%rbp)
	je	.L8
	movq	-88(%rbp), %rax
	movq	-64(%rbp), %rdx
	movq	%rdx, 16(%rax)
	jmp	.L10
.L8:
	movq	-88(%rbp), %rax
	movq	-56(%rbp), %rdx
	movq	%rdx, 16(%rax)
	jmp	.L10
.L7:
	movq	-88(%rbp), %rax
	leaq	.LC3(%rip), %rdx
	movq	%rdx, 16(%rax)
.L10:
	cmpq	$0, -24(%rbp)
	je	.L11
	movq	-88(%rbp), %rax
	movq	16(%rax), %rax
	testq	%rax, %rax
	je	.L12
	movq	-88(%rbp), %rax
	movq	16(%rax), %rax
	jmp	.L13
.L12:
	leaq	.LC4(%rip), %rax
.L13:
	movq	%rax, %rdi
	call	strlen@PLT
	movq	-24(%rbp), %rdx
	addq	%rax, %rdx
	movq	-88(%rbp), %rax
	movq	%rdx, 24(%rax)
	jmp	.L14
.L11:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movl	$47, %esi
	movq	%rax, %rdi
	call	strchr@PLT
	movq	%rax, -72(%rbp)
	cmpq	$0, -72(%rbp)
	je	.L15
	movq	-72(%rbp), %rax
	jmp	.L16
.L15:
	leaq	.LC2(%rip), %rax
.L16:
	movq	-88(%rbp), %rdx
	movq	%rax, 24(%rdx)
.L14:
	movq	-88(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -76(%rbp)
	cmpl	$0, -76(%rbp)
	je	.L17
	movq	-88(%rbp), %rax
	movq	16(%rax), %rax
	leaq	.LC3(%rip), %rdx
	cmpq	%rdx, %rax
	jne	.L17
	movq	-88(%rbp), %rax
	leaq	.LC5(%rip), %rdx
	movq	%rdx, (%rax)
	jmp	.L18
.L17:
	cmpl	$0, -76(%rbp)
	je	.L18
	movq	-88(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, (%rax)
.L18:
	movq	-88(%rbp), %rax
.L4:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	split_url, .-split_url
	.globl	newDictionary
	.type	newDictionary, @function
newDictionary:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$3076, %edi
	call	malloc@PLT
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	newDictionary, .-newDictionary
	.globl	dictionaryAddValue
	.type	dictionaryAddValue, @function
dictionaryAddValue:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	cmpq	$32, %rax
	ja	.L28
	movl	$0, -4(%rbp)
	jmp	.L24
.L26:
	movl	-4(%rbp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L29
	addl	$1, -4(%rbp)
.L24:
	movq	-24(%rbp), %rax
	movl	3072(%rax), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L26
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	cmpq	$64, %rax
	ja	.L30
	movq	-24(%rbp), %rax
	movl	3072(%rax), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	-24(%rbp), %rax
	movl	3072(%rax), %eax
	cltq
	addq	$16, %rax
	salq	$6, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	-24(%rbp), %rax
	movl	3072(%rax), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 3072(%rax)
	jmp	.L21
.L28:
	nop
	jmp	.L21
.L29:
	nop
	jmp	.L21
.L30:
	nop
.L21:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	dictionaryAddValue, .-dictionaryAddValue
	.globl	dictionarySetValue
	.type	dictionarySetValue, @function
dictionarySetValue:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$-1, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L32
.L35:
	movl	-8(%rbp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L33
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L34
.L33:
	addl	$1, -8(%rbp)
.L32:
	movq	-24(%rbp), %rax
	movl	3072(%rax), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L35
.L34:
	movl	-4(%rbp), %eax
	cltq
	addq	$16, %rax
	salq	$6, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	dictionarySetValue, .-dictionarySetValue
	.globl	dictionaryGetValue
	.type	dictionaryGetValue, @function
dictionaryGetValue:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$-1, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L37
.L40:
	movl	-8(%rbp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L38
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L39
.L38:
	addl	$1, -8(%rbp)
.L37:
	movq	-24(%rbp), %rax
	movl	3072(%rax), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L40
.L39:
	movl	-4(%rbp), %eax
	cltq
	addq	$16, %rax
	salq	$6, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	dictionaryGetValue, .-dictionaryGetValue
	.globl	newHeaderData
	.type	newHeaderData, @function
newHeaderData:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$5124, %edi
	call	malloc@PLT
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	newHeaderData, .-newHeaderData
	.globl	headerAddValue
	.type	headerAddValue, @function
headerAddValue:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	cmpq	$32, %rax
	ja	.L51
	movl	$0, -4(%rbp)
	jmp	.L47
.L49:
	movl	-4(%rbp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L52
	addl	$1, -4(%rbp)
.L47:
	movq	-24(%rbp), %rax
	movl	5120(%rax), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L49
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	cmpq	$64, %rax
	ja	.L53
	movq	-24(%rbp), %rax
	movl	5120(%rax), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	-24(%rbp), %rax
	movl	5120(%rax), %eax
	cltq
	addq	$8, %rax
	salq	$7, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	-24(%rbp), %rax
	movl	5120(%rax), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 5120(%rax)
	jmp	.L44
.L51:
	nop
	jmp	.L44
.L52:
	nop
	jmp	.L44
.L53:
	nop
.L44:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	headerAddValue, .-headerAddValue
	.globl	headerSetValue
	.type	headerSetValue, @function
headerSetValue:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$-1, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L55
.L58:
	movl	-8(%rbp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L56
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L57
.L56:
	addl	$1, -8(%rbp)
.L55:
	movq	-24(%rbp), %rax
	movl	5120(%rax), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L58
.L57:
	movl	-4(%rbp), %eax
	cltq
	addq	$8, %rax
	salq	$7, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	headerSetValue, .-headerSetValue
	.globl	headerGetValue
	.type	headerGetValue, @function
headerGetValue:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	$-1, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L60
.L63:
	movl	-8(%rbp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L61
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L62
.L61:
	addl	$1, -8(%rbp)
.L60:
	movq	-24(%rbp), %rax
	movl	5120(%rax), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L63
.L62:
	cmpl	$-1, -4(%rbp)
	jne	.L64
	movl	$0, %eax
	jmp	.L65
.L64:
	movl	-4(%rbp), %eax
	cltq
	addq	$8, %rax
	salq	$7, %rax
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
.L65:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	headerGetValue, .-headerGetValue
	.section	.rodata
.LC7:
	.string	"%s: %s\r\n"
	.text
	.globl	headersToText
	.type	headersToText, @function
headersToText:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$144, %rsp
	movq	%rdi, -136(%rbp)
	movq	%rsi, -144(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L67
.L68:
	movl	-4(%rbp), %eax
	cltq
	salq	$5, %rax
	movq	%rax, %rdx
	movq	-136(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movl	-4(%rbp), %eax
	cltq
	addq	$8, %rax
	salq	$7, %rax
	movq	%rax, %rdx
	movq	-136(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movq	$0, -128(%rbp)
	movq	$0, -120(%rbp)
	movq	$0, -112(%rbp)
	movq	$0, -104(%rbp)
	movq	$0, -96(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	-24(%rbp), %rcx
	movq	-16(%rbp), %rdx
	leaq	-128(%rbp), %rax
	leaq	.LC7(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	-128(%rbp), %rdx
	movq	-144(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	addl	$1, -4(%rbp)
.L67:
	movq	-136(%rbp), %rax
	movl	5120(%rax), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L68
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	headersToText, .-headersToText
	.section	.rodata
.LC8:
	.string	": "
	.text
	.globl	headersFromText
	.type	headersFromText, @function
headersFromText:
.LFB16:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L70
.L73:
	movl	-4(%rbp), %eax
	cltq
	salq	$9, %rax
	movq	%rax, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L74
	movq	-16(%rbp), %rax
	leaq	.LC8(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -24(%rbp)
	leaq	.LC8(%rip), %rsi
	movl	$0, %edi
	call	strtok@PLT
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	headerAddValue
	addl	$1, -4(%rbp)
.L70:
	cmpl	$32, -4(%rbp)
	jle	.L73
	jmp	.L75
.L74:
	nop
.L75:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	headersFromText, .-headersFromText
	.globl	newRequestData
	.type	newRequestData, @function
newRequestData:
.LFB17:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$12808, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movw	$47, (%rax)
	movq	-8(%rbp), %rax
	addq	$500, %rax
	movl	$5522759, (%rax)
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	newRequestData, .-newRequestData
	.section	.rodata
.LC9:
	.string	"\n"
.LC10:
	.string	"\r"
.LC11:
	.string	"%s %s HTTP/1.1"
	.align 8
.LC12:
	.string	"Request(%s , %s , headers=%d ,http_subver=%d)\n"
.LC13:
	.string	"Host"
.LC14:
	.string	"Host: %s"
	.text
	.globl	deserializeHttpRequest
	.type	deserializeHttpRequest, @function
deserializeHttpRequest:
.LFB18:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48720, %rsp
	movq	%rdi, -48712(%rbp)
	movq	%rsi, -48720(%rbp)
	leaq	-16944(%rbp), %rax
	movl	$16896, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	$0, -25136(%rbp)
	movq	$0, -25128(%rbp)
	leaq	-25120(%rbp), %rdx
	movl	$0, %eax
	movl	$1022, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	$0, -47664(%rbp)
	movq	$0, -47656(%rbp)
	leaq	-47648(%rbp), %rax
	movl	$22512, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	-48712(%rbp), %rdx
	leaq	-47664(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	leaq	-47664(%rbp), %rax
	leaq	.LC9(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -24(%rbp)
	jmp	.L79
.L83:
	movq	-24(%rbp), %rax
	leaq	.LC10(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L80
	addl	$1, -12(%rbp)
	jmp	.L81
.L80:
	cmpl	$0, -12(%rbp)
	jne	.L82
	leaq	-16944(%rbp), %rdx
	movl	-8(%rbp), %eax
	cltq
	salq	$9, %rax
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcat@PLT
	addl	$1, -4(%rbp)
.L82:
	cmpl	$0, -12(%rbp)
	jle	.L81
	movq	-24(%rbp), %rdx
	leaq	-25136(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-25136(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-25136(%rbp), %rax
	addq	%rdx, %rax
	movw	$2573, (%rax)
	movb	$0, 2(%rax)
.L81:
	addl	$1, -8(%rbp)
	leaq	.LC9(%rip), %rsi
	movl	$0, %edi
	call	strtok@PLT
	movq	%rax, -24(%rbp)
.L79:
	cmpq	$0, -24(%rbp)
	jne	.L83
	movq	$0, -48176(%rbp)
	movq	$0, -48168(%rbp)
	leaq	-48160(%rbp), %rdx
	movl	$0, %eax
	movl	$62, %ecx
	movq	%rdx, %rdi
	rep stosq
	leaq	-16944(%rbp), %rdx
	leaq	-48176(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-48720(%rbp), %rax
	movq	512(%rax), %rax
	leaq	-16944(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	headersFromText
	movq	$0, -48688(%rbp)
	movq	$0, -48680(%rbp)
	leaq	-48672(%rbp), %rdx
	movl	$0, %eax
	movl	$60, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	%rdi, %rdx
	movl	%eax, (%rdx)
	addq	$4, %rdx
	movq	$0, -48696(%rbp)
	movl	$1, -28(%rbp)
	leaq	-48688(%rbp), %rcx
	leaq	-48696(%rbp), %rdx
	leaq	-48176(%rbp), %rax
	leaq	.LC11(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf@PLT
	movzbl	-48176(%rbp), %eax
	movzbl	%al, %eax
	testl	%eax, %eax
	jne	.L84
	movl	$0, %eax
	jmp	.L87
.L84:
	movq	-48720(%rbp), %rax
	movq	512(%rax), %rax
	movl	5120(%rax), %ecx
	movl	-28(%rbp), %esi
	leaq	-48688(%rbp), %rdx
	leaq	-48696(%rbp), %rax
	movl	%esi, %r8d
	movq	%rax, %rsi
	leaq	.LC12(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-48720(%rbp), %rax
	movq	512(%rax), %rax
	leaq	.LC13(%rip), %rsi
	movq	%rax, %rdi
	call	headerGetValue
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	je	.L86
	movq	-48720(%rbp), %rax
	movq	512(%rax), %rax
	leaq	.LC13(%rip), %rsi
	movq	%rax, %rdi
	call	headerGetValue
	movq	%rax, %rsi
	leaq	.LC14(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L86:
	movq	-48720(%rbp), %rax
	leaq	-48688(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-48720(%rbp), %rax
	leaq	500(%rax), %rdx
	leaq	-48696(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	-48720(%rbp), %rax
	leaq	520(%rax), %rdx
	leaq	-25136(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movl	$10, %edi
	call	putchar@PLT
	movl	$1, %eax
.L87:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	deserializeHttpRequest, .-deserializeHttpRequest
	.globl	newResponseData
	.type	newResponseData, @function
newResponseData:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$12304, %edi
	call	malloc@PLT
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	newResponseData, .-newResponseData
	.section	.rodata
.LC15:
	.string	"HTTP/1.0 %d %s\n"
	.text
	.globl	serializeHttpResponse
	.type	serializeHttpResponse, @function
serializeHttpResponse:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$192, %rsp
	movq	%rdi, -184(%rbp)
	movq	%rsi, -192(%rbp)
	movq	$19279, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movq	-192(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$200, %eax
	je	.L91
	movq	-192(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$400, %eax
	jne	.L92
	leaq	-48(%rbp), %rax
	movabsq	$8462656578211045698, %rcx
	movq	%rcx, (%rax)
	movl	$7631717, 8(%rax)
.L92:
	movq	-192(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$404, %eax
	jne	.L93
	leaq	-48(%rbp), %rax
	movabsq	$7959390263430115150, %rcx
	movq	%rcx, (%rax)
	movw	$100, 8(%rax)
.L93:
	movq	-192(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$500, %eax
	jne	.L91
	leaq	-48(%rbp), %rax
	movabsq	$7809644666444607049, %rsi
	movabsq	$2338042715958498080, %rdi
	movq	%rsi, (%rax)
	movq	%rdi, 8(%rax)
	movl	$1869771333, 16(%rax)
	movw	$114, 20(%rax)
.L91:
	movq	$0, -176(%rbp)
	movq	$0, -168(%rbp)
	movq	$0, -160(%rbp)
	movq	$0, -152(%rbp)
	movq	$0, -144(%rbp)
	movq	$0, -136(%rbp)
	movq	$0, -128(%rbp)
	movq	$0, -120(%rbp)
	movq	$0, -112(%rbp)
	movq	$0, -104(%rbp)
	movq	$0, -96(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -80(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	-192(%rbp), %rax
	movl	(%rax), %edx
	leaq	-48(%rbp), %rcx
	leaq	-176(%rbp), %rax
	leaq	.LC15(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	leaq	-176(%rbp), %rdx
	movq	-184(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	movl	$2048, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-192(%rbp), %rax
	movq	8(%rax), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	headersToText
	movq	-8(%rbp), %rdx
	movq	-184(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	movq	-184(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-184(%rbp), %rax
	addq	%rdx, %rax
	movw	$10, (%rax)
	movq	-192(%rbp), %rax
	leaq	16(%rax), %rdx
	movq	-184(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	serializeHttpResponse, .-serializeHttpResponse
	.section	.rodata
.LC16:
	.string	"HTTP/1.0 %s %s"
	.text
	.globl	deserializeHttpResponse
	.type	deserializeHttpResponse, @function
deserializeHttpResponse:
.LFB21:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$41680, %rsp
	movq	%rdi, -41672(%rbp)
	movq	%rsi, -41680(%rbp)
	movq	$0, -18448(%rbp)
	movq	$0, -18440(%rbp)
	leaq	-18432(%rbp), %rax
	movl	$18416, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	-41672(%rbp), %rdx
	leaq	-18448(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-35344(%rbp), %rax
	movl	$16896, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	$0, -41488(%rbp)
	movq	$0, -41480(%rbp)
	leaq	-41472(%rbp), %rdx
	movl	$0, %eax
	movl	$766, %ecx
	movq	%rdx, %rdi
	rep stosq
	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)
	leaq	-18448(%rbp), %rax
	leaq	.LC9(%rip), %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -16(%rbp)
	jmp	.L96
.L100:
	movq	-16(%rbp), %rax
	leaq	.LC10(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L97
	addl	$1, -8(%rbp)
	jmp	.L98
.L97:
	cmpl	$0, -8(%rbp)
	jne	.L99
	leaq	-35344(%rbp), %rdx
	movl	-4(%rbp), %eax
	cltq
	salq	$9, %rax
	addq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcat@PLT
.L99:
	cmpl	$0, -8(%rbp)
	jle	.L98
	movq	-16(%rbp), %rdx
	leaq	-41488(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-41488(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-41488(%rbp), %rax
	addq	%rdx, %rax
	movw	$2573, (%rax)
	movb	$0, 2(%rax)
.L98:
	addl	$1, -4(%rbp)
	leaq	.LC9(%rip), %rsi
	movl	$0, %edi
	call	strtok@PLT
	movq	%rax, -16(%rbp)
.L96:
	cmpq	$0, -16(%rbp)
	jne	.L100
	movq	-41680(%rbp), %rax
	movq	8(%rax), %rax
	leaq	-35344(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	headersFromText
	movq	$0, -41616(%rbp)
	movq	$0, -41608(%rbp)
	movq	$0, -41600(%rbp)
	movq	$0, -41592(%rbp)
	movq	$0, -41584(%rbp)
	movq	$0, -41576(%rbp)
	movq	$0, -41568(%rbp)
	movq	$0, -41560(%rbp)
	movq	$0, -41552(%rbp)
	movq	$0, -41544(%rbp)
	movq	$0, -41536(%rbp)
	movq	$0, -41528(%rbp)
	movq	$0, -41520(%rbp)
	movq	$0, -41512(%rbp)
	movq	$0, -41504(%rbp)
	movq	$0, -41496(%rbp)
	movq	$0, -41648(%rbp)
	movq	$0, -41640(%rbp)
	movq	$0, -41632(%rbp)
	movq	$0, -41624(%rbp)
	movq	$0, -41664(%rbp)
	movq	$0, -41656(%rbp)
	leaq	-35344(%rbp), %rdx
	leaq	-41616(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-41648(%rbp), %rcx
	leaq	-41664(%rbp), %rdx
	leaq	-41616(%rbp), %rax
	leaq	.LC16(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_sscanf@PLT
	leaq	-41664(%rbp), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movq	-41680(%rbp), %rdx
	movl	%eax, (%rdx)
	movq	-41680(%rbp), %rax
	leaq	16(%rax), %rdx
	leaq	-41488(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movl	$1, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	deserializeHttpResponse, .-deserializeHttpResponse
	.globl	newHttpClient
	.type	newHttpClient, @function
newHttpClient:
.LFB22:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -72(%rbp)
	movq	-72(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	testl	%eax, %eax
	jne	.L103
	movl	$0, %eax
	jmp	.L105
.L103:
	movl	$344, %edi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movq	-24(%rbp), %rdx
	movl	%eax, 328(%rdx)
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	-72(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	split_url
	movl	$516, %edi
	call	malloc@PLT
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, 336(%rax)
	movq	-56(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-56(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	336(%rdx), %rdx
	addq	$260, %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	-40(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	336(%rdx), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	-48(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	336(%rdx), %rbx
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, 256(%rbx)
	movq	-24(%rbp), %rax
.L105:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	newHttpClient, .-newHttpClient
	.globl	clientConnect
	.type	clientConnect, @function
clientConnect:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$120, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -120(%rbp)
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	gethostbyname@PLT
	movq	%rax, -24(%rbp)
	movq	-120(%rbp), %rax
	movq	256(%rax), %rax
	testq	%rax, %rax
	jne	.L107
	movl	$16, %edi
	call	malloc@PLT
	movq	%rax, %rdx
	movq	-120(%rbp), %rax
	movq	%rdx, 256(%rax)
.L107:
	cmpq	$0, -24(%rbp)
	jne	.L108
	movl	$0, %eax
	jmp	.L111
.L108:
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movl	(%rax), %edi
	call	inet_ntoa@PLT
	movq	%rax, %rdx
	movq	-120(%rbp), %rax
	addq	$264, %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-120(%rbp), %rax
	movq	256(%rax), %rax
	movq	-32(%rbp), %rdx
	movl	(%rdx), %edx
	movl	%edx, 4(%rax)
	movq	-120(%rbp), %rax
	movq	256(%rax), %rax
	movw	$2, (%rax)
	movq	-120(%rbp), %rax
	movq	336(%rax), %rax
	movl	256(%rax), %eax
	movzwl	%ax, %eax
	movq	-120(%rbp), %rdx
	movq	256(%rdx), %rbx
	movl	%eax, %edi
	call	htons@PLT
	movw	%ax, 2(%rbx)
	movq	-120(%rbp), %rax
	movq	256(%rax), %rcx
	movq	-120(%rbp), %rax
	movl	328(%rax), %eax
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	connect@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	je	.L110
	movl	$0, %eax
	jmp	.L111
.L110:
	movl	$1, %eax
.L111:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	clientConnect, .-clientConnect
	.globl	clientRead
	.type	clientRead, @function
clientRead:
.LFB24:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$10272, %rsp
	movq	%rdi, -10264(%rbp)
	movq	%rsi, -10272(%rbp)
	movq	-10264(%rbp), %rax
	movl	328(%rax), %eax
	testl	%eax, %eax
	je	.L113
	movq	$0, -10256(%rbp)
	movq	$0, -10248(%rbp)
	leaq	-10240(%rbp), %rax
	movl	$10224, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	-10264(%rbp), %rax
	movl	328(%rax), %eax
	leaq	-10256(%rbp), %rcx
	movl	$1024, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	movl	%eax, -4(%rbp)
	leaq	-10256(%rbp), %rdx
	movq	-10272(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movl	-4(%rbp), %eax
	jmp	.L114
.L113:
	movl	$-1, %eax
.L114:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	clientRead, .-clientRead
	.globl	clientWrite
	.type	clientWrite, @function
clientWrite:
.LFB25:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	328(%rax), %eax
	testl	%eax, %eax
	je	.L116
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movl	328(%rax), %eax
	movq	-16(%rbp), %rsi
	movl	$0, %ecx
	movl	%eax, %edi
	call	send@PLT
.L116:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	clientWrite, .-clientWrite
	.section	.rodata
.LC17:
	.string	"text/html"
.LC18:
	.string	"accept"
.LC19:
	.string	"0"
.LC20:
	.string	"User-Agent"
.LC21:
	.string	"close"
.LC22:
	.string	"Connection"
.LC23:
	.string	"GET %s HTTP/1.0\r\n"
	.text
	.globl	httpGetRequest
	.type	httpGetRequest, @function
httpGetRequest:
.LFB26:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$10320, %rsp
	movq	%rdi, -10296(%rbp)
	movq	%rsi, -10304(%rbp)
	movq	%rdx, -10312(%rbp)
	cmpq	$0, -10312(%rbp)
	jne	.L118
	movl	$0, %eax
	call	newHeaderData
	movq	%rax, -10312(%rbp)
	movq	-10296(%rbp), %rdx
	movq	-10312(%rbp), %rax
	leaq	.LC13(%rip), %rsi
	movq	%rax, %rdi
	call	headerAddValue
	movq	-10312(%rbp), %rax
	leaq	.LC17(%rip), %rdx
	leaq	.LC18(%rip), %rsi
	movq	%rax, %rdi
	call	headerAddValue
	movq	-10312(%rbp), %rax
	leaq	.LC19(%rip), %rdx
	leaq	.LC20(%rip), %rsi
	movq	%rax, %rdi
	call	headerAddValue
	movq	-10312(%rbp), %rax
	leaq	.LC21(%rip), %rdx
	leaq	.LC22(%rip), %rsi
	movq	%rax, %rdi
	call	headerAddValue
.L118:
	movl	$4096, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movl	$316, %edi
	call	malloc@PLT
	movq	%rax, -16(%rbp)
	movq	-10296(%rbp), %rax
	movq	336(%rax), %rax
	movq	%rax, %rdx
	movq	-16(%rbp), %rax
	leaq	.LC23(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	sprintf@PLT
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	movl	$1024, %edi
	call	malloc@PLT
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-10312(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	headersToText
	movq	-24(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movw	$2573, (%rax)
	movb	$0, 2(%rax)
	movq	-8(%rbp), %rdx
	movq	-10296(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	clientWrite
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	$0, -10288(%rbp)
	movq	$0, -10280(%rbp)
	leaq	-10272(%rbp), %rax
	movl	$10224, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	leaq	-10288(%rbp), %rdx
	movq	-10296(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	clientRead
	movl	%eax, -28(%rbp)
	movl	$0, %eax
	call	newResponseData
	movq	%rax, -40(%rbp)
	movl	$0, %eax
	call	newHeaderData
	movq	-40(%rbp), %rdx
	movq	%rax, 8(%rdx)
	movq	-40(%rbp), %rdx
	leaq	-10288(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	deserializeHttpResponse
	movq	-40(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	httpGetRequest, .-httpGetRequest
	.globl	newClientContext
	.type	newClientContext, @function
newClientContext:
.LFB27:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$20, %edi
	call	malloc@PLT
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	newClientContext, .-newClientContext
	.section	.rodata
.LC24:
	.string	"Error Creating Socket"
	.text
	.globl	newHttpServer
	.type	newHttpServer, @function
newHttpServer:
.LFB28:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$288, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$80, 4(%rax)
	movl	$0, %edx
	movl	$1, %esi
	movl	$2, %edi
	call	socket@PLT
	movq	-8(%rbp), %rdx
	movl	%eax, (%rdx)
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$-1, %eax
	jne	.L123
	leaq	.LC24(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L124
.L123:
	movq	-8(%rbp), %rax
.L124:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.size	newHttpServer, .-newHttpServer
	.section	.rodata
	.align 8
.LC25:
	.string	"Server is listening or bound already"
.LC26:
	.string	"Server Port is 0 or less"
.LC27:
	.string	"Error Binding Server"
	.text
	.globl	serverBind
	.type	serverBind, @function
serverBind:
.LFB29:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movl	272(%rax), %edx
	movq	-24(%rbp), %rax
	movl	276(%rax), %eax
	addl	%edx, %eax
	testl	%eax, %eax
	je	.L126
	leaq	.LC25(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L127
.L126:
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	testl	%eax, %eax
	jg	.L128
	leaq	.LC26(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L127
.L128:
	movl	$16, %edi
	call	malloc@PLT
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, 264(%rax)
	movq	-24(%rbp), %rax
	movq	264(%rax), %rax
	movw	$2, (%rax)
	movq	-24(%rbp), %rax
	movl	4(%rax), %eax
	movzwl	%ax, %eax
	movq	-24(%rbp), %rdx
	movq	264(%rdx), %rbx
	movl	%eax, %edi
	call	htons@PLT
	movw	%ax, 2(%rbx)
	movq	-24(%rbp), %rax
	movq	264(%rax), %rbx
	movl	$0, %edi
	call	htonl@PLT
	movl	%eax, 4(%rbx)
	movq	-24(%rbp), %rax
	movq	264(%rax), %rcx
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind@PLT
	cmpl	$-1, %eax
	jne	.L129
	leaq	.LC27(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L127
.L129:
	movq	-24(%rbp), %rax
	movl	$1, 272(%rax)
	movl	$1, %eax
.L127:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	serverBind, .-serverBind
	.section	.rodata
	.align 8
.LC28:
	.string	"Server Tried to listen while not bound"
.LC29:
	.string	"Error Listening"
	.text
	.globl	serverListen
	.type	serverListen, @function
serverListen:
.LFB30:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	272(%rax), %eax
	testl	%eax, %eax
	jne	.L131
	leaq	.LC28(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L132
.L131:
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	movl	$6, %esi
	movl	%eax, %edi
	call	listen@PLT
	cmpl	$-1, %eax
	jne	.L133
	leaq	.LC29(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L132
.L133:
	movq	-8(%rbp), %rax
	movl	$1, 276(%rax)
	movl	$1, %eax
.L132:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	serverListen, .-serverListen
	.section	.rodata
.LC30:
	.string	"Socket return is -1"
	.text
	.globl	acceptConnection
	.type	acceptConnection, @function
acceptConnection:
.LFB31:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, %eax
	call	newClientContext
	movq	%rax, -8(%rbp)
	movl	$16, -16(%rbp)
	movq	-8(%rbp), %rax
	leaq	4(%rax), %rcx
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	leaq	-16(%rbp), %rdx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	accept@PLT
	movl	%eax, -12(%rbp)
	cmpl	$-1, -12(%rbp)
	jne	.L135
	leaq	.LC30(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L137
.L135:
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, (%rax)
	movq	-24(%rbp), %rax
	movl	280(%rax), %eax
	leal	1(%rax), %edx
	movq	-24(%rbp), %rax
	movl	%edx, 280(%rax)
	movq	-8(%rbp), %rax
.L137:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.size	acceptConnection, .-acceptConnection
	.globl	closeConnection
	.type	closeConnection, @function
closeConnection:
.LFB32:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, %edi
	call	close@PLT
	movq	-8(%rbp), %rax
	movl	280(%rax), %eax
	leal	-1(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 280(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.size	closeConnection, .-closeConnection
	.section	.rodata
.LC31:
	.string	"Error During Reading Request"
	.text
	.globl	readHttpRequest
	.type	readHttpRequest, @function
readHttpRequest:
.LFB33:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$20528, %rsp
	movq	%rdi, -20504(%rbp)
	movq	%rsi, -20512(%rbp)
	movq	%rdx, -20520(%rbp)
	movq	$0, -20496(%rbp)
	movq	$0, -20488(%rbp)
	leaq	-20480(%rbp), %rax
	movl	$20464, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	-20512(%rbp), %rax
	movl	(%rax), %eax
	leaq	-20496(%rbp), %rsi
	movl	$0, %ecx
	movl	$20480, %edx
	movl	%eax, %edi
	call	recv@PLT
	movl	%eax, -4(%rbp)
	cmpl	$-1, -4(%rbp)
	jne	.L141
	leaq	.LC31(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L143
.L141:
	leaq	-20496(%rbp), %rdx
	movq	-20520(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movl	$1, %eax
.L143:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.size	readHttpRequest, .-readHttpRequest
	.section	.rodata
.LC32:
	.string	"Error Sending Response"
	.text
	.globl	writeHttpRespone
	.type	writeHttpRespone, @function
writeHttpRespone:
.LFB34:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$20528, %rsp
	movq	%rdi, -20504(%rbp)
	movq	%rsi, -20512(%rbp)
	movq	%rdx, -20520(%rbp)
	movq	-20520(%rbp), %rdx
	leaq	-20496(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	movq	-20512(%rbp), %rax
	movl	(%rax), %eax
	leaq	-20496(%rbp), %rsi
	movl	$0, %ecx
	movl	$20480, %edx
	movl	%eax, %edi
	call	send@PLT
	movl	%eax, -4(%rbp)
	cmpl	$-1, -4(%rbp)
	jne	.L145
	leaq	.LC32(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L147
.L145:
	movl	$1, %eax
.L147:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.size	writeHttpRespone, .-writeHttpRespone
	.globl	readAndParseRequest
	.type	readAndParseRequest, @function
readAndParseRequest:
.LFB35:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movl	$21504, %edi
	call	malloc@PLT
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	readHttpRequest
	movl	$0, %eax
	call	newRequestData
	movq	%rax, -24(%rbp)
	movl	$0, %eax
	call	newHeaderData
	movq	-24(%rbp), %rdx
	movq	%rax, 512(%rdx)
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	deserializeHttpRequest
	movl	%eax, -28(%rbp)
	cmpl	$0, -28(%rbp)
	jne	.L149
	movq	-48(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	closeConnection
	movl	$0, %eax
	jmp	.L150
.L149:
	movl	$0, -4(%rbp)
	jmp	.L151
.L152:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-16(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	addl	$1, -4(%rbp)
.L151:
	cmpl	$21503, -4(%rbp)
	jle	.L152
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-24(%rbp), %rax
.L150:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.size	readAndParseRequest, .-readAndParseRequest
	.globl	sendResponse
	.type	sendResponse, @function
sendResponse:
.LFB36:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$10240, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movb	$0, (%rax)
	movq	-40(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	serializeHttpResponse
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-8(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	writeHttpRespone
	testl	%eax, %eax
	jne	.L154
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$0, %eax
	jmp	.L155
.L154:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movl	$1, %eax
.L155:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	sendResponse, .-sendResponse
	.globl	makeHttpResponse
	.type	makeHttpResponse, @function
makeHttpResponse:
.LFB37:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$0, %eax
	call	newResponseData
	movq	%rax, -8(%rbp)
	movl	$0, %eax
	call	newHeaderData
	movq	-8(%rbp), %rdx
	movq	%rax, 8(%rdx)
	movq	-8(%rbp), %rax
	movl	-28(%rbp), %edx
	movl	%edx, (%rax)
	movq	-8(%rbp), %rax
	leaq	16(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	movq	-8(%rbp), %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.size	makeHttpResponse, .-makeHttpResponse
	.section	.rodata
.LC33:
	.string	"Close"
	.text
	.globl	handleRequest
	.type	handleRequest, @function
handleRequest:
.LFB38:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$1072, %rsp
	movq	%rdi, -1064(%rbp)
	movq	%rsi, -1072(%rbp)
	movl	$0, -12(%rbp)
	movq	-1072(%rbp), %rdx
	movq	-1064(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	readAndParseRequest
	movq	%rax, -24(%rbp)
	cmpl	$0, -12(%rbp)
	je	.L159
	movq	-1072(%rbp), %rdx
	movq	-1064(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	closeConnection
	movl	$0, %eax
	jmp	.L163
.L159:
	movq	$0, -1056(%rbp)
	movq	$0, -1048(%rbp)
	leaq	-1040(%rbp), %rdx
	movl	$0, %eax
	movl	$126, %ecx
	movq	%rdx, %rdi
	rep stosq
	movq	$0, -8(%rbp)
	movq	-24(%rbp), %rax
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L161
	leaq	-1056(%rbp), %rax
	movabsq	$4332531476944152636, %rsi
	movabsq	$7510913731243831138, %rdi
	movq	%rsi, (%rax)
	movq	%rdi, 8(%rax)
	movabsq	$8245905239640194609, %rsi
	movabsq	$2323348781308605291, %rdi
	movq	%rsi, 16(%rax)
	movq	%rdi, 24(%rax)
	movabsq	$7812730814536575036, %rdx
	movabsq	$4351722378696794223, %rcx
	movq	%rdx, 32(%rax)
	movq	%rcx, 40(%rax)
	movabsq	$3704276802692409391, %rsi
	movabsq	$4211540160944624446, %rdi
	movq	%rsi, 48(%rax)
	movq	%rdi, 56(%rax)
	movabsq	$4332586487001932576, %rdx
	movabsq	$7074939648802514991, %rcx
	movq	%rdx, 64(%rax)
	movq	%rcx, 72(%rax)
	movabsq	$7887043455388050543, %rcx
	movq	%rcx, 80(%rax)
	movw	$15980, 88(%rax)
	movb	$0, 90(%rax)
	leaq	-1056(%rbp), %rax
	movl	$200, %esi
	movq	%rax, %rdi
	call	makeHttpResponse
	movq	%rax, -8(%rbp)
.L161:
	cmpq	$0, -8(%rbp)
	jne	.L162
	leaq	-1056(%rbp), %rax
	movabsq	$7078601349733312572, %rsi
	movabsq	$4481477712165823599, %rdi
	movq	%rsi, (%rax)
	movq	%rdi, 8(%rax)
	movabsq	$8030873963933741108, %rdx
	movabsq	$8390010531861459573, %rcx
	movq	%rdx, 16(%rax)
	movq	%rcx, 24(%rax)
	movabsq	$3403705843964659232, %rsi
	movabsq	$7237111081221370216, %rdi
	movq	%rsi, 32(%rax)
	movq	%rdi, 40(%rax)
	movabsq	$7813028919375576697, %rcx
	movq	%rcx, 48(%rax)
	movw	$62, 56(%rax)
	leaq	-1056(%rbp), %rax
	movl	$404, %esi
	movq	%rax, %rdi
	call	makeHttpResponse
	movq	%rax, -8(%rbp)
.L162:
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	leaq	.LC33(%rip), %rdx
	leaq	.LC22(%rip), %rsi
	movq	%rax, %rdi
	call	headerAddValue
	movq	-8(%rbp), %rdx
	movq	-1072(%rbp), %rcx
	movq	-1064(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	sendResponse
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	movq	-1072(%rbp), %rdx
	movq	-1064(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	closeConnection
	movl	$1, %eax
.L163:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	handleRequest, .-handleRequest
	.section	.rodata
.LC34:
	.string	"Unable to Create Socket"
	.align 8
.LC35:
	.string	"Http Server Listening on port %d\n"
.LC36:
	.string	"http://localhost:%d/\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movl	$0, %eax
	call	newHttpServer
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L165
	leaq	.LC34(%rip), %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L166
.L165:
	movq	-8(%rbp), %rax
	movl	$8000, 4(%rax)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	serverBind
	testl	%eax, %eax
	jne	.L167
	movl	$1, %eax
	jmp	.L166
.L167:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	serverListen
	testl	%eax, %eax
	jne	.L168
	movl	$1, %eax
	jmp	.L166
.L168:
	movq	-8(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, %esi
	leaq	.LC35(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movq	-8(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, %esi
	leaq	.LC36(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L171:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	acceptConnection
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	handleRequest
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	je	.L173
	jmp	.L171
.L173:
	nop
	movl	$0, %eax
.L166:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
