CXX := g++

INCLUDE_DIRS += -I./include
INCLUDE_DIRS += -I/usr/local/include
INCLUDE_DIRS += -I/usr/local/include/BasicUsageEnvironment
INCLUDE_DIRS += -I/usr/local/include/groupsock
INCLUDE_DIRS += -I/usr/local/include/liveMedia
INCLUDE_DIRS += -I/usr/local/include/UsageEnvironment


LINKFLAGS := 

#live555 lib 链接顺序不能变
LIBRARYS += -L /usr/local/lib -lliveMedia -lgroupsock -lUsageEnvironment -lBasicUsageEnvironment 
LIBRARYS += -L /usr/local/lib -lopencv_core -lopencv_highgui -lopencv_imgproc -lavcodec -lavutil -lswscale -lavformat 
LIBRARYS += -L /usr/lib -pthread
 
CXXFLAGS := -Wall -g -std=gnu++11 -fPIC -Wdeprecated-declarations
 
SRCS :=  ./src/main.cpp \
		./src/rtsp_client.cpp \
		./src/ffmpeg_h264.cpp
	
 
OBJS := ${SRCS:.cpp=.o}

BIN_NAME := openRtsp

all: $(BIN_NAME)

$(BIN_NAME) : $(OBJS) 
	$(CXX) $(CXXFLAGS) $(LINKFLAGS) -o $(BIN_NAME) $^ $(LIBRARYS) 

./src/%.o: ./src/%.cpp
	$(CXX) -c $(INCLUDE_DIRS) $(CXXFLAGS) $< -o $@
	
clean:
	rm -rf ./src/*.o  $(BIN_NAME)
