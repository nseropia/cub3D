# --- TARGET ---

NAME        := cub3D

# --- DIRECTORIES ---

SRCDIR      := src
GNLDIR      := get_next_line
INCDIR      := include
OBJDIR      := obj
MLXDIR      := minilibx-linux

# --- SOURCES ---

SRC         := $(wildcard $(SRCDIR)/*.c)
GNL         := $(wildcard $(GNLDIR)/*.c)
SRCS        := $(SRC) $(GNL)

OBJS        := $(SRCS:%.c=$(OBJDIR)/%.o)

# --- COMPILER / FLAGS ---

CC          := cc
CFLAGS      := -Wall -Wextra -Werror -g
CPPFLAGS    := -I$(INCDIR) -I$(GNLDIR) -I$(MLXDIR)
MLXFLAGS    := -L$(MLXDIR) -lmlx_Linux -lX11 -lXext -lm -lz

# --- COMMANDS ---

RM          := rm -rf
MKDIR       := mkdir -p

# --- RULES ---

.PHONY: all clean fclean re help

all: $(MLXDIR)/libmlx_Linux.a $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(OBJS) $(MLXFLAGS) -o $(NAME)
	@echo "cub3D built successfully."
	@echo "Run with: ./$(NAME) <path/to/map.cub>"

$(MLXDIR)/libmlx_Linux.a:
	@if [ ! -d "$(MLXDIR)" ] || [ ! -f "$(MLXDIR)/Makefile" ]; then \
		echo "MiniLibX submodule is missing or incomplete."; \
		echo "Run: git submodule update --init --recursive"; \
		exit 1; \
	fi
	@$(MAKE) -C $(MLXDIR)

$(OBJDIR)/%.o: %.c
	@$(MKDIR) $(dir $@)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

clean:
	$(RM) $(OBJDIR)
	@if [ -d "$(MLXDIR)" ]; then $(MAKE) -C $(MLXDIR) clean; fi

fclean: clean
	$(RM) $(NAME)

re: fclean all

help:
	@echo "Available targets:"
	@echo "  make        Build cub3D"
	@echo "  make clean  Remove object files"
	@echo "  make fclean Remove object files and binary"
	@echo "  make re     Rebuild from scratch"