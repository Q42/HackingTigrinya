import codecs
import tensorflow as tf

model_dir = 'gs://hacking-tigrinya-cloud/nmt_model/'
meta_path = model_dir + 'translate.ckpt-12000.meta'
output_path = model_dir + 'output_graph.pb'

with tf.Session() as sess:
    # Restore the graph
    saver = tf.train.import_meta_graph(meta_path, clear_devices=True)

    # Load weights
    saver.restore(sess,tf.train.latest_checkpoint(model_dir))

    # Freeze the graph
    output_node_names =[n.name for n in tf.get_default_graph().as_graph_def().node]
    frozen_graph_def = tf.graph_util.convert_variables_to_constants(
        sess,
        sess.graph_def,
        output_node_names)

    # Save the frozen graph
    with tf.gfile.GFile(output_path, "wb") as f:
        f.write(frozen_graph_def.SerializeToString())
