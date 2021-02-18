#
# Rules to build libhcrexecutive.a and export it as a SCons tool
#
tools = Split('''
hcrpmc730client
doxygen
motioncontrol
qt5
xmlrpc_client++
''')
hcrExecutiveDir = Dir('.').abspath

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

lib = env.Library('hcrexecutive', sources)
Default(lib)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "HcrExecutive library" })
doxref = env.Apidocs(sources + headers)

def hcrexecutive(env):
    env.AppendUnique(CPPPATH = hcrExecutiveDir)
    env.Append(LIBS=[lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('hcrexecutive')
