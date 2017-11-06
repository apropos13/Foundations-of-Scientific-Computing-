''' Solution to Hw 4 / problem 7 '''

def isTriagle(a,b,c):
	''' Returns True if a,b,c can form a trinagle,
	False otherwise '''

	#take all pairs of two numbers and check
	#that the third is less than their sum  

	return (a + b > c) and (a + c > b) and (b + c > a)




def main():
	# not a triangle since 8 + 4 < 15
	assert isTriagle(8,15,4) == False
	print(isTriagle(8,15,4))

	# not a triangle since 8 + 7 < 16
	assert isTriagle(16,7,8) == False
	print(isTriagle(16,7,8))

	# not a triangle since 1 + 7 < 9
	assert isTriagle(1,7,9) == False
	print(isTriagle(16,7,8))

	assert isTriagle(3,6,4) == True
	print(isTriagle(3,6,4))

	# Pythagorean tiple 
	assert isTriagle(3,4,5) == True
	print(isTriagle(3,4,5))

if __name__ == '__main__':
	main()