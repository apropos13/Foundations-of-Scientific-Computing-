''' Solution to Hw 4 / problem 2 '''

#part b
def do_twice(f, x):
	f(x)
	f(x)

#part c
def print_twice(s):
	for i in range(2):
		print(s)


def main():
	#part d
	#this prints 4 times the word 'spam'
	do_twice(print_twice, 'spam')

if __name__ == '__main__':
	main()