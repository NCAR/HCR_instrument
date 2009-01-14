#
# Rules to build ddslib and export it as a SCons tool
#
tools = ['opendds', 'doxygen']
env = Environment(tools = ['default'] + tools)

lib, sources, headers = env.DdsLibrary('hcrtypes.idl', env)

html = env.Apidocs(sources + headers, DOXYFILE_FILE = "#/Doxyfile")

Default([lib, html])

# Actually define and export the hcrddstypes tool
def hcrtypes(env):
    env.AppendUnique(CPPPATH = ['#/hcrtypes',])
    env.AppendLibrary('hcrtypes')
    env.Require(tools)

Export('hcrtypes')
