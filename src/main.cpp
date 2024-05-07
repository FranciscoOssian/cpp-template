#include <Eigen/Dense>
#include <iostream>

int main() {
  // Definindo uma matriz 2x2
  Eigen::Matrix2d matriz;
  matriz << 1, 2, 3, 4;

  // Definindo um vetor
  Eigen::Vector2d vetor(1, 2);

  // Multiplicando a matriz pelo vetor
  Eigen::Vector2d resultado = matriz * vetor;

  // Imprimindo o resultado
  std::cout << "Resultado da multiplicacao: \n" << resultado << std::endl;

  return 0;
}
