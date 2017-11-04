''' Solution to Hw 4 / problem 4 '''

def print_yourName(l, flag = True):
	first = l[0]
	new_first = first[0].upper() + first[1:]
	last = l[1]
	new_last = last[0].upper() + last[1:]

	if flag == True:
		print(new_first+" "+new_last)
	else:
		print(new_last+", "+new_first)

def main():
	l = ['panos', 'karagiannis']
	print_yourName(l, False)

	

if __name__ == '__main__':
	main()