#
# Rules to build libmotioncontrolrpcclient.a and export it as a SCons tool
#
tools = Split('''
    canfestival
    cmigits
    doxygen
    logx
    qt4
    SpatialFogClient
    xmlrpc_client++
''')
motionControlDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(['QtCore', 'QtNetwork'])

# Create the CanFestival object dictionary implementation files ElmoMasterNode.c 
# and ElmoMasterNode.h from ElmoMasterNode.od
env.canfestivalObjdictImpl('ElmoMasterNode.od')

sources = Split('''
    CanElmoConnection.cpp
    ElmoConnection.cpp
    ElmoMasterNode.c
    ElmoServoDrive.cpp
    MotionControl.cpp
    MotionControlRpcClient.cpp
    MotionControlStatusThread.cpp
    TtyElmoConnection.cpp
''')

headers = Split('''
    CanElmoConnection.h
    ElmoConnection.h
    ElmoMasterNode.h
    ElmoServoDrive.h
    MotionControl.h
    MotionControlRpcClient.h
    MotionControlStatusThread.h
    RotServoDrive.h
    TiltServoDrive.h
    TtyElmoConnection.h
''')

lib = env.Library('motioncontrol', sources)
Default(lib)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "motion control library" })
doxref = env.Apidocs(sources + headers)

def motioncontrol(env):
    env.AppendUnique(CPPPATH = motionControlDir)
    env.Append(LIBS=[lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('motioncontrol')


