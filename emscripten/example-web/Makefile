# gather source list (for compile)
SOURCES = $(shell find src -name "*.cpp")

# create object and dependency lists (for link)
OBJECTS = $(patsubst src/%.cpp, out/obj/%.o, $(SOURCES))

# compile & link options
CFLAGS = 
LFLAGS = --no-entry -s EXPORTED_FUNCTIONS='["_add"]'

CC = em++

all :
	$(MAKE) $(MAKEFLAGS) out/example-web.js

# link executable
out/example-web.js : out/obj/main.o
	@test -d $(@D) || mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ $^ $(LFLAGS)

# compile all sources
out/obj/%.o : src/%.cpp
	@test -d $(@D) || mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ -c $<

clean :
	rm -rf out pch

# $@ : The target of the current rule.
# $< : The first dependency of the target.
# $^ : All the dependencies of the target.
# $(@D) : The directory part of the target, with the trailing slash removed.
