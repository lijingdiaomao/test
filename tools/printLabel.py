# Copyright 2016 Rokid. All Rights Reserved.
#
# @Author: Fan Lichun
# @Created: 2018.4.18
#
# ==============================================================================

"""Run CTC training
"""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import sys
import tensorflow as tf

TFR_LIST_FILE = ''
LIST_FILE_ROOT = ''
CMVN_FILE = ''
SHUFFLE_LIST = False
NUM_EPOCHS = 1

# frequency bin number for each frame
FREQ_BIN_NUM = 40
CHANNEL_NUM = 1
BATCH_SIZE = 32

START_FREQ_BIN = 0
TOTAL_FREQ_BIN = 40


class FlushFile(object):
    def __init__(self, f):
        self.f = f

    def write(self, x):
        self.f.write(x)
        self.f.flush()

sys.stdout = FlushFile(sys.stdout)


def printLabel(file_name):

    sess = tf.Session()
    for serialized_example in tf.python_io.tf_record_iterator(file_name):
        raw_example = tf.parse_single_example(
            serialized_example,
            # Defaults are not specified since both keys are required.
            features={
                'spectr': tf.FixedLenFeature([], tf.string),
                'label': tf.FixedLenFeature([], tf.string),
            })
    # decode example
    label = tf.decode_raw(raw_example['label'], tf.int32)
    label = tf.reshape(label, [-1])
    # print(sess.run(tf.shape(example))) # 241
    lab = sess.run(label)

    print(lab)


def main(argv):
    """argv[1]: configure file name
    """
    symbol_table = "symbol_table.txt"
    file_name = "host148_seg_2_2012_3_13_32_481ce189366842b1_0.tfr"

    printLabel(file_name)


if __name__ == '__main__':
    tf.app.run()
