#
# Rules to build FireFly and FireFlyStatus classes and export them (and 
# their headers) as a tool
#
import os

tools = Split("""
    archive_xmlrpc_c
    boost
    logx
    pmc730
    qt4
""")
env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(['QtCore'])

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
FireFly.cpp
FireFlyStatus.cpp
''')

headers = Split('''
FireFly.h
FireFlyStatus.h
''')
lib = env.Library('firefly', sources)

dox = env.Apidocs(sources + headers)
Default(dox)
    
# By default, env.Apidocs() will put its generated documentation in a directory
# named the same as this one.
doxdir = os.path.basename(tooldir)
    
def FireFly(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.AppendUnique(LIBS = [lib])
    env.AppendDoxref(doxdir)
    env.Require(tools)

Export('FireFly')
