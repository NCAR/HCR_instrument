#
# Rules to build HcrPmc730Client class and export it (and its header) as a tool
#
import os

tools = Split("""
    hcrpmc730
    logx
    boost_serialization
    qt4
    xmlrpc_client++
""")
env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(['QtCore', 'QtNetwork'])

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
HcrPmc730Client.cpp
HcrPmc730StatusThread.cpp
''')

headers = Split('''
HcrPmc730Client.h
HcrPmc730StatusThread.h
HmcModeChange.h
''')
lib = env.Library('hcrpmc730client', sources)

#doxref = env.Apidocs(sources + headers)
    
def hcrpmc730client(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.AppendUnique(LIBS = [lib])
#    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('hcrpmc730client')
