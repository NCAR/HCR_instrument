#
# Rules to build hcrdds and export it as a SCons tool
#
import os

tools = ['ddssvc','hcrtypes','doxygen']
env = Environment(tools = ['default'] + tools)
qt4modules = ['QtCore',]
env.EnableQt4Modules(qt4modules)

libsources = Split("""
QtTSReader.cpp
""")

headers = Split("""
QtTSReader.h
TSReader.h
TSWriter.h
""")

libhcrdds = env.Library('hcrdds', libsources)

html = env.Apidocs(libsources + headers, DOXYFILE_FILE = "Doxyfile")

Default(libhcrdds, html)

def hcrdds(env):
    env.AppendUnique(CPPPATH = ['#/hcrdds',])
    env.AppendLibrary('hcrdds')
    env.AppendDoxref('hcrdds')
    env.Require(tools)

Export('hcrdds')

