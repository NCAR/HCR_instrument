#
# Rules to build HcrPmc730 class and export it (and its header) as a tool
#
import os

tools = Split("""
    pmc730
    logx
    boost_serialization
""")
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
HcrPmc730.cpp
''')

headers = Split('''
HcrPmc730.h
''')
lib = env.Library('hcrpmc730', sources)

doxref = env.Apidocs(sources + headers)
    
def hcrpmc730(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.AppendUnique(LIBS = [lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('hcrpmc730')
