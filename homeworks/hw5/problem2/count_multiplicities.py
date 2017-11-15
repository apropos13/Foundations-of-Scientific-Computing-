'''
Similar to Problem 1/part(a) but replacing list with dict
and counting frequencies of chars.
'''
def get_freq(path_to_file = '../words.txt'):
	l = dict() #call default constructor

	with open(path_to_file) as f:
		for line in f:
			for char in line:
				if char not in l: #check if key does not exist 
					l[char] = 1 # first occurence
				else:
					l[char] += 1 # increment frequency
	return l


def main():

	freq = get_freq()
	#print("Examples: ")
	#print r"Frequency of \n:= ", freq['\n']
	#print "Frequency of a:= ", freq['a']
	#print "Frequency of g:= ", freq['g']
	#print "Frequency of p:= ", freq['p']
	for k,v in freq.iteritems():
		if k == '\n':
			print r"Frequency of \n:= ", str(v)
		else:
			print "Frequency of ", k + ':= ',str(v)

if __name__ == '__main__':
	main()