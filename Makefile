### Generated by Winemaker 0.8.4
###
### Invocation command line was
### /usr/bin/winemaker --wine32 . --nosource-fix --dll -Isteam


SRCDIR                = .
SUBDIRS               =
LIBS                  =
EXES                  =



### Common settings
ARCH                  ?= 32
NOTUNE                ?= 0
ifeq ($(ARCH), 64)
  LIB_POSTFIX = 64
else
  LIB_POSTFIX =
endif
ifeq ($(NOTUNE), 1)
  NOTUNEOPT = -march=i386 -mtune=i386
else
  NOTUNEOPT =
endif
DLLS                  = steam_api$(LIB_POSTFIX).dll
CEXTRA                = -mno-cygwin \
			-m$(ARCH)
CXXEXTRA              = -m$(ARCH) -fpermissive -Wno-attributes \
                        $(NOTUNEOPT)
RCEXTRA               =
DEFINES               =  \
			-D__WINESRC__ \
			-DVERSION_SAFE_STEAM_API_INTERFACES \
			-DUSE_BREAKPAD_HANDLER
INCLUDE_PATH          = -Isteam \
			-I. \
			-Iautoclass
DLL_PATH              =
DLL_IMPORTS           =
LIBRARY_PATH          = -L.
LIBRARIES             = -lsteam_api$(LIB_POSTFIX)


### steam_api.dll sources and settings

steam_api_dll_MODULE  = steam_api$(LIB_POSTFIX).dll
steam_api_dll_C_SRCS  =
steam_api_dll_CXX_SRCS= steam_api.cpp callbacks.cpp
steam_api_dll_RC_SRCS =
steam_api_dll_LDFLAGS = -shared \
			steam_api.auto.spec \
			-mno-cygwin \
			-m$(ARCH)
steam_api_dll_ARFLAGS =
steam_api_dll_DLL_PATH=
steam_api_dll_DLLS    = odbc32 \
			ole32 \
			oleaut32 \
			winspool \
			odbccp32
steam_api_dll_LIBRARY_PATH=
steam_api_dll_LIBRARIES= uuid

steam_api_dll_OBJS    = $(steam_api_dll_C_SRCS:.c=.o) \
			$(steam_api_dll_CXX_SRCS:.cpp=.o) \
			$(steam_api_dll_RC_SRCS:.rc=.res)
WRAPPER_CPPS = $(wildcard autoclass/*.cpp)
WRAPPERS = $(WRAPPER_CPPS:.cpp=.o)

### Global source lists

C_SRCS                = $(steam_api_dll_C_SRCS)
CXX_SRCS              = $(steam_api_dll_CXX_SRCS)
RC_SRCS               = $(steam_api_dll_RC_SRCS)

### Tools

CC = winegcc
CXX = wineg++
RC = wrc
AR = ar


### Generic targets

all: $(SUBDIRS) $(WRAPPERS) $(DLLS:%=%.so) $(LIBS) $(EXES)

clean-generated-code: clean
	$(RM) -f $(WRAPPER_CPPS) $(WRAPPER_CPPS:.cpp=.h) steam_api.auto.spec steam_api.cpp

generate-code: clean clean-generated-code build-codegen spec
	./codegenerator --spec=$(DLLS:.dll=.spec) -s=steam -t=autoclass

generate-test-code: clean clean-generated-code build-codegen spec
	./codegenerator --spec=$(DLLS:.dll=.spec) -s=steam -t=autoclass --testtarget=tests
build-codegen:
	nim c -o:codegenerator codegen/codegen.nim

spec:
	winedump spec $(DLLS)

### Build rules

.PHONY: all clean dummy

$(SUBDIRS): dummy
	@cd $@ && $(MAKE)

DEFINCL = $(INCLUDE_PATH) $(DEFINES) $(OPTIONS)
ifeq ($(MAKE_VERSION), 4.1)
# EXPLICIT RULES SPECIAL FOR make 4.1
%.o:
	$(CXX) -c $(CXXFLAGS) $(CXXEXTRA) $(DEFINCL) -o $@ $(@:.o=.cpp)
else
# Implicit rules
.SUFFIXES: .h.proto .cpp.proto .h .cpp .cxx .rc .res


.c.o:
	$(CC) -c $(CFLAGS) $(CEXTRA) $(DEFINCL) -o $@ $<

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(CXXEXTRA) $(DEFINCL) -o $@ $<

.cxx.o:# protos
	$(CXX) -c $(CXXFLAGS) $(CXXEXTRA) $(DEFINCL) -o $@ $<

.rc.res:
	$(RC) $(RCFLAGS) $(RCEXTRA) $(DEFINCL) -fo$@ $<

endif
# Rules for cleaning

CLEAN_FILES     = y.tab.c y.tab.h lex.yy.c core *.orig *.rej \
                  \\\#*\\\# *~ *% .\\\#*

clean:: $(SUBDIRS:%=%/__clean__) $(EXTRASUBDIRS:%=%/__clean__)
	$(RM) $(CLEAN_FILES) $(RC_SRCS:.rc=.res) $(C_SRCS:.c=.o) $(CXX_SRCS:.cpp=.o)
	$(RM) $(DLLS:%=%.so) $(LIBS) $(EXES) $(EXES:%=%.so)
	$(RM) $(WRAPPERS)

$(SUBDIRS:%=%/__clean__): dummy
	cd `dirname $@` && $(MAKE) clean

$(EXTRASUBDIRS:%=%/__clean__): dummy
	-cd `dirname $@` && $(RM) $(CLEAN_FILES)

### Target specific build rules
DEFLIB = $(LIBRARY_PATH) $(LIBRARIES) $(DLL_PATH) $(DLL_IMPORTS:%=-l%)

$(steam_api_dll_MODULE).so: $(steam_api_dll_OBJS) steam_api.auto.spec
	$(CXX) $(steam_api_dll_LDFLAGS) -o $@ $(WRAPPERS) $(steam_api_dll_OBJS) $(steam_api_dll_LIBRARY_PATH) $(steam_api_dll_DLL_PATH) $(DEFLIB) $(steam_api_dll_DLLS:%=-l%) $(steam_api_dll_LIBRARIES:%=-l%)


