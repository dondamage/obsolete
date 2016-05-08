#!/bin/python
##############################################################################
# File:   libhdl_list_tags.py 
# Author: Andreas Mueller
# Date:   2016-03-20
#
# Description: List all tags found within a given file.
#              Tags must be enclosed by a given delimiter.
##############################################################################

import os
import re
import sys

def main(inFile, tagDelim=['<', '>']):
    """List all tags found within given text file."""
    try: fdr = open(inFile, 'r');
    except Exception as e: raise
    
    txt = fdr.read()
    
    if not fdr.closed: fdr.close()
    
    tagRegExp = re.compile(tagDelim[0]+r'(\w+)'+tagDelim[1])
    
    tags = list(set(tagRegExp.findall(txt)))
    
    return tags


if __name__ == '__main__':
    tags = main(sys.argv[1])
    print(tags)
else:
    print("Initializing module.")
