#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Executable paths
PUSH_SWAP="./push_swap"
CHECKER="./checker_linux"

# Make sure executables exist and are executable
if [ ! -f "$PUSH_SWAP" ]; then
  echo -e "${RED}Error: $PUSH_SWAP not found!${NC}"
  exit 1
fi

if [ ! -f "$CHECKER" ]; then
  echo -e "${RED}Error: $CHECKER not found!${NC}"
  exit 1
fi

if [ ! -x "$PUSH_SWAP" ]; then
  echo -e "${RED}Error: $PUSH_SWAP is not executable!${NC}"
  chmod +x "$PUSH_SWAP"
  echo -e "${GREEN}Made $PUSH_SWAP executable.${NC}"
fi

if [ ! -x "$CHECKER" ]; then
  echo -e "${RED}Error: $CHECKER is not executable!${NC}"
  chmod +x "$CHECKER"
  echo -e "${GREEN}Made $CHECKER executable.${NC}"
fi

# Function to test sorting with different array sizes
test_sort() {
  size=$1
  iterations=$2
  total_instructions=0
  max_instructions=0
  min_instructions=999999
  success_count=0

  echo -e "${BLUE}Testing with $size numbers ($iterations iterations)...${NC}"

  for ((i = 1; i <= $iterations; i++)); do
    # Generate random numbers - ensure no duplicates
    declare -A used_numbers
    ARGS=""
    count=0

    while [ $count -lt $size ]; do
      # Generate number between -1000 and 1000
      num=$((RANDOM % 2001 - 1000))

      # Check if this number was already used
      if [ -z "${used_numbers[$num]}" ]; then
        used_numbers[$num]=1
        ARGS+="$num "
        count=$((count + 1))
      fi
    done

    # Run push_swap and count instructions
    INSTRUCTIONS=$($PUSH_SWAP $ARGS | wc -l)

    # Run checker to verify if sorting is correct
    RESULT=$($PUSH_SWAP $ARGS | $CHECKER $ARGS)

    if [ "$RESULT" == "OK" ]; then
      total_instructions=$((total_instructions + INSTRUCTIONS))
      success_count=$((success_count + 1))

      # Update min/max
      if ((INSTRUCTIONS > max_instructions)); then
        max_instructions=$INSTRUCTIONS
      fi

      if ((INSTRUCTIONS < min_instructions)); then
        min_instructions=$INSTRUCTIONS
      fi

      echo -e "  Test $i: ${GREEN}OK${NC} - Instructions: $INSTRUCTIONS"
    else
      echo -e "  Test $i: ${RED}KO${NC} - Sorting failed on: $ARGS"
    fi

    # Clear the associative array for the next iteration
    unset used_numbers
    declare -A used_numbers
  done

  if [ $success_count -eq 0 ]; then
    echo -e "${RED}All tests failed!${NC}"
  else
    avg_instructions=$((total_instructions / success_count))
    echo -e "${GREEN}Success rate: $success_count/$iterations${NC}"
    echo -e "${YELLOW}Min instructions: $min_instructions${NC}"
    echo -e "${YELLOW}Max instructions: $max_instructions${NC}"
    echo -e "${YELLOW}Average instructions: $avg_instructions${NC}"

    # Evaluate performance based on size
    case $size in
    3)
      if [ $max_instructions -le 3 ]; then
        echo -e "${GREEN}Excellent! Max operations <= 3${NC}"
      else
        echo -e "${RED}Try to optimize! For 3 numbers, max operations should be <= 3${NC}"
      fi
      ;;
    5)
      if [ $max_instructions -le 12 ]; then
        echo -e "${GREEN}Excellent! Max operations <= 12${NC}"
      else
        echo -e "${YELLOW}Could be better. For 5 numbers, max operations should be <= 12${NC}"
      fi
      ;;
    100)
      if [ $avg_instructions -le 700 ]; then
        echo -e "${GREEN}Great! Average under 700 operations${NC}"
      elif [ $avg_instructions -le 900 ]; then
        echo -e "${YELLOW}Good. Average under 900 operations${NC}"
      else
        echo -e "${RED}Try to optimize! For 100 numbers, average should be < 700 for best score${NC}"
      fi
      ;;
    500)
      if [ $avg_instructions -le 5500 ]; then
        echo -e "${GREEN}Great! Average under 5500 operations${NC}"
      elif [ $avg_instructions -le 8500 ]; then
        echo -e "${YELLOW}Good. Average under 8500 operations${NC}"
      else
        echo -e "${RED}Try to optimize! For 500 numbers, average should be < 5500 for best score${NC}"
      fi
      ;;
    esac
  fi
  echo ""
}

