#!/bin/python
##############################################################################
# File:   libhdl_gen_new_module.py 
# Author: Andreas Mueller
# Date:   2015-04-25
#
# Description: Create new empty file from template. Replace placeholder tags
#              with values from a configuration file.
##############################################################################

import getopt
import os
import re
import sys

def main():
    ODL = '#' # Output delimiter.
    
    generateTarget = None
    outputFile = None
    
    # Supported language versions.
    vhdlTargets = set(['vhdl-1987', 'vhdl-1993', 'vhdl-2008'])
    verilogTargets = set(['verilog-1995', 'verilog-2001', 'verilog-2005'])
    systemVerilogTargets = set(['systemverilog-2005', 'systemverilog-2009', 
                                'systemverilog-2012'])
    supportedGenTargets = set()
    supportedGenTargets.update(vhdlTargets)
    supportedGenTargets.update(verilogTargets)
    supportedGenTargets.update(systemVerilogTargets)
    
    VHDL_MOD_FILE_EXT = '.vhd'
    VHDL_PKG_FILE_EXT = '.vhd'
    VLOG_MOD_FILE_EXT = '.v'
    VLOG_HDR_FILE_EXT = '.vh'
    SVLOG_MOD_FILE_EXT = '.sv'
    SVLOG_HDR_FILE_EXT = '.svh'
    
    # Define paths to template files.
    PATH = '../comp/_template'
    DIRS = {}
    DIRS.update({x : os.path.join('vhdl', x) for x in vhdlTargets})
    DIRS.update({x : os.path.join('verilog', x) for x in verilogTargets})
    DIRS.update({x : os.path.join('systemverilog', x) for x in systemVerilogTargets})
    TEMPLATE_MODULES = {}
    TEMPLATE_MODULES.update({x : ''.join(['template_module', VHDL_MOD_FILE_EXT])
                             for x in vhdlTargets})
    TEMPLATE_MODULES.update({x : ''.join(['template_module', VLOG_MOD_FILE_EXT])
                             for x in verilogTargets})
    TEMPLATE_MODULES.update({x : ''.join(['template_module', SVLOG_MOD_FILE_EXT])
                             for x in systemVerilogTargets})
    TEMPLATE_PACKAGES = {}
    TEMPLATE_PACKAGES.update({x : ''.join(['template_package', VHDL_PKG_FILE_EXT])
                              for x in vhdlTargets})
    TEMPLATE_PACKAGES.update({x : ''.join(['template_header', VLOG_HDR_FILE_EXT])
                              for x in verilogTargets})
    TEMPLATE_PACKAGES.update({x : ''.join(['template_header', SVLOG_HDR_FILE_EXT])
                              for x in systemVerilogTargets})
    
    # Parse command line arguments.
    try:
        opts, args = getopt.getopt(sys.argv[1:], 'hg:o:', ['help', 'generate=', 'outputFile='])
    except getopt.GetoptError as e:
        print_usage()
        sys.exit(2)
    
    #print('opts {0}'.format(opts))
    #print('args {0}'.format(args))
    
    for opt, arg in opts:
        if opt in ('-h', '--help'):
            print_usage()
            sys.exit(2)
        elif opt in ('-g', '--generate'):
            generateTarget = arg
        elif opt in ('-o', '--outputFile'):
            outputFile = arg
        else:
            printf("Unknown option %s".format(opt))
            print_usage()
            sys.exit(2)
    
    # Set default values for missing options or abort.
    if generateTarget not in supportedGenTargets:
        print('Unsupported target for generation from template.')
        print_usage()
        sys.exit(2)
    
    if outputFile is None:
        outputFile = 'new'
    
    outputFile, outputExtension = os.path.splitext(outputFile)
    if outputExtension == '':
        if generateTarget[0:4] == 'vhdl':
            outputExtension = VHDL_MOD_FILE_EXT
        elif generateTarget[0:7] == 'verilog':
            outputExtension = VLOG_MOD_FILE_EXT
        elif generateTarget[0:12] == 'systemverilog':
            outputExtension = SVLOG_MOD_FILE_EXT
        else:
            outputExtension = 'out'
    
    # Get requested template.
    try:
        fdr = open(os.path.join(PATH, DIRS[generateTarget],
            TEMPLATE_MODULES[generateTarget]), 'r')
    except Exception as e:
        raise
    
    template = fdr.read()
    
    if not fdr.closed:
        fdr.close()
    
    # Replace template tags by values.
    
    # TODO
    
    # Write output to file.
    try:
        fdw = open(outputFile, 'w')
    except Exception as e:
        raise
    
    fdw.write(template)
    
    if not fdr.closed:
        fdr.close()
    
    print(3*ODL)
    print('Done')
    print(3*ODL)
    

def print_usage():
        print(3*ODL)
        print('Usage: {0} -g TARGET [-o] [-h]'.format(sys.argv[0]))
        print(4*' '+'-h, --help : print this help text.')
        print(4*' '+'-g, --generate : generate file from template.')
        print(4*' '+'-o, --outputFile : write output to this file.')
        print('')
        print(4*' '+'TARGET : vhdl-{1987, 1993, 2008}, verilog-{1995, 2001, 2005}, systemverilog-{2005, 2009, 2012}')
        print(3*ODL)
    

if __name__ == '__main__':

else: # if __name == '__main__'
    print("Initializing module.")
