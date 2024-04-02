#
# Build a library of classes shared by hcrdrx and its clients and export it
# as a tool
#
import os

tools = Split("""
    archive_xmlrpc_c
    boost_serialization
    cmigits
    drxstatus
    logx
    lrose
    motioncontrol
    operationmode
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
HcrdrxRpcClient.cpp
''')
headers = Split('''
HcrdrxRpcClient.h
''')
lib = env.Library('hcrdrxrpcclient', sources)
    
def hcrdrxrpcclient(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.Append(LIBS = [lib])
    env.Require(tools)

Export('hcrdrxrpcclient')
