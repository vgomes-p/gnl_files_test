# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vigomes- <vigomes-@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/05/13 10:56:07 by vigomes-          #+#    #+#              #
#    Updated: 2026/05/16 16:54:49 by vigomes-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		=	gnl_tester
CC			=	cc
CFLAGS		=	-Wall -Wextra -Werror
MAKEFLAGS	=	--silent
AR			=	ar -rcs
RM			=	rm -rf

HEADER		=	get_next_line.h

SRCS		=	main.c get_next_line.c get_next_line_utils.c
OBJS 		=	$(addprefix $(OBJ_DIR), $(SRCS:.c=.o))
OBJ_DIR		=	build/
OBJ_M		=	$(OBJ_DIR)

PROGRAM		=	"GNL TESTER"

DEFAULT		=	\033[0m
RED			=	\033[1;31m
CYAN		=	\033[1;36m
PINK		=	\033[1;35m
GREEN		=	\033[1;32m
YELLOW		=	\033[1;33m
REWHITE		=	\033[1;7;97m
RECYAN		=	\033[1;7;36m
REPINK		=	\033[1;7;35m
RERED		=	\033[1;7;31m
REGREEN		=	\033[1;7;32m
REYELLOW	=	\033[1;7;33m

TOTAL_FILES =	$(words $(OBJS))
COMPLETED	=	0

define update_progress
		@if [ "$(COMPLETED)" -eq "0" ]; then \
			clear; \
		fi
		@$(eval COMPLETED=$(shell echo $$(($(COMPLETED)+1))))
		@$(eval PERCENT=$(shell echo $$(($(COMPLETED)*100/$(TOTAL_FILES)))))
		@$(eval FILLED=$(shell echo $$(($(PERCENT)*20/100))))
		@$(eval EMPTY=$(shell echo $$((20-$(FILLED)))))
		@clear
		@printf "$(YELLOW)COMPILING $(PROGRAM)! \n"
		@for i in $$(seq 1 $(FILLED)); do printf "🟧"; done
		@for i in $$(seq 1 $(EMPTY)); do printf "  "; done
		@printf "%d%%$(DEFAULT)" $(PERCENT)
		@if [ "$(COMPLETED)" -eq "$(TOTAL_FILES)" ]; then \
			clear; \
			echo "${GREEN}$(PROGRAM) COMPILED!"; \
			echo "🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 100%${DEFAULT}"; \
		fi
endef

all: $(NAME)
$(OBJ_DIR)%.o: %.c $(HEADER)
		@clear
		@mkdir -p $(OBJ_DIR)
		$(CC) $(CFLAGS) -c $< -o $@
		@$(call update_progress)

$(NAME): $(OBJS)
		$(CC) $(CFLAGS) $(OBJS) -o $(NAME)


norm:
		@for file in $(SRCS); do \
			if norminette $$file | grep -q "Error"; then \
				echo "$(RED)❌ $$file$(DEFAULT)"; \
			else \
				echo "$(GREEN)✅ $$file$(DEFAULT)"; \
			fi; \
		done
		-@norminette > norminette.log 2>&1
		@echo "$(CYAN)🆗 Norminette check complete! 🆗$(DEFAULT)"
		@echo "$(CYAN)Norminette report saved in norminette.log!$(DEFAULT)"

clean:
		$(RM) $(OBJ_DIR)

fclean: clean
		$(RM) $(NAME)
		$(RM) norminette.log

re: fclean all

.PHONY: all clean fclean re norm