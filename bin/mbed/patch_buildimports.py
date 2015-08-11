"""
Monkey Patch script for mbed build imports
"""

# Setup the Import Hooks to override certain modules like targets
# http://stackoverflow.com/questions/3012473/how-do-i-override-a-python-import
# http://xion.org.pl/2012/05/06/hacking-python-imports/

# The below tricks the original script into loading python files from this directory
# instead of the original workspace_tools one like private_settings.py

import sys, os, imp

# The current root directory
ROOT = os.path.abspath(os.path.dirname(__file__))

class ImportOverride(object):
    def __init__(self, *args):
        self.module_names = args[0]
 
    def find_module(self, fullname, path=None):
        tmptuple = [item for item in self.module_names if item[0] == fullname]
        if tmptuple != []:
            self.path = path
            return self
        return None

    def load_module(self, name):
        if name in sys.modules:
            return sys.modules[name]
        tmptuple = [item for item in self.module_names if item[0] == name][0]
        filename = tmptuple[1]
        filepath = os.path.join(ROOT, filename)
        module = imp.load_source(name,filepath)
        sys.modules[name] = module
        return module

# Specify which modules to override with the ones located within this mbed directory
MODULE_OVERRIDES = (
    ('workspace_tools.private_settings', 'private_settings.py'),
    ('workspace_tools.paths', 'private_paths.py'),
    ('workspace_tools.targets', 'private_targets.py'),
);
sys.meta_path.append(ImportOverride(MODULE_OVERRIDES))
