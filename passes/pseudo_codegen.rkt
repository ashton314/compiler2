#lang racket/base

;;; Module for emitting a quasi-IR
;;;
;;; The idea here is that we have a format that we can convert to
;;; basically any IR/source code that we wish. This is an IR that *I*
;;; understand.

(struct program (instructions) #:transparent)

;;; All instructions contain some metadata
(struct instruction (src-loc) #:transparent)

(struct label instruction (name) #:transparent)
(struct jmp instruction (label) #:transparent)
(struct set-reg instruction (reg reg-or-immediate) #:transparent)
(struct opt instruction (name regs) #:transparent)
(struct push instruction (val-or-reg) #:transparent)

;;; litteral values baked into the source
(struct immediate instruction (value) #:transparent)
