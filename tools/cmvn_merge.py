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


CMVN_LIST_FILE = ''
CMVN_FILE = ''
LIST_FILE_ROOT = ''
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


def main(argv):
    """argv[1]: configure file name
    """
    global CMVN_LIST_FILE
    CMVN_LIST_FILE = argv[1]
    global CMVN_FILE
    CMVN_FILE = argv[2]

    accsum1 = np.zeros(FREQ_BIN_NUM + 1, dtype=float)
    accsum2 = np.zeros(FREQ_BIN_NUM + 1, dtype=float)
    with open(CMVN_LIST_FILE) as list_file:
        for line in list_file:
            line = line.strip()
            sum1, sum2 = np.loadtxt(line)
            accsum1 += sum1
            accsum2 += sum2

    mean = np.zeros(FREQ_BIN_NUM, dtype=float)
    var = np.zeros(FREQ_BIN_NUM, dtype=float)
    for i in range(FREQ_BIN_NUM):
        mean[i] = accsum1[i]/accsum1[FREQ_BIN_NUM]
        var[i] = accsum2[i]/accsum1[FREQ_BIN_NUM]

    fbias = -mean
    fscale = 1 / np.sqrt(var - np.square(mean))
    np.savetxt(CMVN_FILE, (fbias, fscale))
    print("compute sucessful!")


if __name__ == '__main__':
    tf.app.run()
