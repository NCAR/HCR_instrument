#
# Rules to build libcmigits.a and export it as a SCons tool
#

tools = ['doxygen', 'logx', 'qt4']
env = Environment(tools=['default'] + tools)
env.EnableQt4Modules(['QtCore', 'QtGui', 'QtNetwork'])


tooldir = env.Dir('.').srcnode().abspath    # this directory

# The library and header files will live in this directory.
libDir = tooldir
includeDir = tooldir

sources = Split('''
    cmigitsDaemon.cpp
    Cmigits.cpp
    CmigitsSharedMemory.cpp
''')

headers = Split('''
    Cmigits.h
    CmigitsSharedMemory.h
''')

lib = env.Library('cmigits', sources)
Default(lib)

daemon = env.Program('cmigitsDaemon', sources)
Default(daemon)

html = env.Apidocs(sources + headers, DOXYFILE_DICT={'PROJECT_NAME':'cmigits'})
Default(html)

def cmigits(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.AppendUnique(LIBS = [lib])
    env.Require(tools)

Export('cmigits')
