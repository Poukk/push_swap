#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H

# include <limits.h>
# include "libft.h"
# include "helpers.h"

int				get_len(t_stack_node *stack);
int				is_sorted(t_stack_node *stack);
t_stack_node	*get_last(t_stack_node *stack);
t_stack_node	*get_min(t_stack_node *stack);
t_stack_node	*get_max(t_stack_node *stack);
t_stack_node	*get_cheapest(t_stack_node *stack);

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

void			populate_stack(t_stack_node **stack, char **list);

/* Error handling */
void			free_stack(t_stack_node **stack);
void			free_error(t_stack_node **stack);
int				is_valid_integer(const char *str);
#endif
