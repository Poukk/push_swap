/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   operations_a.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: alexanfe <alexanfe@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/10 19:27:20 by alexanfe          #+#    #+#             */
/*   Updated: 2025/03/10 19:27:45 by alexanfe         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	pa(t_stack_node **a, t_stack_node **b, int print)
{
	push(b, a);
	if (print)
		ft_printf("pa\n");
}

void	sa(t_stack_node	**a, int print)
{
	swap(a);
	if (print)
		ft_printf("sa\n");
}

void	ra(t_stack_node **a, int print)
{
	rotate(a);
	if (print)
		ft_printf("ra\n");
}

void	rra(t_stack_node **a, int print)
{
	rev_rotate(a);
	if (print)
		ft_printf("rra\n");
}
