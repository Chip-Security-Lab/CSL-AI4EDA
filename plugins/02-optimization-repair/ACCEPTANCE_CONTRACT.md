# Result interpretation and verification scope

[Plugin](README.md) · [中文手册](USER_GUIDE.zh-CN.md)

This public guide summarizes the current version's result contract. Complete original implementation notes remain in the VSIX.

- A completed run or generated/exportable candidate is not verification success. Export, target assessment and overall assessment are separate.
- A side-channel target requires the recorded target-specific evidence and its interface/resource/functional/formal/measurement prerequisites. Missing evidence and unproved formal results remain visible. T06/T09/T10 have at most RTL mitigation scope.
- Timing optimization success requires the same-constraint measured improvement and required checks. Timing closure is displayed separately: negative WNS means the constraint is not closed. A formal timeout is not a pass; an explicit counterexample, functional failure or tool failure remains a failure.
- RTL-TVLA describes design-stage switching activity. It is not a gate-level glitch, entropy, measured physical power, or chip security proof.
- Example candidate fixtures that explicitly change latency are valid only under their recorded historical contract, not the ordinary preserve-cycle behavior workflow.

Use the task's actual evidence and the [manual](USER_GUIDE.zh-CN.md) to interpret each result rather than accepting a model's description as verification.
