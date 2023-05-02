# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ltrinchini <ltrinchini@student.42lyon.f    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/26 15:59:40 by ltrinchi          #+#    #+#              #
#    Updated: 2023/05/02 15:03:34 by ltrinchini       ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

NAME = minishell

SRCS_WITHOUT_PATH = \
					main.c	\
					prompt.c \
					set_lstenv.c \
					heredoc.c

BUILTINS_WITHOUT_PATH = \
					echo.c	\
					cd.c	\
					pwd.c \
					env.c \
					export.c \
					export_tools_1.c \
					export_tools_2.c \
					unset.c \
					call_builtins.c \
					exit.c

ADD_WITHOUT_PATH =	\
					free_dstr.c \
					free_tstr.c \
					free_data.c \
					check_varname.c \
					signal.c \
					err.c \
					init_tty_setting.c \
					files.c

PARSING_WITHOUT_PATH = \
					prepars_utils.c \
					prepars_utils_help.c \
					pars_utils.c \
					prepars_pipe.c \
					postpars_utils.c \
					parsing.c \
					postpars.c \
					check_flag.c \
					check_flag_utils.c \
					pars_err.c \
					thirdsplit.c \
					thirdsplit_utils.c \
					fourthsplit.c \
					delnodes.c \
					delquotes.c

EXEC_WITHOUT_PATH = \
					exec.c \
					free_pipex_struct.c \
					nb_of_pipe.c \
					init_pipe.c \
					init_struct_pipex.c	\
					pipex.c \
					pipex_utils.c \
					set_env.c \
					set_path_cmd.c \
					take_path.c \
					set_flags_cmd.c \
					set_files.c \
					init_heredocs.c \
					pipexec.c

OBJS_SRCS_WITHOUT_PATH = $(SRCS_WITHOUT_PATH:.c=.o)
OBJS_BUILTINS_WITHOUT_PATH = $(BUILTINS_WITHOUT_PATH:.c=.o)
OBJS_ADD_WITHOUT_PATH = $(ADD_WITHOUT_PATH:.c=.o)
OBJS_PARSING_WITHOUT_PATH = $(PARSING_WITHOUT_PATH:.c=.o)
OBJS_EXEC_WITHOUT_PATH = $(EXEC_WITHOUT_PATH:.c=.o)

HEADER_WITHOUT_PATH = JeanMiShell.h

PATH_TO_SRCS = ./srcs/
PATH_TO_BUILTINS = ./builtins/
PATH_TO_OBJS = ./objs/
PATH_TO_HEADER = ./inclds/
PATH_TO_ADD = ./add/
PATH_TO_PARSING = ./parsing/
PATH_TO_EXEC = ./exec/

SRCS = $(addprefix $(PATH_TO_SRCS), $(SRCS_WITHOUT_PATH))
BUILTINS = $(addprefix $(PATH_TO_BUILTINS), $(BUILTINS_WITHOUT_PATH))
ADD = $(addprefix $(PATH_TO_ADD), $(ADD_WITHOUT_PATH))
PARSING = $(addprefix $(PATH_TO_PARSING), $(PARSING_WITHOUT_PATH))
EXEC = $(addprefix $(PATH_TO_EXEC), $(EXEC_WITHOUT_PATH))

OBJS_SRCS = $(addprefix $(PATH_TO_OBJS), $(OBJS_SRCS_WITHOUT_PATH))
OBJS_BUILTINS = $(addprefix $(PATH_TO_OBJS), $(OBJS_BUILTINS_WITHOUT_PATH))
OBJS_ADD = $(addprefix $(PATH_TO_OBJS), $(OBJS_ADD_WITHOUT_PATH))
OBJS_PARSING = $(addprefix $(PATH_TO_OBJS), $(OBJS_PARSING_WITHOUT_PATH))
OBJS_EXEC = $(addprefix $(PATH_TO_OBJS), $(OBJS_EXEC_WITHOUT_PATH))

