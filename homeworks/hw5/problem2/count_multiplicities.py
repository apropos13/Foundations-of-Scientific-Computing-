'''
Similar to part a but replacing list with dict.
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
	print freq['\n']
	#for k,v in freq.iteritems():
		#print "key =", k + ' value = ',str(v)

if __name__ == '__main__':
	main()