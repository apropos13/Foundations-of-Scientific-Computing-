import numpy as np
import subprocess  
import glob  
import os
import matplotlib.pyplot as plt
from numpy.linalg import inv
from matplotlib.patches import Rectangle

def make_make():
	list_exec = glob.glob('../LinAlg/*.exe')
	if len(list_exec) != 0:
		make_clean = subprocess.Popen(['make', 'clean'], stderr=subprocess.STDOUT, cwd=r'../LinAlg')
		make_clean.communicate()

	make_process = subprocess.Popen("make", stderr=subprocess.STDOUT, cwd=r'../LinAlg')
	make_process.communicate()
	return 


def write_runtimeParemeters(A,b):

	#make current parametes be A_1 b_1 while shifting existing versions
	fortran_rpath = r'../LinAlg/'

	existing_versions = glob.glob(fortran_rpath+'*.dat')
	# sort in descending version order using generation time. 
	#Do that in order not to  overwrite existing versions while renaming
	existing_versions.sort(key=os.path.getmtime)
	if len(existing_versions) != 0:
		for file_name in existing_versions:
			# will get component if version is more than one digit
			version_components = [s for s in file_name if s.isdigit()]
			#now concat digits and get final version
			version = int(''.join(version_components))
			new_version = version+1

			version_components[-1] = str( int(version_components[-1]) + 1)

			new_name = ''
			counter = 0
			for c in file_name:
				if c.isdigit():
					new_name = new_name + version_components[counter]
					counter += 1
				else:
					new_name = new_name + c
			os.rename(file_name, new_name)


	A_fname = fortran_rpath+"A_"+str(1)+".dat"
	b_fname = fortran_rpath+"b_"+str(1)+".dat"

	np.savetxt(A_fname, A, delimiter = ' ')
	np.savetxt(b_fname, b)

def run_lu(A,b):
	write_runtimeParemeters(A, b)
	run_process = subprocess.Popen("./linear_solve.exe", stderr=subprocess.STDOUT, cwd=r'../LinAlg')
	run_process.communicate()

def solution_check(A,b):
	''' Make sure solutions from python and fortran are
	withing 10^-4 of each other '''
	x_python = np.matmul(inv(A),b)

	x_fortran = np.loadtxt('../LinAlg/x_1.dat')

	# assert that elementwise both vectors do not differ by more than 0.0001
	for i in range(len(x_python)):
		assert( abs(x_python[i] - x_fortran[i]) < 0.0001)

