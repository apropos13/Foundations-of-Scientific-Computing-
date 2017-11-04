''' Solution to Hw 4 / problem 4 '''

def cumulative_sum(l):
	''' returns the cumulative sum of s '''
	return [ sum(l[:i+1]) for i in range(len(l))]


def main():
	l = [5,2,3]
	print(cumulative_sum(l))

	

if __name__ == '__main__':
	main()