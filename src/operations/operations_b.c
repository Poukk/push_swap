/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   operations_b.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: alexanfe <alexanfe@student.42sp.org.br>    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/03/10 19:27:23 by alexanfe          #+#    #+#             */
/*   Updated: 2025/03/10 19:27:45 by alexanfe         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	pb(t_stack_node **a, t_stack_node **b, int print)
{
	push(a, b);
	if (print)
		ft_printf("pb\n");
}

void	sb(t_stack_node	**b, int print)
{
	swap(b);
	if (print)
		ft_printf("sb\n");
}

void	rb(t_stack_node **b, int print)
{
	rotate(b);
	if (print)
		ft_printf("rb\n");
}

void	rrb(t_stack_node **b, int print)
{
	rev_rotate(b);
	if (print)
		ft_printf("rrb\n");
}
