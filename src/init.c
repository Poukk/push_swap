#include "push_swap.h"

t_stack_node	*create_node(int content)
{
	t_stack_node	*new_node;

	new_node = (t_stack_node *)malloc(sizeof(t_stack_node));
	if (!new_node)
		return (NULL);
	new_node->content = content;
	new_node->next = NULL;
	new_node->prev = NULL;
	return (new_node);
}

void	add_node(t_stack_node **stack, int content)
{
	t_stack_node	*node;
	t_stack_node	*last_node;

	node = create_node(content);
	if (!node)
		return ;
	if (!*stack)
		*stack = node;
	else
	{
		last_node = get_last(*stack);
		last_node->next = node;
		node->prev = last_node;
		node->next = NULL;
	}
}

int	is_duplicated(t_stack_node **stack, int content)
{
	t_stack_node	*temp;

	if (!stack || !*stack)
		return (0);
	temp = *stack;
	while (temp)
	{
		if (temp->content == content)
			return (1);
		temp = temp->next;
	}
	return (0);
}

void	populate_stack(t_stack_node **stack, char **list)
{
	long	number;

	if (!list)
		return ;
	while (*list)
	{
		if (!is_valid_integer(*list))
			free_error(stack);
		number = ft_atol(*list);
		if (is_duplicated(stack, number))
			free_error(stack);
		if (number > INT_MAX || number < INT_MIN)
			free_error(stack);
		add_node(stack, number);
		list++;
	}
}
