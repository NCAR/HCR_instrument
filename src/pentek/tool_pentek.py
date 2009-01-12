import os


PENTEK_ROOT = os.environ['PENTEK_ROOT']
PENTEK_INCLUDE = PENTEK_ROOT+'/include'

tools = []
env = Environment(tools = ['default'] + tools)

def pentek(env):
    env.AppendUnique(CPPPATH   =[PENTEK_INCLUDE,])
    env.AppendUnique(CPPDEFINES=['PENTEK_LINUX',])
    env.Require(tools)

Export('pentek')

libsources = Split("""
p7142.cpp
""")

libpentek = env.Library('pentek', libsources)

Default(libpentek)
