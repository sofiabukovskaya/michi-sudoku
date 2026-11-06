"""Export a validated Keras checkpoint to float32 TensorFlow Lite."""

import argparse
import hashlib
import json
from pathlib import Path

import tensorflow as tf
import yaml


def export_model(
    checkpoint: Path, output: Path, version: str, config_path: Path
) -> dict:
    config = yaml.safe_load(config_path.read_text(encoding="utf-8"))
    model = tf.keras.models.load_model(checkpoint)
    converter = tf.lite.TFLiteConverter.from_keras_model(model)
    artifact = converter.convert()
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_bytes(artifact)
    interpreter = tf.lite.Interpreter(model_path=str(output))
    interpreter.allocate_tensors()
    input_tensor = interpreter.get_input_details()[0]
    output_tensor = interpreter.get_output_details()[0]
    if list(input_tensor["shape"]) != [1, 32, 32, 1] or list(
        output_tensor["shape"]
    ) != [1, 10]:
        raise ValueError("Unexpected TFLite input/output shape")
    metadata = {
        "model_version": version,
        "input_size": 32,
        "channels": 1,
        "input_dtype": "float32",
        "output_dtype": "float32",
        "normalization": (
            "RGB mean / 255; black=0, white=1; bilinear pixel-center resize"
        ),
        "labels": ["empty", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
        "confidence_thresholds": config["confidence"],
        "training_dataset_version": config["dataset_version"],
        "sha256": hashlib.sha256(artifact).hexdigest(),
        "bytes": len(artifact),
    }
    output.with_suffix(".json").write_text(
        json.dumps(metadata, indent=2), encoding="utf-8"
    )
    return metadata


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--checkpoint", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--version", required=True)
    parser.add_argument("--config", type=Path, required=True)
    args = parser.parse_args()
    print(
        json.dumps(
            export_model(args.checkpoint, args.output, args.version, args.config),
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
