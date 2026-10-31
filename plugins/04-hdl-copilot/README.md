# HDL Copilot Plugin

**Understand RTL. Ask questions. Review suggestions.**

[Home](../../README.md) · [Plugin directory](../README.md) · [User guide](../../docs/USER_GUIDE.md)

HDL Copilot supports conversations about Verilog and SystemVerilog, including code explanation, design questions, and suggested changes. It fits across the RTL design flow as an assistant to the engineer.

## Interaction

1. Provide the current RTL and a concrete question, including the expected behavior and constraints.
2. Read the explanation and ask follow-up questions in the same discussion.
3. Review proposed code differences before applying a suggestion.

The existing VS Code interaction reads the current editor buffer and supports explicit application after a diff preview. The Vivado interaction reads saved RTL from the selected project file and provides previewable, copyable suggestions. These editor-specific details are introduced in the shared [user guide](../../docs/USER_GUIDE.md).

## This publication

This directory contains the plugin introduction. Implementation source, extension engineering files and installation packages will be documented with their implementation release.

Suggested RTL changes should be checked with the normal compilation, simulation and project validation workflow.
