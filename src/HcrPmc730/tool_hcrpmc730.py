#
# Rules to build HcrPmc730 class and export it (and its header) as a tool
#
import os

tools = Split("""
    archive_xmlrpc_c
    logx
    pmc730
""")
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
HcrPmc730.cpp
HcrPmc730Status.cpp
''')

headers = Split('''
HcrPmc730.h
HcrPmc730Status.h
''')
lib = env.Library('hcrpmc730', sources)

doxref = env.Apidocs(sources + headers)
    
def hcrpmc730(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.AppendUnique(LIBS = [lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('hcrpmc730')
