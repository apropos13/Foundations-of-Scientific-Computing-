'''
Similar to part a but replacing list with dict.
'''
def read_N(N, read_all = False, path_to_file = '../words.txt'):
	l = dict() #call default constructor

	with open(path_to_file) as f:
		counter = 1 
		for line in f:
			line = line.strip('\n')
			if counter <= N or read_all:
				if line not in l: #check if key does not exist 
					l[line] = None # random value
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
	try:
		n = int(raw_input("Please input the number of words to read (number only): "))
	except ValueError as e:
		print "Number of words must be an integer. Try again.\nBye"
		exit()


	l = read_N(n)
	assert(len(l) == n) # sanity check
	print l

	l_all = read_all()
	#TO PRINT ALL WORDS UNCOMMENT THE FOLLOWING LINE
	#print l_all
	print "Number of all words in words.txt = ", len(l_all)


if __name__ == '__main__':
	main()