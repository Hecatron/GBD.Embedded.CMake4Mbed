"""
Common code for overriding the python modules within mbed
"""

import imp
import sys
import os
import logging
from os.path import join, abspath, dirname

# Modify the paths to include the original mbed deps directories
sys.path.append(os.path.abspath("../../deps/mbed"))
sys.path.append(os.path.abspath("../../deps/mbed/workspace_tools"))

# The override root directory (parent of script)
OVERRIDE_ROOT = abspath(join(dirname(__file__), ".."))

# Setup the Import Hooks to override certain modules like targets
# http://stackoverflow.com/questions/3012473/how-do-i-override-a-python-import
# http://xion.org.pl/2012/05/06/hacking-python-imports/
# Having a __init__.py in this directory stops python for searching for modules in the original mbed workspace_tools directory
class ImportOverride(object):
    def __init__(self, *args):
        self.module_names = args[0]
 
    def find_module(self, fullname, path=None):
        if fullname in self.module_names:
            self.path = path
            return self
        return None

    def load_module(self, name):
        if name in sys.modules:
            return sys.modules[name]
        filepath = join(OVERRIDE_ROOT,str.replace(name,".",os.path.sep)) + ".py"
        module = imp.load_source(name,filepath)
        sys.modules[name] = module
        return module

# Specify which modules to override with the ones located within this workspace_tools directory
MODULE_OVERRIDES = (
    'workspace_tools.targets',
    'workspace_tools.paths',
	'workspace_tools.private_settings',
);
sys.meta_path.append(ImportOverride(MODULE_OVERRIDES))
