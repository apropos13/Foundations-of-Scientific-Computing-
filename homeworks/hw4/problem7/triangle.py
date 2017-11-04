''' Solution to Hw 4 / problem 7 '''

def isTriagle(a,b,c):
	''' Returns True if a,b,c can form a trinagle,
	False otherwise '''

	#take all pairs of two numbers and check
	#that the third if their sum is larger 

	return (a + b > c) and (a + c > b) and (b + c > a)




def main():
	# not a triangle since 8 + 4 < 15
	print(isTriagle(8,15,4))

	# Pythagorean tiple 
	print(isTriagle(3,4,5))

if __name__ == '__main__':
	main()