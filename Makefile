# Makefile for setwall 

CC = gcc
SRC = setwall.c

TARGET = setwall
CFLAGS = -Wall -O2
LDFLAGS =

# Detect platform and locate raylib
UNAME_S := $(shell uname)
PKGCONF := $(shell command -v pkg-config 2>/dev/null)
BREW := $(shell command -v brew 2>/dev/null)
BREW_PREFIX := $(shell test -n "$(BREW)" && brew --prefix 2>/dev/null)

# Prefer pkg-config if available
ifeq ($(PKGCONF),)
RAYLIB_CFLAGS :=
RAYLIB_LIBS :=
else
RAYLIB_CFLAGS := $(shell pkg-config --cflags raylib 2>/dev/null)
RAYLIB_LIBS := $(shell pkg-config --libs raylib 2>/dev/null)
endif

# If pkg-config not available or returns nothing on macOS, use Homebrew paths
ifeq ($(UNAME_S),Darwin)
ifeq ($(strip $(RAYLIB_CFLAGS)$(RAYLIB_LIBS)),)
ifneq ($(strip $(BREW_PREFIX)),)
CFLAGS += -I$(BREW_PREFIX)/include
LDFLAGS += -L$(BREW_PREFIX)/lib
LIBS = -lraylib -framework Cocoa -framework IOKit -framework CoreVideo -framework OpenGL -lm
else
# Fallback to frameworks without explicit include/lib (may fail if raylib not in default paths)
LIBS = -lraylib -framework Cocoa -framework IOKit -framework CoreVideo -framework OpenGL -lm
endif
else
LIBS = $(RAYLIB_LIBS)
CFLAGS += $(RAYLIB_CFLAGS)
endif
else
# Non-macOS (Linux/others)
ifneq ($(strip $(RAYLIB_CFLAGS)$(RAYLIB_LIBS)),)
LIBS = $(RAYLIB_LIBS)
CFLAGS += $(RAYLIB_CFLAGS)
else
LIBS = -lraylib -lm
endif
endif

PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(if $(UNIVERSAL),-arch x86_64 -arch arm64,) $(SRC) -o $(TARGET) $(LDFLAGS) $(if $(UNIVERSAL),-arch x86_64 -arch arm64,) $(LIBS)

clean:
	@echo "Cleaning up..."
	rm -f $(TARGET)

install: $(TARGET)
	mkdir -p $(BINDIR)
	install -m 755 $(TARGET) $(BINDIR)

uninstall:
	rm -f $(BINDIR)/$(TARGET)

.PHONY: all clean install uninstall