OBJS =	$(OBJS_SRCS) \
		$(OBJS_BUILTINS) \
		$(OBJS_ADD) \
		$(OBJS_PARSING) \
		$(OBJS_EXEC)

HEADER = $(addprefix $(PATH_TO_HEADER), $(HEADER_WITHOUT_PATH))

	##### COMMANDS ######
CC = gcc
CFLAGS = -Wall -Wextra -Werror -g
RM = rm -rf
	#####################

	########### RESOURCES ###########

	###### LIBFT ######
PATH_TO_LIBFT = ./libft/
LIBFT_A = $(PATH_TO_LIBFT)libft.a
PATH_TO_READLINE = /opt/homebrew/opt/readline
READLINE_LIB = -lreadline
READLINE_HOMEBREW_LIB = -L $(PATH_TO_READLINE)/lib
READLINE_HOMEBREW_INCLUDE = -I $(PATH_TO_READLINE)/include
	###################

	#################################

	###### COLORS FOR PRINTF ######
GREEN 		= \033[0;92m
RED			= \033[0;91m
BLUE		= \033[0;94m
YELLOW      = \033[0;93m
WHITE       = \033[1;49;97m
	###############################

all: rsc $(PATH_TO_OBJS) $(NAME)
	printf "$(GREEN)✅ $(NAME) is up to date$(WHITE) 👏\n"  

$(PATH_TO_OBJS):
	mkdir -p ./objs/

rsc:
	make -C $(PATH_TO_LIBFT)

$(LIBFT_A): rsc

$(OBJS_SRCS):$(PATH_TO_OBJS)%.o	: $(PATH_TO_SRCS)%.c Makefile $(HEADER) $(LIBFT_A)
	printf "\033[2K\r$(YELLOW)⏳ Compiling:$(WHITE) $< 🤞"
	$(CC) $(CFLAGS) -c $< -o $@ 

$(OBJS_BUILTINS):$(PATH_TO_OBJS)%.o	: $(PATH_TO_BUILTINS)%.c Makefile $(HEADER) $(LIBFT_A)
	printf "\033[2K\r$(YELLOW)⏳ Compiling:$(WHITE) $< 🤞"
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJS_ADD):$(PATH_TO_OBJS)%.o	: $(PATH_TO_ADD)%.c Makefile $(HEADER) $(LIBFT_A)
	printf "\033[2K\r$(YELLOW)⏳ Compiling:$(WHITE) $< 🤞"
	$(CC) $(CFLAGS) $(READLINE_HOMEBREW_INCLUDE) -c $< -o $@

$(OBJS_PARSING):$(PATH_TO_OBJS)%.o	: $(PATH_TO_PARSING)%.c Makefile $(HEADER) $(LIBFT_A)
	printf "\033[2K\r$(YELLOW)⏳ Compiling:$(WHITE) $< 🤞"
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJS_EXEC):$(PATH_TO_OBJS)%.o	: $(PATH_TO_EXEC)%.c Makefile $(HEADER) $(LIBFT_A)
	printf "\033[2K\r$(YELLOW)⏳ Compiling:$(WHITE) $< 🤞"
	$(CC) $(CFLAGS) -c $< -o $@

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LIBFT_A) $(READLINE_LIB) $(READLINE_HOMEBREW_LIB) -o $(NAME)
	printf "\n$(GREEN)✅ $(NAME) has been build 👍$(WHITE)\n"
	printf "$(BLUE)"
	echo ""
	echo "               _                        __  __ _ ____  _          _ _                  "
	echo "              | | ___  __ _ _ __       |  \/  (_) ___|| |__   ___| | |                 "
	echo "           _  | |/ _ \/ _  |  _ \ _____| |\/| | \___ \|  _ \ / _ \ | |                 "
	echo "          | |_| |  __/ (_| | | | |_____| |  | | |___) | | | |  __/ | |                 "
	echo "           \___/ \___|\__,_|_| |_|     |_|  |_|_|____/|_| |_|\___|_|_|                 "
	printf "$(WHITE)"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣶⣦⣤⣄⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡻⣿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠛⠞⠋⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠑⠀⣸⡟⣻⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢦⠀⠀⠹⠀⠠⠗⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⣷⢲⡄⠀⠂⠀⠀⠀⠈⠉⠻⢿⣿⣿⡿⠿⠟⢻⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣶⡀⠀⢠⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢦⡀⠃⢳⡥⠥⡄⠀⠀⠀⠀⠀⢀⣤⣦⠀⠀⠀⠀⠄⢸⢧⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣄⠀⠋⣿⣷⠀⢻⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⠀⠀⠀⠘⣇⣤⣤⣤⡐⢠⣾⣿⣿⡇⠀⠰⢿⣿⣿⡜⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⣿⣦⠐⣿⣿⡄⢸⣿⣿⠀⣴⣆⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠋⠀⠀⠀⠀⠈⠻⠿⠋⠰⠿⢿⣿⣿⣿⢳⣧⣼⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣄⢘⣿⣿⠀⣿⣿⡄⣾⣿⡀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠾⣄⡀⠀⠈⣩⣿⡆⠹⢿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⡈⢿⣿⡆⣿⣿⡇⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⠀⠀⠀⠀⠀⠸⡞⠆⠀⠁⠣⠤⠼⢿⡿⢿⣼⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⣿⣿⣬⣿⣷⣾⣿⣧⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣄⠀⠀⠀⠠⠀⠀⠐⠂⠀⠁⠐⠒⡊⣶⡞⠉⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⡻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣧⡀⠀⠀⠀⠀⠐⢶⣾⣶⣾⣿⣷⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢢⣤⣙⠿⢿⣆⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣤⡀⠀⠀⠀⠀⠀⠀⠉⠙⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣄⣀⠀⠀⠀⢀⣿⣷⣟⣿⣿⣿⣾⣿⣎⣿⣿⡇⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⢀⣸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠛⠿⠿⣿⣿⣿⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣟⢿⡇⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣷⣶⣶⣶⠆⠂⠙⢿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣿⡇⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⠏⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠹⠋⠉⠹⢿⣿⡇⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣿⡟⢇⡀⠀⠀⠀⠈⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⢼⣿⡾⠃⢸⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⣿⣷⡾⠃⠀⠀⠀⢸⣯⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠁⠀⢠⢿⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⡇⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠤⠀⣰⡟⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣧⠀⠀⠀⢸⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⠀⠀⠀⠀⢿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⠄⠀⠀⠀⠸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⡆⠀⠀⠀⠀⠹⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⡄⠀⠀⠀⠀⠘⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
	printf "$(RED)"
	echo "                                                     _           _ _                   "
	echo "            __      ____ _ ___    ___ _ __ ___  __ _| |_ ___  __| | |                  "
	echo "            \ \ /\ / / _  / __|  / __|  __/ _ \/ _  | __/ _ \/ _  | |                  "
	echo "             \ V  V / (_| \__ \ | (__| | |  __/ (_| | ||  __/ (_| |_|                  "
	echo "              \_/\_/ \__,_|___/  \___|_|  \___|\__,_|\__\___|\__,_(_)                  "

git: fclean
	git add *
	git add -u
	git commit

clean:
	make clean -C $(PATH_TO_LIBFT)
	$(RM) $(PATH_TO_OBJS)
	printf "$(RED)👌 Files has been deleted in $(PATH_TO_OBJS) ($(NAME))$(WHITE)\n"  
	printf "$(GREEN)✅ Clean 👍$(WHITE)\n"  

fclean: clean
	printf "$(RED)👌 $(NAME) has been deleted$(WHITE)\n"  
	$(RM) $(LIBFT_A)
	$(RM) $(NAME)

re: fclean all

.PHONY: all rsc debug clean git fclean re
.SILENT:
