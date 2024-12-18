#
# Rules to build HcrPmc730Client class and export it (and its header) as a tool
#
import os

tools = Split("""
    hcrpmc730
    logx
    boost_serialization
    operationmode
    qtcore
    qtnetwork
    xmlrpc_client++
""")
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
HcrPmc730Client.cpp
HcrPmc730StatusWorker.cpp
''')

headers = Split('''
HcrPmc730Client.h
HcrPmc730StatusWorker.h
''')
lib = env.Library('hcrpmc730client', sources)

#doxref = env.Apidocs(sources + headers)
    
def hcrpmc730client(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.Append(LIBS = [lib])
#    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('hcrpmc730client')
