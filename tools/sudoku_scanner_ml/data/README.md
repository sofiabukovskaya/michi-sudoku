# Dataset storage

Generated cells, private photographs, manifests, checkpoints, and training
contact sheets are local development artifacts and are not committed. The
Phase 13 programmatically generated photo remains a fixed benchmark and must
never be included in model training or threshold tuning. A new real-photo
holdout should be collected before claiming real-world accuracy.

Each manifest row has `sample_id`, `sample_path`, `label` (0 = empty),
`source_image_id`, `source_type`, `font_id`, `split`, and optional `notes`,
`old_prediction`, `old_confidence`. All cells from one source image stay in one
split. Use the preparation CLI to extract cells from approved local photos;
never upload user photos.
