import os

tools = []

PENTEK_ROOT = os.environ['PENTEK_ROOT']

PENTEK_INCLUDE = PENTEK_ROOT+'/include'

def pentek(env):
    env.AppendUnique(CPPPATH   =[PENTEK_INCLUDE,])
    env.AppendUnique(CPPDEFINES=['PENTEK_LINUX',])
    env.Require(tools)

Export('pentek')
