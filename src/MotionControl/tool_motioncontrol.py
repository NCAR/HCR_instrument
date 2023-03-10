#
# Rules to build libmotioncontrolrpcclient.a and export it as a SCons tool
#
tools = Split('''
    canfestival
    cmigits
    doxygen
    logx
    qt5
    qtcore
    qtnetwork
    xmlrpc_client++
''')
motionControlDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)

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
    MotionControlStatusWorker.cpp
    TtyElmoConnection.cpp
''')

headers = Split('''
    CanElmoConnection.h
    ElmoConnection.h
    ElmoMasterNode.h
    ElmoServoDrive.h
    MotionControl.h
    MotionControlRpcClient.h
    MotionControlStatusWorker.h
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


