#
# Rules to build libhcrexecutiveclient.a containing stuff used by both
# HcrExecutive and its RPC clients, and export it as a SCons tool

tools = Split('''
hcrdrxrpcclient
hcrpmc730client
doxygen
motioncontrol
operationmode
qt5
''')

toolDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)

# Create the CanFestival object dictionary implementation files ElmoMasterNode.c
# and ElmoMasterNode.h from ElmoMasterNode.od
env.canfestivalObjdictImpl('ElmoMasterNode.od')

sources = Split('''
    ApsControl.cpp
    HcrExecutiveRpcClient.cpp
    HcrExecutiveStatus.cpp
    HcrExecutiveStatusThread.cpp
    TransmitControl.cpp
''')

headers = Split('''
    ApsControl.h
    HcrExecutiveRpcClient.h
    HcrExecutiveStatus.h
    HcrExecutiveStatusThread.h
    TransmitControl.h
''')

lib = env.Library('hcrexecutiveclient', sources)
Default(lib)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "HcrExecutive client library" })
doxref = env.Apidocs(sources + headers)

def hcrexecutiveclient(env):
    env.AppendUnique(CPPPATH = toolDir)
    env.Append(LIBS=[lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('hcrexecutiveclient')
