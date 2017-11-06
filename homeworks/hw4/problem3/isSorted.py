''' Solution to Hw 4 / problem 3 '''

def is_sorted(l):
	''' Checks if elements in l are sorted in ascending order '''
	for i in range(len(l)-1):
		if l[i] > l[i+1]:
			return False 
	return True


def main():
	#test cases
	l1 = [1,2,3,6,7,8,9]
	assert is_sorted(l1) == True, 'List 1 is sorted'
	print(is_sorted(l1))

	l2 = [1,2,3,6,7,8,0]
	assert is_sorted(l2) == False, 'List 2 is not sorted'
	print(is_sorted(l2))

	l3 = ['c','a']
	assert is_sorted(l3) == False, 'List 3 is not sorted'
	print(is_sorted(l3))
	

if __name__ == '__main__':
	main()