#------------------ Config -----------------#
NAME = push_swap
SRCS = \
$(SRCDIR)/main.c                        \
$(SRCDIR)/stack_helpers.c               \
$(SRCDIR)/init.c                        \
$(SRCDIR)/error.c                       \
$(SRCDIR)/operations/operations.c       \
$(SRCDIR)/operations/operations_a.c     \
$(SRCDIR)/operations/operations_b.c     \
$(SRCDIR)/operations/operations_both.c  \
$(SRCDIR)/algorithm/algorithm.c         \
$(SRCDIR)/algorithm/algorithm_helpers.c \
$(SRCDIR)/algorithm/stack_a_helpers.c   \
$(SRCDIR)/algorithm/stack_b_helpers.c   \

#---------------- Variables ----------------#
CC = cc
CFLAGS = -Wall -Wextra -Werror
INCLUDES = -I./include -I./Libft/include

SRCDIR = src
OBJDIR = obj

LIBFT_DIR = Libft

OBJS = $(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

LIBFT = $(LIBFT_DIR)/libft.a

GREEN = $$(tput setaf 2)
RESET = $$(tput sgr0)

#----------------- Targets ----------------#
all: $(LIBFT) $(NAME)

$(OBJDIR):
	@mkdir -p $(dir $(OBJS))
	@echo "$(GREEN)Created object directory$(RESET)"

$(LIBFT):
	@echo "Compiling libft..."
	@make --no-print-directory -C $(LIBFT_DIR)

$(NAME): $(OBJDIR) $(OBJS)
	@$(CC) $(CFLAGS) $(INCLUDES) -o $(NAME) $(OBJS) -L$(LIBFT_DIR) -lft
	@echo "$(GREEN)$(NAME) created successfully!$(RESET)"

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@echo "Compiling $<..."
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

clean:
	@make --no-print-directory -C $(LIBFT_DIR) clean
	@rm -rf $(OBJDIR)
	@rm -rf $(BONUS_OBJDIR)
	@echo "$(GREEN)Cleaned object files$(RESET)"

fclean:
	@make --no-print-directory -C $(LIBFT_DIR) fclean
	@rm -rf $(OBJDIR)
	@rm -rf $(BONUS_OBJDIR)
	@echo "$(GREEN)Cleaned object files$(RESET)"
	@rm -f $(NAME)
	@echo "$(GREEN)Cleaned program$(RESET)"

re: fclean all

.PHONY: all clean fclean re
