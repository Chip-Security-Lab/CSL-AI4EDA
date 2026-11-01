# Version notes

## Frontend 0.1.1 — local distribution candidate

- Removes only the internal `extension/PROGRESS.md` handover record from the supplied VSIX and pairs the candidate with the supplied runtime snapshot. All remaining VSIX entries, including JavaScript, manifests, ID and version, are byte-identical.
- Preserves all six `examples/demo_soc` RTL files and one existing interface illustration.
- Separates runtime files from extension development files and optional paper datasets/notebook.
- Removes a supplied default database password and personal example/comment paths from the staged runtime only; leaves the example scan target empty and documents picker/absolute target paths.
- Backend FastAPI metadata remains 0.1.0; this is not a new backend version.
- Archive/example checks were performed during preparation. Real VS Code, Neo4j, engine, and model integration checks remain outstanding.
- Upstream license documents and applicable distribution terms remain pending maintainer confirmation; see [third-party notices](THIRD_PARTY_NOTICES.md).

This record describes publication preparation rather than a new implementation release.
