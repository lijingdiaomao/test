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

import re
import time
import os
import sys
import math
import struct
import ConfigParser

# from six.moves import xrange  # pylint: disable=redefined-builtin
import tensorflow as tf
import numpy as np
from tensorflow.python.framework import ops


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


def compute_global_cmvn(file_names):
    """
    compute global cmvn
    """
    accsum1 = np.zeros([FREQ_BIN_NUM, CHANNEL_NUM], dtype=float)
    accsum2 = np.zeros([FREQ_BIN_NUM, CHANNEL_NUM], dtype=float)
    accnfrm = 0
    with tf.Session() as sess:
        fsum1 = tf.zeros([FREQ_BIN_NUM, CHANNEL_NUM], dtype=tf.float32)
        fsum2 = tf.zeros([FREQ_BIN_NUM, CHANNEL_NUM], dtype=tf.float32)
        # read feature
        filename_queue = tf.train.string_input_producer(file_names, shuffle=False, num_epochs=1,
                                                        capacity=BATCH_SIZE)
        reader = tf.TFRecordReader()
        file_and_idx, serialized_example = reader.read(filename_queue)
        raw_example = tf.parse_single_example(
            serialized_example,
            # Defaults are not specified since both keys are required.
            features={
                'spectr': tf.FixedLenFeature([], tf.string),
                'label': tf.FixedLenFeature([], tf.string),
            })
        # decode example
        example = tf.decode_raw(raw_example['spectr'], tf.float32)
        example = tf.reshape(example, [-1, FREQ_BIN_NUM, CHANNEL_NUM])
        if START_FREQ_BIN != 0 or FREQ_BIN_NUM != TOTAL_FREQ_BIN:
            example = tf.slice(example, [0, START_FREQ_BIN, 0], [-1, TOTAL_FREQ_BIN, -1])

        # compute
        fsum1 = tf.reduce_sum(example, 0)
        fsum2 = tf.reduce_sum(tf.square(example), 0)
        nfrm = tf.shape(example)[0]

        # run sess
        init_local_op = tf.local_variables_initializer()
        sess.run(init_local_op)
        coord = tf.train.Coordinator()
        threads = tf.train.start_queue_runners(sess=sess, coord=coord)
        try:
            i = 1
            while not coord.should_stop():
                f1, f2, n = sess.run([fsum1, fsum2, nfrm])
                accsum1 += f1
                accsum2 += f2
                accnfrm += n
                if i % 100 == 0:
                    print (i, accnfrm)
                i += 1
        except tf.errors.OutOfRangeError:
            print('Done cmvn -- epoch limit reached')
        finally:
            # When done, ask the threads to stop.
            coord.request_stop()

        coord.join(threads)
        # print(accsum1[0][0], accsum2[0][0])
        # accsum1 = tf.negative(tf.div(accsum1, accnfrm))
        # accsum2 = tf.rsqrt(tf.subtract(tf.div(accsum2, accnfrm), tf.square(accsum1)))
        print('Compute done')
        fmean = np.zeros(FREQ_BIN_NUM + 1, dtype=float)
        fvar = np.zeros(FREQ_BIN_NUM + 1, dtype=float)
        # mean = accsum1.eval()
        # var = accsum2.eval()
        for i in range(FREQ_BIN_NUM):
            fmean[i] = accsum1[i, 0]
            fvar[i] = accsum2[i, 0]
        fmean[FREQ_BIN_NUM] = accnfrm
        fvar[FREQ_BIN_NUM] = 0.0
        # print(fmean, fvar)
        np.savetxt(CMVN_FILE, (fmean, fvar))
        print('Save done')


def main(argv):
    """argv[1]: configure file name
    """
    global TFR_LIST_FILE
    TFR_LIST_FILE = argv[1]
    global CMVN_FILE
    CMVN_FILE = argv[2]

    file_names = []
    with open(TFR_LIST_FILE) as list_file:
        for line in list_file:
            line = line.strip()
            file_names.append(LIST_FILE_ROOT + line)
    compute_global_cmvn(file_names)


if __name__ == '__main__':
    tf.app.run()
