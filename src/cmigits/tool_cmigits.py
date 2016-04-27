#
# Rules to build libcmigits.a and export it as a SCons tool
#
tools = ['doxygen', 'logx', 'lrose', 'qt4', 'archive_xmlrpc_c']
qt4modules = ['QtGui', 'QtNetwork', 'QtCore']
cmigitsDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(qt4modules)

sources = Split('''
    Cmigits.cpp
    CmigitsFmq.cpp
    CmigitsFmqWatcher.cpp
    CmigitsStatus.cpp
''')

headers = Split('''
    Cmigits.h
    CmigitsFmq.h
    CmigitsFmqWatcher.h
    CmigitsStatus.h
''')

lib = env.Library('cmigits', sources)
Default(lib)

progEnv = env.Clone()
progEnv.Append(LIBS=[lib])
progEnv.Require(tools)
cmigitsFmqDump = progEnv.Program('cmigitsFmqDump', ['cmigitsFmqDump.cpp', 'FmqDumper.cpp'])
Default(cmigitsFmqDump)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "cmigits library" })
doxref = env.Apidocs(sources + headers)

def cmigits(env):
    env.AppendUnique(CPPPATH = cmigitsDir)
    env.Append(LIBS=[lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)
    env.EnableQt4Modules(qt4modules)

Export('cmigits')
