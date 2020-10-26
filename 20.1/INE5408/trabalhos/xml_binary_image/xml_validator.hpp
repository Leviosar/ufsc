#include <string>
#include <utility>
#include <fstream>
#include <tuple>

/**
 * 
 * @brief Declaração das funções usadas para validar e extrair os dados dos arquivos XML de entrada.
 * 
 */

namespace xml {
    /**
        @brief Valida o arquivo XML baseando-se num algoritmo que empilha e desempilha tags de abertura fechamento.
    */ 
    bool validate(const std::string& contents);

    /**
        @brief Retorna o conteúdo completo de uma tag específica (incluindo os delimitadores da tag)
        @param string source texto de onde se quer buscar as tags
        @param string open_tag tag de abertura do que se quer buscar
        @param string close_tag tag de fechamento do que se quer buscar
        @param size_t start_index indice da string source de onde será começado a busca
    */
    std::string get_tag(
        const std::string& source, 
        const std::string& open_tag,
        const std::string& close_tag, 
        size_t& start_index
    );

    /**
        @brief Retorna o valor interno de uma tag específica
        @param string source texto de onde se quer buscar as tags
        @param string open_tag tag de abertura do que se quer buscar
        @param string close_tag tag de fechamento do que se quer buscar
    */
    std::string get_value(
        const std::string& source,
        const std::string& open_tag,
        const std::string& close_tag
    );
} // namespace xml
