''' Solution to Hw 4 / problem 3 '''

def is_sorted(l):
	''' Checks if elements in l are sorted in ascending order '''
	for i in range(len(l)-1):
		if l[i] > l[i+1]:
			return False 
	return True


def main():
	l = [1,2,3,6,7,8,9]
	print(is_sorted(l))

	l = [1,2,3,6,7,8,0]
	print(is_sorted(l))

	l = ['c','a']
	print(is_sorted(l))
	

if __name__ == '__main__':
	main()