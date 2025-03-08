#include "push_swap.h"

void	set_target_b(t_stack_node *a, t_stack_node *b)
{
	t_stack_node	*temp;
	t_stack_node	*target_node;
	int		target_index;

	while (b)
	{
		target_index = INT_MAX;
		temp = a;
		while (temp)
		{
			if (temp->content > b->content && temp->content < target_index)
			{
				target_index = temp->content;
				target_node = temp;
			}
			temp = temp->next;
		}
		if (target_index == INT_MAX)
			b->target_node = get_min(a);
		else
			b->target_node = target_node;
		b = b->next;
	}
}

void	update_stack_b(t_stack_node *a, t_stack_node *b)
{
	set_index(a);
	set_index(b);
	set_target_b(a, b);
}

void	move_b_to_a(t_stack_node **a, t_stack_node **b)
{
	node_to_top(a, (*b)->target_node, 'a');
	pa(a, b, 1); 
}
