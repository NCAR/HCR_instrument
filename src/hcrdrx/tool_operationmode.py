#
# Build OperationMode class and export it (and its header) as a tool
#
import os

tools = Split("""
    archive_xmlrpc_c
    boost_serialization
""")
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
OperationMode.cpp
''')
headers = Split('''
OperationMode.h
''')
lib = env.Library('operationmode', sources)
    
def operationmode(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.Append(LIBS = [lib])
    env.Require(tools)

Export('operationmode')
