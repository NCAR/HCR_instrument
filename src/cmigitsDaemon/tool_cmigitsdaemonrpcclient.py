#
# Rules to build libcmigitsdaemonrpcclient.a and export it as a SCons tool
#
tools = Split('''
    doxygen
    logx
    xmlrpc_client++
    cmigits
    qt5
    qtcore
''')
cmigitsDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)

sources = Split('''
CmigitsDaemonRpcClient.cpp
CmigitsStatusThread.cpp
''')

headers = Split('''
CmigitsDaemonRpcClient.h
CmigitsStatusThread.h
''')

lib = env.Library('cmigitsdaemonrpcclient', sources)
Default(lib)

#env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "cmigitsdaemonrpcclient library" })
#doxref = env.Apidocs(sources + headers)

def cmigitsdaemonrpcclient(env):
    env.AppendUnique(CPPPATH = cmigitsDir)
    env.Append(LIBS=[lib])
#    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('cmigitsdaemonrpcclient')


