#------------------ Config -----------------#
NAME =	push_swap 
SRCS = \
$(SRCDIR)/main.c          \
$(SRCDIR)/stack_helpers.c \

#---------------- Variables ----------------#
CC = cc
CFLAGS = -Wall -Wextra -Werror
INCLUDES = -I./include -I./Libft/include

SRCDIR = src
OBJDIR = obj

BONUSDIR = bonus
BONUS_OBJDIR = obj_bonus

LIBFT_DIR = Libft

OBJS = $(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
BONUS_OBJS = $(BONUS_SRCS:$(BONUSDIR)/%.c=$(BONUS_OBJDIR)/%.o)

LIBFT = $(LIBFT_DIR)/libft.a

GREEN = $$(tput setaf 2)
RESET = $$(tput sgr0)

#----------------- Targets ----------------#
all: $(LIBFT) $(NAME)

$(OBJDIR):
	@mkdir -p $(OBJDIR)
	@echo "$(GREEN)Created object directory$(RESET)"

$(BONUS_OBJDIR):
	@mkdir -p $(BONUS_OBJDIR)
	@echo "$(GREEN)Created bonus object directory$(RESET)"

$(LIBFT):
	@echo "Compiling libft..."
	@make --no-print-directory -C $(LIBFT_DIR)

$(NAME): $(OBJDIR) $(OBJS)
	@$(CC) $(CFLAGS) $(INCLUDES) -o $(NAME) $(OBJS) -L$(LIBFT_DIR) -lft
	@echo "$(GREEN)$(NAME) created successfully!$(RESET)"

bonus: $(BONUS_OBJDIR) $(BONUS_OBJS) $(LIBFT)
	@$(CC) $(CFLAGS) $(INCLUDES) -o $(NAME) $(BONUS_OBJS) -L$(LIBFT_DIR) -lft
	@echo "$(GREEN)$(NAME) (bonus) created successfully!$(RESET)"

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@echo "Compiling $<..."
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(BONUS_OBJDIR)/%.o: $(BONUSDIR)/%.c
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
