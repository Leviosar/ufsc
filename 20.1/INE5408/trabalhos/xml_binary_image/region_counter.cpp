#include "region_counter.hpp"

namespace region_counter {

// Implementa a lógica de Flood Fill, pintando de preto todos os pixels brancos
// que são conexos ao pixel inicial passado pelas coordenadas (i, j). A lógica de
// flood é implementada com o auxílio de uma estrutura do tipo Pilha, implementada
// durante as aulas da disciplina.

void clear_region(std::vector<std::vector<bool>>& matrix, int i, int j) {
    structures::LinkedStack<std::tuple<int, int>> stack;

    int width = matrix[0].size();
    int height = matrix.size();

    stack.push(std::make_tuple(i, j));

    while (!stack.empty()) {
        std::tuple<int, int> last = stack.pop();
        
        i = std::get<0>(last);
        j = std::get<1>(last);

        matrix[i][j] = 0;

        // Verifica se o elemento a esquerda existe e se é branco.
        if (j > 0 && matrix[i][j - 1])
            stack.push(std::make_tuple(i, j - 1));     

        // Verifica se o elemento a direita existe e se é branco.
        if (j < (width - 1) && matrix[i][j + 1])
            stack.push(std::make_tuple(i, j + 1));

        // Verifica se o elemento acima existe e se é branco.
        if (i > 0 && matrix[i - 1][j])
            stack.push(std::make_tuple(i - 1, j));
        
        // Verifica se o elemento abaixo existe e se é branco.
        if (i < (height - 1) && matrix[i + 1][j])
            stack.push(std::make_tuple(i + 1, j));
    }

} 

// Conta a quantidade de regiões conexas de valor 1 existentes em uma matriz booleana, para isso
// usa uma lógica de flood fill, onde ao encontrar um elemento com valor 1 incrementa um contador/
// e logo após preenche com 0 esse elemento e toda os pixels conexos a ele. Essa lógica de preenchimento
// é executada pela função clear_region

int connectivity_counter(std::vector<std::vector<bool>> matrix) {
    int connectivity_count = 0;
    
    for (int i = 0; i < (int) matrix.size(); i++) {
        for (int j = 0; j < (int) matrix[0].size(); j++) {
            if (matrix[i][j] == COLOR::WHITE) {
                connectivity_count++;
                clear_region(matrix, i, j);
            }
        }
    }
    
    return connectivity_count;
}

/// Cria uma matriz de tamanho width * height, do tipo std::vector<std::vector<bool>> a partir de uma
/// string binária. A string deve conter apenas os caracteres 0 e 1. 
std::vector<std::vector<bool>> create_matrix(const std::string& str_matrix, int width, int height) {
    std::vector<std::vector<bool>> matrix;

    for (int i = 0u; i < height; i++) {
        std::vector<bool> line;

        for (int j = 0; j < width; j++)
            line.push_back(str_matrix[i * width + j] == '1');

        matrix.push_back(line);
    }
    
    return matrix;
}

}