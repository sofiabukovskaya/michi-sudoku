"""Small ten-class CNN for printed Sudoku cells."""

import tensorflow as tf


def build_model(input_size: int = 32) -> tf.keras.Model:
    inputs = tf.keras.Input(shape=(input_size, input_size, 1), name="cell")
    x = tf.keras.layers.Conv2D(16, 3, padding="same", activation="relu")(inputs)
    x = tf.keras.layers.MaxPool2D()(x)
    x = tf.keras.layers.Conv2D(32, 3, padding="same", activation="relu")(x)
    x = tf.keras.layers.MaxPool2D()(x)
    x = tf.keras.layers.Conv2D(48, 3, padding="same", activation="relu")(x)
    x = tf.keras.layers.Flatten()(x)
    x = tf.keras.layers.Dense(64, activation="relu")(x)
    x = tf.keras.layers.Dropout(0.15)(x)
    outputs = tf.keras.layers.Dense(10, activation="softmax", name="class")(x)
    return tf.keras.Model(inputs, outputs, name="michi_digit_v1")
