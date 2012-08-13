#
# Rules to build XmitdRpcClient class and export it (and its header) as a tool
#
import os

tools = ['xmlrpc']
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

lib = env.Library('xmitdrpcclient', 'XmitdRpcClient.cpp')
    
def xmitdrpcclient(env):
    env.Require(tools)
    env.AppendUnique(CPPPATH = [includeDir])
    env.AppendUnique(LIBS = [lib])

Export('xmitdrpcclient')
