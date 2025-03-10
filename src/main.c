#include "push_swap.h"

int	main(int argc, char *argv[])
{
	t_stack_node	*a;
	t_stack_node	*b;

	a = NULL;
	b = NULL;
	if (argc < 2)
		return (EXIT_FAILURE);
	populate_stack(&a, argv + 1);
	if (!is_sorted(a))
	{
		if (get_len(a) == 2)
			sa(&a, 1);
		else if (get_len(a) == 3)
			sort_three(&a);
		else
			sort_stacks(&a, &b);
	}
	free_stack(&a);
}
