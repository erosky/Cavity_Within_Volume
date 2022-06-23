// cylindrical_calc.cpp
//
// Description:
// Finds values as a function of radius for a cylindrical symmetry
// Basic implementation for a cylindrical "droplet" 
// to be expanded on for future applications
//
// Usage: ./cylindrical_calc.x INPUT_FILE [OUTPUT_FILE]
//	e.g.: ./cylindrical_calc.x cylinder.dump [cylinder.csv]
//
// Outputs avg q6 parameter, avg density, avg MSD 
//
// Metrics:
// Date/Time					 : 2021-08-11
// CPU/Core count			: 6
// Author information	: Elise Rosky (emrosky@mtu.edu)
// Software/Language	 : C++ (GNU)
// Version						 : 4.8.5
// Pre-req/Dependency	: 
// Compilation command : g++ -fopenmp -std=c++0x cylindrical_calc.cpp -o cylindrical_calc.x
// Compilation time		: 
// Execution command	 : ./cylindrical_calc.x INPUT_FILE [OUTPUT_FILE]
// Execution time			: 



#include <iostream>
#include <fstream>
#include <string>
#include <cmath>
#include <fstream>
#include <chrono>
#include <omp.h>
using namespace std;



// Function Declarations
int findN(string filename); 				// Find number of atoms in simulation
int fintL(string filename); 				// Find number of timesteps in simulation
int findLenProps(string filename);	// Find number of atom properties given in dumpfile


// UI
void Problem_Statement()
{
	cout << "Finds values as a function of radius for a cylindrical symmetry" <<endl;
	return;
}

void Help_Message()
{
	cout << "\n		./cylindrical_calc.x INPUT_FILE [OUTPUT_FILE]" <<endl;
	return;
}



//
int main(int argc, char* argv[])
{ 
	string filename;
	
	// Check that the command line inputs are correct
	// argv[0] is the program name
	// argv[1] is the dump filename to open
	if ( argc != 2 ) Help_Message;	// Print help message if the number 
																	// of inputs is wrong
	else {
		filename = argv[1];
		cout << "\n Using file: " << argv[1] << endl;
		
		// Values needed to declare the full arrays
		int L; // Number of timesteps
		int N; // Number of atoms
		int len_props; // Number of atom properties given in dumpfile
	 
		L = findL(filename);
		N = findN(filename);
		len_props = findLenProps();
		
		// Initialize the full array
		double full_arr[L][N][len_props];	// this is an LxNxlen_props array 
																			// containing all the data in the dumpfile

		// Load the dumpfile data into the array
		ifstream dumpfile (filename);
	}
}



// Function Definitions

int a(int i, int j, int N)
// Matrix elements of A
{
	double a_ij = i*(N-i-1)*j*(N-j-1);
	return a_ij;
}

int b(int i)
// Matrix elements of B
{
	return (i + 2);
}


