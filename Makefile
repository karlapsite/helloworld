ifndef CROSS_CC_PREFIX
  CROSS_CC_PREFIX=$(CROSS_COMPILE)
endif

CC=$(CROSS_CC_PREFIX)gcc
LD=$(CROSS_CC_PREFIX)ld
RANLIB=$(CROSS_CC_PREFIX)corelib
CFLAGS = -g -Wall -Wextra -Werror -std=c99
PROGRAM = hello

HOST = $(USER)@localhost

SOURCEDIR = src
BUILDDIR = build
BINDIR = bin

SRCS = $(wildcard $(SOURCEDIR)/*.c)
OBJS = $(patsubst $(SOURCEDIR)%.c,$(BUILDDIR)%.o, $(SRCS))

all: $(BINDIR)/$(PROGRAM)

$(BUILDDIR)/%.o: $(SOURCEDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) -c -o $@ $^ $(CFLAGS)

$(BINDIR)/$(PROGRAM): $(OBJS)
	@mkdir -p $(dir $@)
	$(CC) -o $@ $^ $(LDFLAGS)

install:
	cat $(BINDIR)/$(PROGRAM) | ssh $(HOST) 'cat >> $(EXENAME)'
	ssh $(HOST) 'chmod +x $(PROGRAM)'

clean:
	rm -rf $(BINDIR)/$(PROGRAM) $(BUILDDIR)/
