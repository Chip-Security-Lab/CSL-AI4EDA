# Secure Generation Plugin

**Generate RTL and FSM drafts with hardware-security knowledge.**

[Home](../../README.md) · [Plugin directory](../README.md) · [User guide](../../docs/USER_GUIDE.md)

Secure Generation combines design requirements with security knowledge to produce Verilog or SystemVerilog drafts and supporting review information. The technical context is **PowerSecV (CWE) + SecFSM**.

## Interaction

1. Describe the functionality, ports, clock, reset behavior and relevant constraints.
2. Choose the general RTL or FSM generation workflow.
3. Review the code draft, retrieved knowledge and report.
4. Inspect a proposed file change before confirming it in the editor integration.

The existing interaction patterns cover VS Code and Vivado, with model configuration described in the shared [user guide](../../docs/USER_GUIDE.md). Optional low-power refinement of general RTL belongs to this plugin's workflow; the Optimization & Repair Plugin has its own scope.

## This publication

This directory contains the plugin introduction. Source code, knowledge snapshots, engineering files and installation packages are outside this documentation release.

Generated HDL is a draft. A model review does not replace functional simulation or independent security verification.
