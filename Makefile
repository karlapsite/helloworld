CFLAGS = -g -Wall -Wextra -Werror -std=c99
LDFLAGS =
EXENAME = hello

HOST = $(USER)@localhost

SOURCEDIR = src
BUILDDIR = build
BINDIR = bin

SRCS = $(wildcard $(SOURCEDIR)/*.c)
OBJS = $(patsubst $(SOURCEDIR)%.c,$(BUILDDIR)%.o, $(SRCS))

all: $(BINDIR)/$(EXENAME)

$(BUILDDIR)/%.o: $(SOURCEDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) -c -o $@ $^ $(CFLAGS)

$(BINDIR)/$(EXENAME): $(OBJS)
	@mkdir -p $(dir $@)
	$(CC) -o $@ $^ $(LDFLAGS)

install:
	cat $(BINDIR)/$(EXENAME) | ssh $(HOST) 'cat >> $(EXENAME)'
	ssh $(HOST) 'chmod +x $(EXENAME)'

clean:
	rm -rf $(BINDIR)/$(EXENAME) $(BUILDDIR)/
