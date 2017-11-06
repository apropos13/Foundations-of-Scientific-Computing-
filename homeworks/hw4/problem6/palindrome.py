''' Solution to Hw 4 / problem 6 '''

def palindrome(s):
	''' returns true if s is palindrome '''
	for i in range(len(s)):
		if s[i] != s[-i-1]:
			return False
	return True


def main():
	s = "ababa"
	assert palindrome(s) == True
	print(palindrome(s))

	s = "abab"
	assert palindrome(s) == False
	print(palindrome(s))

	s = "abba"
	assert palindrome(s) == True
	print(palindrome(s))

if __name__ == '__main__':
	main()