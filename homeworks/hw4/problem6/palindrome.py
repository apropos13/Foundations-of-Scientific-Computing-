''' Solution to Hw 4 / problem 6 '''

def palindrome(s):
	''' returns true if s is palindrome '''
	for i in range(len(s)):
		if s[i] != s[-i-1]:
			return False
	return True


def main():
	s = "ababa"
	print(palindrome(s))

	s = "abab"
	print(palindrome(s))

	s = "abba"
	print(palindrome(s))

if __name__ == '__main__':
	main()