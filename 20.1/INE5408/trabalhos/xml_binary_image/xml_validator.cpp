#include <stack>
#include <string>

#include "linked_stack.hpp"

namespace xml {
    bool validate(const std::string& contents) {
        structures::LinkedStack<std::string> tags;

        size_t i = 0u;

        while (i < contents.length())
        {
            // Calcula o íncio e final da próxima tag do arquivo
            size_t start_position = contents.find('<', i);
            size_t end_position = contents.find('>', start_position);

            // Caso o find do início falhe, chegamos ao final do arquivo
            if (start_position == std::string::npos) break;

            // Caso a posição do final falhe, temos um erro no arquivo
            if (end_position == std::string::npos) return false;
            
            // Utiliza substring para buscar a tag completa
            std::string tag = contents.substr(start_position, end_position + 1 - start_position);
            
            // Incrementa a posição de busca inicial para a posição seguinte ao final da tag atual
            i = end_position + 1;

            // Caso seja uma tag de abertura, insere na pilha com uma / no início
            // que será utilizada depois para comparação
            if (tag[1] != '/') {
                tags.push(tag.insert(1, "/"));
            } else {
                // Se tiver uma tag de fechamento com a pilha vazia
                // significa que não havia uma tag de abertura, arquivo inválido
                if (tags.empty()) return false;
                // Se a tag de fechamento for igual ao topo da pilha, desempilha o topo
                else if(tags.top() == tag) tags.pop();
                // Do contrário, erro no arquivo
                else return false;  
            }
        }
        
        return tags.empty();
    }

    std::string get_tag(
        const std::string& source, 
        const std::string& open_tag, 
		const std::string& close_tag, 
        size_t& start_index
    )
    {		
        size_t start_position = source.find(open_tag, start_index);
        size_t end_position = source.find(close_tag, start_position);
                
        start_position += open_tag.length();

        std::string tag_contents = source.substr(start_position, end_position - start_position);
        
        return tag_contents;
    }

    std::string get_value(
        const std::string& source, 
        const std::string& open_tag, 
        const std::string& close_tag
    )
    {
        std::size_t pos{0};

        return get_tag(source, open_tag, close_tag, pos);
    }
} // namespace xml
