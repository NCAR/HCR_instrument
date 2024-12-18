#
# Rules to build fireflydRpcClient class and export it (and its header) as a tool
#
import os

tools = Split("""
    logx
    FireFlyWorker
    xmlrpc_client++
    boost_serialization
""")
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
fireflydRpcClient.cpp
''')
lib = env.Library('fireflydrpcclient', sources)
    
def fireflydRpcClient(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.Append(LIBS = [lib])
    env.Require(tools)

Export('fireflydRpcClient')
