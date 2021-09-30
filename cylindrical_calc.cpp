// cylindrical_calc.cpp
//
// Description:
// Finds values as a function of radius for a cylindrical symmetry
// Basic implementation for a cylindrical "droplet" 
// to be expanded on for future applications
//
// Usage: ./cylindrical_calc.x INPUT_FILE OUTPUT_FILE
//  e.g.: ./cylindrical_calc.x cylinder.dump cylinder.dat
//
// Outputs avg q6 parameter, avg density, avg MSD 
//
// Metrics:
// Date/Time           : 2021-08-11
// CPU/Core count      : 6
// Author information  : Elise Rosky (emrosky@mtu.edu)
// Software/Language   : C++ (GNU)
// Version             : 4.8.5
// Pre-req/Dependency  : 
// Compilation command : g++ -fopenmp -std=c++0x MatrixMultiplyP.cpp -o MatrixMultiplyP.x
// Compilation time    : About one second
// Execution command   : ./MatrixMultiplyP.x
// Execution time      : Less than one second


#include <iostream>
#include <fstream>
#include <string>
#include <cmath>
#include <fstream>
#include <chrono>
#include <omp.h>
using namespace std;



// Function Declarations

int a(int i, int j, int N);
int b(int i);


void loadDataArray(string filename, double arr[]);
int findN(string filename); // Find number of atoms in simulation
int fintL(string filename); // Find number of timesteps in simulation

double computeCoM(double 


// UI
void Problem_Statement()
{
  cout << "Multiplies an NxN matrix by an Nx1 matrix. Matrix size is provided by command line argument" <<endl;
  return;
}

void Help_Message()
{
  cout << "\n    Usage: ./MatrixMultiplyP.x  MATRIX_SIZE" <<endl;
  cout << "     e.g.: ./MatrixMultiplyP.x  16" <<endl;

  return;
}



//
int main(int argc, char* argv[])
{ 
  if ( argc != 2 ) // argc should be 2 for correct execution
    // We print argv[0] assuming it is the program name
    cout<<"usage: "<< argv[0] <<" <filename>\n";
  else {
    // We assume argv[1] is a filename to open
    ifstream the_file ( argv[1] );
    // Always check to see if file opening succeeded
    if ( !the_file.is_open() )
      cout<<"Could not open file\n";
    else {
      char x;
      // the_file.get ( x ) returns false if the end of the file
      //  is reached or an error occurs
      while ( the_file.get ( x ) )
        cout<< x;
    }
   
    
    
    // the_file is closed implicitly here
  }
  }



  Problem_Statement();
  int N = stoi(input);
  int num_procs;           // Total number of available processors
  int max_threads;         // Maximum number of usable threads
  int thread_id;           // ID of each participating thread

  // Total number of available processors and maximum number of usable threads
  num_procs   = omp_get_num_procs();
  max_threads = omp_get_max_threads(); // Same as OMP_NUM_THREADS
  cout << "    Total number of processors available : " << num_procs <<endl;
  cout << "    Maximum number of usable threads     : " << max_threads <<endl;

  // Output data file
  string dataFileName = "MatrixMultiplyP.dat";
  cout << "Will write execution time data into file: " << dataFileName <<endl;

  // Load Matrix A
  int A [N][N];
  for (int i=0; i<N; i++) {
    for (int j=0; j<N; j++) {
      A[i][j] = a(i, j, N);
    }
  }

  // Load Matrix B
  int B [N];
  for (int i=0; i<N; i++) {
    B[i] = b(i);
  }


  // Perform Multiplication
  auto start = chrono::steady_clock::now();      // Start timing program execution time

  int C [N];
  //shared(max_threads) private(thread_id)
  #pragma omp parallel
  {
    int array_chunk = N/max_threads;
    int array_llimit = thread_id*array_chunk;
    int array_ulimit = array_llimit + array_chunk;
    printf("  thread %d out of %d\n has chunk %d and lower %d and upper %d", thread_id, max_threads, array_chunk, array_llimit, array_ulimit);
    
      
    for (int i=array_llimit; i<array_ulimit; i++) {
      int sum = 0;
      for (int j=0; j<N; j++) {
        sum += A[i][j]*B[j];
      }
      C[i] = sum;
      printf("  thread %d out of %d\n has computed C[%d] to be %d ", thread_id, max_threads, i, C[i]);
    }
  }
  
  auto end = chrono::steady_clock::now();       // End timing of Matrix Multiplication

  // Report the Elapsed time
  double time = chrono::duration_cast<chrono::microseconds>(end - start).count();
  cout << time << " microseconds" <<endl;
  // Write to data file
  fstream datafile;
  datafile.open(dataFileName, ios::out | ios::app);
  if (datafile.is_open())
  {
  datafile << N << "\t" << time <<endl;
  }
  else cout << "Unable to open file" <<endl;

  // Print C
  for (int j=0; j<N; j++) {
    cout << C[j] <<endl;
  }
  
  
  // SAMPLE CODE TO READ DATA IN FROM FILE
  string array[2]; 
  short loop=0; 
  string line; 
  ifstream myfile ("Codespeedy.txt"); 
  if (myfile.is_open()) 
  {
    while (! myfile.eof() ) 
      {
          getline (myfile,line); 
          array[loop] = line;
          cout << array[loop] << endl; 
          loop++;
      }
      myfile.close(); 
  }
  else cout << "can't open the file"; 
  system("PAUSE");

  return 0;
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


