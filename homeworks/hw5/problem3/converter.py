
#relation dict
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
	'meter': 1
	}

def gimme_list(N, system):
	return [ str( (N * meter_dict[i])/ (meter_dict[system]) ) + " "+ i   for i in meter_dict.keys() if i!=system]

def converter(n, system):
	N = int(n)
	if system not in meter_dict.keys():
		print('Wrong system. Try again. \nBye.')
		return
	else:
		return gimme_list(N, system)


def main():
	user_length = raw_input("Please input a length (number only): ")
	user_system = raw_input("Please type a unit system (meter, mile, inch, foot, yard): ")
	li = converter(user_length, user_system)
	#li = converter(159, 'yard')
	print li

if __name__ == '__main__':
	main()

