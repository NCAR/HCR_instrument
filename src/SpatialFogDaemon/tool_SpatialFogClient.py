#
# Rules to build assorted classes for SpatialFog clients into
# libSpatialFogClient.a and export it as a SCons tool
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

lib = env.Library('SpatialFogClient', sources)
Default(lib)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "SpatialFogClient library" })
doxref = env.Apidocs(sources + headers)

def SpatialFogClient(env):
    env.AppendUnique(CPPPATH = toolDir)
    env.Append(LIBS=[lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('SpatialFogClient')
