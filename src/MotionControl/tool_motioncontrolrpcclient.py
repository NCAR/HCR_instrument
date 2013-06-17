#
# Rules to build libmotioncontrolrpcclient.a and export it as a SCons tool
#
tools = ['doxygen', 'logx', 'xmlrpc_client++']
motionControlDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)

sources = ['MotionControlRpcClient.cpp']

headers = ['MotionControlRpcClient.h']

lib = env.Library('motioncontrolrpcclient', sources)
Default(lib)

def motioncontrolrpcclient(env):
    env.AppendUnique(CPPPATH = motionControlDir)
    env.Append(LIBS=[lib])
    env.Require(tools)

Export('motioncontrolrpcclient')


