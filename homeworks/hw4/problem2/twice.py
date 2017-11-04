''' Solution to Hw 4 / problem 2 '''

#part b
def do_twice(f, x):
	f(x)
	f(x)

def print_something(something):
	print(something)

#part c
def print_twice(s):
	for i in range(2):
		print(s)


def main():
	#part d
	do_twice(print_twice, 'hello world')

if __name__ == '__main__':
	main()