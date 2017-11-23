import subprocess  
import glob  
import os
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle


def make_make():
	list_exec = glob.glob('../newton_rootFinder/*.exe')
	if len(list_exec) != 0:
		make_clean = subprocess.Popen(['make', 'clean'], stderr=subprocess.STDOUT, cwd=r'../newton_rootFinder')
		make_clean.communicate()

	make_process = subprocess.Popen("make", stderr=subprocess.STDOUT, cwd=r'../newton_rootFinder')
	make_process.communicate()
	return 

def runtimeParameters_init(name, newton_method, x_b, x_e, m_iter, thres, function_type, init_guess, mult):
	list_init = glob.glob('../newton_rootFinder/*.init')
	if len(list_init) != 0: 		
		list_all_init = glob.glob('../newton_rootFinder/*.init.*')

		# if other versions exist take their number
		if len(list_all_init) != 0:
			versions = [ int(i[-1]) for i in list_all_init ]
		else:
			versions = [0]

		new_version = max(versions)+1
		#print "Found an existing .init file, so renamed it to ", list_init[0]+'.'+str(new_version)

		os.rename(list_init[0], list_init[0]+'.'+str(new_version))

	args = [name, newton_method, x_b, x_e, m_iter, thres, function_type, init_guess, mult]
	args =  [str(i)+'\n' for i in args] # make every argument a string
	defaults = ['run_name', 'method_type', 'x_beg', 'x_end', 'max_iter', 'threshold', 'ftn_type', 'init_guess', 'multiplicity']


	args[1] = args[1]+'\n'
	args[3] = args[3]+'\n'
	args[5] = args[5]+'\n'

	with open('../newton_rootFinder/rootFinder.init', 'w') as f:
		for parameter, default in zip(args, defaults):
			f.write(default+ ' '* (13 - len(default))+ parameter)

	return

def run_rootFinder(name, newton_method, x_b, x_e, m_iter, thres, function_type, init_guess, mult):
	#create the runtime file
	runtimeParameters_init(name, newton_method, x_b, x_e, m_iter, thres, function_type, init_guess, mult)

	run_process = subprocess.Popen("./rootFinder.exe", stderr=subprocess.STDOUT, cwd=r'../newton_rootFinder')
	run_process.communicate()
	return 


def plot_data(plotFileName, isLast = False):
	n_iter = []
	approx = []
	error = []

	### EXTRACT VALUES ###
	with open(r'../newton_rootFinder/rootFinder_newt.dat') as f:
		for line in f:
			all_fields = line.split(' ')
			goodies = []
			for element in all_fields:
				if element != '': #get rid of empty lines 
					goodies.append(float(element))

			n_iter.append(goodies[0])
			approx.append(goodies[1])
			error.append(goodies[3])

	####RENAMING only if it is not the last one####
	if not isLast:
		list_dat = glob.glob('../newton_rootFinder/*.dat')
		if len(list_dat) != 0: 		
			list_all_dat = glob.glob('../newton_rootFinder/*.dat.*')

			# if other versions exist take their number
			if len(list_all_dat) != 0:
				versions = [ int(i[-1]) for i in list_all_dat ]
			else:
				versions = [0]

			new_version = max(versions)+1
			#print "Found an existing .dat file, so renamed it to ", list_dat[0]+'.'+str(new_version)

			os.rename(list_dat[0], list_dat[0]+'.'+str(new_version))

	fig1 = plt.figure()
	fig1.set_facecolor('lightslategray')
	ax1 = fig1.add_subplot(211)


	ax1.plot(n_iter, approx, 'm-', 
		marker="o", 
		markersize=8, 
		markerfacecolor='orange',
		color='orange',
		mec='black',
		mew=1, 
		label="Approx. vs Iterations",
		zorder=3)


	#set grid to True to display grid 
	ax1.grid(True)
	#ax1.title("Approximation convergence", fontsize=14, fontweight='bold')
	ax1.legend(loc='lower right')

	ax1.grid(linestyle='--', zorder=0)
	plt.xlim([min(n_iter)-0.4,max(n_iter)+0.4])


	plt.ylabel("Root", fontsize=14)
	plt.xlabel("Number of iterations ", fontsize=14)
	plt.title("Root convergence", fontsize=16, fontweight='bold')
	legend = ax1.legend(loc='lower right', shadow=True)
	#plt.savefig("stack_backoff.pdf")



	#### ADD SUBFIGURE ####

	ax1 = fig1.add_subplot(212)


	ax1.plot(n_iter, error, 'b-', 
		marker="D", 
		markersize=8, 
		color='black',
		markerfacecolor='brown',
		mec='black',
		mew=1, 
		label="Error vs Iterations",
		zorder=3)


	#set grid to True to display grid 
	ax1.grid(True)
	#ax1.title("Approximation convergence", fontsize=14, fontweight='bold')
	ax1.legend(loc='lower right')

	ax1.grid(linestyle='--', zorder=0)
	plt.xlim([min(n_iter)-0.4,max(n_iter)+0.4])
	plt.ylim([min(error)-0.04,max(error)+0.04])

	plt.ylabel("Error", fontsize=14)
	plt.xlabel("Number of iterations ", fontsize=14)
	plt.title("Error convergence", fontsize=16, fontweight='bold')
	legend = ax1.legend(loc='upper right', shadow=True)
	fig1.set_tight_layout(True)

	plt.savefig(plotFileName)
	plt.show()

	return



## TO DO ## 
# make y axis universal

def main():
	make_make()

	#parameters 
	name = 'newt'
	method = 'newton'
	x_begin = -10
	x_end = 10
	m_iter = 1000
	function_type = 2
	init_guess = 0.8
	mult = 2

	####################
	thresholds = [1.e-4, 1.e-6, 1.e-8]
	####################

	for t in thresholds:
		if t == thresholds[-1]:
			run_rootFinder(name, method, x_begin, x_end, m_iter,t, function_type, init_guess, mult)
			plot_name = 'result_'+ str(function_type)+ '_' + "%1.*e"%(0,t)
			plot_data(plot_name, isLast = True)
		else:
			run_rootFinder(name, method, x_begin, x_end, m_iter,t, function_type, init_guess, mult)
			plot_name = 'result_'+ str(function_type)+ '_' + "%1.*e"%(0,t)
			plot_data(plot_name)


if __name__ == '__main__':
	main()