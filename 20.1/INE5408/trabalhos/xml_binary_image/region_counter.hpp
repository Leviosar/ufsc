/**
 * 
 * @brief Declaração das funções usadas para contar as regiões conexas nas imagens binárias.
 * 
 */

#include <algorithm>
#include <stack>
#include <string> 
#include <vector>
#include <iostream>
#include <tuple>

#include "linked_stack.hpp"

namespace region_counter {

    /**
     * Valores possíveis de um pixel na matriz binária  
    */
    enum COLOR {
        /// Pixel preto = 0
        BLACK,
        /// Pixel branco = 1
        WHITE,
    };

    /**
	 * @brief Transforma uma região conexa inteira da matriz em 0's, começando pelo elemento indicado pelas posições (i, j)
     * @param vector<vector<bool>> matriz booleana base
     * @param int i coordenada i do pixel 
     * @param int j coordenada j do pixel 
    */
    void clear_region(std::vector<std::vector<bool>>& matrix, int i, int j);
    
    /**
	 * @brief Conta a quantidade de regiões de valor 1 conexas em uma matriz booleana
     * @param vector<vector<bool>> matriz booleana a ser utilizada para a contagem
    */
    int connectivity_counter(std::vector<std::vector<bool>> matrix);

    /** 
	 * @brief Cria uma matriz booleana a partir de uma string de '0' e '1'.
     * @param string str_matrix matriz codificada em string
     * @param int width largura da matriz
     * @param int height altura da matriz
    */
    std::vector<std::vector<bool>> create_matrix(const std::string& str_matrix, int width, int height);
}