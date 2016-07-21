#
# Rules to build libspatialfogfmq.a and export it as a SCons tool
#
tools = Split('''
    doxygen
    lrose
    qt4
''')
toolDir = Dir('.').abspath

env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(['QtCore'])

sources = Split('''
    SpatialFogFmq.cpp
''')

headers = Split('''
    SpatialFogFmq.h
''')

lib = env.Library('SpatialFogFmq', sources)
Default(lib)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "SpatialFogFmq library" })
doxref = env.Apidocs(sources + headers)

def SpatialFogFmq(env):
    env.AppendUnique(CPPPATH = toolDir)
    env.Append(LIBS=[lib])
    env.AppendDoxref(doxref[0])
    env.Require(tools)

Export('SpatialFogFmq')
