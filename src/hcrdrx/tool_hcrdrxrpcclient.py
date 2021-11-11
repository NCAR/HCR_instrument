#
# Build HcrdrxRpcClient class and export it (and its header) as a tool
#
import os

tools = Split("""
    archive_xmlrpc_c
    boost_serialization
    hcrpmc730client
    logx
    lrose
    motioncontrol
    Pentek_xx821
    qt5
    qtcore
    xmitdrpcclient
    xmlrpc_client++
""")
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
DrxStatus.cpp
HcrdrxRpcClient.cpp
''')
headers = Split('''
DrxStatus.h
''')
lib = env.Library('hcrdrxrpcclient', sources)
    
def hcrdrxrpcclient(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.AppendUnique(LIBS = [lib])
    env.Require(tools)

Export('hcrdrxrpcclient')
