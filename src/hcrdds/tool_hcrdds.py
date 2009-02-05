#
# Rules to build hcrdds and export it as a SCons tool
#
import os

tools = ['ddssvc','hcrtypes','doxygen']

env = Environment(tools = ['default'] + tools)

libsources = Split("""
""")

headers = Split("""
TSReader.h
TSWriter.h
""")

#libhcrdds = env.Library('hcrdds', libsources)

html = env.Apidocs(libsources + headers, DOXYFILE_FILE = "Doxyfile")

#Default(libhcrdds, html)
Default(html)

def hcrdds(env):
    env.AppendUnique(CPPPATH = ['#/hcrdds',])
    env.Require(tools)

Export('hcrdds')

