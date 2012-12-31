#
# Rules to build libcmigits.a and export it as a SCons tool
#
tools = ['doxygen', 'logx', 'qt4']
qt4modules = ['QtCore', 'QtGui']
cmigitsDir = Dir('.').abspath

def cmigits(env):
#    env.Append(LIBS=[env.GetGlobalTarget('libcmigits'),])
    env.AppendUnique(CPPPATH = cmigitsDir)
    env.AppendDoxref(doxref[0])
    env.Require(tools)
    env.EnableQt4Modules(qt4modules)

Export('cmigits')


env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(qt4modules)

sources = ['Cmigits.cpp', 'CmigitsSharedMemory.cpp']

headers = ['Cmigits.h',  'CmigitsSharedMemory.h']

cmlib = env.Library('cmigits', sources)
Default(cmlib)

env['DOXYFILE_DICT'].update({ "PROJECT_NAME" : "cmigits library" })
doxref = env.Apidocs(sources + headers)
