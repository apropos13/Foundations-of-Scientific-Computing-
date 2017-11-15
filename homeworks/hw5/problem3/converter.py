#relation dict where point of reference is the meter
meter_dict = { 
	'mile': 0.000621,
	'inch': 39.370079,
	'foot': 3.28084,
	'yard': 1.093613,
	'nm': 10**9,
	'um': 10**6,
	'mm': 10**3,
	'cm': 10**2,
	'km': 10**(-3),
	'meter': 1.0
	}

def gimme_list(N, system):
	return [ str( float( (N * meter_dict[i]))/ (meter_dict[system]) ) + " " + i   for i in meter_dict.keys() if i!=system]

def converter(n, system):
	return gimme_list(n, system)

def pretty_print(l):
	for element in l:
		split_str = element.split()
		print '-----> ' + str(split_str[0]) + " ("+ split_str[1] + ")"		

def main():

	try:
		user_length = float(raw_input("Please input a length (number only): "))
	except ValueError as e:
		print "Length must be a number. Try again.\nBye"
		exit()

	user_system = raw_input("Please type a unit system (meter, mile, inch, foot, yard): ")
	if user_system not in meter_dict.keys():
		print('Wrong system. Try again. \nBye.')
		exit()

	
	li = converter(user_length, user_system)
	pretty_print(li)

if __name__ == '__main__':
	main()

