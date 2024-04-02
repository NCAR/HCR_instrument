#
# Build DrxStatus class and export it (and its header) as a tool
#
import os

tools = Split("""
    boost_serialization
    cmigits
    hcrpmc730
    logx
    lrose
    motioncontrol
    operationmode
    Pentek_xx821
""")
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory

sources = Split('''
DrxStatus.cpp
''')
headers = Split('''
DrxStatus.h
''')
lib = env.Library('drxstatus', sources)
    
def drxstatus(env):
    env.AppendUnique(CPPPATH = [tooldir])
    env.Append(LIBS = [lib])
    env.Require(tools)

Export('drxstatus')
