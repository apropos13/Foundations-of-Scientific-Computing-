'''
Write a function which reads the first N many words from the file
 words.txt and builds a list with one element per word. 
 N is a user input number. read_all functions as a wrapper function for
 read_N and is used to read all the lines from the given file
'''

#read the first N lines
def read_N(N = 10, read_all = False, path_to_file = '../words.txt'):
	l = list() #call default constructor

	with open(path_to_file) as f:
		counter = 1 
		for line in f:
			# either read as many as N lines or all of them
			if counter <= N or read_all:
				l.append(line.strip())
				counter += 1
			else:
				break
	return l

#Wrapper function to call read_N to read ALL lines 
def read_all(path_to_file = '../words.txt'):
	''' Calls read_N with arguments to read all lines '''
	return read_N(read_all = True) 

def main():
	#example usages
	try:
		n = int(raw_input("Please input the number of words to read (number only): "))
	except ValueError as e:
		print "Number of words must be an integer. Try again.\nBye"
		exit()

	#read the first 10 lines  
	l = read_N(N = n)
	assert(len(l) == n) # sanity check
	print "First "+ str(n)+" words of the file: \n", l

	#read all lines print number of words in file
	l_all = read_all()
	
	#TO PRINT ALL WORDS UNCOMMENT THE FOLLOWING LINE
	#print l_all
	print "Number of all words in words.txt = ", len(l_all)

if __name__ == '__main__':
	main()

