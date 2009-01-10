#
# Rules to build ddslib and export it as a SCons tool
#
tools = ['opendds', 'doxygen']
env = Environment(tools = ['default'] + tools)

libHcrDds, sources, headers = env.DdsLibrary('ProfilerDds.idl', env)

html = env.Apidocs(sources + headers, DOXYFILE_FILE = "#/Doxyfile")

Default([libHcrDds, html])

# Actually define and export the ddslib tool
def ddslib(env):
    env.AppendLibrary('ProfilerDds')
    env.AppendDoxref('ProfilerDds')
    env.AppendUnique(CPPPATH = ['#/ddslib',])
    env.Require(tools)
    
Export('ddslib')
