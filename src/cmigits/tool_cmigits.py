#
# Rules to build libcmigits.a and export it as a SCons tool
#
tools = ['doxygen', 'logx', 'qt4', 'rapradar', 'archive_xmlrpc_c']
qt4modules = ['QtGui', 'QtNetwork', 'QtCore']
cmigitsDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(qt4modules)

sources = Split('''
    Cmigits.cpp
    CmigitsSharedMemory.cpp
    CmigitsStatus.cpp
    CmigitsShmWatchThread.cpp
''')

headers = Split('''
    Cmigits.h
    CmigitsSharedMemory.h
    CmigitsStatus.h
    CmigitsShmWatchThread.h
''')

lib = env.Library('cmigits', sources)
Default(lib)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "cmigits library" })
doxref = env.Apidocs(sources + headers)

def cmigits(env):
    env.AppendUnique(CPPPATH = cmigitsDir)
    env.Append(LIBS=[lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)
    env.EnableQt4Modules(qt4modules)

Export('cmigits')
