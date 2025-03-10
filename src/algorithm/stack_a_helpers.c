#include "push_swap.h"

void	set_target_a(t_stack_node *a, t_stack_node *b)
{
	t_stack_node	*temp;
	t_stack_node	*target_node;
	int				target_index;

	while (a)
	{
		target_index = INT_MIN;
		temp = b;
		while (temp)
		{
			if (temp->content < a->content && temp->content > target_index)
			{
				target_index = temp->content;
				target_node = temp;
			}
			temp = temp->next;
		}
		if (target_index == INT_MIN)
			a->target_node = get_max(b);
		else
			a->target_node = target_node;
		a = a->next;
	}
}

void	update_stack_a(t_stack_node *a, t_stack_node *b)
{
	set_index(a);
	set_index(b);
	set_target_a(a, b);
	set_cost(a, b);
	set_cheapest(a);
}

void	move_a_to_b(t_stack_node **a, t_stack_node **b)
{
	t_stack_node	*cheapest_node;

	cheapest_node = get_cheapest(*a);
	if (cheapest_node->above_median
		&& cheapest_node->target_node->above_median)
		bring_to_bottom(a, b, cheapest_node);
	else if (!(cheapest_node->above_median)
		&& !(cheapest_node->target_node->above_median))
		bring_to_top(a, b, cheapest_node);
	node_to_top(a, cheapest_node, 'a');
	node_to_top(b, cheapest_node->target_node, 'b');
	pb(a, b, 1);
}
