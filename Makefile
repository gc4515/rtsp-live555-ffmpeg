PLATFORM=linux_x64
DEBUG=YES

ifeq ($(PLATFORM), linux_x64)
CROSS_COMPILE:=
else
CROSS_COMPILE:=arm-linux-
endif
CXX=${CROSS_COMPILE}g++

ifeq ($(DEBUG), YES)
CXXFLAGS += -Wall -g
endif


INCLUDE_DIRS += -I./include -I/usr/local/include
INCLUDE_DIRS += -I/usr/local/include/BasicUsageEnvironment -I/usr/local/include/groupsock -I/usr/local/include/liveMedia -I/usr/local/include/UsageEnvironment

#live555 lib 链接顺序不能变
LIBRARYS += -L /usr/local/lib -lliveMedia -lgroupsock -lUsageEnvironment -lBasicUsageEnvironment
LIBRARYS += -L /usr/local/lib -lopencv_core -lopencv_highgui -lopencv_imgproc -lavcodec -lavutil -lswscale -lavformat

LINKFLAGS := 

CXXFLAGS += -o2 -std=gnu++11 -fPIC -Wdeprecated-declarations -pthread

CxxSources := $(shell find -iname *.cpp)
  
Objs := ${CxxSources:.cpp=.o}

Deps := ${Objs:.o=.d}

INC := -I include

TARGET := openRtsp

.PHONY: all clean

all: $(Objs)
	$(CXX) $(CXXFLAGS) $(LINKFLAGS) -o $(TARGET) $^ $(LIBRARYS)

sinclude $(Deps)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(INCLUDE_DIRS) -MM -MT $@ -MF $(patsubst %.o, %.d, $@) $<
	$(CXX) -c $(INCLUDE_DIRS) $(CXXFLAGS) $< -o $@	

clean:
	rm -rf $(Deps) $(Objs) $(TARGET)




