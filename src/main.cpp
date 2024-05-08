#include <Eigen/Dense>
#include <chrono>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <viennacl/matrix.hpp>

int main() {
  std::cout << "init" << std::endl;

  const int size = 1500;  // Size of the matrices
  std::string fileName1 = "./list1.txt";
  std::string fileName2 = "./list2.txt";

  // Creating two large matrices using ViennaCL
  viennacl::matrix<float> matrix1_viennacl(size, size);
  viennacl::matrix<float> matrix2_viennacl(size, size);

  // Creating two large matrices using Eigen
  Eigen::MatrixXf matrix1_eigen(size, size);
  Eigen::MatrixXf matrix2_eigen(size, size);

  // Initializing the matrices with random values
  for (int i = 0; i < size; ++i) {
    for (int j = 0; j < size; ++j) {
      matrix1_viennacl(i, j) = rand() / static_cast<float>(RAND_MAX);
      matrix2_viennacl(i, j) = rand() / static_cast<float>(RAND_MAX);
    }
  }

  // Initializing the matrices with the same random values
  for (int i = 0; i < size; ++i) {
    for (int j = 0; j < size; ++j) {
      matrix1_eigen(i, j) = matrix1_viennacl(i, j);
      matrix2_eigen(i, j) = matrix2_viennacl(i, j);
    }
  }

  //==============================================================

  // Performing computation with the matrices using ViennaCL and
  // measuring the execution time
  auto start_viennacl = std::chrono::steady_clock::now();
  viennacl::matrix<float> result_viennacl =
      viennacl::linalg::prod(matrix1_viennacl, matrix2_viennacl);
  auto end_viennacl = std::chrono::steady_clock::now();
  std::chrono::duration<double> time_viennacl = end_viennacl - start_viennacl;

  std::ofstream file1(fileName1);
  if (!file1.is_open()) {
    std::cout << "Err file 1" << std::endl;
    return 1;
  }
  for (int i = 0; i < size; ++i) {
    for (int j = 0; j < size; ++j) {
      file1 << result_viennacl(i, j) << std::endl;
    }
  }

  // Printing the execution time with ViennaCL
  std::cout << "Execution time with ViennaCL: " << time_viennacl.count()
            << " seconds" << std::endl;

  //=================================================================

  // Performing computation with the matrices using Eigen and
  // measuring the execution time
  auto start_eigen = std::chrono::steady_clock::now();
  Eigen::MatrixXf result_eigen = matrix1_eigen * matrix2_eigen;
  auto end_eigen = std::chrono::steady_clock::now();
  std::chrono::duration<double> time_eigen = end_eigen - start_eigen;

  std::ofstream file2(fileName2);
  if (!file2.is_open()) {
    std::cout << "Err file 2" << std::endl;
    return 1;
  }
  for (int i = 0; i < size; ++i) {
    for (int j = 0; j < size; ++j) {
      file2 << result_eigen(i, j) << std::endl;
    }
  }

  // Printing the execution time with Eigen
  std::cout << "Execution time with Eigen: " << time_eigen.count() << " seconds"
            << std::endl;

  return 0;
}