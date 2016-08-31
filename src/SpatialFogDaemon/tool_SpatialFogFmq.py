#
# Rules to build libspatialfogfmq.a and export it as a SCons tool
#
tools = Split('''
    archive_xmlrpc_c
    doxygen
    lrose
    qt4
''')
toolDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(['QtCore'])

sources = Split('''
    SpatialFogDaemonRpcClient.cpp
    SpatialFogFmq.cpp
    SpatialFogFmqWatcher.cpp
    SpatialFogStatus.cpp
    SpatialFogStatusThread.cpp
''')

headers = Split('''
    SpatialFogDaemonRpcClient.h
    SpatialFogFmq.h
    SpatialFogFmqWatcher.h
    SpatialFogStatus.h
    SpatialFogStatusThread.h
''')

lib = env.Library('SpatialFogFmq', sources)
Default(lib)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "SpatialFogFmq library" })
doxref = env.Apidocs(sources + headers)

def SpatialFogFmq(env):
    env.AppendUnique(CPPPATH = toolDir)
    env.Append(LIBS=[lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('SpatialFogFmq')
