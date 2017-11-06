''' Solution to Hw 4 / problem 4 '''

def cumulative_sum(l):
	''' returns the cumulative sum of s '''
	return [ sum(l[:i+1]) for i in range(len(l))]


def main():
	#test cases

	l1 = [5,2,3]
	print(cumulative_sum(l1))

	l2 = [-1,4,-10000]
	print(cumulative_sum(l2))

	#border case
	l3 = []
	print(cumulative_sum(l3))

	l4 = [0,0,0,0,0,-1]
	print(cumulative_sum(l4))


if __name__ == '__main__':
	main()