'''
Similar to part a but replacing list with dict.
'''
def read_N(N, read_all = False, path_to_file = '../words.txt'):
	l = dict() #call default constructor

	with open(path_to_file) as f:
		counter = 1 
		for line in f:
			if counter <= N or read_all:
				if line not in l: #check if key does not exist 
					l[line] = 1 # random value
				counter += 1
			else:
				break
	return l

#TODO: answer the second subpart of Q1
def read_all(path_to_file = '../words.txt'):
	''' Calls read_N with arguments to read all lines '''
	return read_N(1, read_all = True) #value of N doest affect anything

def main():
	#example usages 
	l = read_N(10)
	print l
	l_all = read_all()
	print len(l_all)

if __name__ == '__main__':
	main()