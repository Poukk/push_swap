#include "push_swap.h"

void	bring_to_bottom(t_stack_node **a, t_stack_node **b, t_stack_node *node)
{
	while (*a != node && *b != node->target_node)
		rr(a, b, 1);
	set_index(*a);
	set_index(*b);
}

void	bring_to_top(t_stack_node **a, t_stack_node **b, t_stack_node *node)
{
	while (*a != node && *b != node->target_node)
		rrr(a, b, 1);
	set_index(*a);
	set_index(*b);
}

void	min_to_top(t_stack_node **a)
{
	while ((*a)->content != get_min(*a)->content)
	{
		if (get_min(*a)->above_median)
			ra(a, 1);
		else
			rra(a, 1);
	}
}

void	sort_three(t_stack_node **a)
{
	t_stack_node	*biggest_node;

	biggest_node = get_max(*a);
	if (biggest_node == *a)
		ra(a, 1);
	else if ((*a)->next == biggest_node)
		rra(a, 1);
	if ((*a)->content > (*a)->next->content)
		sa(a, 1);
}

void	sort_stacks(t_stack_node **a, t_stack_node **b)
{
	int	len_a;

	len_a = get_len(*a);
	if (len_a-- > 3 && !is_sorted(*a))
		pb(a, b, 1);
	if (len_a-- > 3 && !is_sorted(*a))
		pb(a, b, 1);
	while (len_a-- > 3 && !is_sorted(*a))
	{
		update_stack_a(*a, *b);
		move_a_to_b(a, b);
	}
	sort_three(a);
	while (*b)
	{
		update_stack_b(*a, *b);
		move_b_to_a(a, b);
	}
	set_index(*a);
	min_to_top(a);
}
