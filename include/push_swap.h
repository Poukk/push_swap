#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H

# include <limits.h>
# include "libft.h"

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

int				get_len(t_stack_node *stack);
int				is_sorted(t_stack_node *stack);
t_stack_node	*get_last(t_stack_node *stack);
t_stack_node	*get_min(t_stack_node *stack);
t_stack_node	*get_max(t_stack_node *stack);

/* Operations */
void			push(t_stack_node **src, t_stack_node **dst);
void			swap(t_stack_node **stack);
void			rotate(t_stack_node **stack);
void			rev_rotate(t_stack_node **stack);

/* Operations Stack A */
void			pa(t_stack_node **a, t_stack_node **b, int print);
void			sa(t_stack_node	**a, int print);
void			ra(t_stack_node **a, int print);
void			rra(t_stack_node **a, int print);

/* Operations Stack B */
void			pb(t_stack_node **a, t_stack_node **b, int print);
void			sb(t_stack_node	**b, int print);
void			rb(t_stack_node **b, int print);
void			rrb(t_stack_node **b, int print);

/* Operations Both Stacks */
void			rrr(t_stack_node **a, t_stack_node **b, int print);
void			rr(t_stack_node **a, t_stack_node **b, int print);
void			ss(t_stack_node **a, t_stack_node **b, int print);

void populate_stack(t_stack_node **stack, char **list);


void	free_stack(t_stack_node **stack);
void	free_error(t_stack_node **stack);


void	set_cost(t_stack_node *a, t_stack_node *b);
void	set_cheapest(t_stack_node *stack);
void	set_index(t_stack_node *stack);
t_stack_node	*get_cheapest(t_stack_node *stack);
void	bring_to_bottom(t_stack_node **a, t_stack_node **b, t_stack_node *node);
void	bring_to_top(t_stack_node **a, t_stack_node **b, t_stack_node *node);
void	min_to_top(t_stack_node **a);
void	node_to_top(t_stack_node **stack, t_stack_node *top_node, char stack_name);
void	update_stack_a(t_stack_node *a, t_stack_node *b);
void	move_a_to_b(t_stack_node **a, t_stack_node **b);
void	update_stack_b(t_stack_node *a, t_stack_node *b);
void	move_b_to_a(t_stack_node **a, t_stack_node **b);
void	sort_three(t_stack_node **a);
void	sort_stacks(t_stack_node **a, t_stack_node **b);
#endif
