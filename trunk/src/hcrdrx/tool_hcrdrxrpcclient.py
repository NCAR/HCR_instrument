#
# Rules to build HcrdrxRpcClient class and export it (and its header) as a tool
#
import os

tools = Split("""
    cmigits
    logx
    pentek
    pmc730
    xmlrpc
    boost_serialization
""")
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
DrxStatus.cpp
HcrdrxRpcClient.cpp
HcrPmc730.cpp
XmlRpcValueArchive.cpp
''')
lib = env.Library('hcrdrxrpcclient', sources)
    
def hcrdrxrpcclient(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.AppendUnique(LIBS = [lib])
    env.Require(tools)

Export('hcrdrxrpcclient')