# Function to test error handling
test_error_handling() {
  echo -e "${BLUE}Testing error handling...${NC}"

  # Test case: No arguments
  output=$($PUSH_SWAP 2>&1)
  if [ -z "$output" ]; then
    echo -e "  Empty input: ${GREEN}OK${NC} - Program exits silently"
  else
    echo -e "  Empty input: ${RED}KO${NC} - Program should exit silently, got: $output"
  fi

  # Test case: Non-integer
  output=$($PUSH_SWAP 1 2 3 abc 4 2>&1)
  if [[ "$output" == *"Error"* ]]; then
    echo -e "  Non-integer: ${GREEN}OK${NC} - Program correctly outputs 'Error'"
  else
    echo -e "  Non-integer: ${RED}KO${NC} - Program should output 'Error', got: $output"
  fi

  # Test case: Integer overflow
  output=$($PUSH_SWAP 1 2 3 2147483648 4 2>&1)
  if [[ "$output" == *"Error"* ]]; then
    echo -e "  Integer overflow: ${GREEN}OK${NC} - Program correctly outputs 'Error'"
  else
    echo -e "  Integer overflow: ${RED}KO${NC} - Program should output 'Error', got: $output"
  fi

  # Test case: Duplicates
  output=$($PUSH_SWAP 1 2 3 2 4 2>&1)
  if [[ "$output" == *"Error"* ]]; then
    echo -e "  Duplicates: ${GREEN}OK${NC} - Program correctly outputs 'Error'"
  else
    echo -e "  Duplicates: ${RED}KO${NC} - Program should output 'Error', got: $output"
  fi
  echo ""
}

# Function to test already sorted arrays
test_sorted() {
  echo -e "${BLUE}Testing already sorted arrays...${NC}"

  # Small sorted array
  ARGS="1 2 3 4 5"
  INSTRUCTIONS=$($PUSH_SWAP $ARGS | wc -l)
  RESULT=$($PUSH_SWAP $ARGS | $CHECKER $ARGS)

  if [ "$RESULT" == "OK" ] && [ "$INSTRUCTIONS" -eq 0 ]; then
    echo -e "  Small sorted array: ${GREEN}OK${NC} - No instructions required"
  else
    echo -e "  Small sorted array: ${RED}KO${NC} - Program should not output any instructions for already sorted array"
  fi

  # Large sorted array
  ARGS=$(seq 1 100 | tr '\n' ' ')
  INSTRUCTIONS=$($PUSH_SWAP $ARGS | wc -l)
  RESULT=$($PUSH_SWAP $ARGS | $CHECKER $ARGS)

  if [ "$RESULT" == "OK" ] && [ "$INSTRUCTIONS" -eq 0 ]; then
    echo -e "  Large sorted array: ${GREEN}OK${NC} - No instructions required"
  else
    echo -e "  Large sorted array: ${RED}KO${NC} - Program should not output any instructions for already sorted array"
  fi
  echo ""
}

# Test specific cases
test_specific_cases() {
  echo -e "${BLUE}Testing specific hard cases...${NC}"

  # Test case: Reversed array
  ARGS="5 4 3 2 1"
  INSTRUCTIONS=$($PUSH_SWAP $ARGS | wc -l)
  RESULT=$($PUSH_SWAP $ARGS | $CHECKER $ARGS)

  if [ "$RESULT" == "OK" ]; then
    echo -e "  Reversed 5 numbers: ${GREEN}OK${NC} - Instructions: $INSTRUCTIONS"
  else
    echo -e "  Reversed 5 numbers: ${RED}KO${NC} - Sorting failed"
  fi

  # Test case: Negative numbers
  ARGS="-5 -4 -3 -2 -1"
  INSTRUCTIONS=$($PUSH_SWAP $ARGS | wc -l)
  RESULT=$($PUSH_SWAP $ARGS | $CHECKER $ARGS)

  if [ "$RESULT" == "OK" ]; then
    echo -e "  Negative numbers: ${GREEN}OK${NC} - Instructions: $INSTRUCTIONS"
  else
    echo -e "  Negative numbers: ${RED}KO${NC} - Sorting failed"
  fi

  # Test case: Mixed positive and negative
  ARGS="-2 1 -3 4 -5 0"
  INSTRUCTIONS=$($PUSH_SWAP $ARGS | wc -l)
  RESULT=$($PUSH_SWAP $ARGS | $CHECKER $ARGS)

  if [ "$RESULT" == "OK" ]; then
    echo -e "  Mixed positive/negative: ${GREEN}OK${NC} - Instructions: $INSTRUCTIONS"
  else
    echo -e "  Mixed positive/negative: ${RED}KO${NC} - Sorting failed"
  fi
  echo ""
}

# Main test sequence
echo -e "${YELLOW}===== PUSH_SWAP TESTER =====${NC}"
echo ""

test_error_handling
test_sorted
test_specific_cases

echo -e "${YELLOW}===== PERFORMANCE TESTS =====${NC}"
test_sort 3 5   # Test with 3 numbers, 5 iterations
test_sort 5 5   # Test with 5 numbers, 5 iterations
test_sort 100 5 # Test with 100 numbers, 5 iterations
test_sort 500 2 # Test with 500 numbers, 2 iterations (fewer due to time)

echo -e "${GREEN}All tests completed!${NC}"
