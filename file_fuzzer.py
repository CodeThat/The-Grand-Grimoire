from pydbg import *
from pydbg.defines import *

import utils
import random
import sys
import struct
import threading
import os
import shutil
import time
import getopt

class file_fuzzer:
    
    def __init__(self, exe_path, ext, notify):
        
        self.exe_path       = exe_path
        self.ext            = ext
        self.notify_crash   = notify
        self.orig_file      = None
        self.mutated_file   = None
        self.iteration      = 0
        self.exe_path       = exe_path
        self.orig_file      = None
        self.mutated_file   = None
        self.iteration      = 0
        self.crash          = None
        self.send_notify    = False
        self.pid            = None
        self.in_accessv_handler = False
        self.dbg            = None
        self.ready          = False
        
        # Optional
        self.smtpserver = 'mail.google.com'
        self.recipients = ['someone@somewhere.com']
        self.sender     = 'self@hnothere.com'
        self.test_cases = [ "%s%n%s%n%s%n", "\xff", "\x00", "A"]
        
    def file_picker(self):
        
        file_list = os.listdir("examples/")
        list_length = len(file_list)
        file = file_list[random.randint(0, list_length-1)]
        shutil.copy("examples\\%s" % file, "test.%s" % self.ext)
        
        return file
