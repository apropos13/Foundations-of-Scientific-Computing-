''' Solution to Hw3/problem 1 '''

def right_justify(s):
	''' 
	named right_justify takes a string named s as a 
	parameter and prints the string with enough leading 
	spaces so that the last letter of the string is in column 70 
	of the display
	'''
	column = 70 #define column to shift here for more modularity
	if len(s) > column:
		print('name has length larger than 70. \n Aborting.') 
	else:
		spaces = " " * (column - len(s))
		print(spaces + s)


def main():
	right_justify('panos')

if __name__ == '__main__':
	main()