#
# Rules to build libcmigits.a and export it as a SCons tool
#

tools = ['doxygen', 'logx']
env = Environment(tools=['default'] + tools)

tooldir = env.Dir('.').srcnode().abspath    # this directory

# The library and header files will live in this directory.
libDir = tooldir
includeDir = tooldir

sources = Split('''
    Cmigits.cpp
    CmigitsMessage.cpp
''')

headers = Split('''
    Cmigits.h
    CmigitsMessage.h
''')

lib = env.Library('cmigits', sources)
Default(lib)

html = env.Apidocs(sources + headers, DOXYFILE_DICT={'PROJECT_NAME':'cmigits'})
Default(html)
    
def cmigits(env):
    env.Require(tools)
    env.AppendUnique(CPPPATH = [includeDir])
    env.AppendUnique(LIBS = [lib])

Export('cmigits')
