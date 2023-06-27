import coremltools as ct
import tensorflow as tf

# Load the TF model
model = tf.keras.models.load_model('/Users/admin/University/IOS/ArtApp/magenta_arbitrary-image-stylization-v1-256_3/')

# Convert the model
coreml_model = ct.convert(
    model,
    source='tensorflow',
    inputs=[ct.TensorType(shape=(1, 224, 224, 3))],  # Shape of input data
)

# Save the Core ML model
coreml_model.save('MyModel.mlmodel')
