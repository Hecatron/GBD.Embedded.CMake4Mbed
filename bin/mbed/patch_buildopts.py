"""
Monkey Patch script for mbed build options
"""

# The below script
# 1. Tricks the option parser into accepting additional options such as the build output directory

import workspace_tools.options

# Override the options parser within mbed
class MbedOptionsOverride(object):

    def newoptparse(self):
        parser = self.oldfunc()

        # Add some of our own options
        # This is just to avoid option parser from bombing out
        # when it sees options it doesn't recognise
        parser.add_option("--builddir",
            help="Build Directory Output")
        return parser

    def __init__(self):
        self.oldfunc = workspace_tools.options.get_default_options_parser
        workspace_tools.options.get_default_options_parser = self.newoptparse
        return

# Patch the Options Parser
OptsOverride = MbedOptionsOverride()

