#ifndef HELPERS_H
# define HELPERS_H

# include "push_swap.h"

typedef struct s_stack_node
{
	int					content;
	int					index;
	int					push_cost;
	int					above_median;
	int					cheapest;
	struct s_stack_node	*target_node;
	struct s_stack_node	*next;
	struct s_stack_node	*prev;
}	t_stack_node;

/* Algorithm Helpers*/
void	set_cost(t_stack_node *a, t_stack_node *b);
void	set_cheapest(t_stack_node *stack);
void	set_index(t_stack_node *stack);

void	bring_to_bottom(t_stack_node **a, t_stack_node **b, t_stack_node *node);
void	bring_to_top(t_stack_node **a, t_stack_node **b, t_stack_node *node);

void	min_to_top(t_stack_node **a);
void	node_to_top(t_stack_node **stack, t_stack_node *top_node, char s_name);

void	update_stack_a(t_stack_node *a, t_stack_node *b);
void	update_stack_b(t_stack_node *a, t_stack_node *b);

void	move_a_to_b(t_stack_node **a, t_stack_node **b);
void	move_b_to_a(t_stack_node **a, t_stack_node **b);

void	sort_three(t_stack_node **a);
void	sort_stacks(t_stack_node **a, t_stack_node **b);
#endif
