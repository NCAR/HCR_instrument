#
# Rules to build libmotioncontrolrpcclient.a and export it as a SCons tool
#
tools = Split('''
hcrpmc730client
cmigits
doxygen
motioncontrol
qt4
xmlrpc_client++
''')
motionControlDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(['QtCore'])

# Create the CanFestival object dictionary implementation files ElmoMasterNode.c 
# and ElmoMasterNode.h from ElmoMasterNode.od
env.canfestivalObjdictImpl('ElmoMasterNode.od')

sources = Split('''
    ApsControl.cpp
    HcrMonitorStatus.cpp
    TransmitControl.cpp
    TransmitControlStatus.cpp
''')

headers = Split('''
    ApsControl.h
    HcrMonitorStatus.h
    TransmitControl.h
    TransmitControlStatus.h
''')

lib = env.Library('hcrmonitor', sources)
Default(lib)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "HcrMonitor library" })
doxref = env.Apidocs(sources + headers)

def hcrmonitor(env):
    env.AppendUnique(CPPPATH = motionControlDir)
    env.Append(LIBS=[lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('hcrmonitor')


