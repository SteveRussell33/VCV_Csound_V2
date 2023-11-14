RACK_DIR ?= ../..

CSOUND_INCLUDE ?= C:/_Projects/Csound6/include
CSOUND_LIBRARY ?= C:/_Projects/Csound6/lib
	
FLAGS +=
CFLAGS +=
CXXFLAGS +=

include $(RACK_DIR)/arch.mk

# linking to libraries
ifeq ($(ARCH_OS), win)
	FLAGS += -g -w -DUSE_DOUBLE
	CXXFLAGS += -I$(CSOUND_INCLUDE)
	LDFLAGS += -L$(CSOUND_LIBRARY) -lcsound64 #-lcsnd6
else ifeq ($(ARCH_OS), mac)
	CXXFLAGS += -I /Library/Frameworks/CsoundLib64.framework/Versions/6.0/Headers 
	LDFLAGS += -F /Library/Frameworks/ -framework CsoundLib64 -rpath
else ifeq ($(ARCH_OS), lin)
	CXXFLAGS += -I /usr/local/include/csound
	LDFLAGS += -L /usr/local/lib/ -lcsound64
endif

SOURCES += $(wildcard src/*.cpp)

DISTRIBUTABLES += $(wildcard LICENSE*) res csd samples

include $(RACK_DIR)/plugin.mk
