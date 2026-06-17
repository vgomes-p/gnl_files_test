/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vigomes- <vigomes-@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/05/13 10:56:04 by vigomes-          #+#    #+#             */
/*   Updated: 2026/05/13 10:56:05 by vigomes-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"
#include <fcntl.h>
#include <stdio.h>

void	ft_putchar(char c)
{
	write(1, &c, 1);
}

void	gnl_putstr(char *st)
{
	long int	i;

	i = 0;
	while (st[i] != '\0')
		ft_putchar(st[i++]);
}

void ft_putnbr(int nb)
{
	char		c;
	long int	n;

	n = nb;
	if (n < 0)
	{
		ft_putchar('-');
		n *= -1;
	}
	if (n > 9)
		ft_putnbr(n / 10);
	c = n % 10 + '0';
	ft_putchar(c);
}

int	ft_strcmp(char *s1, char *s2)
{
	int	i;

	i = 0;
	while (s1[i] && s2[i] && (s1[i] == s2[i]))
		i++;
	return (s1[i] - s2[i]);
}

int exec_cnt(char *file_path)
{
	int			fd;
	char		*line;
	long int	i;

	i = 1;
	fd = open(file_path, O_RDONLY);
	if (fd < 0)
	{
		perror("open");
		return (1);
	}
	while ((line = get_next_line(fd)) != NULL)
	{
		gnl_putstr("line ");
		ft_putnbr(i);
		gnl_putstr(" >> ");
		gnl_putstr(line);
		free(line);
		i++;
	}
	close(fd);
	return (0);
}

int exec_long(char *file_path)
{
	int		fd;
	char	*line;

	fd = open(file_path, O_RDONLY);
	if (fd < 0)
	{
		perror("open");
		return (1);
	}
	while ((line = get_next_line(fd)) != NULL)
	{
		gnl_putstr(line);
		free(line);
	}
	close(fd);
	return (0);
}

int	main(int ac, char **av)
{
	if (ac < 2)
	{
		gnl_putstr("Usage: ./gnl_tester <file> cnt");
		return (2);
	}
	if (ac > 2)
	{
		if (ft_strcmp(av[2], "--cnt") == 0)
			exec_cnt(av[1]);
		else
		{
			ft_putchar('\'');
			gnl_putstr(av[2]);
			gnl_putstr("' not a valid argument, to count lines while testing, run '--cnt'!\n");
			return (2);
		}
	}
	else
		exec_long(av[1]);
	
	return (0);
}
