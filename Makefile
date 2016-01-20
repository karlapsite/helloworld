CFLAGS := -g -Wall -Werror -std=c99
LIBS :=
PROGRAM := prgm

SRCDIR = src
BLDDIR = build
BINDIR = bin

SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(patsubst $(SRCDIR)%.c,$(BLDDIR)%.o, $(SRCS))

all: $(BINDIR)/$(PROGRAM)

$(BLDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) -c -o $@ $^ $(CFLAGS)

$(BINDIR)/$(PROGRAM): $(OBJS)
	@mkdir -p $(dir $@)
	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)

clean:
	rm -rf $(BINDIR)/$(PROGRAM) $(BLDDIR)/
