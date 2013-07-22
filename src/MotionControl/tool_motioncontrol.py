#
# Rules to build libmotioncontrolrpcclient.a and export it as a SCons tool
#
tools = Split('''
    cmigits
    doxygen
    logx
    qt4
    xmlrpc_client++
''')
motionControlDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(['QtCore', 'QtNetwork'])

sources = Split('''
    ElmoServoDrive.cpp
    MotionControl.cpp
    MotionControlRpcClient.cpp
''')

headers = Split('''
    ElmoServoDrive.h
    MotionControl.h
    MotionControlRpcClient.h
''')

lib = env.Library('motioncontrol', sources)
Default(lib)

def motioncontrol(env):
    env.AppendUnique(CPPPATH = motionControlDir)
    env.Append(LIBS=[lib])
    env.Require(tools)

Export('motioncontrol')


