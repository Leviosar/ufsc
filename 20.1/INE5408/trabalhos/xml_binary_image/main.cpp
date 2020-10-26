#include <algorithm>
#include <stack>
#include <string>
#include <utility> // pair
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>

#include "xml_validator.hpp"
#include "region_counter.hpp"
#include "linked_stack.hpp"

int main() {
    char xml_file_name[100];
    std::ifstream xml_file;

    std::cin >> xml_file_name;

    xml_file.open(xml_file_name);
    
    if (not xml_file.is_open()) {
        std::cout << "error\n";
        return -1;
    }
    
    std::stringstream stream;
	stream << xml_file.rdbuf();
	std::string contents = stream.str();

    xml_file.close();

    // Se o arquivo não é um XML válido, retorna -1 junto com uma mensagem de erro
    if (not xml::validate(contents)) {
        std::cout << "error\n";
        return -1;
    }

    size_t i = {0};

    while (i < contents.length())
    {
        // Busca a tag completa da próxima imagem dentro do arquivo
        std::string open_tag = "<img>";
        std::string close_tag = "</img>";
        std::string image = xml::get_tag(contents, open_tag, close_tag, i);

        i += image.length() + close_tag.length();
        
        // Sai do laço caso tenha chegado ao final das imagens
        if (i > contents.length()) break;
	
        // Utiliza a função get_value pra buscar o conteúdo de cada atributo da imagem
        std::string data = xml::get_value(image, "<data>", "</data>");
        const std::string name = xml::get_value(image, "<name>", "</name>");
        const int width = std::stoi(xml::get_value(image, "<width>", "</width>"));
        const int height = std::stoi(xml::get_value(image, "<height>", "</height>"));

        // Caso seja uma imagem inválida (com alguma das dimensões menores ou iguais a 0)
        // retorna -1 como sinal de erro.
        if (height <= 0|| width <= 0) return -1;

        // Remove \n da string data
        data.erase(std::remove(data.begin(), data.end(), '\n'), data.end());

        std::vector<std::vector<bool>> matrix = region_counter::create_matrix(data, width, height);

        int regions = region_counter::connectivity_counter(matrix);
		std::cout << name << ' ' << regions << std::endl;
    }
}