def plot_data(plotFileName1, plotFileName2,A,b, id):
	
	x = np.loadtxt('../LinAlg/x_1.dat')
	entry = [i+1 for i in range(len(x))]

	fig1 = plt.figure()
	fig1.set_facecolor('lightslategray')
	ax1 = fig1.add_subplot(221)


	ax1.plot(entry, x, 'm-', 
		marker="o", 
		markersize=8, 
		markerfacecolor='orange',
		color='orange',
		mec='black',
		mew=1, 
		label="x. vs entry",
		zorder=3)


	#set grid to True to display grid 
	ax1.grid(True)


	ax1.grid(linestyle='--', zorder=0)
	plt.xlim([min(entry)-0.4,max(entry)+0.4])
	if id == 3:
		plt.ylim([min(x)-1.2,max(x)+1.2])
	else:
		plt.ylim([min(x)-0.09,max(x)+0.09])



	plt.ylabel("x", fontsize=14)
	plt.xlabel("Entry Index ", fontsize=14)
	plt.title("Solution to Linear System", fontsize=16, fontweight='bold')
	if  id == 3:
		legend = ax1.legend(loc='lower left', shadow=True)
	elif id == 2:
		legend = ax1.legend(loc='upper right', shadow=True)
	else:
		legend = ax1.legend(loc='upper left', shadow=True)


	#### ADD SUBFIGURE FOR B ####

	ax1 = fig1.add_subplot(223)
	ax1.plot(entry, b, 'b-', 
		marker="D", 
		markersize=8, 
		color='black',
		markerfacecolor='brown',
		mec='black',
		mew=1, 
		label="b vs entry",
		zorder=3)

	#set grid to True to display grid 
	ax1.grid(True)

	ax1.grid(linestyle='--', zorder=0)
	if id == 3:
		plt.xlim([min(entry)-0.4,max(entry)+0.4])
		plt.ylim([min(b)-0.8,max(b)+0.8])
	else:
		plt.xlim([min(entry)-0.4,max(entry)+0.4])
		plt.ylim([min(b)-0.2,max(b)+0.2])

	plt.ylabel("b", fontsize=14)
	plt.xlabel("Entry Index ", fontsize=14)
	plt.title("Vector b", fontsize=16, fontweight='bold')
	if id == 3 or id == 2: 
		legend = ax1.legend(loc='lower left', shadow=True)
	else:
		legend = ax1.legend(loc='upper center', shadow=True)

	fig1.set_tight_layout(True)
	

	##### DRAW VECTOR B #####
	ax1 = fig1.add_subplot(224)
	ax1.set_aspect('equal')
	plt.imshow(b, interpolation='nearest', cmap=plt.cm.ocean,
    extent=(0.5,np.shape(b)[0]+0.5,0.5,np.shape(b)[1]+0.5))
	plt.colorbar()
	plt.title("Matrix b", fontsize=16, fontweight='bold')


	##### DRAW VECTOR x #####
	x  = x.reshape(b.shape)
	ax1 = fig1.add_subplot(222)
	ax1.set_aspect('equal')
	plt.imshow(x, interpolation='nearest', cmap=plt.cm.ocean,
    extent=(0.5,np.shape(x)[0]+0.5,0.5,np.shape(x)[1]+0.5))
	plt.colorbar()
	plt.title("Matrix x", fontsize=16, fontweight='bold')

	plt.savefig(plotFileName1)

	plt.show()


	#### DRAW MATRIX A #####
	fig2 = plt.figure()
	fig2.set_facecolor('lightslategray')
	ax2 = fig2.add_subplot(111)
	ax2.set_aspect('equal')
	plt.imshow(A, interpolation='nearest', cmap=plt.cm.ocean,
    extent=(0.5,np.shape(A)[0]+0.5,0.5,np.shape(A)[1]+0.5))
	plt.colorbar()
	plt.title("Matrix A", fontsize=16, fontweight='bold')
	plt.savefig(plotFileName2)


	plt.show()






	return


def case1(run_id=1):
	print "################### Example 1 ################### \n"
	A = np.zeros(shape = (3,3))
	b = np.zeros(3)

	A = np.array([ [1.0,1.0,-1.0],
			[1.0, 2.0, -2.0],
			[-2.0, 1.0, 1.0] ] )
	b = np.array([ [1.0], [0.0], [1.0] ] )

	run_lu(A, b)
	solution_check(A, b)
	plot_data('plot_line_%s.pdf' %(str(run_id)), 'plot_matrix_%s.pdf' %(str(run_id)), A, b, id = run_id)
	print "################### End of Example 1 ################### \n"

def case2(run_id=2):
	print "################### Example 2 ################### \n"
	A = np.zeros(shape = (3,3))
	b = np.zeros(3)

	A = np.array([ [4.0,3.0,2.0, 1.0],
					[3.0, 4.0, 3.0, 2.0],
					[2.0, 3.0, 4.0, 3.0],
					[1.0,2.0,3.0,4.0] ] )
	b = np.array([ [1.0], [1.0], [-1.0], [-1.0] ] )

	run_lu(A, b )
	solution_check(A, b)
	plot_data('plot_line_%s.pdf' %(str(run_id)), 'plot_matrix_%s.pdf' %(str(run_id)), A, b,  id = run_id)

	print "################### End of Example 2 ################### \n"

def case3(run_id=3):
	print "################### Example 3 ################### \n"
	A = np.zeros(shape = (3,3))
	b = np.zeros(3)

	A = np.array([ [1.0,-1.0,1.0, -1.0],
					[-1.0, 3.0, -3.0, 3.0],
					[2.0, -4.0, 7.0, -7.0],
					[-3.0,7.0,-10.0,14.0] ] )
	b = np.array([ [0.0], [2.0], [-2.0], [-8.0] ] )

	run_lu(A, b)
	solution_check(A, b)
	plot_data('plot_line_%s.pdf' %(str(run_id)), 'plot_matrix_%s.pdf' %(str(run_id)), A, b,  id = run_id)
	print "################### End of Example 3 ################### \n"

def main():
	# call make before the run
	make_make()

	############ CASE 1 ############
	case1()
	############ CASE 2 ##############
	case2()
	############ CASE 3 ##############
	case3()


if __name__ == '__main__':
	main()