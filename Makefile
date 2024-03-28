#*** check basic make file for basic understanding, although that willnot run here actually***#
#***please go through targets before variable for learning ***#

#VARIABLES
## variable can only be string
## single or double quotes for variable names does not required. by default string
## always put the variable on the top even before any target in makefile


## CC: c program compiler , gcc
#CXX: cpp program compiler , g++
#CFLAGS: extra flags to give c compiler
#CPPFLAGS: extra flags to give c++ compiler
####CPPFLAGS: extra flag to give the C preprocessor
#LDFLAGS: extra flag to give to the linker

#################
#VARIABLES
#################
INCLUDE_DIR = inc
SOURCE_DIR = src
BUILD_DIR = build

CXX_STANDARD = c++17
CC = gcc
CXX = g++
CXXFLAGS = -Wall -Wextra -Wpedantic -std=$(CXX_STANDARD) -g -O3
#all -W are some warning
LDFLAGS = -lmath
CPPFLAGS = -I $(INCLUDE_DIR)
#let say c++ inbuilt math lib is a dependant one
#all above variable are make predefined variable

#steps to create new user defined variable
COMPILER_CALL = $(CXX) $(CXXFLAGS) $(CPPFLAGS)
#it is actually -> g++ -Wall -Wextra -Wpedantic -std=c++17 -I inc
#by using $() we can reuse or call any variable in linux
#####we can over written any variable value while trigger make command , along with that pasing variable , eg make CXX_STANDARD=c++14


#instead of manually write commands for each make.o we can use a pattern

#CXX_SOURCES = $(wildcard $(SOURCE_DIR)/*.cpp)
CXX_OBJECTS = $(BUILD_DIR)/main.o \
			  $(BUILD_DIR)/helloworld.o
#CXX_OBJECTS = $(patsubst $(SOURCE_DIR)/%.cpp , $(BUILD_DIR)/%.o , $(CXX_SOURCES))

#???????if we use patsubst it is directly creating main execulable file. no objectfile is getting created

#***we can replace CXX_OBJECTS as ->  $(patsubst %.cpp , %.o , $(CXX_SOURCES))  -> it is nothing but a for loop which will go .cpp listed in CXX_SOURCES and replace .cpp with .o and create CXX_OBJECTS


#CXX_OBJECTS is the list of dependancy objectfile. so 1st it will get main.o in the list and will go to execute that command
#and that will be find in the form of the pattern written below.
#so the pattern will create main.o	

#TARGETS

#pattern -> target: prerequisites -> then commands
# -c is used to build object file , here main.o
# -o is used to create executable. here used to link the object file with executable
#prerequisites are the files name (eg: object files) and seperated by space. these files need to be present before the make targer command run 

#"build: main.o helloworld.o"  -> here we have added the prerequisits files needed. main.o, helloworld.o . but this does not mean these two object file will be created.
#instead it will call two dependencies command main.o and helloworld.o where the files will be createed.

###build(target): main.o helloworld.o (prerequisites/dependancy) g++ main.o helloworld.o -o main(command)


###################
#TARGETS
####################
all: create build

create:
	mkdir -p build

build: $(CXX_OBJECTS)
	$(COMPILER_CALL) $(CXX_OBJECTS) -o $(BUILD_DIR)/main
#here also we have declared the dependancy in the form of :$(CXX_OBJECTS)

execute:
	./$(BUILD_DIR)/main

clean:
	rm -rf build



# steps to run make
# "make" use this command to trigger the build
#build and execute, clean are the traget here. 
# so we can specify with "make build" or "make execute" to run a specific sets of command

################
#PATTERNS
################
# $@: file name of the target
# $<: name of the dependency
# $^: name of all prerequisites

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.cpp
	$(COMPILER_CALL) -c $< -o $@

#how it works
# %o:%cpp -> make will go through all .cpp file in this folder one by one and will run the command and will generate respective .o file
# $(COMPILER_CALL) -c $< -o $@ -> this is actually -> g++ -c helloworld.cpp -o helloworld.o



