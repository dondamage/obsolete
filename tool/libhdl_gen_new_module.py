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

class libhdl_gen(object):
    """
    libhdl_gen is wrapper class for the tag-replacement functionality.
    """
    ODL = '#' # Output delimiter.
    TDL = '=' # Tag definition delimiter.
    
    # Supported language versions.
    vhdlTargets = set(['vhdl-1987', 'vhdl-1993', 'vhdl-2008'])
    verilogTargets = set(['verilog-1995', 'verilog-2001', 'verilog-2005'])
    systemVerilogTargets = set(['systemverilog-2005', 'systemverilog-2009', 
                                'systemverilog-2012'])
    supportedTargets = set.union(vhdlTargets, verilogTargets, systemVerilogTargets)
    
    VHDL_MOD_FILE_EXT = '.vhd'
    VHDL_PKG_FILE_EXT = '.vhd'
    VLOG_MOD_FILE_EXT = '.v'
    VLOG_HDR_FILE_EXT = '.vh'
    SVLOG_MOD_FILE_EXT = '.sv'
    SVLOG_HDR_FILE_EXT = '.svh'
    
    def __init__(self):
        """Initialize a libhdl_gen object."""
        self.generateTarget = None
        self.tagDefFileName = None
        self.tagDef = {}
        self.outputFile = None
        
        # Define templatePaths to template files.
        self.templatePath = '../comp/_template'
        self.templateDirs = {}
        self.templateDirs.update({x : os.path.join('vhdl', x)
                                  for x in libhdl_gen.vhdlTargets})
        self.templateDirs.update({x : os.path.join('verilog', x)
                                  for x in libhdl_gen.verilogTargets})
        self.templateDirs.update({x : os.path.join('systemverilog', x)
                                  for x in libhdl_gen.systemVerilogTargets})
        self.templateModules = {}
        self.templateModules.update({x : ''.join(['template_module', libhdl_gen.VHDL_MOD_FILE_EXT])
                                 for x in libhdl_gen.vhdlTargets})
        self.templateModules.update({x : ''.join(['template_module', libhdl_gen.VLOG_MOD_FILE_EXT])
                                 for x in libhdl_gen.verilogTargets})
        self.templateModules.update({x : ''.join(['template_module', libhdl_gen.SVLOG_MOD_FILE_EXT])
                                 for x in libhdl_gen.systemVerilogTargets})
        self.templatePackages = {}
        self.templatePackages.update({x : ''.join(['template_package', libhdl_gen.VHDL_PKG_FILE_EXT])
                                  for x in libhdl_gen.vhdlTargets})
        self.templatePackages.update({x : ''.join(['template_header', libhdl_gen.VLOG_HDR_FILE_EXT])
                                  for x in libhdl_gen.verilogTargets})
        self.templatePackages.update({x : ''.join(['template_header', libhdl_gen.SVLOG_HDR_FILE_EXT])
                                  for x in libhdl_gen.systemVerilogTargets})
        
    def main(self):
        """
        Generate a new HDL module skeleton from a template depending on given
        command line options.
        """
        # Parse command line arguments.
        try:
            opts, args = getopt.getopt(sys.argv[1:], 'hg:o:t:', ['help', 'generate=', 'outputFile=',
                                                                 'tagDefinitionFile='])
        except getopt.GetoptError as e:
            print("Unknown command line option.")
            self.print_usage()
            sys.exit(2)
        
        # Debug.
        #print('opts {0}'.format(opts))
        #print('args {0}'.format(args))
        
        for opt, arg in opts:
            if opt in ('-h', '--help'):
                self.print_usage()
                sys.exit(2)
            elif opt in ('-g', '--generate'):
                self.generateTarget = arg
            elif opt in ('-o', '--outputFile'):
                self.outputFile = arg
            elif opt in ('-t', '--tagDefinition'):
                self.tagDefFileName = arg
            else:
                self.print_usage()
                sys.exit(2)
        
        # Set default values for missing options or abort.
        if self.generateTarget not in self.supportedTargets:
            print('Unsupported target for generation from template.')
            self.print_usage()
            sys.exit(2)
        
        if self.outputFile is None:
            self.outputFile = 'new'
        
        self.outputFile, self.outputExtension = os.path.splitext(self.outputFile)
        if self.outputExtension == '':
            if self.generateTarget[0:4] == 'vhdl':
                self.outputExtension = libhdl_gen.VHDL_MOD_FILE_EXT
            elif self.generateTarget[0:7] == 'verilog':
                self.outputExtension = libhdl_gen.VLOG_MOD_FILE_EXT
            elif self.generateTarget[0:12] == 'systemverilog':
                self.outputExtension = libhdl_gen.SVLOG_MOD_FILE_EXT
            else:
                self.outputExtension = 'out'
        
        if self.tagDefFileName is None:
            self.tagDefFileName = None
        
        # Get requested template.
        try:
            self.fdr = open(os.path.join(self.templatePath, self.templateDirs[self.generateTarget],
                self.templateModules[self.generateTarget]), 'r')
        except Exception as e:
            raise
        
        self.template = self.fdr.read()
        
        if not self.fdr.closed:
            self.fdr.close()
        
        print(3*libhdl_gen.ODL + " Getting tag definitions from file.")
        if self.tagDefFileName is not None:
            self.tagDef = self.read_config(self.tagDefFileName)
        print(self.tagDef)
        
        print(3*libhdl_gen.ODL + " Replacing tags by replacement strings.")
        self.template = self.replace_tags(self.template, self.tagDef)
        print(self.template)
        
        # Write output to file.
        try:
            self.fdw = open(self.outputFile, 'w')
        except Exception as e:
            raise
        
        self.fdw.write(self.template)
        
        if not self.fdr.closed:
            self.fdr.close()
        
        print(3*libhdl_gen.ODL + " Done")
    
    def read_config(self, tagDefFileName):
        """
        Read a tag definition file given by tagDefFileName which contains
        tag strings and replacement strings delimited by libhdl.TDL.
        Return a dictionary with pairs of tag strings and replacement strings. 
        """
        tagDef = {}
        try:
            tdfr = open(tagDefFileName, 'r')
        except Exception as e:
            raise
        for line in tdfr:
            line = line.strip()
            if line == '':
                continue
            tagStr, replStr = line.split(libhdl_gen.TDL)
            if tagStr in tagDef.keys():
                print("Warning: tag {0} is defined more than once.".format(tagStr))
            else:
                tagDef[tagStr] = replStr
        if not tdfr.closed:
            tdfr.close()
        return tagDef
    
    def replace_tags(self, text, tagDef):
        """
        Within the string text, replace all tags given in tagDef by their
        corresponding replacement string.
        """
        for tag, s in tagDef.items():
            s = s.strip()
            text = text.replace(tag, s)
        return text
    
    def print_usage(self):
        """Print help text on how to use libhdl_gen."""
        print(3*self.ODL)
        print('Usage: {0} -g TARGET [-o] [-h]'.format(sys.argv[0]))
        print(4*' '+'-h, --help : print this help text.')
        print(4*' '+'-g, --generate : generate file from template.')
        print(4*' '+'-o, --outputFile : write output to this file.')
        print('')
        print(4*' '+'TARGET : vhdl-{1987, 1993, 2008}, verilog-{1995, 2001, 2005}, systemverilog-{2005, 2009, 2012}')
        print(3*self.ODL)

if __name__ == '__main__':
    L = libhdl_gen()
    L.main()
else: # if __name == '__main__'
    print("Initializing module.")
