#lang racket/base

;;; Module for emitting a quasi-IR
;;;
;;; The idea here is that we have a format that we can convert to
;;; basically any IR/source code that we wish. This is an IR that *I*
;;; understand.

(struct program (instructions) #:transparent)

;;; All instructions contain some metadata
(struct instruction (src-loc) #:transparent)

;;; The following instructions take some kind of arguments. The types:
;;;
;;;  - name :: name for a label
;;;  - label :: a label reference
;;;  - args :: a list of register names or immediate values
;;;  - reg :: name of a register
;;;  - immediate :: a value that can be encoded directly in the asm
;;;
;;; Note that depending on the final target, these instructions may
;;; correspond to *multiple* instructions.

;;; Control
(struct label instruction (name) #:transparent)
(struct jmp instruction (label) #:transparent)
(struct set-reg instruction (reg reg-or-immediate) #:transparent)
(struct if0 instruction (reg true-label false-label))
(struct if= instruction (reg-or-immediate1 reg-or-immediate2 true-label false-label))

;;; Function calls
(struct prep-call instruction (args) #:transparent)
(struct call instruction (label) #:transparent)
(struct ret instruction (reg-or-immediate) #:transparent)

;;; Mathematical operation
(struct opt instruction (opt-name regs) #:transparent)

;;; Stack
(struct push instruction (reg-or-immediate) #:transparent)
(struct pop instruction (reg) #:transparent)

;;; litteral values baked into the source
(struct immediate instruction (value) #:transparent)
